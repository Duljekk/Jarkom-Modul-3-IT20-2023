echo '
{
  "username": "kelompokit20",
  "password": "passwordit20"
}' > /root/register.json

ab -n 100 -c 10 -p register.json -T application/json http://192.243.4.1:8001/api/auth/register

echo '
{
  "username": "kelompokit20",
  "password": "passwordit20"
}' > /root/login.json

ab -n 100 -c 10 -p register.json -T application/json http://192.243.4.1:8001/api/auth/login

curl -X POST -H "Content-Type: application/json" -d @login.json http://192.243.4.1:8001/api/auth/login > output.txt

token=$(cat output.txt | jq -r '.token')

ab -n 100 -c 10 -H "Authorization: Bearer $token" http://192.243.4.1:8001/api/me

ab -n 100 -c 10 -p login.json -T application/json http://www.riegel.canyon.it20.com/api/auth/login

ab -n 100 -c 10 -p login.json -T application/json http://www.riegel.canyon.it20.com/api/auth/login

ab -n 100 -c 10 -p login.json -T application/json http://www.riegel.canyon.it20.com/api/auth/login




