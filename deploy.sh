docker build -t smukes/multi-client:latest -t smukes/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t smukes/multi-server:latest -t smukes/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t smukes/multi-worker:latest -t smukes/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push smukes/multi-client:latest
docker push smukes/multi-client:$SHA
docker push smukes/multi-server:latest
docker push smukes/multi-server:$SHA
docker push smukes/multi-worker:latest
docker push smukes/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=smukes/multi-server:$SHA
kubectl set image deployments/client-deployment client=smukes/multi-client:$SHA
kubectl set image deplpoyments/worker-deployment worker=smukes/multi-worker:$SHA