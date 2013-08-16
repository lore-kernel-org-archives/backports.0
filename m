Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:53180 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab3HPKpR (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 Aug 2013 06:45:17 -0400
Message-ID: <520E02B8.5040305@hauke-m.de> (sfid-20130816_124519_491697_D1DD7D08)
Date: Fri, 16 Aug 2013 12:45:12 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: ww_mutex compile warning
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Luis,

The empty implementations of owner_running() and mutex_spin_on_owner()
in backport/compat/kernel/ww_mutex.c should return something (one an in,
one an bool), but they don't. That causes a compile warning about a
missing return statement with kernel 3.9. I do not understand that code,
could you please have a look into that.

Hauke
