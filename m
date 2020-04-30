Return-Path: <SRS0=fJJY=6O=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46577C4724C
	for <backports@archiver.kernel.org>; Thu, 30 Apr 2020 21:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A88C2186A
	for <backports@archiver.kernel.org>; Thu, 30 Apr 2020 21:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgD3V1i convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgD3V1g (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 30 Apr 2020 17:27:36 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 207529] New: firewire load error wifi ax 200
Date:   Thu, 30 Apr 2020 21:27:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: andre@academ.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-207529-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207529

            Bug ID: 207529
           Summary: firewire load error wifi ax 200
           Product: Backports project
           Version: unspecified
    Kernel Version: 4.9.140-tegra
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: andre@academ.org
        Regression: No

the issue is defined in the post
https://forums.developer.nvidia.com/t/failed-to-use-wifi-module-on-nx/121553/15?u=andrey1984

it will throw :
 cat dmesg.log 
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.140-tegra (buildbrain@mobile-u64-3193) (gcc
version 7.3.1 20180425 [linaro-7.3-2018.05 revision
d29120a424ecfbc167ef90065c0eeb7f91977701] (Linaro GCC 7.3-2018.05) ) #1 SMP
PREEMPT Wed Apr 8 18:15:20 PDT 2020
[    0.000000] Boot CPU: AArch64 Processor [4e0f0040]
[    0.000000] OF: fdt:memory scan node memory, reg size 48,
[    0.000000] OF: fdt: - 80000000 ,  2c000000
[    0.000000] OF: fdt: - ac200000 ,  44600000
[    0.000000] OF: fdt: - 100000000 ,  180000000
[    0.000000] earlycon: tegra_comb_uart0 at MMIO32 0x000000000c168000 (options
'')
[    0.000000] bootconsole [tegra_comb_uart0] enabled
[    0.000000] OF: fdt:Reserved memory: failed to reserve memory for node
'fb0_carveout': base 0x0000000000000000, size 0 MiB
[    0.000000] OF: fdt:Reserved memory: failed to reserve memory for node
'fb0_carveout': base 0x0000000000000000, size 0 MiB
[    0.000000] OF: fdt:Reserved memory: failed to reserve memory for node
'fb1_carveout': base 0x0000000000000000, size 0 MiB
[    0.000000] OF: fdt:Reserved memory: failed to reserve memory for node
'fb1_carveout': base 0x0000000000000000, size 0 MiB
[    0.000000] OF: fdt:Reserved memory: failed to reserve memory for node
'fb2_carveout': base 0x0000000000000000, size 0 MiB
[    0.000000] OF: fdt:Reserved memory: failed to reserve memory for node
'fb2_carveout': base 0x0000000000000000, size 0 MiB
[    0.000000] OF: fdt:Reserved memory: failed to reserve memory for node
'fb3_carveout': base 0x0000000000000000, size 0 MiB
[    0.000000] OF: fdt:Reserved memory: failed to reserve memory for node
'fb3_carveout': base 0x0000000000000000, size 0 MiB
[    0.000000] OF: reserved mem: initialized node ramoops_carveout, compatible
id nvidia,ramoops
[    0.000000] OF: reserved mem: initialized node vpr-carveout, compatible id
nvidia,vpr-carveout
[    0.000000] OF: reserved mem: initialized node grid-of-semaphores,
compatible id nvidia,gosmem
[    0.000000] cma: Reserved 64 MiB at 0x00000000c2000000
[    0.000000] On node 0 totalpages: 2032640
[    0.000000]   DMA zone: 7184 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 459776 pages, LIFO batch:31
[    0.000000]   Normal zone: 24576 pages used for memmap
[    0.000000]   Normal zone: 1572864 pages, LIFO batch:31
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 25 pages/cpu @ffffffc1ffd04000 s61656 r8192
d32552 u102400
[    0.000000] pcpu-alloc: s61656 r8192 d32552 u102400 alloc=25*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 
[    0.000000] Speculative Store Bypass Disable mitigation not required
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total
pages: 2000880
[    0.000000] Kernel command line: root=/dev/mmcblk0p1 rw rootwait
rootfstype=ext4 console=ttyTCU0,115200n8 console=tty0 fbcon=map:0 net.ifnames=0
video=tegrafb no_console_suspend=1 earlycon=tegra_comb_uart,mmio32,0x0c168000
gpt usbcore.old_scheme_first=1 tegraid=19.1.2.0.0 maxcpus=6 boot.slot_suffix=
boot.ratchetvalues=0.4.2 vpr_resize sdhci_tegra.en_boot_part_access=1    quiet
[    0.000000] log_buf_len individual max cpu contribution: 32768 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 163840 bytes
[    0.000000] log_buf_len min size: 32768 bytes
[    0.000000] log_buf_len: 262144 bytes
[    0.000000] early log buf free: 29104(88%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608
bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304
bytes)
[    0.000000] Memory: 7190452K/8130560K available (15294K kernel code, 2934K
rwdata, 6636K rodata, 8576K init, 609K bss, 186444K reserved, 753664K
cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffffff8000000000 - 0xffffff8008000000   (   128
MB)
[    0.000000]     vmalloc : 0xffffff8008000000 - 0xffffffbebfff0000   (   250
GB)
[    0.000000]       .text : 0xffffff8008080000 - 0xffffff8008f70000   ( 15296
KB)
[    0.000000]     .rodata : 0xffffff8008f70000 - 0xffffff80095f0000   (  6656
KB)
[    0.000000]       .init : 0xffffff80095f0000 - 0xffffff8009e50000   (  8576
KB)
[    0.000000]       .data : 0xffffff8009e50000 - 0xffffff800a12d808   (  2935
KB)
[    0.000000]        .bss : 0xffffff800a12d808 - 0xffffff800a1c5f3c   (   610
KB)
[    0.000000]     fixed   : 0xffffffbefe7fd000 - 0xffffffbefec00000   (  4108
KB)
[    0.000000]     PCI I/O : 0xffffffbefee00000 - 0xffffffbeffe00000   (    16
MB)
[    0.000000]     vmemmap : 0xffffffbf00000000 - 0xffffffc000000000   (     4
GB maximum)
[    0.000000]               0xffffffbf00000000 - 0xffffffbf08000000   (   128
MB actual)
[    0.000000]     memory  : 0xffffffc000000000 - 0xffffffc200000000   (  8192
MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000]  RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=6.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=6
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 31.25MHz
(phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0xe6a171046, max_idle_ns: 881590405314 ns
[    0.000004] sched_clock: 56 bits at 31MHz, resolution 32ns, wraps every
4398046511088ns
[    0.000593] Console: colour dummy device 80x25
[    0.000606] console [tty0] enabled
[    0.000613] bootconsole [tegra_comb_uart0] disabled
[    0.000627] kmemleak: Kernel memory leak detector disabled
[    0.000644] Calibrating delay loop (skipped), value calculated using timer
frequency.. 62.50 BogoMIPS (lpj=125000)
[    0.000659] pid_max: default: 32768 minimum: 301
[    0.001759] Security Framework initialized
[    0.002326] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.002336] Mountpoint-cache hash table entries: 16384 (order: 5, 131072
bytes)
[    0.003962] ftrace: allocating 47094 entries in 184 pages
[    0.398997] sched-energy: Sched-energy-costs installed from DT
[    0.399017] ASID allocator initialised with 65536 entries
[    0.434058] tegra-id: chipid=21917.
[    0.434070] tegra-id: opt_subrevision=1.
[    0.434096] Tegra Revision: A02 SKU: 0xde CPU Process: 0 SoC Process: 0
[    0.434111] DTS File Name:
/dvs/git/dirty/git-master_linux/kernel/kernel-4.9/arch/arm64/boot/dts/../../../../../../hardware/nvidia/platform/t19x/jakku/kernel-dts/tegra194-p3668-all-p3509-0000.dts
[    0.434121] DTB Build time: Apr  8 2020 18:20:54
[    0.482117] CPU1: Booted secondary processor [4e0f0040]
[    0.514167] CPU2: Booted secondary processor [4e0f0040]
[    0.546262] CPU3: Booted secondary processor [4e0f0040]
[    0.578553] CPU4: Booted secondary processor [4e0f0040]
[    0.610633] CPU5: Booted secondary processor [4e0f0040]
[    0.610835] Brought up 6 CPUs
[    0.610845] SMP: Total of 6 processors activated.
[    0.610856] CPU features: detected feature: Privileged Access Never
[    0.610865] CPU features: detected feature: LSE atomic instructions
[    0.610871] CPU features: detected feature: User Access Override
[    0.610877] CPU features: detected feature: 32-bit EL0 Support
[    0.612406] CPU: All CPU(s) started at EL2
[    0.612472] alternatives: patching kernel code
[    0.619579] devtmpfs: initialized
[    0.656392] Initilizing CustomIPI irq domain
[    0.656699] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 7645041785100000 ns
[    0.656719] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.678644] pinctrl core: initialized pinctrl subsystem
[    0.678862] OS set in device tree is not L4T.
[    0.679185] regulator-dummy: no parameters
[    0.679470] Initializing plugin-manager
[    0.679522] Plugin module not found
[    0.679578] Plugin-manager status disabled
[    0.681521] NET: Registered protocol family 16
[    0.682758] pstore: using zlib compression
[    0.682780] console [pstore-1] enabled
[    0.682788] pstore: Registered ramoops as persistent store backend
[    0.682797] ramoops: attached 0x200000@0xf0600000, ecc: 0/0
[    0.701353] cpuidle: using governor menu
[    0.702705] bpmp: waiting for handshake
[    0.702717] bpmp: handshake completed
[    0.702747] bpmp: synchronizing channels
[    0.702758] bpmp: channels synchronized
[    0.702764] bpmp: mail init ok
[    0.705816] t19x-arm-smmu 12000000.iommu: found 3 SMMUs and ISO SMMU id is 2
[    0.705993] t19x-arm-smmu 12000000.iommu: probing hardware configuration...
[    0.705999] t19x-arm-smmu 12000000.iommu: SMMUv2 with:
[    0.706006] t19x-arm-smmu 12000000.iommu:    stage 1 translation
[    0.706012] t19x-arm-smmu 12000000.iommu:    stage 2 translation
[    0.706018] t19x-arm-smmu 12000000.iommu:    nested translation
[    0.706026] t19x-arm-smmu 12000000.iommu:    stream matching with 128
register groups, mask 0x7f80
[    0.706035] t19x-arm-smmu 12000000.iommu: SMMU address space size (0x800000)
differs from mapped region size (0x1000000)!
[    0.706041] t19x-arm-smmu 12000000.iommu:    64 context banks (0 stage-2
only)
[    0.706049] t19x-arm-smmu 12000000.iommu:    Stage-1: 39-bit VA -> 48-bit
IPA
[    0.706055] t19x-arm-smmu 12000000.iommu:    Stage-2: 39-bit IPA -> 48-bit
PA
[    0.709448] vdso: 2 pages (1 code @ ffffff8008f77000, 1 data @
ffffff8009e54000)
[    0.709482] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.711836] atomic_pool_init():622: DMA: preallocated 1024 KiB pool for
atomic allocations
[    0.713210] Registering BPMP clocks...
[    0.713315] tegra_bpmp_clk_init: clock init ok (400 clks)
[    0.713970] Serial: AMBA PL011 UART driver
[    0.714127] tegra_powergate_init: DONE
[    0.714193] DTS File Name:
/dvs/git/dirty/git-master_linux/kernel/kernel-4.9/arch/arm64/boot/dts/../../../../../../hardware/nvidia/platform/t19x/jakku/kernel-dts/tegra194-p3668-all-p3509-0000.dts
[    0.714204] DTB Build time: Apr  8 2020 18:20:54
[    0.717336] Tegra reboot handler registered.
[    0.725520] iommu: Adding device 141a0000.pcie to group 0
[    0.726878] iommu: Adding device 2490000.ether_qos to group 1
[    0.727432] iommu: Adding device 3100000.serial to group 2
[    0.727907] iommu: Adding device 3110000.serial to group 3
[    0.728348] iommu: Adding device 3140000.serial to group 4
[    0.728923] tegra-pmc c360000.pmc: scratch reg offset dts data not present
[    0.729141] tegra-pmc: get_secure_pmc_setting: done secure_pmc=0
[    0.729165] tegra-pmc: ### PMC reset source: TEGRA_POWER_ON_RESET
[    0.729188] tegra-pmc: ### PMC reset level: TEGRA_RESET_LEVEL_L0
[    0.729196] tegra-pmc: ### PMC reset status reg: 0x0
[    0.729250] tegra-pmc: PMC Prod config success
[    0.729500] padctrl padctrl.0: Pad control driver tegra-pmc-padctrl
registered
[    0.729515] tegra-pmc c360000.pmc: IO padctrl driver initialized
[    0.729901] iommu: Adding device 3460000.sdhci to group 5
[    0.730461] iommu: Adding device 3210000.spi to group 6
[    0.730843] iommu: Adding device 3230000.spi to group 7
[    0.731225] iommu: Adding device 3270000.spi to group 8
[    0.732407] iommu: Adding device 3160000.i2c to group 9
[    0.732774] iommu: Adding device c240000.i2c to group 10
[    0.733198] iommu: Adding device 3180000.i2c to group 11
[    0.733605] iommu: Adding device 3190000.i2c to group 12
[    0.734128] iommu: Adding device 31b0000.i2c to group 13
[    0.734571] iommu: Adding device 31c0000.i2c to group 14
[    0.734970] iommu: Adding device c250000.i2c to group 15
[    0.735348] iommu: Adding device 31e0000.i2c to group 16
[    0.735886] iommu: Adding device sound to group 17
[    0.736377] iommu: Adding device 3510000.hda to group 18
[    0.736959] iommu: Adding device bc00000.rtcpu to group 19
[    0.738790] iommu: Adding device 13e10000.host1x to group 20
[    0.739164] iommu: Adding device 13e10000.host1x:ctx0 to group 21
[    0.739559] iommu: Adding device 13e10000.host1x:ctx1 to group 22
[    0.740020] iommu: Adding device 13e10000.host1x:ctx2 to group 23
[    0.740425] iommu: Adding device 13e10000.host1x:ctx3 to group 24
[    0.740839] iommu: Adding device 13e10000.host1x:ctx4 to group 25
[    0.741212] iommu: Adding device 13e10000.host1x:ctx5 to group 26
[    0.741556] iommu: Adding device 13e10000.host1x:ctx6 to group 27
[    0.741983] iommu: Adding device 13e10000.host1x:ctx7 to group 28
[    0.742484] iommu: Adding device 15340000.vic to group 29
[    0.742884] iommu: Adding device 15380000.nvjpg to group 30
[    0.743268] iommu: Adding device 15500000.tsec to group 31
[    0.743542] iommu: Adding device 15100000.tsecb to group 32
[    0.743941] iommu: Adding device 15480000.nvdec to group 33
[    0.744265] iommu: Adding device 15140000.nvdec1 to group 34
[    0.744556] iommu: Adding device 154c0000.nvenc to group 35
[    0.744830] iommu: Adding device 15a80000.nvenc1 to group 36
[    0.745235] iommu: Adding device 15880000.nvdla0 to group 37
[    0.745653] iommu: Adding device 158c0000.nvdla1 to group 38
[    0.746218] iommu: Adding device 15200000.nvdisplay to group 39
[    0.750334] platform 15200000.nvdisplay: IOVA linear map
0x00000000c6000000(2a000000)
[    0.750395] t19x-arm-smmu: Adding 15200000.nvdisplay to ISO SMMU client
[    0.751030] iommu: Adding device 15210000.nvdisplay to group 40
[    0.751097] t19x-arm-smmu: Adding 15210000.nvdisplay to ISO SMMU client
[    0.752810] iommu: Adding device 15c10000.vi to group 41
[    0.752964] t19x-arm-smmu: Adding 15c10000.vi to ISO SMMU client
[    0.753355] iommu: Adding device 14800000.isp to group 42
[    0.754321] iommu: Adding device 16000000.pva0 to group 43
[    0.754845] iommu: Adding device 16800000.pva1 to group 44
[    0.755276] iommu: Adding device 15810000.se to group 45
[    0.755623] iommu: Adding device 15820000.se to group 46
[    0.755934] iommu: Adding device 15830000.se to group 47
[    0.756224] iommu: Adding device 15840000.se to group 48
[    0.756480] iommu: Adding device c1a0000.aon to group 49
[    0.757927] iommu: Adding device d000000.bpmp to group 50
[    0.758280] bpmp: ping status is 0
[    0.758417] bpmp d000000.bpmp: firmware tag is
57f8a77779f848bf2ecf21dabee5645f
[    0.761615] bpmp d000000.bpmp: probe ok
[    0.763686] tegra-reset 0.bpmp_reset: registered 190 resets.
[    0.764107] iommu: Adding device smmu_test to group 51
[    0.765138] mc: mapped MMIO address: 0xffffff800a590000 -> 0x2c10000
[    0.765155] mc: mapped MMIO address: 0xffffff800a5b0000 -> 0x2c20000
[    0.765171] mc: mapped MMIO address: 0xffffff800a5d0000 -> 0x2c30000
[    0.765186] mc: mapped MMIO address: 0xffffff800a7b0000 -> 0x2c40000
[    0.765201] mc: mapped MMIO address: 0xffffff800a7d0000 -> 0x2c50000
[    0.765218] mc: mapped MMIO address: 0xffffff800b010000 -> 0x2b80000
[    0.765233] mc: mapped MMIO address: 0xffffff800b030000 -> 0x2b90000
[    0.765250] mc: mapped MMIO address: 0xffffff800b050000 -> 0x2ba0000
[    0.765265] mc: mapped MMIO address: 0xffffff800b070000 -> 0x2bb0000
[    0.765279] mc: mapped MMIO address: 0xffffff800b090000 -> 0x1700000
[    0.765293] mc: mapped MMIO address: 0xffffff800b0b0000 -> 0x1710000
[    0.765332] mc: mapped MMIO address: 0xffffff800b0d0000 -> 0x1720000
[    0.765356] mc: mapped MMIO address: 0xffffff800b0f0000 -> 0x1730000
[    0.765370] mc: mapped MMIO address: 0xffffff800b110000 -> 0x1740000
[    0.765385] mc: mapped MMIO address: 0xffffff800b130000 -> 0x1750000
[    0.765399] mc: mapped MMIO address: 0xffffff800b150000 -> 0x1760000
[    0.765413] mc: mapped MMIO address: 0xffffff800b170000 -> 0x1770000
[    0.765482] mc-err: mcerr ops are set to t19x
[    0.771553] iommu: Adding device 2600000.dma to group 52
[    0.777777] GPIO line 339 (wifi-enable) hogged as output/high
[    0.777813] GPIO line 412 (camera-control-output-low) hogged as output/low
[    0.777845] GPIO line 413 (camera-control-output-low) hogged as output/low
[    0.778171] gpiochip_setup_dev: registered GPIOs 288 to 511 on device:
gpiochip0 (tegra-gpio)
[    0.786333] GPIO line 253 (pex-refclk-sel-low) hogged as output/low
[    0.786711] gpiochip_setup_dev: registered GPIOs 248 to 287 on device:
gpiochip1 (tegra-gpio-aon)
[    0.789132] tegra186-aowake c370000.pmc: WAKE_AOWAKE_CTRL_0 = 3
[    0.789143] tegra186-aowake c370000.pmc: WAKE_AOWAKE_CNTRL_24(PMU_INT) = 256
[    0.789847] iommu: Adding device 3550000.xudc to group 53
[    0.790573] iommu: Adding device 3610000.xhci to group 54
[    0.792648] arm64_ras arm64_ras: probed
[    0.793082] ras_fhi_enable: FHI 466 enabled on CPU0
[    0.793128] ras_fhi_enable: FHI 467 enabled on CPU1
[    0.793218] ras_fhi_enable: FHI 468 enabled on CPU2
[    0.793274] ras_fhi_enable: FHI 469 enabled on CPU3
[    0.793338] ras_fhi_enable: FHI 470 enabled on CPU4
[    0.793404] ras_fhi_enable: FHI 471 enabled on CPU5
[    0.793607] carmel_ras_enable: RAS enabled on cpu0
[    0.793780] carmel_ras_enable: RAS enabled on cpu1
[    0.793975] carmel_ras_enable: RAS enabled on cpu2
[    0.794159] carmel_ras_enable: RAS enabled on cpu3
[    0.794342] carmel_ras_enable: RAS enabled on cpu4
[    0.794514] carmel_ras_enable: RAS enabled on cpu5
[    0.794572] carmel_ras carmel_ras: probed
[    0.795704] tegra-cbb 2300000.cbb-noc: noc_secure_irq = 475,
noc_nonsecure_irq = 474>
[    0.796213] tegra-cbb c600000.aon-noc: noc_secure_irq = 477,
noc_nonsecure_irq = 476>
[    0.797155] tegra-cbb d600000.bpmp-noc: noc_secure_irq = 479,
noc_nonsecure_irq = 478>
[    0.798117] tegra-cbb be00000.rce-noc: noc_secure_irq = 481,
noc_nonsecure_irq = 480>
[    0.799264] tegra-cbb b600000.sce-noc: noc_secure_irq = 483,
noc_nonsecure_irq = 482>
[    0.799895] tegra-cbb 14040000.cv-noc: defer probe as CV-NOC not probed yet
[    0.801176] vdd-ac-bat: 5000 mV 
[    0.801589] vdd-sdmmc1-sw: 3300 mV 
[    0.801888] vdd-1v8-sd: 1800 mV 
[    0.802266] vdd-usb2-5v: 5000 mV 
[    0.802618] vdd-3v3-cvb: 3300 mV 
[    0.802910] vdd-1v8-cvb: 1800 mV 
[    0.803250] vdd-epb-1v0: supplied by vdd-3v3-cvb
[    0.803286] vdd-epb-1v0: 1000 mV 
[    0.803655] avdd-cam-2v8: 2800 mV 
[    0.803957] vdd-fan: 5000 mV 
[    0.804245] vdd-hdmi-5v0: 5000 mV 
[    0.804550] vdd_sys_en: 1200 mV 
[    0.843588] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.847901] eventlib_kernel: keventlib is initialized, test id: 0
[    0.848230] SCSI subsystem initialized
[    0.848492] libata version 3.00 loaded.
[    0.848773] usbcore: registered new interface driver usbfs
[    0.848828] usbcore: registered new interface driver hub
[    0.848919] usbcore: registered new device driver usb
[    0.860580] tegra-i2c 31e0000.i2c: could not find pctldev for node
/host1x/dpaux@155F0000/pinmux@0, deferring probe
[    0.863183] max77620 4-003c: PMIC Version OTP:0x51 and ES:0x1
[    0.874483] vdd-1v0: at 1000 mV 
[    0.882536] vdd-1v8-hs: at 1800 mV 
[    0.890543] vdd-1v8-ls: at 1800 mV 
[    0.898640] vdd-1v8-ao: at 1800 mV 
[    0.906616] vddio-ddr-1v1: at 1100 mV 
[    0.914406] vdd-rtc: at 800 mV 
[    0.915735] spmic-ldo1: at 2375 mV 
[    0.926444] vdd-ao-3v3: at 3300 mV 
[    0.938479] vddio-emmc-3v3: at 3300 mV 
[    0.939781] spmic-ldo4: at 1587 mV 
[    0.950555] vdd-usb-3v3: at 3300 mV 
[    0.959222] vddio-sdmmc1-3v3: at 3300 mV 
[    0.963251] vdd-csi-1v2: at 1200 mV 
[    0.964753] spmic-ldo8: at 1800 mV 
[    0.969624] GPIO line 246 (gpio_default) hogged as output/high
[    0.970990] GPIO line 247 (gpio_default) hogged as output/high
[    0.971307] gpiochip_setup_dev: registered GPIOs 240 to 247 on device:
gpiochip2 (max77620-gpio)
[    0.971624] max77620 4-003c: max77620 probe successful
[    0.972194] media: Linux media interface: v0.10
[    0.972284] Linux video capture interface: v2.00
[    0.973829] pps_core: LinuxPPS API ver. 1 registered
[    0.973836] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo
Giometti <giometti@linux.it>
[    0.973905] PTP clock support registered
[    0.974206] tegra_wdt_t18x 30c0000.watchdog: Expiry count is deprecated
[    0.974448] tegra_wdt_t18x 30c0000.watchdog: Tegra WDT init timeout = 120
sec
[    0.974478] tegra_wdt_t18x 30c0000.watchdog: Registered successfully
[    0.976949] trusty trusty: trusty version: Built: 18:08:23 Apr  8 2020 
[    0.977013] trusty trusty: selected api version: 3 (requested 3)
[    0.977961] Advanced Linux Sound Architecture Driver Initialized.
[    0.978509] Bluetooth: Core ver 2.22
[    0.978575] NET: Registered protocol family 31
[    0.978581] Bluetooth: HCI device and connection manager initialized
[    0.978591] Bluetooth: HCI socket layer initialized
[    0.978600] Bluetooth: L2CAP socket layer initialized
[    0.978635] Bluetooth: SCO socket layer initialized
[    0.980914] camchar: rtcpu character device driver loaded
[    0.981312] gpio tegra-gpio wake61 for gpio=201(Z:1)
[    0.981411] extcon-gpio-states external-connection:extcon@1: Cable state:1,
cable id:1
[    0.982874] clocksource: Switched to clocksource arch_sys_counter
[    1.032540] VFS: Disk quotas dquot_6.6.0
[    1.032633] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.033036] nvmap_heap_init: nvmap_heap_init: created heap block cache
[    1.034316] tegra-carveouts tegra-carveouts: assigned reserved memory node
grid-of-semaphores
[    1.034364] dma_declare_coherent_resizable_cma_memory:324: resizable
heap=vpr, base=0x00000000c6000000, size=0x2a000000
[    1.034649] cma: enabled page replacement for spfn=c6000, epfn=f0000
[    1.034656] dma_declare_coherent_resizable_cma_memory:373: resizable cma
heap=vpr create successful
[    1.034669] nvmap: nvmap_select_cache_ops() nvmap cache ops set to scf
[    1.034676] nvmap_page_pool_init: Total RAM pages: 1986029
[    1.034682] nvmap_page_pool_init: nvmap page pool size: 248253 pages (969
MB)
[    1.034823] nvmap_background_zero_thread: PP zeroing thread starting.
[    1.035354] misc nvmap: created heap vpr base 0x00000000c6000000 size
(688128KiB)
[    1.037520] tegra-gpcdma 2600000.dma: GPC DMA driver register 31 channels
[    1.050214] thermal thermal_zone0: Registering thermal zone thermal_zone0
for type CPU-therm
[    1.050412] thermal thermal_zone1: Registering thermal zone thermal_zone1
for type GPU-therm
[    1.050594] thermal thermal_zone2: Registering thermal zone thermal_zone2
for type AUX-therm
[    1.050769] thermal thermal_zone3: Registering thermal zone thermal_zone3
for type AO-therm
[    1.050985] thermal thermal_zone4: Registering thermal zone thermal_zone4
for type PMIC-Die
[    1.052155] la/ptsa driver initialized.
[    1.052486] NET: Registered protocol family 2
[    1.053362] TCP established hash table entries: 65536 (order: 7, 524288
bytes)
[    1.053698] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.054268] TCP: Hash tables configured (established 65536 bind 65536)
[    1.054310] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.054425] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    1.054806] NET: Registered protocol family 1
[    1.055438] RPC: Registered named UNIX socket transport module.
[    1.055444] RPC: Registered udp transport module.
[    1.055448] RPC: Registered tcp transport module.
[    1.055453] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.055462] PCI: CLS 0 bytes, default 64
[    1.055670] Trying to unpack rootfs image as initramfs...
[    1.237269] Freeing initrd memory: 5432K
[    1.255343] random: fast init done
[    1.259741] host1x 13e10000.host1x: initialized
[    1.261251] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 counters
available
[    1.265764] audit: initializing netlink subsys (disabled)
[    1.265813] audit: type=2000 audit(0.884:1): initialized
[    1.266623] workingset: timestamp_bits=46 max_order=21 bucket_order=0
[    1.277833] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    1.279187] ntfs: driver 2.1.32 [Flags: R/W].
[    1.279862] 9p: Installing v9fs 9p2000 file system support
[    1.284952] Block layer SCSI generic (bsg) driver version 0.4 loaded (major
240)
[    1.285116] io scheduler noop registered
[    1.285348] io scheduler cfq registered (default)
[    1.288819] gic 2a41000.agic-controller: GIC IRQ controller registered
[    1.324037] iommu: Adding device 2993000.adsp to group 55
[    1.437488] iommu: Adding device aconnect@2a41000:adsp_audio to group 56
[    1.438486] tegra-aconnect aconnect@2a41000: Tegra ACONNECT bus registered
[    1.451343] tegra-pwm 3280000.pwm: PWM clk can sleep in ops
[    1.451778] tegra-pwm c340000.pwm: PWM clk can sleep in ops
[    1.452440] tegra-pwm 32c0000.pwm: PWM clk can sleep in ops
[    1.452859] tegra-pwm 32d0000.pwm: PWM clk can sleep in ops
[    1.453269] tegra-pwm 32f0000.pwm: PWM clk can sleep in ops
[    1.456160] tegra_camera_platform tegra-camera-platform:
tegra_camera_probe:camera_platform_driver probe
[    1.456414] misc tegra_camera_ctrl: tegra_camera_isomgr_register
isp_iso_bw=1500000, vi_iso_bw=1500000, max_bw=1500000
[    1.459269] tsec 15500000.tsec: initialized
[    1.460998] tsec 15100000.tsecb: initialized
[    1.464975] nvdec 15480000.nvdec: initialized
[    1.467442] nvdec 15140000.nvdec1: initialized
[    1.473444] falcon 15340000.vic: initialized
[    1.475527] falcon 15380000.nvjpg: initialized
[    1.477383] falcon 154c0000.nvenc: initialized
[    1.479336] falcon 15a80000.nvenc1: initialized
[    1.483177] iommu_context_dev 13e10000.host1x:ctx0: initialized
(streamid=56)
[    1.484691] iommu_context_dev 13e10000.host1x:ctx1: initialized
(streamid=57)
[    1.485936] iommu_context_dev 13e10000.host1x:ctx2: initialized
(streamid=58)
[    1.487297] iommu_context_dev 13e10000.host1x:ctx3: initialized
(streamid=59)
[    1.488619] iommu_context_dev 13e10000.host1x:ctx4: initialized
(streamid=60)
[    1.489944] iommu_context_dev 13e10000.host1x:ctx5: initialized
(streamid=61)
[    1.491306] iommu_context_dev 13e10000.host1x:ctx6: initialized
(streamid=62)
[    1.492659] iommu_context_dev 13e10000.host1x:ctx7: initialized
(streamid=63)
[    1.496190] t194-nvcsi 15a00000.nvcsi: initialized
[    1.501295] scare-pigeon 13e10000.host1x:vi-thi@15f00000: initialized
[    1.501748] scare-pigeon 14b00000.isp-thi: initialized
[    1.507696] pva 16000000.pva0: initialized
[    1.513728] pva 16800000.pva1: initialized
[    1.519010] nvdla 15880000.nvdla0: initialized
[    1.523764] nvdla 158c0000.nvdla1: initialized
[    1.525208] tegradccommon 15200000.dc_common: host1x channel mapped
[    1.525221] tegradccommon 15200000.dc_common: dc_common syncpt # 1 allocated
[    1.525265] tegradccommon 15200000.dc_common: dma mapping done
[    1.525976] tegra_cec 3960000.tegra_cec: dt=1 start=0x03960000
end=0x03960FFF irq=75
[    1.525986] tegra_cec 3960000.tegra_cec: Unpowergate DISP: 0.
[    1.526199] tegra_cec 3960000.tegra_cec: Enable clock result: 0.
[    1.526230] tegra_cec 3960000.tegra_cec: tegra_cec_init started
[    1.526478] tegra_cec 3960000.tegra_cec: cec_add_sysfs ret=0
[    1.526485] tegra_cec 3960000.tegra_cec: probed
[    1.527027] tegradc 15200000.nvdisplay: disp0 connected to
head0->/host1x/sor1
[    1.527069] generic_infoframe_type: 0x87
[    1.527135] tegradc 15200000.nvdisplay: DT parsed successfully
[    1.527168] tegradc 15200000.nvdisplay: Display dc.ffffff800bd10000
registered with id=0
[    1.531733] tegra_nvdisp_bandwidth_register_max_config: max config iso bw =
7088400 KB/s
[    1.531743] tegra_nvdisp_bandwidth_register_max_config: max config EMC floor
= 800000000 Hz
[    1.531748] tegra_nvdisp_bandwidth_register_max_config: max config hubclk =
179200000 Hz
[    1.531973] tegradc 15200000.nvdisplay: vblank syncpt # 8 for dc 0
[    1.531982] tegradc 15200000.nvdisplay: vpulse3 syncpt # 9 for dc 0
[    1.535027] tegradc 15200000.nvdisplay: hdmi: invalid prod list
prod_list_hdmi_board
[    1.535035] tegradc 15200000.nvdisplay: hdmi: tegra_hdmi_tmds_range_read(bd)
failed
[    1.538710] tegra-adma 2930000.adma: Tegra210 ADMA driver registered 32
channels
[    1.539548] tegradc 15200000.nvdisplay: probed
[    1.539670] tegra-fuse-burn 3820000.efuse:efuse-burn: shutdown limit check
disabled
[    1.539678] tegra-fuse-burn 3820000.efuse:efuse-burn: Fuse burn driver
initialized
[    1.540002] kfuse 3830000.kfuse: initialized
[    1.540174] Console: switching to colour frame buffer device 80x30
[    1.540223] tegradc 15200000.nvdisplay: fb registered
[    1.540550] gpio tegra-gpio wake63 for gpio=97(M:1)
[    1.542154] tegradc 15210000.nvdisplay: disp1 connected to
head1->/host1x/sor
[    1.542238] tegradc 15210000.nvdisplay: parse_dp_settings: No dp-lt-settings
node
[    1.542358] tegradc 15210000.nvdisplay: DT parsed successfully
[    1.542386] tegradc 15210000.nvdisplay: Display dc.ffffff800be90000
registered with id=1
[    1.542582] tegradc 15210000.nvdisplay: vblank syncpt # 11 for dc 1
[    1.542592] tegradc 15210000.nvdisplay: vpulse3 syncpt # 12 for dc 1
[    1.551533] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.553768] tegradc 15210000.nvdisplay: probed
[    1.554102] tegradc 15210000.nvdisplay: fb registered
[    1.554151] 3100000.serial: ttyTHS0 at MMIO 0x3100000 (irq = 45, base_baud =
0) is a TEGRA_UART
[    1.555410] 3110000.serial: ttyTHS1 at MMIO 0x3110000 (irq = 46, base_baud =
0) is a TEGRA_UART
[    1.556259] 3140000.serial: ttyTHS4 at MMIO 0x3140000 (irq = 47, base_baud =
0) is a TEGRA_UART
[    1.557456] console [ttyTCU0] enabled
[    1.557609] hpd: state 7 (Takeover from bootloader), hpd 0, pending_hpd_evt
1
[    1.557617] hpd: switching from state 7 (Takeover from bootloader) to state
0 (Reset)
[    1.557629] hpd: state 0 (Reset), hpd 0, pending_hpd_evt 0
[    1.557641] tegradc 15210000.nvdisplay: blank - powerdown
[    1.557656] extcon-disp-state external-connection:disp-state: cable 44 state
0 already set.
[    1.557661] Extcon DP: HPD disabled
[    1.557665] hpd: hpd_switch 0
[    1.557671] hpd: switching from state 0 (Reset) to state 1 (Check Plug)
[    1.557682] hpd: state 1 (Check Plug), hpd 0, pending_hpd_evt 0
[    1.557691] hpd: switching from state 1 (Check Plug) to state 3 (Disabled)
[    1.557861] [drm] Initialized
[    1.571380] brd: module loaded
[    1.577167] loop: module loaded
[    1.577268] tegra_profiler: version: 1.141, samples/io: 48/28
[    1.577464] tegra_profiler: auth: init
[    1.578143] THERMAL EST: found 3 subdevs
[    1.578150] THERMAL EST num_resources: 0
[    1.578161] [THERMAL EST subdev 0]
[    1.578169] [THERMAL EST subdev 1]
[    1.578177] [THERMAL EST subdev 2]
[    1.578186] THERMAL EST: Found 2 profiles, default profile is quiet
[    1.578530] thermal thermal_zone5: Registering thermal zone thermal_zone5
for type thermal-fan-est
[    1.578535] THERMAL EST: thz register success.
[    1.578672] THERMAL EST: end of probe, return err: 0
[    1.579367] sd: No Scsi addr parsed to reserve index
[    1.579397] hisi_sas: driver version v1.6
[    1.589366] qspi_mtd spi6.0: s25fs256s SSG 8 0 1000 2000000
[    1.589374] qspi_mtd spi6.0: s25fs256s (32768 Kbytes)
[    1.589384] qspi_mtd spi6.0: mtd .name = spi6.0, .size = 0x2000000 (32MiB)
.erasesize = 0x00010000 (64KiB) .numeraseregions = 0
[    1.589679] 1 ofpart partitions found on MTD device spi6.0
[    1.589686] Creating 1 MTD partitions on "spi6.0":
[    1.589703] 0x000000000000-0x000002000000 : "Whole_flash0"
[    1.592505] libphy: Fixed MDIO Bus: probed
[    1.593213] tun: Universal TUN/TAP device driver, 1.6
[    1.593218] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.593941] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.593946] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.594004] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    1.594009] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.594061] igbvf: Intel(R) Gigabit Virtual Function Network Driver -
version 2.4.0-k
[    1.594065] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    1.594108] Intel(R) 10GbE PCI Express Linux Network Driver - version 4.6.4
[    1.594113] Copyright(c) 1999 - 2017 Intel Corporation.
[    1.838556] eqos 2490000.ether_qos: Setting local MAC: 48 b0 2d 5 a0 da
[    1.838822] libphy: dwc_phy: probed
[    1.841665] PPP generic driver version 2.4.2
[    1.841961] PPP BSD Compression module registered
[    1.841970] PPP Deflate Compression module registered
[    1.842015] PPP MPPE Compression module registered
[    1.842021] NET: Registered protocol family 24
[    1.842077] usbcore: registered new interface driver r8152
[    1.842120] usbcore: registered new interface driver asix
[    1.842192] usbcore: registered new interface driver ax88179_178a
[    1.842237] usbcore: registered new interface driver cdc_ether
[    1.842274] usbcore: registered new interface driver net1080
[    1.842307] usbcore: registered new interface driver cdc_subset
[    1.842337] usbcore: registered new interface driver zaurus
[    1.842381] usbcore: registered new interface driver cdc_ncm
[    1.842686] VFIO - User Level meta-driver version: 0.3
[    1.844069] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.844091] ehci-pci: EHCI PCI platform driver
[    1.844128] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.844138] ohci-pci: OHCI PCI platform driver
[    1.844177] ohci-platform: OHCI generic platform driver
[    1.848751] tegra-xusb 3610000.xhci: USB2 port 0 has OTG_CAP
[    1.850594] tegra-xusb 3610000.xhci: extcon 0: ffffffc1f4d06800 id
[    1.850884] usbcore: registered new interface driver uas
[    1.850945] usbcore: registered new interface driver usb-storage
[    1.851025] usbcore: registered new interface driver usbserial
[    1.853880] tegra-xusb 3610000.xhci: Firmware timestamp: 2019-07-24 05:47:34
UTC, Version: 60.06 release
[    1.853929] tegra-xusb 3610000.xhci: xHCI Host Controller
[    1.853952] tegra-xusb 3610000.xhci: new USB bus registered, assigned bus
number 1
[    1.854667] tegra-xusb 3610000.xhci: hcc params 0x0184ff25 hci version 0x110
quirks 0x00050810
[    1.854740] tegra-xusb 3610000.xhci: irq 461, io mem 0x03610000
[    1.855012] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.855020] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.855027] usb usb1: Product: xHCI Host Controller
[    1.855034] usb usb1: Manufacturer: Linux 4.9.140-tegra xhci-hcd
[    1.855040] usb usb1: SerialNumber: 3610000.xhci
[    1.855582] hub 1-0:1.0: USB hub found
[    1.855651] hub 1-0:1.0: 4 ports detected
[    1.856191] tegra-xusb 3610000.xhci: xHCI Host Controller
[    1.856204] tegra-xusb 3610000.xhci: new USB bus registered, assigned bus
number 2
[    1.856214] tegra-xusb 3610000.xhci: Host supports USB 3.1 Enhanced
SuperSpeed
[    1.856530] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    1.856539] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.856548] usb usb2: Product: xHCI Host Controller
[    1.856577] usb usb2: Manufacturer: Linux 4.9.140-tegra xhci-hcd
[    1.856583] usb usb2: SerialNumber: 3610000.xhci
[    1.857000] tegra-xudc-new 3550000.xudc: PMQOS CPU boost enabled
[    1.857079] tegra-xudc-new 3550000.xudc: device count: 1
[    1.857112] hub 2-0:1.0: USB hub found
[    1.857175] hub 2-0:1.0: 4 ports detected
[    1.858071] tegra-xudc-new 3550000.xudc: vbus state: 1
[    1.858095] tegra-xudc-new 3550000.xudc: device mode on: 0
[    1.858359] tegra-xudc-new 3550000.xudc: active: 0 => 1
[    1.858370] tegra-xudc-new 3550000.xudc: Initialize boost_cpufreq work
[    1.859132] mousedev: PS/2 mouse device common for all mice
[    1.859236] usbcore: registered new interface driver xpad
[    1.990128] max77686-rtc max77620-rtc: rtc core: registered max77620-rtc as
rtc0
[    1.991948] Wake73 for irq=42
[    1.993412] rtc rtc1: alarm rtc device
[    1.993442] tegra_rtc c2a0000.rtc: rtc core: registered c2a0000.rtc as rtc1
[    1.993479] tegra_rtc c2a0000.rtc: Tegra internal Real Time Clock
[    1.993614] i2c /dev entries driver
[    1.996306] i2c i2c-2: Added multiplexed i2c bus 9
[    1.996746] i2c i2c-2: Added multiplexed i2c bus 10
[    1.996755] i2c-mux-gpio cam_i2cmux: 2 port mux on 3180000.i2c adapter
[    1.997273] imx219 9-0010: tegracam sensor driver:imx219_v2.0.6
[    2.020898] tegra-i2c 3180000.i2c: no acknowledge from address 0x10
[    2.020961] imx219 9-0010: imx219_board_setup: error during i2c read probe
(-121)
[    2.021207] imx219 9-0010: board setup failed
[    2.021411] imx219: probe of 9-0010 failed with error -121
[    2.021942] imx219 10-0010: tegracam sensor driver:imx219_v2.0.6
[    2.045199] tegra-i2c 3180000.i2c: no acknowledge from address 0x10
[    2.045291] imx219 10-0010: imx219_board_setup: error during i2c read probe
(-121)
[    2.045521] imx219 10-0010: board setup failed
[    2.045711] imx219: probe of 10-0010 failed with error -121
[    2.047479] max77620-power max20024-power: Event recorder REG_NVERC : 0x40
[    2.054480] tegra-thermal-throttle bthrot_cdev: clk:cpu max:1907200000,
min:115200000 steps:24
[    2.058655] tegra-thermal-throttle bthrot_cdev: clk:gpu max:1109250000,
min:114750000 steps:10
[    2.058686] tegra-thermal-throttle bthrot_cdev: cdev:skin-balanced clk:0:cpu
off:0 slope-adj:200
[    2.058693] tegra-thermal-throttle bthrot_cdev: cdev:skin-balanced clk:1:gpu
off:0 slope-adj:400
[    2.058790] tegra-thermal-throttle bthrot_cdev: cdev:skin-balanced
max_state:48 cutoff:0
[    2.058926] tegra-thermal-throttle bthrot_cdev: cdev:gpu-balanced clk:0:cpu
off:0 slope-adj:400
[    2.058934] tegra-thermal-throttle bthrot_cdev: cdev:gpu-balanced clk:1:gpu
off:0 slope-adj:400
[    2.059235] tegra-thermal-throttle bthrot_cdev: cdev:gpu-balanced
max_state:40 cutoff:1
[    2.059296] tegra-thermal-throttle bthrot_cdev: cdev:cpu-balanced clk:0:cpu
off:0 slope-adj:200
[    2.059330] tegra-thermal-throttle bthrot_cdev: cdev:cpu-balanced clk:1:gpu
off:365500000 slope-adj:300
[    2.059602] tegra-thermal-throttle bthrot_cdev: cdev:cpu-balanced
max_state:48 cutoff:0
[    2.059662] tegra-thermal-throttle bthrot_cdev: cdev:emergency-balanced
clk:0:cpu off:38400000 slope-adj:10
[    2.059670] tegra-thermal-throttle bthrot_cdev: cdev:emergency-balanced
clk:1:gpu off:25500000 slope-adj:10
[    2.060038] tegra-thermal-throttle bthrot_cdev: cdev:emergency-balanced
max_state:2 cutoff:0
[    2.060110] tegra-thermal-throttle bthrot_cdev: cdev:aux-balanced clk:0:cpu
off:0 slope-adj:400
[    2.060117] tegra-thermal-throttle bthrot_cdev: cdev:aux-balanced clk:1:gpu
off:0 slope-adj:400
[    2.060387] tegra-thermal-throttle bthrot_cdev: cdev:aux-balanced
max_state:40 cutoff:1
[    2.060849] FAN dev name: pwm-fan
[    2.060904] FAN:gpio request success.
[    2.060914] FAN: can't find tach_gpio
[    2.060925] pwm_fan_driver pwm-fan: Found 2 profiles, default profile is
quiet
[    2.060954] pwm_fan_driver pwm-fan: cap state:4, cap pwm:255
[    2.061170] pwm_fan_driver pwm-fan: got pwm for fan. polarity is normal
[    2.061207] pwm_fan_driver pwm-fan: tach period: 1000
[    2.061830] pwm_fan_driver pwm-fan: index 0: pwm=0, rpm=0, rru=40, rrd=40,
state:2
[    2.061839] pwm_fan_driver pwm-fan: index 1: pwm=130, rpm=1000, rru=2,
rrd=2, state:2
[    2.061846] pwm_fan_driver pwm-fan: index 2: pwm=160, rpm=2000, rru=1,
rrd=1, state:2
[    2.061853] pwm_fan_driver pwm-fan: index 3: pwm=200, rpm=3000, rru=1,
rrd=1, state:2
[    2.061859] pwm_fan_driver pwm-fan: index 4: pwm=255, rpm=4000, rru=1,
rrd=1, state:3
[    2.061866] pwm_fan_driver pwm-fan: index 5: pwm=255, rpm=5000, rru=1,
rrd=1, state:3
[    2.061872] pwm_fan_driver pwm-fan: index 6: pwm=255, rpm=6000, rru=1,
rrd=1, state:3
[    2.061879] pwm_fan_driver pwm-fan: index 7: pwm=255, rpm=7000, rru=1,
rrd=1, state:4
[    2.061885] pwm_fan_driver pwm-fan: index 8: pwm=255, rpm=10000, rru=1,
rrd=1, state:4
[    2.061912] pwm_fan_driver pwm-fan: index 9: pwm=255, rpm=11000, rru=1,
rrd=1, state:4
[    2.063276] device-mapper: uevent: version 1.0.3
[    2.063806] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised:
dm-devel@redhat.com
[    2.067639] tegra194_cpufreq_probe: platform driver Initialization: pass
[    2.068662] cpuidle: Initializing cpuidle driver
[    2.069715] sdhci: Secure Digital Host Controller Interface driver
[    2.069721] sdhci: Copyright(c) Pierre Ossman
[    2.069725] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.071114] sdhci-tegra 3460000.sdhci: Client registration for eMC
Successful
[    2.073050] CMDQ: cmdq_platfm_init successful
[    2.077787] tegra-se-elp 3ad0000.se_elp: tegra_se_elp_probe: complete
[    2.078887] tegra-se-nvhost 15810000.se: initialized
[    2.080090] tegra-se-nvhost 15810000.se: tegra_se_probe: complete
[    2.081111] tegra-se-nvhost 15820000.se: initialized
[    2.082276] tegra-se-nvhost 15820000.se: tegra_se_probe: complete
[    2.083027] tegra-se-nvhost 15830000.se: initialized
[    2.083755] tegra-se-nvhost 15830000.se: tegra_se_probe: complete
[    2.084599] tegra-se-nvhost 15840000.se: initialized
[    2.085528] tegra-se-nvhost 15840000.se: tegra_se_probe: complete
[    2.085790] hidraw: raw HID events driver (C) Jiri Kosina
[    2.088315] usbcore: registered new interface driver usbhid
[    2.088319] usbhid: USB HID core driver
[    2.092472] tegra186-cam-rtcpu bc00000.rtcpu: deferring, 14800000.isp is not
probed
[    2.093597] tegra_aon c1a0000.aon: tegra aon driver probe OK
[    2.094189] tegra186-aondbg aondbg: aondbg driver probe() OK
[    2.095012] denver_knobs_init:MTS_VERSION:48073932
[    2.095203] tegra19x_actmon d230000.actmon: in actmon_register()...
[    2.095808] tegra19x_actmon d230000.actmon: initialization Completed for the
device mc_all
[    2.096250] t19x_cache tegra-cache: probed
[    2.098554] misc nvmap: cvsram :dma coherent mem declare
0x0000000050000000,4194304
[    2.098564] misc nvmap: created heap cvsram base 0x0000000050000000 size
(4096KiB)
[    2.099210] carmel-pmu-drv carmel-pmu: Registered Carmel PMU
[    2.100922] nvpmodel: initialized successfully
[    2.102032] trusty-virtio trusty:virtio: initializing
[    2.102243] trusty_ipc virtio0: vring0: va(pa)  ffffffc1f2ba8000(0) qsz 32
notifyid 1
[    2.102254] trusty_ipc virtio0: vring1: va(pa)  ffffffc1f2baa000(0) qsz 32
notifyid 2
[    2.102401] trusty-virtio trusty:virtio: initializing done
[    2.102715] trusty_ipc virtio0: is online
[    2.103450] tegra-hda 3510000.hda: Override SDO lines to 4
[    2.103791] usbcore: registered new interface driver snd-usb-audio
[    2.114907] mmc0: SDHCI controller on 3460000.sdhci [3460000.sdhci] using
ADMA 64-bit with 64 bit addr
[    2.117793] input: tegra-hda-galen-t194 HDMI/DP,pcm=3 as
/devices/3510000.hda/sound/card0/input0
[    2.118044] input: tegra-hda-galen-t194 HDMI/DP,pcm=7 as
/devices/3510000.hda/sound/card0/input1
[    2.118300] input: tegra-hda-galen-t194 HDMI/DP,pcm=8 as
/devices/3510000.hda/sound/card0/input2
[    2.118526] input: tegra-hda-galen-t194 HDMI/DP,pcm=9 as
/devices/3510000.hda/sound/card0/input3
[    2.160838] mmc0: mmc_decode_ext_csd: CMDQ supported: depth: 31,
cmdq_support: 1
[    2.173727] mmc0: periodic cache flush enabled
[    2.173746] mmc0: new HS400 Enhanced strobe MMC card at address 0001
[    2.174367] mmcblk0: mmc0:0001 DG4016 14.7 GiB 
[    2.174661] mmcblk0boot0: mmc0:0001 DG4016 partition 1 4.00 MiB
[    2.174903] mmcblk0boot1: mmc0:0001 DG4016 partition 2 4.00 MiB
[    2.179168] mmcblk0rpmb: mmc0:0001 DG4016 partition 3 4.00 MiB
[    2.182341]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11
[    2.182904] usb 1-2: new high-speed USB device number 2 using tegra-xusb
[    2.188232] OPE platform probe
[    2.188351] OPE platform probe successful
[    2.211604] usb 1-2: New USB device found, idVendor=0bda, idProduct=5411
[    2.211611] usb 1-2: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    2.211616] usb 1-2: Product: 4-Port USB 2.1 Hub
[    2.211621] usb 1-2: Manufacturer: Generic
[    2.212577] hub 1-2:1.0: USB hub found
[    2.213179] hub 1-2:1.0: 4 ports detected
[    2.268385] tegra-asoc: sound: ADMAIF1 <-> ADMAIF1 mapping ok
[    2.268505] tegra-asoc: sound: ADMAIF2 <-> ADMAIF2 mapping ok
[    2.268626] tegra-asoc: sound: ADMAIF3 <-> ADMAIF3 mapping ok
[    2.268728] tegra-asoc: sound: ADMAIF4 <-> ADMAIF4 mapping ok
[    2.268826] tegra-asoc: sound: ADMAIF5 <-> ADMAIF5 mapping ok
[    2.268932] tegra-asoc: sound: ADMAIF6 <-> ADMAIF6 mapping ok
[    2.269049] tegra-asoc: sound: ADMAIF7 <-> ADMAIF7 mapping ok
[    2.269170] tegra-asoc: sound: ADMAIF8 <-> ADMAIF8 mapping ok
[    2.269301] tegra-asoc: sound: ADMAIF9 <-> ADMAIF9 mapping ok
[    2.269428] tegra-asoc: sound: ADMAIF10 <-> ADMAIF10 mapping ok
[    2.269565] tegra-asoc: sound: ADMAIF11 <-> ADMAIF11 mapping ok
[    2.269673] tegra-asoc: sound: ADMAIF12 <-> ADMAIF12 mapping ok
[    2.269780] tegra-asoc: sound: ADMAIF13 <-> ADMAIF13 mapping ok
[    2.269884] tegra-asoc: sound: ADMAIF14 <-> ADMAIF14 mapping ok
[    2.269989] tegra-asoc: sound: ADMAIF15 <-> ADMAIF15 mapping ok
[    2.270108] tegra-asoc: sound: ADMAIF16 <-> ADMAIF16 mapping ok
[    2.270235] tegra-asoc: sound: ADMAIF17 <-> ADMAIF17 mapping ok
[    2.270349] tegra-asoc: sound: ADMAIF18 <-> ADMAIF18 mapping ok
[    2.270472] tegra-asoc: sound: ADMAIF19 <-> ADMAIF19 mapping ok
[    2.270559] tegra-asoc: sound: ADMAIF20 <-> ADMAIF20 mapping ok
[    2.301088] u32 classifier
[    2.301094]     Actions configured
[    2.301186] Initializing XFRM netlink socket
[    2.301800] NET: Registered protocol family 10
[    2.302631] NET: Registered protocol family 17
[    2.302662] NET: Registered protocol family 15
[    2.302729] bridge: filtering via arp/ip/ip6tables is no longer available by
default. Update your scripts to load br_netfilter if you need this.
[    2.302872] Bluetooth: RFCOMM socket layer initialized
[    2.302893] Bluetooth: RFCOMM ver 1.11
[    2.302900] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    2.302907] Bluetooth: HIDP socket layer initialized
[    2.302935] 9pnet: Installing 9P2000 support
[    2.302997] Key type dns_resolver registered
[    2.303245] Registered cp15_barrier emulation handler
[    2.303269] Registered setend emulation handler
[    2.305085] registered taskstats version 1
[    2.305633] tegra-pcie-dw 141a0000.pcie: Setting init speed to max speed
[    2.306876] OF: PCI: host bridge /pcie@141a0000 ranges:
[    2.306904] OF: PCI:    IO 0x3a100000..0x3a1fffff -> 0x3a100000
[    2.306918] OF: PCI:   MEM 0x1f40000000..0x1fffffffff -> 0x40000000
[    2.306924] OF: PCI:   MEM 0x1c00000000..0x1f3fffffff -> 0x1c00000000
[    2.334888] usb 1-3: new full-speed USB device number 3 using tegra-xusb
[    2.354948] usb 1-2: usb_suspend_both: status 0
[    2.357580] usb 1-3: New USB device found, idVendor=8087, idProduct=0029
[    2.357586] usb 1-3: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    2.418876] tegra-pcie-dw 141a0000.pcie: link is up
[    2.419097] tegra-pcie-dw 141a0000.pcie: PCI host bridge to bus 0005:00
[    2.419126] pci_bus 0005:00: root bus resource [bus 00-ff]
[    2.419132] pci_bus 0005:00: root bus resource [io  0x0000-0xfffff] (bus
address [0x3a100000-0x3a1fffff])
[    2.419138] pci_bus 0005:00: root bus resource [mem
0x1f40000000-0x1fffffffff] (bus address [0x40000000-0xffffffff])
[    2.419143] pci_bus 0005:00: root bus resource [mem
0x1c00000000-0x1f3fffffff pref]
[    2.419169] pci 0005:00:00.0: [10de:1ad0] type 01 class 0x060400
[    2.419318] pci 0005:00:00.0: PME# supported from D0 D3hot D3cold
[    2.419576] iommu: Adding device 0005:00:00.0 to group 57
[    2.419962] pci 0005:01:00.0: [8086:2723] type 00 class 0x028000
[    2.420091] pci 0005:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[    2.420750] pci 0005:01:00.0: PME# supported from D0 D3hot D3cold
[    2.421038] iommu: Adding device 0005:01:00.0 to group 58
[    2.431805] pci 0005:00:00.0: BAR 14: assigned [mem
0x1f40000000-0x1f400fffff]
[    2.431816] pci 0005:01:00.0: BAR 0: assigned [mem 0x1f40000000-0x1f40003fff
64bit]
[    2.431882] pci 0005:00:00.0: PCI bridge to [bus 01-ff]
[    2.431890] pci 0005:00:00.0:   bridge window [mem
0x1f40000000-0x1f400fffff]
[    2.431907] pci 0005:00:00.0: Max Payload Size set to  128/ 256 (was  256),
Max Read Rq  512
[    2.431955] pci 0005:01:00.0: Max Payload Size set to  128/ 128 (was  128),
Max Read Rq  128
[    2.432288] pcieport 0005:00:00.0: Signaling PME through PCIe PME interrupt
[    2.432294] pci 0005:01:00.0: Signaling PME through PCIe PME interrupt
[    2.432300] pcie_pme 0005:00:00.0:pcie001: service driver pcie_pme loaded
[    2.432392] aer 0005:00:00.0:pcie002: service driver aer loaded
[    2.443411] tegra-cbb 14040000.cv-noc: noc_secure_irq = 87,
noc_nonsecure_irq = 86>
[    2.448166] tegra194-isp5 14800000.isp: initialized
[    2.456120] tegra194-vi5 15c10000.vi: using default number of vi channels,
36
[    2.461854] tegra194-vi5 15c10000.vi: initialized
[    2.466688] tegra194-vi5 15c10000.vi: subdev 15a00000.nvcsi--2 bound
[    2.466764] tegra194-vi5 15c10000.vi: subdev 15a00000.nvcsi--1 bound
[    2.467586] tegra186-cam-rtcpu bc00000.rtcpu: Trace buffer configured at
IOVA=0xbff00000
[    2.549472] tegra-ivc ivc-bc00000.rtcpu: region 0:
iova=0xbfee0000-0xbfefffff size=131072
[    2.549773] tegra-ivc ivc-bc00000.rtcpu:echo@0: echo: ver=0 grp=1
RX[16x64]=0x1000-0x1480 TX[16x64]=0x1480-0x1900
[    2.550006] tegra-ivc ivc-bc00000.rtcpu:dbg@1: dbg: ver=0 grp=1
RX[1x384]=0x1900-0x1b00 TX[1x384]=0x1b00-0x1d00
[    2.550207] tegra-ivc ivc-bc00000.rtcpu:dbg@2: dbg: ver=0 grp=1
RX[1x8192]=0x1d00-0x3d80 TX[1x8192]=0x3d80-0x5e00
[    2.550601] tegra-ivc ivc-bc00000.rtcpu:ivccontrol@3: ivccontrol: ver=0
grp=1 RX[64x320]=0x5e00-0xae80 TX[64x320]=0xae80-0xff00
[    2.550660] tegra-ivc ivc-bc00000.rtcpu:ivccapture@4: ivccapture: ver=0
grp=1 RX[512x64]=0xff00-0x17f80 TX[512x64]=0x17f80-0x20000
[    2.550943] tegra186-cam-rtcpu bc00000.rtcpu: using cam RTCPU IRQ (63)
[    2.550970] tegra186-cam-rtcpu bc00000.rtcpu: tegra_camrtc_mon_create is
successful
[    2.552234] tegra186-cam-rtcpu bc00000.rtcpu: firmware version cpu=rce cmd=5
sha1=cf2bef3ad10e437272857b76308abef8ffb80bda
[    2.552732] gpio tegra-gpio wake67 for gpio=48(G:0)
[    2.552802] gpio tegra-gpio-aon wake29 for gpio=36(EE:4)
[    2.552943] input: gpio-keys as /devices/gpio-keys/input/input4
[    2.554905] tegra_cec 3960000.tegra_cec: Can't find physical addresse.
[    2.554911] tegra_cec 3960000.tegra_cec: tegra_cec_init Done.
[    2.583964] tegra_rtc c2a0000.rtc: setting system clock to 2000-01-01
01:00:13 UTC (946688413)
[    2.584463] mmcblk mmc0:0001: Card claimed for testing.
[    2.625013] bpmp: mounted debugfs mirror
[    2.631586] vdd-sdmmc1-sw: disabling
[    2.631597] vdd-1v8-sd: disabling
[    2.631606] vdd-1v8-cvb: disabling
[    2.631613] vdd-epb-1v0: disabling
[    2.631620] avdd-cam-2v8: disabling
[    2.631627] vdd-fan: disabling
[    2.631636] vdd_sys_en: disabling
[    2.631648] ALSA device list:
[    2.631654]   #0: tegra-hda-galen-t194 at 0x3518000 irq 62
[    2.631659]   #1: jetson-xaviernx-ape
[    2.633818] Freeing unused kernel memory: 8576K
[    2.666163] Root device found: mmcblk0p1
[    2.667666] Found dev node: /dev/mmcblk0p1
[    2.807550] EXT4-fs (mmcblk0p1): 2 orphan inodes deleted
[    2.807561] EXT4-fs (mmcblk0p1): recovery complete
[    2.812564] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode.
Opts: (null)
[    2.813772] Rootfs mounted over mmcblk0p1
[    2.833610] Switching from initrd to actual rootfs
[    2.942338] systemd[1]: System time before build time, advancing clock.
[    2.964495] ip_tables: (C) 2000-2006 Netfilter Core Team
[    2.968559] cgroup: cgroup2: unknown option "nsdelegate"
[    2.976429] systemd[1]: systemd 237 running in system mode. (+PAM +AUDIT
+SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS
+ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2
default-hierarchy=hybrid)
[    2.977089] systemd[1]: Detected architecture arm64.
[    2.984098] systemd[1]: Set hostname to <nvidia-desktop>.
[    3.066270] systemd[1]: File /lib/systemd/system/systemd-journald.service:36
configures an IP firewall (IPAddressDeny=any), but the local system does not
support BPF/cgroup based firewalling.
[    3.066283] systemd[1]: Proceeding WITHOUT firewalling in effect! (This
warning is only shown for the first loaded unit using IP firewalling.)
[    3.204345] random: systemd: uninitialized urandom read (16 bytes read)
[    3.207200] systemd[1]: Created slice User and Session Slice.
[    3.207362] random: systemd: uninitialized urandom read (16 bytes read)
[    3.208467] systemd[1]: Created slice System Slice.
[    3.208548] random: systemd: uninitialized urandom read (16 bytes read)
[    3.209644] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    3.209945] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.210170] systemd[1]: Listening on udev Control Socket.
[    3.264503] EXT4-fs (mmcblk0p1): re-mounted. Opts: (null)
[    3.334770] nvgpu: 17000000.gv11b          nvgpu_nvhost_syncpt_init:291 
[INFO]  syncpt_unit_base 60000000 syncpt_unit_size 400000 size 1000

[    3.622765] systemd-journald[2325]: Received request to flush runtime
journal from PID 1
[    4.338334] using random self ethernet address
[    4.338466] using random host ethernet address
[    5.029482] random: crng init done
[    5.029590] random: 7 urandom warning(s) missed due to ratelimiting
[    5.088799] Mass Storage Function, version: 2009/09/11
[    5.088809] LUN: removable file: (no medium)
[    5.095534] using random self ethernet address
[    5.095675] using random host ethernet address
[    5.120119] rndis0: HOST MAC 62:d7:f7:de:b2:00
[    5.120350] rndis0: MAC 62:d7:f7:de:b2:01
[    5.122087] usb0: HOST MAC 62:d7:f7:de:b2:02
[    5.122131] usb0: MAC 62:d7:f7:de:b2:03
[    5.122158] tegra-xudc-new 3550000.xudc: ep 0 (type: 0, dir: out) enabled
[    5.128213] l4tbr0: port 1(rndis0) entered blocking state
[    5.128225] l4tbr0: port 1(rndis0) entered disabled state
[    5.129683] device rndis0 entered promiscuous mode
[    5.136225] IPv6: ADDRCONF(NETDEV_UP): rndis0: link is not ready
[    5.143351] l4tbr0: port 2(usb0) entered blocking state
[    5.143360] l4tbr0: port 2(usb0) entered disabled state
[    5.144481] device usb0 entered promiscuous mode
[    5.153940] IPv6: ADDRCONF(NETDEV_UP): usb0: link is not ready
[    5.239503] ras_fhi_disable: FHI 468 disabled
[    5.240177] CPU2: shutdown
[    5.240283] psci: CPU2 killed.
[    5.311457] ras_fhi_disable: FHI 469 disabled
[    5.312118] CPU3: shutdown
[    5.312222] psci: CPU3 killed.
[    5.320231] android_work: did not send uevent (0 0           (null))
[    5.367477] ras_fhi_disable: FHI 470 disabled
[    5.368320] CPU4: shutdown
[    5.368420] psci: CPU4 killed.
[    5.393191] android_work: sent uevent USB_STATE=CONNECTED
[    5.411457] ras_fhi_disable: FHI 471 disabled
[    5.412516] CPU5: shutdown
[    5.412623] psci: CPU5 killed.
[    5.414411] nvgpu: 17000000.gv11b                 tpc_pg_mask_store:843 
[INFO]  no value change, same mask already set
[    5.448478] android_work: sent uevent USB_STATE=DISCONNECTED
[    5.469512] compat: loading out-of-tree module taints kernel.
[    5.474137] Loading modules backported from iwlwifi
[    5.474142] iwlwifi-stack-public:master:8324:9176b151
[    5.541104] android_work: sent uevent USB_STATE=CONNECTED
[    5.542395] configfs-gadget gadget: high-speed config #1: c
[    5.542425] tegra-xudc-new 3550000.xudc: ep 5 (type: 3, dir: in) enabled
[    5.542438] tegra-xudc-new 3550000.xudc: ep 3 (type: 2, dir: in) enabled
[    5.542449] tegra-xudc-new 3550000.xudc: ep 2 (type: 2, dir: out) enabled
[    5.542524] tegra-xudc-new 3550000.xudc: ep 9 (type: 3, dir: in) enabled
[    5.542536] tegra-xudc-new 3550000.xudc: ep 7 (type: 2, dir: in) enabled
[    5.542547] tegra-xudc-new 3550000.xudc: ep 4 (type: 2, dir: out) enabled
[    5.542574] tegra-xudc-new 3550000.xudc: ep 15 (type: 3, dir: in) enabled
[    5.542594] tegra-xudc-new 3550000.xudc: ep 11 (type: 2, dir: in) enabled
[    5.542613] tegra-xudc-new 3550000.xudc: ep 6 (type: 2, dir: out) enabled
[    5.542676] IPv6: ADDRCONF(NETDEV_CHANGE): rndis0: link becomes ready
[    5.543049] android_work: sent uevent USB_STATE=CONFIGURED
[    5.550599] tegra-xudc-new 3550000.xudc: ep 13 (type: 2, dir: in) enabled
[    5.550616] tegra-xudc-new 3550000.xudc: ep 8 (type: 2, dir: out) enabled
[    5.550728] IPv6: ADDRCONF(NETDEV_CHANGE): usb0: link becomes ready
[    5.550938] tegra-xudc-new 3550000.xudc: ep 13 disabled
[    5.551042] tegra-xudc-new 3550000.xudc: ep 8 disabled
[    5.569180] tegra-xudc-new 3550000.xudc: ep 13 (type: 2, dir: in) enabled
[    5.569195] tegra-xudc-new 3550000.xudc: ep 8 (type: 2, dir: out) enabled
[    5.643094] zram: Added device: zram0
[    5.647335] zram: Added device: zram1
[    5.691617] zram0: detected capacity change from 0 to 2037280768
[    5.744958] Adding 1989528k swap on /dev/zram0.  Priority:5 extents:1
across:1989528k SS
[    5.769715] zram1: detected capacity change from 0 to 2037280768
[    5.798522] Adding 1989528k swap on /dev/zram1.  Priority:5 extents:1
across:1989528k SS
[    6.030757] Wake76 for irq=199
[    6.030764] Wake77 for irq=199
[    6.030767] Wake78 for irq=199
[    6.030770] Wake79 for irq=199
[    6.030773] Wake80 for irq=199
[    6.030775] Wake81 for irq=199
[    6.030778] Wake82 for irq=199
[    6.030837] tegra-xusb 3610000.xhci: Upgrade port 0 to USB3.0
[    6.030842] tegra-xusb 3610000.xhci: Upgrade port 1 to USB3.0
[    6.057936] cfg80211: Loading compiled-in X.509 certificates for regulatory
database
[    6.062710] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    6.076516] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    6.351365] usb 2-3: new SuperSpeed USB device number 2 using tegra-xusb
[    6.381019] usb 2-3: New USB device found, idVendor=0bda, idProduct=0411
[    6.381027] usb 2-3: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    6.381032] usb 2-3: Product: 4-Port USB 3.1 Hub
[    6.381036] usb 2-3: Manufacturer: Generic
[    6.391645] gpio tegra-gpio wake20 for gpio=52(G:4)
[    6.394239] hub 2-3:1.0: USB hub found
[    6.395345] hub 2-3:1.0: 4 ports detected
[    6.397592] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    6.460204] Intel(R) Wireless WiFi driver for Linux
[    6.460210] Copyright(c) 2003- 2015 Intel Corporation
[    6.460446] iwlwifi 0005:01:00.0: enabling device (0000 -> 0002)
[    6.471340] iwlwifi 0005:01:00.0: Direct firmware load for iwl-dbg-cfg.ini
failed with error -2
[    6.471536] iwlwifi 0005:01:00.0: Falling back to user helper
[    6.559788] usb 2-3: usb_suspend_both: status 0
[    6.562580] usb usb2: usb_suspend_both: status 0
[    6.705660] usbcore: registered new interface driver btusb
[    6.956227] tegradc 15200000.nvdisplay: blank - powerdown
[    6.956239] tegradc 15210000.nvdisplay: blank - powerdown
[    7.769300] fuse init (API version 7.26)
[    8.040903] eqos 2490000.ether_qos eth0: Link is Up - 100Mbps/Full - flow
control off
[    8.041522] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   12.771449] l4tbr0: port 2(usb0) entered blocking state
[   12.771457] l4tbr0: port 2(usb0) entered forwarding state
[   12.771526] l4tbr0: port 1(rndis0) entered blocking state
[   12.771531] l4tbr0: port 1(rndis0) entered forwarding state
[   12.783121] IPv6: ADDRCONF(NETDEV_UP): l4tbr0: link is not ready
[   12.783151] IPv6: ADDRCONF(NETDEV_CHANGE): l4tbr0: link becomes ready
[   66.908383] iwlwifi 0005:01:00.0: Direct firmware load for
iwlwifi-cc-a0-55.ucode failed with error -2
[   66.909744] iwlwifi 0005:01:00.0: Falling back to user helper
[   66.919171] iwlwifi 0005:01:00.0: Direct firmware load for
iwlwifi-cc-a0-54.ucode failed with error -2
[   66.919361] iwlwifi 0005:01:00.0: Falling back to user helper
[   66.920271] iwlwifi 0005:01:00.0: Direct firmware load for
iwlwifi-cc-a0-53.ucode failed with error -2
[   66.920456] iwlwifi 0005:01:00.0: Falling back to user helper
[   66.921475] iwlwifi 0005:01:00.0: Direct firmware load for
iwlwifi-cc-a0-52.ucode failed with error -2
[   66.921659] iwlwifi 0005:01:00.0: Falling back to user helper
[   66.924350] iwlwifi 0005:01:00.0: Direct firmware load for
iwlwifi-cc-a0-51.ucode failed with error -2
[   66.924533] iwlwifi 0005:01:00.0: Falling back to user helper
[   66.926520] iwlwifi 0005:01:00.0: Direct firmware load for
iwlwifi-cc-a0-50.ucode failed with error -2
[   66.926699] iwlwifi 0005:01:00.0: Falling back to user helper
[   66.930752] iwlwifi 0005:01:00.0: Direct firmware load for
iwlwifi-cc-a0-49.ucode failed with error -2
[   66.930978] iwlwifi 0005:01:00.0: Falling back to user helper
[   66.956381] iwlwifi 0005:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version:
43.2.23.17
[   66.956394] iwlwifi 0005:01:00.0: Found debug destination: EXTERNAL_DRAM
[   66.956398] iwlwifi 0005:01:00.0: Found debug configuration: 0
[   66.957014] iwlwifi 0005:01:00.0: loaded firmware version 48.4fa0041f.0
cc-a0-48.ucode op_mode iwlmvm
[   66.957089] iwlwifi 0005:01:00.0: Direct firmware load for
iwl-debug-yoyo.bin failed with error -2
[   66.957262] iwlwifi 0005:01:00.0: Falling back to user helper
[   67.219341] iwlwifi 0005:01:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz,
REV=0x340
[   67.234296] iwlwifi 0005:01:00.0: Applying debug destination EXTERNAL_DRAM
[   67.234686] iwlwifi 0005:01:00.0: Allocated 0x00400000 bytes for firmware
monitor.
[   67.332345] iwlwifi 0005:01:00.0: reporting RF_KILL (radio disabled)
[   67.393427] iwlwifi 0005:01:00.0: base HW address: dc:fb:48:02:b1:e7
[   67.419244] thermal thermal_zone6: failed to read out thermal zone (-61)
[   67.419393] thermal thermal_zone6: Registering thermal zone thermal_zone6
for type iwlwifi_1
[   67.529604] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
