{ pkgs ? import <nixpkgs> {} }:

let
  pythonEnv = pkgs.python310.withPackages (ps: with ps; [
    pandas
    matplotlib
    numpy
    ipython
    jupyter
    jupyterlab
    pyspark
    ipykernel
    duckdb             # SQL moderno embutido (pode ler CSVs, Parquet, etc.)
    sqlalchemy         # ORM se quiseres usar
  ]);
in

pkgs.mkShell {
  buildInputs = [
    pythonEnv
    pkgs.openjdk11
    pkgs.sqlite
    pkgs.bashInteractive
  ];

  shellHook = ''
    export EDITOR=vim
    export JAVA_HOME=${pkgs.openjdk11}
    echo "✅ Ambiente com Python, Spark e SQL carregado"
  '';
}