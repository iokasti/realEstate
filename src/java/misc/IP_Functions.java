package misc;

import java.net.InetAddress;
import java.net.UnknownHostException;

public class IP_Functions {

    public static int pack(String client_ip_string) throws UnknownHostException {
        int val = 0;
        byte[] bytes = InetAddress.getByName(client_ip_string).getAddress();
        for (int i = 0; i < bytes.length; i++) {
            val <<= 8;
            val |= bytes[i] & 0xff;
        }
        return val;
    }

    public static String unpack(int bytes) throws UnknownHostException {
        return InetAddress.getByAddress(new byte[]{
            (byte) ((bytes >>> 24) & 0xff),
            (byte) ((bytes >>> 16) & 0xff),
            (byte) ((bytes >>> 8) & 0xff),
            (byte) ((bytes) & 0xff)
        }).getHostAddress();
    }
}
