defmodule SiteGen do
  @moduledoc """
  Documentation for SiteGen.
  """

  @doc """
	Generate a static site 

  ## Examples
	site_gen --name name-of-your-react-app

  """

  def main(args) do
		args |> parse_args |> process |> done
  end

	def done(_) do
		System.halt(0)
	end 

	def parse_args(args) do
		 OptionParser.parse(args)
	end

	def process(options) do
		new_directory(options)
		|> yarnify
		|> install_deps
		|> start_app
	end

	def start_app(name) do
		System.cmd "ls", ['-a']
		System.halt(0)
		System.cmd "cd", [name]	
		System.cmd "yarn", ["start"]	
	end 

	def new_directory({[name: name], _, _}) do
		System.cmd "mkdir", [name]
		System.cmd "cd", [name]
		name
	end

	def yarnify(name) do
		try_yarn(name)
	end

	def try_yarn(name) do
		System.cmd "yarn", ["init","-y"]
		name
	end

	def exit_error(name) do
		IO.warn("#{name} broke")
		done(name)
	end


	def install_deps(name) do
		System.cmd "yarn", ["install"]
		System.cmd "cd", [name]
		System.cmd "create-react-app", [name]
		name
	end
end
