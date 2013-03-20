Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: ben@decadent.org.uk,
	noelamac@gmail.com,
	linux-kernel@vger.kernel.org,
	rusty@rustcorp.com.au,
	andi@firstfloor.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 26/30] compat: embrace LINUX_BACKPORT() for crc8
Date: Wed, 20 Mar 2013 02:22:51 -0700
Message-Id: <1363771375-31715-27-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1363771375-31715-1-git-send-email-mcgrof@do-not-panic.com>
References: <1363771375-31715-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.65              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.38              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.32              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.9               [  OK  ]
25  3.8.0               [  OK  ]
26  3.9-rc1             [  OK  ]

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 include/linux/crc8.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/crc8.h b/include/linux/crc8.h
index 13c8dab..f0a92ef 100644
--- a/include/linux/crc8.h
+++ b/include/linux/crc8.h
@@ -52,6 +52,7 @@
  *
  * - lsb first: poly = 10101011(1) = 0xAB
  */
+#define crc8_populate_lsb LINUX_BACKPORT(crc8_populate_lsb)
 void crc8_populate_lsb(u8 table[CRC8_TABLE_SIZE], u8 polynomial);
 
 /**
@@ -70,6 +71,7 @@ void crc8_populate_lsb(u8 table[CRC8_TABLE_SIZE], u8 polynomial);
  *
  * - msb first: poly = (1)11010101 = 0xD5
  */
+#define crc8_populate_msb LINUX_BACKPORT(crc8_populate_msb)
 void crc8_populate_msb(u8 table[CRC8_TABLE_SIZE], u8 polynomial);
 
 /**
@@ -96,6 +98,7 @@ void crc8_populate_msb(u8 table[CRC8_TABLE_SIZE], u8 polynomial);
  * Williams, Ross N., ross<at>ross.net
  * (see URL http://www.ross.net/crc/download/crc_v3.txt).
  */
+#define crc8 LINUX_BACKPORT(crc8)
 u8 crc8(const u8 table[CRC8_TABLE_SIZE], u8 *pdata, size_t nbytes, u8 crc);
 
 #endif /* __CRC8_H_ */
-- 
1.7.10.4
