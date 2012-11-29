MIME-Version: 1.0
In-Reply-To: <1354143460-28164-4-git-send-email-hauke@hauke-m.de>
References: <1354143460-28164-1-git-send-email-hauke@hauke-m.de>
	<1354143460-28164-4-git-send-email-hauke@hauke-m.de>
Date: Thu, 29 Nov 2012 10:30:49 -0800
Message-ID: <CAB=NE6XbBOn8TNn_2oaM+BkSKxUobMFqSCU4eUz++3hORUGwXw@mail.gmail.com>
Subject: Re: [PATCH 4/4] compat: move config_enabled to compat-3.4.h
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Wed, Nov 28, 2012 at 2:57 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> diff --git a/include/linux/compat-3.1.h b/include/linux/compat-3.1.h
> index fc05245..71bc00f 100644
> --- a/include/linux/compat-3.1.h
> +++ b/include/linux/compat-3.1.h

> @@ -63,7 +50,7 @@ static inline struct sk_buff *__netdev_alloc_skb_ip_align(struct net_device *dev
>   *
>   */
>  #define IS_ENABLED(option) \
> -        (config_enabled(option) || config_enabled(option##_MODULE))
> +       (config_enabled(option) || config_enabled(option##_MODULE))

This hunk is not required, right?

  Luis
