// to be able to login
path "auth/approle/login/" {
	capabilities = [ "create"]
}

path "sys/wrapping/wrap" {
    capabilities = ["create"]
}

path "auth/token/*" {
    capabilities = ["create"]
}