MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <CAFbutietUh=r65eZM7tGG+ST3RhS+pB+RJrX=ZK0jZehEyYaNA@mail.gmail.com>
References: <CAFbutietUh=r65eZM7tGG+ST3RhS+pB+RJrX=ZK0jZehEyYaNA@mail.gmail.com>
Date: Fri, 8 Mar 2013 14:47:42 -0800
Message-ID: <CAB=NE6VDJrNHr130gsiaoGcHOSpRadJYnJjE=qCNW3535LZX1g@mail.gmail.com>
Subject: Re: compat-driver doesn't compile
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Manu <vbmanu@gmail.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Fri, Mar 8, 2013 at 3:11 AM, Manu <vbmanu@gmail.com> wrote:
>> /compat-drivers-3.8-1/drivers/net/wireless/ath/ath5k/led.c:179:2: error:
>> implicit declaration of function 'pci_match_id'
>> [-Werror=implicit-function-declaration]

What kernel are you on?

uname -r

Also please note that compat-drivers-3.9-rc1-1 is out too, you should upgrade.

https://www.kernel.org/pub/linux/kernel/projects/backports/stable/v3.9-rc1/

  Luis
