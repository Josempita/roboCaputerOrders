while true 
do
curl -v -d "" -X POST --header 'Accept: application/json' 'http://52.226.72.185/v1/Order?EmailAddress=sachinnaidoo%40hotmail.com&PreferredLanguage=en&Total=100'
sleep 0.5
done