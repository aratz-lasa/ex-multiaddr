defmodule Multiaddr.Transcoder do
  import Multiaddr.Utils.Constants

  defstruct [:bytes_to_string, :string_to_bytes, :validate_bytes]

  # Default
  def default_bytes_to_string(bytes) when is_binary(bytes) do
    {:ok, bytes}
  end

  def default_string_to_bytes(string) when is_binary(string) do
    if true = String.valid?(string) do
      {:ok, string}
    else
      {:error, "Invalid string"}
    end
  end

  def default_validate_bytes(bytes) when is_binary(bytes) do
    {:ok, bytes}
  end

  # Text
  def text_bytes_to_string(bytes) when is_binary(bytes) do
    if true == valid_text?(bytes) do
      {:ok, bytes}
    else
      {:error, "Invalid bytes"}
    end
  end

  def text_string_to_bytes(string) when is_binary(string) do
    if true == valid_text?(string) do
      {:ok, string}
    else
      {:error, "Invalid string"}
    end
  end

  def text_validate_bytes(bytes) when is_binary(bytes) do
    if true == valid_text?(bytes) do
      {:ok, bytes}
    else
      {:error, "Invalid bytes"}
    end
  end

  def valid_text?(string) when is_binary(string) do
    with true <- String.valid?(string),
         false <- String.contains?(string, "/") do
      true
    else
      _ -> false
    end
  end

  # IP4
  def ip4_bytes_to_string(bytes) when is_binary(bytes) do
    try do
      string =
        bytes
        |> :binary.bin_to_list()
        |> Enum.join(".")

      {:ok, string}
    rescue
      _ -> {:error, "Invalid IP4 string"}
    end
  end

  def ip4_string_to_bytes(string) when is_binary(string) do
    try do
      bytes =
        string
        |> to_charlist()
        |> :inet.parse_ipv4_address()
        |> elem(1)
        |> Tuple.to_list()
        |> :binary.list_to_bin()

      {:ok, bytes}
    rescue
      _ -> {:error, "Invalid IP4 bytes"}
    end
  end

  # IP6
  def ip6_bytes_to_string(bytes) when is_binary(bytes) do
    try do
      string =
        bytes
        |> :binary.bin_to_list()
        |> Enum.chunk_every(2)
        |> Enum.map(&:binary.list_to_bin/1)
        |> Enum.map(fn x ->
          <<integer::size(16)>> = x
          integer
        end)
        |> Enum.join(":")

      {:ok, string}
    rescue
      _ -> {:error, "Invalid IP6 string"}
    end
  end

  def ip6_string_to_bytes(string) when is_binary(string) do
    try do
      bytes =
        string
        |> to_charlist()
        |> :inet.parse_ipv6_address()
        |> elem(1)
        |> Tuple.to_list()
        |> Enum.map(fn x -> <<x::size(16)>> end)
        |> :binary.list_to_bin()

      {:ok, bytes}
    rescue
      _ -> {:error, "Invalid IP4 bytes"}
    end
  end

  # Port
  def port_bytes_to_string(bytes) when is_binary(bytes) do
    try do
      <<integer::size(16)>> = bytes
      string = to_string(integer)
      {:ok, string}
    rescue
      _ -> {:error, "Invalid port"}
    end
  end

  def port_string_to_bytes(string) when is_binary(string) do
    try do
      integer = String.to_integer(string)

      true = integer < 65536
      bytes = <<integer::size(16)>>
      {:ok, bytes}
    rescue
      _ -> {:error, "Invalid port"}
    end
  end

  define(:ip4_transcoder, %__MODULE__{
    bytes_to_string: &ip4_bytes_to_string/1,
    string_to_bytes: &ip4_string_to_bytes/1,
    validate_bytes: &default_validate_bytes/1
  })

  define(:ip6_transcoder, %__MODULE__{
    bytes_to_string: &ip6_bytes_to_string/1,
    string_to_bytes: &ip6_string_to_bytes/1,
    validate_bytes: &default_validate_bytes/1
  })

  define(:port_transcoder, %__MODULE__{
    bytes_to_string: &port_bytes_to_string/1,
    string_to_bytes: &port_string_to_bytes/1,
    validate_bytes: &default_validate_bytes/1
  })

  define(:ip6zone, %__MODULE__{
    bytes_to_string: &text_bytes_to_string/1,
    string_to_bytes: &text_string_to_bytes/1,
    validate_bytes: &text_validate_bytes/1
  })
end
