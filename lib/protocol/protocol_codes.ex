defmodule Multiaddr.Protocol.Codes do
  @moduledoc false

  import Multiaddr.Utils.Constants, only: :macros

  define(:c_ip4, 4)
  define(:c_tcp, 6)
  define(:c_udp, 274)
  define(:c_dccp, 33)
  define(:c_ip6, 41)
  define(:c_ip6zone, 42)
  define(:c_dns, 53)
  define(:c_dns4, 54)
  define(:c_dns6, 55)
  define(:c_dnsaddr, 56)
  define(:c_sctp, 132)
  define(:c_udt, 301)
  define(:c_utp, 302)
  define(:c_unix, 400)
  define(:c_p2p, 421)
  define(:c_ipfs, 421)
  define(:c_onion, 444)
  define(:c_onion3, 445)
  define(:c_garlic64, 446)
  define(:c_garlic32, 447)
  define(:c_tls, 448)
  define(:c_quic, 460)
  define(:c_http, 480)
  define(:c_https, 443)
  define(:c_ws, 477)
  define(:c_wss, 478)
  define(:c_p2p_websocket_star, 479)
  define(:c_p2p_stardust, 277)
  define(:c_p2p_webrtc_star, 275)
  define(:c_p2p_webrtc_direct, 276)
  define(:c_p2p_circuit, 290)
  define(:c_memory, 777)
end
