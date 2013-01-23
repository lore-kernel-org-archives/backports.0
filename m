Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: hauke@hauke-m.de
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/1] compat: ppc stable assembly fix
Date: Wed, 23 Jan 2013 13:22:43 -0800
Message-Id: <1358976165-22389-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Hauke,

here's a patch I had almost missed by Felix for compat. I've
test compiled this with ckmake against master branch of compat,
compat-drivers on the linux-next tag next-20130123 (today's
release). This fix should also be applied to the linux-3.8.y
and linux-3.7.y branches.

The below is the ckmake log on compat-drivers after applying
the patch to compat.

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
17  3.0.50              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.33              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.17              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.5               [  OK  ]
24  3.7.0               [  OK  ]

real    13m33.413s
user    336m14.841s
sys     48m46.255s

Felix Fietkau (1):
  compat: fix compile errors when assembly is built into modules

 include/linux/compat-2.6.h |    4 ++++
 1 file changed, 4 insertions(+)

-- 
1.7.10.4
