puppet facts find --render-as json > /opt/puppetlabs/facts.out

HOSTCERT=$(puppet config print hostcert)
PRIVKEY=$(puppet config print hostprivkey)
CACERT=$(puppet config print cacert)

HOSTNAME=$(hostname -f)

while true; do

  curl -X POST --cert $HOSTCERT --key $PRIVKEY --cacert $CACERT https://$HOSTNAME:8140/puppet/v3/catalog/$HOSTNAME?environment=production --data-urlencode 'facts_format=pson' --data-urlencode "facts=$(/opt/puppetlabs/puppet/bin/ruby -rcgi -e "puts CGI.escape('$(cat /opt/puppetlabs/facts.out)')")" > /dev/null

done
