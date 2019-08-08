docker build -t mchvs/multi-client:latest -t mchvs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mchvs/multi-server:latest -t mchvs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mchvs/multi-worker:latest -t mchvs/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mchvs/multi-client
docker push mchvs/multi-server
docker push mchvs/multi-worker

docker push mchvs/multi-client:$SHA
docker push mchvs/multi-server:$SHA
docker push mchvs/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=mchvs/multi-client:$SHA
kubectl set image deployments/server-deployment server=mchvs/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=mchvs/multi-worker:$SHA

# kubectl rollout restart deployment/client-deployment
# kubectl rollout restart deployment/server-deployment
# kubectl rollout restart deployment/worker-deployment
