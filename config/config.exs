import Config

config :advent_of_code_utils,
  session: System.get_env("AOC_SESSION_TOKEN"),
  auto_reload?: true
