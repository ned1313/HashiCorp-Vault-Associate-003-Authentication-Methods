# Just run the following command to start the LDAP server:
docker run --rm -it -p 10389:389 -p 10636:636 ghcr.io/ldapjs/docker-test-openldap/openldap:latest

# LDAP Values
# Set URL to ldap://127.0.0.1:10389
# Set User Attribute to uid
# Set binddn to cn=admin,dc=planetexpress,dc=com
# Set the User DN to ou=people,dc=planetexpress,dc=com
# Set the bindpass to GoodNewsEveryone
# Set the groupdn to ou=people,dc=planetexpress,dc=com
