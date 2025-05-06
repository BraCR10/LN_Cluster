#!/bin/bash

echo "=== DOCKER COMPLETE CLEANUP SCRIPT ==="
echo "This script will remove ALL Docker resources:"
echo "- Containers (running and stopped)"
echo "- Images"
echo "- Volumes"
echo "- Networks (except default ones)"
echo "- Build cache"
echo ""
echo "WARNING! This operation CANNOT BE UNDONE."
echo "Press CTRL+C to cancel or Enter to continue..."
read

echo ""
echo "1. Stopping all running containers..."
docker stop $(docker ps -q) 2>/dev/null || echo "No running containers."

echo ""
echo "2. Removing all containers..."
docker rm $(docker ps -a -q) 2>/dev/null || echo "No containers to remove."

echo ""
echo "3. Removing all volumes..."
docker volume rm $(docker volume ls -q) 2>/dev/null || echo "No volumes to remove."

echo ""
echo "4. Removing all networks (except default ones)..."
docker network rm $(docker network ls -q -f "type=custom") 2>/dev/null || echo "No custom networks to remove."

echo ""
echo "5. Removing all images..."
docker rmi $(docker images -q) -f 2>/dev/null || echo "No images to remove."

echo ""
echo "6. Cleaning orphaned resources and cache..."
docker system prune -f

echo ""
echo "=== CLEANUP COMPLETE ==="
echo "All Docker resources have been removed."