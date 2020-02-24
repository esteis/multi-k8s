docker build -t esteis/multi-client:latest -t esteis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t esteis/multi-server:latest -t esteis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t esteis/multi-worker:latest -t esteis/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push esteis/multi-client:latest
docker push esteis/multi-server:latest
docker push esteis/multi-worker:latest

docker push esteis/multi-client:$SHA
docker push esteis/multi-server:$SHA
docker push esteis/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=esteis/multi-server:$SHA
kubectl set image deployments/client-deployment client=esteis/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=esteis/multi-worker:$SHA