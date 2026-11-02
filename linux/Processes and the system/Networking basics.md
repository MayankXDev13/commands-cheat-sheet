# Networking Basics

## Overview

This chapter covers three practical networking skills on Linux:

-   Finding which ports applications are listening on.
-   Sending HTTP requests and inspecting responses with `curl`.
-   Understanding network interfaces, IPv4 addresses, and `127.0.0.1`.

These skills help diagnose connectivity problems and understand how
clients reach services running on a machine.

## 1. Ports and listening services

A **port** is a number used by a network service to receive connections.
A server listens on an address and port so clients can reach it.

### Inspect listening TCP ports

``` bash
ss -ltn
```

Useful options:

  Option   Meaning
  -------- -----------------------------------
  `-l`     Show listening sockets
  `-t`     Show TCP sockets
  `-n`     Show numeric addresses and ports
  `-p`     Show the process using the socket

Include process information:

``` bash
ss -ltnp
```

Filter for a particular port:

``` bash
ss -ltnp 'sport = :9090'
```

In the output, **Local Address:Port** shows the address and port on
which the service is listening.

## 2. Making HTTP requests with curl

`curl` sends requests to URLs and displays the server's response.

A URL commonly has this structure:

``` text
http://ADDRESS:PORT/PATH
```

Example:

``` bash
curl http://127.0.0.1:9090/
```

### Save only the response body

``` bash
curl -s -o response.json http://127.0.0.1:9090/menu
```

-   `-s` hides the progress meter.
-   `-o` writes the response body to a file.

This is useful when saving JSON for another program to read. Avoid `-i`
when the file must contain only JSON, because `-i` includes response
headers.

### Inspect response headers

Show headers only:

``` bash
curl -I http://127.0.0.1:9090/menu
```

Show headers followed by the response body:

``` bash
curl -i http://127.0.0.1:9090/menu
```

HTTP headers are metadata sent by the server. For example:

``` text
HTTP/1.1 200 OK
X-Kettle: hot
```

`200 OK` indicates that the request succeeded. A custom header such as
`X-Tapri-Version` can communicate an API version.

## 3. Network interfaces and IPv4 addresses

A **network interface** is the machine's connection point to a network.
Linux displays interfaces and their addresses with:

``` bash
ip addr
```

Show IPv4 addresses only:

``` bash
ip -4 addr
```

Inspect a specific interface:

``` bash
ip -4 addr show eth0
```

The interface name varies by machine; common names include `eth0`,
`ens33`, and `wlan0`.

### Understanding an `inet` line

Example:

``` text
inet 10.0.0.1/24 scope global eth0
```

-   `10.0.0.1` is the IPv4 address.
-   `/24` is the network prefix length.
-   `scope global` indicates an address usable beyond the local host,
    subject to network routing and firewall rules.
-   `eth0` is the interface name.

For a machine address intended to be reached by other devices on the
network, identify the appropriate IPv4 address on an interface marked
`scope global`. Do not use the loopback address.

You can also display assigned host addresses with:

``` bash
hostname -I
```

## 4. Loopback and localhost

`127.0.0.1` is the IPv4 **loopback address**. It sends network traffic
back to the same machine that generated it.

The loopback interface is conventionally named `lo`:

``` bash
ip addr show lo
```

A typical output includes:

``` text
lo: <LOOPBACK,UP,LOWER_UP>
inet 127.0.0.1/8 scope host lo
```

The hosts file commonly maps the address to the name `localhost`:

``` bash
grep 127.0.0.1 /etc/hosts
```

Key distinction:

-   `127.0.0.1` / `localhost`: reaches the same machine.
-   A global interface address, such as `10.0.0.1`: identifies the
    machine on a network and may be reachable by other devices,
    depending on routing and firewall configuration.

When an application connects to `127.0.0.1`, the machine running the
client makes a connection to itself. It does not connect to another
computer.

## 5. Practical troubleshooting workflow

When a local API is not responding:

1.  Check whether the service is running.
2.  Use `ss -ltnp` to see whether it is listening.
3.  Confirm the listening port and address.
4.  Request the endpoint with `curl`.
5.  Inspect the HTTP status and headers.
6.  Check the machine's interfaces with `ip -4 addr`.
7.  Distinguish the loopback address from the machine's network-facing
    address.

Useful commands together:

``` bash
ss -ltnp
curl -i http://127.0.0.1:PORT/
ip -4 addr
ip addr show lo
hostname -I
```

Replace `PORT` with the actual service port.

## Quick revision

  -----------------------------------------------------------------------
  Concept                 Command or value        Purpose
  ----------------------- ----------------------- -----------------------
  Listening TCP ports     `ss -ltn`               Find services accepting
                                                  TCP connections

  Process using a port    `ss -ltnp`              Identify the listening
                                                  process

  HTTP request            `curl URL`              Send a request and view
                                                  the response

  Save response body      `curl -s -o file URL`   Save the body without
                                                  headers

  Headers only            `curl -I URL`           Inspect response
                                                  headers

  Network interfaces      `ip addr`               List interfaces and
                                                  addresses

  IPv4 only               `ip -4 addr`            Show IPv4 addresses

  Loopback interface      `lo`                    Interface for
                                                  communication with the
                                                  same host

  Loopback address        `127.0.0.1`             This machine itself

  Local hostname          `localhost`             Common name for the
                                                  loopback address
  -----------------------------------------------------------------------

## Key takeaways

-   A running process is not necessarily reachable; check its listening
    socket and port.
-   `ss -ltnp` helps identify listening TCP services and their
    processes.
-   `curl` can retrieve response bodies and inspect HTTP headers.
-   Use `curl -s -o` to save a clean response body.
-   `ip addr` shows network interfaces and their addresses.
-   `127.0.0.1` always refers to the local machine, through the loopback
    interface.
-   A `scope global` IPv4 address is different from the loopback address
    and is the relevant address to examine for network access.