Return-path: <backports-owner@vger.kernel.org>
Received: from mail.pindomains.com ([173.248.156.94]:57818 "EHLO
	mail.pindomains.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab3JVFKq (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 22 Oct 2013 01:10:46 -0400
Message-ID: <20131022102512.344258ylonx8mckk@192.168.50.55> (sfid-20131022_071048_958497_93A4A0D7)
Date: Tue, 22 Oct 2013 10:25:12 +0530
From: "ravikant patel" <ravikant.patel@matrixcomsec.com>
To: backports@vger.kernel.org
Cc: "Ronak Shah" <ronak.shah@matrixcomsec.com>
Subject: Backports driver not support fragmentation Threshold
MIME-Version: 1.0
Content-Type: text/plain;
	charset=;
	DelSp="Yes";
	format="flowed"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi All,

We are using hostapd daemon(2.0)  and Back Ports Wireless  
driver(3.10.4-1) in our WiFi Access Point.
In the hostapd daemon configuration file (hostapd.conf)  Fragmentation  
Threshold parameter is
available.
The parameter purpose is that if the data which is sending more then  
this limit then it will
fragment the data and send the data in the different frame.

I have configure this Fragmentation Threshold to 500 in my Access Point.
 From One Wireless client i Ping with data 1000 byte .
I have capture the Ping Request and Response using network monitor .
Now according to this Ping Replay must be received in Two packet but I  
received the Ping replay with 1000 byte in single packet.

So From the test I found that fragmentation is not working that is set  
in the  the hostapd.

My question :
Does the fragmentation responsibility of hostapd daemon or back port driver?

Regards,

Ravikant Patel




