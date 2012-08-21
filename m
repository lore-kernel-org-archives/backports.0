Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44897 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757890Ab2HUQWa convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 21 Aug 2012 12:22:30 -0400
Received: by yhmm54 with SMTP id m54so5973832yhm.19
        for <backports@vger.kernel.org>; Tue, 21 Aug 2012 09:22:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1345135656-9563-1-git-send-email-ozancag@gmail.com>
References: <1345135656-9563-1-git-send-email-ozancag@gmail.com>
Date: Tue, 21 Aug 2012 19:22:28 +0300
Message-ID: <CAFub=KQkpJtQ0ya2HKHi_T5iP=fzpJEN=jP-zOuWqOL80H_H7A@mail.gmail.com>
Subject: Re: [PATCH] compat-drivers: Use case instead of if/if/.. blocks
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Aug 16, 2012 at 7:47 PM, Ozan Çağlayan <ozancag@gmail.com> wrote:
> case is much cleaner both for reading and for extending.
>
> Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
> ---
>  scripts/admin-update.sh | 71 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 37 insertions(+), 34 deletions(-)

Did you miss this?



-- 
Ozan Çağlayan
