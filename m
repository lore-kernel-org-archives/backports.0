Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:38822 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750994AbdBFLfG (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 6 Feb 2017 06:35:06 -0500
Message-ID: <1486380902.5430.1.camel@sipsolutions.net> (sfid-20170206_123508_512386_8466ADBF)
Subject: matching a modified identifier?
From: Johannes Berg <johannes@sipsolutions.net>
To: cocci <cocci@systeme.lip6.fr>
Cc: backports <backports@vger.kernel.org>
Date: Mon, 06 Feb 2017 12:35:02 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

In backports, we have the following spatch:

@ attribute_group @
identifier group;
declarer name ATTRIBUTE_GROUPS;
@@

ATTRIBUTE_GROUPS(group);

@ class_group depends on attribute_group @
identifier group_class;
identifier groups;
fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
@@

struct class group_class = {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
        .dev_groups = groups,
+#else
+       .dev_attrs = group_dev_attr,
+#endif
};

[...]



But this isn't sufficient and falls over if there are multiple
instances of ATTRIBUTE_GROUPS, it's essentially undefined which one
gets picked.

I tried to match a modified identifier like this:

@ attribute_group @
identifier group;
fresh identifier groups = group ## "_groups";
declarer name ATTRIBUTE_GROUPS;
@@

ATTRIBUTE_GROUPS(group);

@ class_group depends on attribute_group @
identifier group_class;
identifier attribute_group.groups;
fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
@@

struct class group_class = {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
        .dev_groups = groups,
+#else
+       .dev_attrs = group_dev_attr,
+#endif
};

[...]


but that doesn't work at all.

Any thoughts?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
