defmodule Mix.Tasks.Day do
  @moduledoc "Generates file templates"
  @shortdoc "Generates file templates"

  use Mix.Task

  @impl Mix.Task
  @spec run([...]) :: any()
  def run([day]) do
    module_file = "lib/d#{day}.ex"

    if File.exists?(module_file) do
      input = IO.gets("File #{module_file} already exists. Overwrite? [y/n]\n")
      if String.downcase(input) == "y\n", do: write_files(module_file, day)
    else
      write_files(module_file, day)
    end
  end

  defp write_files(module_file, day) do
    Mix.shell().cmd("echo '#{module_template(day)}' > #{module_file}")
    Mix.shell().cmd("echo '#{test_module_template(day)}' > test/d#{day}_test.exs")
    Mix.shell().cmd("touch test/d#{day}.txt")
    Mix.Shell.IO.info("Files written !")
  end

  def module_template(day) do
    """
    defmodule D#{day} do
      def p1(file) do
        file
        |> File.read!()
        |> String.split("\\\\n")
      end

      def p2(file) do
        file
        |> File.read!()
        |> String.split("\\\\n")
      end
    end
    """
  end

  def test_module_template(day) do
    """
    defmodule D#{day}Test do
      use ExUnit.Case

      test "p1" do
        assert D#{day}.p1("test/d#{day}.txt") == 0
      end

      #test "p2" do
      #  assert D#{day}.p2("test/d#{day}.txt") == 0
      #end
    end
    """
  end
end
