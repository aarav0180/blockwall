module.exports = {
    networks: {
        development: {
            host: "127.0.0.1",
            port: 5999,
            network_id: 5777,
        }
    },
    contracts_directory: "./contracts",
    compilers: {
        solc: {
            version: "0.8.19",
            optimizer:{
                enabled: true,
                runs: 200,
            }
        }
    },
    db: {
        enabled: false,
    }
    
}