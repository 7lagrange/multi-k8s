docker build -t 7lagrange/multi-client:latest -t 7lagrange/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t 7lagrange/multi-server:latest -t 7lagrange/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 7lagrange/multi-worker:latest -t 7lagrange/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push 7lagrange/multi-client:latest
docker push 7lagrange/multi-server:latest
docker push 7lagrange/multi-worker:latest
docker push 7lagrange/multi-client:$SHA
docker push 7lagrange/multi-server:$SHA
docker push 7lagrange/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=7lagrange/multi-server:$SHA
kubectl set image deployments/client-deployment client=7lagrange/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=7lagrange/multi-worker:$SHA