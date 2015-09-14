Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36298 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109AbbINVZ1 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 17:25:27 -0400
Subject: Re: [PATCH] backports: update Kconfig tools from upstream
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1440407785-9458-1-git-send-email-johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <55F73B45.1060401@hauke-m.de> (sfid-20150914_232533_406804_D26F693C)
Date: Mon, 14 Sep 2015 23:25:25 +0200
MIME-Version: 1.0
In-Reply-To: <1440407785-9458-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08/24/2015 11:16 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/compat/Kconfig                   |    9 +
>  backport/kconf/conf.c                     |   26 +-
>  backport/kconf/confdata.c                 |  114 +++-
>  backport/kconf/expr.c                     |  288 ++++----
>  backport/kconf/expr.h                     |   17 +-
>  backport/kconf/list.h                     |   44 +-
>  backport/kconf/lkc.h                      |   18 +-
>  backport/kconf/lkc_proto.h                |   84 ++-
>  backport/kconf/lxdialog/check-lxdialog.sh |   12 +-
>  backport/kconf/lxdialog/checklist.c       |   12 +-
>  backport/kconf/lxdialog/dialog.h          |   25 +-
>  backport/kconf/lxdialog/inputbox.c        |   10 +-
>  backport/kconf/lxdialog/menubox.c         |   19 +-
>  backport/kconf/lxdialog/textbox.c         |    6 +-
>  backport/kconf/lxdialog/util.c            |   87 ++-
>  backport/kconf/lxdialog/yesno.c           |    8 +-
>  backport/kconf/mconf.c                    |  202 ++++--
>  backport/kconf/menu.c                     |   99 ++-
>  backport/kconf/symbol.c                   |  151 +++--
>  backport/kconf/util.c                     |   12 -
>  backport/kconf/zconf.hash.c               |   13 +-
>  backport/kconf/zconf.lex.c                |  318 +++++----
>  backport/kconf/zconf.tab.c                | 1014 ++++++++++++++++-------------
>  23 files changed, 1583 insertions(+), 1005 deletions(-)
> 
Thank you for the patch, it was applied and pushed out.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
