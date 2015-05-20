Return-path: <backports-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:55246 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbbETQzx (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 20 May 2015 12:55:53 -0400
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: Re: [PATCH] backport: allow compilation with Ubuntu's 3.13
Date: Wed, 20 May 2015 16:55:31 +0000
Message-ID: <1432140931.11332.6.camel@intel.com> (sfid-20150520_185555_080756_5B1D28D3)
References: <1432042936-23733-1-git-send-email-emmanuel.grumbach@intel.com>
			 (sfid-20150519_154230_230935_983C6CAB)
 <1432110463.2174.2.camel@sipsolutions.net>
			 <1432110664.5612.6.camel@intel.com>
			 <1432110893.2174.3.camel@sipsolutions.net>
		 <1432111194.8314.1.camel@intel.com> <555CA897.4010606@lwfinger.net>
	 <1432140155.11332.3.camel@intel.com> <555CBC12.4020800@lwfinger.net>
In-Reply-To: <555CBC12.4020800@lwfinger.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

T24gV2VkLCAyMDE1LTA1LTIwIGF0IDExOjUzIC0wNTAwLCBMYXJyeSBGaW5nZXIgd3JvdGU6DQo+
IE9uIDA1LzIwLzIwMTUgMTE6NDIgQU0sIEdydW1iYWNoLCBFbW1hbnVlbCB3cm90ZToNCj4gPg0K
PiA+IEdvb2QgcXVlc3Rpb24uLi4gSSBkb24ndCBrbm93LiBPVE9ILCBkaXN0cm9zIGRvbid0IHJl
YWxseSBzdXBwb3J0DQo+ID4gYmFja3BvcnQuIFlvdSBjYW4ndCByZWFsbHkgYmxhbWUgdGhlbSBp
ZiB0aGV5IGJyZWFrIGJhY2twb3J0LCB3aHkgc2hvdWxkDQo+ID4gdGhleSBjYXJlPw0KPiA+IEkg
YWdyZWUuIEl0IGlzIGFubm95aW5nLiBXZSBjYW4gdHJ5IHRvIGNvbnZpbmNlIHRoZW0sIGJ1dCBJ
IGRvbid0IHRoaW5rDQo+ID4gdGhhdCBzYXlpbmcgInlvdSBhcmUgYWxsIHdyb25nIiBpcyB0aGUg
cmlnaHQgcGF0aC4gTWF5YmUgd2Ugc2hvdWxkIHRyeQ0KPiA+IHRvIGhhdmUgdGhlbSBtb3JlIGlu
dm9sdmVkIGluIGJhY2twb3J0IHRvIGZpeCBpdCB0aGVtc2VsdmVzPw0KPiA+IEFuZCBleHBsYWlu
IHRvIHRoZW0gaG93IGltcG9ydGFudCBpdCBpcyB0byBiZSBhYmxlIHRvIHJ1biBiYWNrcG9ydCBv
bg0KPiA+IHRvcCBvZiBhbGwgdGhlaXIgc2hpcHBlZCBrZXJuZWxzPw0KPiANCj4gU3VwcG9ydGlu
ZyBiYWNrcG9ydCB3b3VsZCBiZSBhIGZpcnN0IHN0ZXAsIGJ1dCB0aGF0IHdvbid0IGhlbHAgYWxs
IG9mIHRoZSBydGw4KiANCj4gcmVwb3MgdGhhdCBJIGhhdmUgYXQgR2l0SHViLiBNb3N0IG9mIHRo
b3NlIGRvIG5vdCBoYXZlIGRyaXZlcnMgaW4gdGhlIGtlcm5lbCwgDQo+IHRodXMgdGhlIHVzZXJz
IGFyZSBkZXBlbmRlbnQgb24gdGhhdCBraW5kIG9mIGV4dGVybmFsIHJlcG87IGhvd2V2ZXIsIEkg
ZG8gbm90IA0KPiBoYXZlIGFueSBkZXNpcmUgdG8gZmluZCBvdXQgd2hhdCBtYWNybyBuZWVkcyB0
byBiZSB0ZXN0ZWQgc28gdGhhdCB0aGVzZSBkcml2ZXJzIA0KPiB3aWxsIGJ1aWxkIG9uIGRpc3Ry
b3MgdGhhdCBJIGRvIG5vdCB1c2UuDQo+IA0KPiBJIGd1ZXNzIEkgc2hvdWxkIHJlcG9ydCBhIGJ1
ZyB0byB3aGF0ZXZlciBkaXN0byBicmVha3MgbXkgZHJpdmVyIGFuZCByZXF1ZXN0IA0KPiB0aGF0
IHRoZXkgZml4IGl0LiBJIGFscmVhZHkga25vdyBob3cgbXVjaCB0aGF0IHdpbGwgaGVscCA6KQ0K
PiANCg0KSGVoIC0geWVhaC4gSSBjYW4gdGVsbCBJIHRyeSB0byBiZSAqdmVyeSogcmVzcG9uc2l2
ZSB3aGVuIHBlb3BsZSBhZGQNCmJ1Z3Mgb24gYnVnemlsbGEua2VybmVsLm9yZyBhYm91dCBpd2x3
aWZpLiBTb21lIHBlb3BsZSBhcmUgc3VycHJpc2VkIHRvDQpzZWUgdGhhdCB0aGUgaXNzdWUgaXMg
YWN0dWFsbHkgaGFuZGxlZCBhbmQgdGhhdCBzb21lb25lIHRha2VzIGNhcmUgb2YNCml0LiBUaGF0
IHRlYWNoZXMgbWUgd2hhdCBoYXBwZW5zIHRvIHRoZSBvdGhlciBpc3N1ZXMuLi4gOikNCg0KPiBM
YXJyeQ0KPiANCj4gDQoNCg==
