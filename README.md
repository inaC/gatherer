# Gatherer

## Installation

Installation can be done using [`asdf`](https://asdf-vm.com), which requires the following plugings:

- [asdf-erlang](https://github.com/asdf-vm/asdf-erlang)
- [asdf-elixir](https://github.com/asdf-vm/asdf-elixir)

Once the plugins are installed, type the following command on the project directory:

```sh
asdf install
```

## Running the app

1. Install the app dependencies:
    ```sh
    mix deps.get
    ```
1. Compile the app:
    ```sh
    mix compile
    ```
1. Access the iex terminal:
    ```sh
    iex -S mix
    ```
1. Try out:
    ```elixir
    Gatherer.fetch("https://www.google.com")
    ```

## Tests

In order to run the tests, type the following:
```sh
mix test
```

In order to see the coverage, add the `--cover` option:
```sh
mix test --cover
```

## Assumptions made

- The `fetch` function does not check whether the img sources or the anchor hrefs  follow the URL syntax. Given more time, one may add validations, as a next step.
