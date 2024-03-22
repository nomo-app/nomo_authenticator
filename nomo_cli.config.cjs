const nomoCliConfig = {
    deployTargets: {
        production: {
            rawSSH: {
                sshHost: process.env.SSH_TARGET,
                sshBaseDir: "/var/www/nomo_authenticator",
                publicBaseUrl: "https://auth.nomo.zone",
                hybrid: true,
            },
        },
    },
};

module.exports = nomoCliConfig;