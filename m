MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <157393863283F442885425D2C45428562A4FFF1D@nasanexd02f.na.qualcomm.com>
References: <1348824541-12396-1-git-send-email-xiong@qca.qualcomm.com>
	<CAB=NE6UsbbXdhQh9hqRxByAVqtskpE4xW0Kz9ascip_8-K56ag@mail.gmail.com>
	<157393863283F442885425D2C45428562A4FFF1D@nasanexd02f.na.qualcomm.com>
Date: Wed, 3 Oct 2012 08:23:31 -0700
Message-ID: <CAB=NE6V5cNQYXD5wMNSO4Y8ZHW-sETvq1ASX8tBUDMn36bJmZQ@mail.gmail.com>
Subject: Re: [PATCH] compat-drivers: update ethernet driver alx in crap dir
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: "Huang, Xiong" <xiong@qca.qualcomm.com>
Cc: "mcgrof@kernel.org" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>, nic-devel <nic-devel@qualcomm.com>,
	"Ren, Cloud" <cjren@qca.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Wed, Oct 3, 2012 at 5:25 AM, Huang, Xiong <xiong@qca.qualcomm.com> wrote:
>> Xiong,
>>
>> You are deleting the file
>> crap/network/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-
>> atl.patch
>> here and then you are updating the
>> crap/network/0002-backport-alx.patch file. What you likely wanted to do was
>> to remove the original crap/network/0001-alx-add-new-QCA-ethernet-driver-
>> which-supercedes-atl.patch
>> file and then git add a new crap/network/0001-something.patch which you
>> likely forgot to do.
>>
> Luis, I just thought the patch name could be a bit more appropriated. Sorry to confuse you :(
> I will resend the patch with the same patch file name, I mean just 'update' the original
> patch files (0001 & 0002), is it ok for you ?

Either way is fine. I just meant that in your patch you forgot to
provide a replacement for the old patch.

  Luis
