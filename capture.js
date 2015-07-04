var pcap = require('pcap'),
    pcap_session = pcap.createSession('wlan1', 'wlan type mgt subtype probe-req');

pcap_session.on('packet', function (raw_packet) {
  var packet = pcap.decode.packet(raw_packet);
  console.log(raw_packet);
});
