mkcd(){ mkdir -p "$1" && cd "$1"; }
kpods(){ kubectl get pods -A; }
docker-clean(){ docker system prune -af --volumes; }
extract(){ tar -xf "$1"; }
