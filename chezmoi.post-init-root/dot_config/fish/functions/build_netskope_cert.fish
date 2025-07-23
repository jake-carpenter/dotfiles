function build_netskope_cert
    set -g target "/Library/Application Support/Netskope/STAgent/data/nsacert_combined.pem"
    set -g root_keychain "/System/Library/Keychains/SystemRootCertificates.keychain"
    set -g system_keychain "/Library/Keychains/System.keychain"
    set -g tmp "/tmp/nscacert_combined.pem"

    echo "⚙️ Creating combined certificate bundle"
    security find-certificate -a -p $root_keychain $system_keychain >$tmp

    echo "🚀 Copying certificate (you will be asked for your password)"
    sudo cp $tmp $target
    rm $tmp

    echo -e (set_color green)"✅"(set_color normal)" Created certificate at "(set_color blue)$target(set_color normal)

    echo
    echo (set_color yellow)"Ensure your profile contains these settings:"(set_color normal)
    echo
    echo -e "set -gx NODE_EXTRA_CA_CERTS $target"
    echo -e "set -gx REQUESTS_CA_BUNDLE $target"
    echo -e "set -gx CURL_CA_BUNDLE $target"
    echo -e "set -gx GIT_SSL_CAPATH $target"
end
