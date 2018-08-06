# Deploying Vault and Consul

## Want to learn how to build this?

Check out the [post](https://testdriven.io/deploying-vault-and-consul).

## Want to use this project?

1. Fork/Clone

1. [Sign up](https://m.do.co/c/d8f211a4b4c2) for Digital Ocean and [generate](https://www.digitalocean.com/community/tutorials/how-to-use-the-digitalocean-api-v2) an access token

1. Add the token to your environment:

    ```sh
    $ export DIGITAL_OCEAN_ACCESS_TOKEN=[your_token]
    ```

1. Spin up three droplets and deploy via Docker Swarm:

    ```sh
    $ sh deploy.sh
    ```
