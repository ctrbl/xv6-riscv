
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	b5013103          	ld	sp,-1200(sp) # 80009b50 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	076000ef          	jal	ra,8000008c <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e422                	sd	s0,8(sp)
    80000020:	0800                	addi	s0,sp,16
// which hart (core) is this?
static inline uint64
r_mhartid()
{
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000022:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80000026:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000; // cycles; 
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    8000002a:	0037979b          	slliw	a5,a5,0x3
    8000002e:	02004737          	lui	a4,0x2004
    80000032:	97ba                	add	a5,a5,a4
    80000034:	0200c737          	lui	a4,0x200c
    80000038:	ff873603          	ld	a2,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000003c:	3e860613          	addi	a2,a2,1000
    80000040:	e390                	sd	a2,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80000042:	00269713          	slli	a4,a3,0x2
    80000046:	9736                	add	a4,a4,a3
    80000048:	00371693          	slli	a3,a4,0x3
    8000004c:	0000a717          	auipc	a4,0xa
    80000050:	b6470713          	addi	a4,a4,-1180 # 80009bb0 <timer_scratch>
    80000054:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80000056:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80000058:	3e800793          	li	a5,1000
    8000005c:	f31c                	sd	a5,32(a4)
}

static inline void 
w_mscratch(uint64 x)
{
  asm volatile("csrw mscratch, %0" : : "r" (x));
    8000005e:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80000062:	00007797          	auipc	a5,0x7
    80000066:	9ee78793          	addi	a5,a5,-1554 # 80006a50 <timervec>
    8000006a:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000006e:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80000072:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80000076:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    8000007a:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    8000007e:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80000082:	30479073          	csrw	mie,a5
}
    80000086:	6422                	ld	s0,8(sp)
    80000088:	0141                	addi	sp,sp,16
    8000008a:	8082                	ret

000000008000008c <start>:
{
    8000008c:	1141                	addi	sp,sp,-16
    8000008e:	e406                	sd	ra,8(sp)
    80000090:	e022                	sd	s0,0(sp)
    80000092:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000094:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80000098:	7779                	lui	a4,0xffffe
    8000009a:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffda5df>
    8000009e:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800000a0:	6705                	lui	a4,0x1
    800000a2:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800000a6:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800000a8:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800000ac:	00001797          	auipc	a5,0x1
    800000b0:	e7278793          	addi	a5,a5,-398 # 80000f1e <main>
    800000b4:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800000b8:	4781                	li	a5,0
    800000ba:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000be:	67c1                	lui	a5,0x10
    800000c0:	17fd                	addi	a5,a5,-1
    800000c2:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    800000c6:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    800000ca:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800000ce:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    800000d2:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    800000d6:	57fd                	li	a5,-1
    800000d8:	83a9                	srli	a5,a5,0xa
    800000da:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    800000de:	47bd                	li	a5,15
    800000e0:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    800000e4:	00000097          	auipc	ra,0x0
    800000e8:	f38080e7          	jalr	-200(ra) # 8000001c <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800000ec:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800000f0:	2781                	sext.w	a5,a5
}

static inline void 
w_tp(uint64 x)
{
  asm volatile("mv tp, %0" : : "r" (x));
    800000f2:	823e                	mv	tp,a5
  asm volatile("mret");
    800000f4:	30200073          	mret
}
    800000f8:	60a2                	ld	ra,8(sp)
    800000fa:	6402                	ld	s0,0(sp)
    800000fc:	0141                	addi	sp,sp,16
    800000fe:	8082                	ret

0000000080000100 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80000100:	715d                	addi	sp,sp,-80
    80000102:	e486                	sd	ra,72(sp)
    80000104:	e0a2                	sd	s0,64(sp)
    80000106:	fc26                	sd	s1,56(sp)
    80000108:	f84a                	sd	s2,48(sp)
    8000010a:	f44e                	sd	s3,40(sp)
    8000010c:	f052                	sd	s4,32(sp)
    8000010e:	ec56                	sd	s5,24(sp)
    80000110:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80000112:	04c05663          	blez	a2,8000015e <consolewrite+0x5e>
    80000116:	8a2a                	mv	s4,a0
    80000118:	84ae                	mv	s1,a1
    8000011a:	89b2                	mv	s3,a2
    8000011c:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    8000011e:	5afd                	li	s5,-1
    80000120:	4685                	li	a3,1
    80000122:	8626                	mv	a2,s1
    80000124:	85d2                	mv	a1,s4
    80000126:	fbf40513          	addi	a0,s0,-65
    8000012a:	00003097          	auipc	ra,0x3
    8000012e:	898080e7          	jalr	-1896(ra) # 800029c2 <either_copyin>
    80000132:	01550c63          	beq	a0,s5,8000014a <consolewrite+0x4a>
      break;
    uartputc(c);
    80000136:	fbf44503          	lbu	a0,-65(s0)
    8000013a:	00001097          	auipc	ra,0x1
    8000013e:	828080e7          	jalr	-2008(ra) # 80000962 <uartputc>
  for(i = 0; i < n; i++){
    80000142:	2905                	addiw	s2,s2,1
    80000144:	0485                	addi	s1,s1,1
    80000146:	fd299de3          	bne	s3,s2,80000120 <consolewrite+0x20>
  }

  return i;
}
    8000014a:	854a                	mv	a0,s2
    8000014c:	60a6                	ld	ra,72(sp)
    8000014e:	6406                	ld	s0,64(sp)
    80000150:	74e2                	ld	s1,56(sp)
    80000152:	7942                	ld	s2,48(sp)
    80000154:	79a2                	ld	s3,40(sp)
    80000156:	7a02                	ld	s4,32(sp)
    80000158:	6ae2                	ld	s5,24(sp)
    8000015a:	6161                	addi	sp,sp,80
    8000015c:	8082                	ret
  for(i = 0; i < n; i++){
    8000015e:	4901                	li	s2,0
    80000160:	b7ed                	j	8000014a <consolewrite+0x4a>

0000000080000162 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80000162:	7159                	addi	sp,sp,-112
    80000164:	f486                	sd	ra,104(sp)
    80000166:	f0a2                	sd	s0,96(sp)
    80000168:	eca6                	sd	s1,88(sp)
    8000016a:	e8ca                	sd	s2,80(sp)
    8000016c:	e4ce                	sd	s3,72(sp)
    8000016e:	e0d2                	sd	s4,64(sp)
    80000170:	fc56                	sd	s5,56(sp)
    80000172:	f85a                	sd	s6,48(sp)
    80000174:	f45e                	sd	s7,40(sp)
    80000176:	f062                	sd	s8,32(sp)
    80000178:	ec66                	sd	s9,24(sp)
    8000017a:	e86a                	sd	s10,16(sp)
    8000017c:	1880                	addi	s0,sp,112
    8000017e:	8aaa                	mv	s5,a0
    80000180:	8a2e                	mv	s4,a1
    80000182:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80000184:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80000188:	00012517          	auipc	a0,0x12
    8000018c:	b6850513          	addi	a0,a0,-1176 # 80011cf0 <cons>
    80000190:	00001097          	auipc	ra,0x1
    80000194:	aec080e7          	jalr	-1300(ra) # 80000c7c <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80000198:	00012497          	auipc	s1,0x12
    8000019c:	b5848493          	addi	s1,s1,-1192 # 80011cf0 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    800001a0:	00012917          	auipc	s2,0x12
    800001a4:	be890913          	addi	s2,s2,-1048 # 80011d88 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];

    if(c == C('D')){  // end-of-file
    800001a8:	4b91                	li	s7,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    800001aa:	5c7d                	li	s8,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    800001ac:	4ca9                	li	s9,10
  while(n > 0){
    800001ae:	07305b63          	blez	s3,80000224 <consoleread+0xc2>
    while(cons.r == cons.w){
    800001b2:	0984a783          	lw	a5,152(s1)
    800001b6:	09c4a703          	lw	a4,156(s1)
    800001ba:	02f71763          	bne	a4,a5,800001e8 <consoleread+0x86>
      if(killed(myproc())){
    800001be:	00002097          	auipc	ra,0x2
    800001c2:	994080e7          	jalr	-1644(ra) # 80001b52 <myproc>
    800001c6:	00002097          	auipc	ra,0x2
    800001ca:	4a2080e7          	jalr	1186(ra) # 80002668 <killed>
    800001ce:	e535                	bnez	a0,8000023a <consoleread+0xd8>
      sleep(&cons.r, &cons.lock);
    800001d0:	85a6                	mv	a1,s1
    800001d2:	854a                	mv	a0,s2
    800001d4:	00002097          	auipc	ra,0x2
    800001d8:	1d6080e7          	jalr	470(ra) # 800023aa <sleep>
    while(cons.r == cons.w){
    800001dc:	0984a783          	lw	a5,152(s1)
    800001e0:	09c4a703          	lw	a4,156(s1)
    800001e4:	fcf70de3          	beq	a4,a5,800001be <consoleread+0x5c>
    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    800001e8:	0017871b          	addiw	a4,a5,1
    800001ec:	08e4ac23          	sw	a4,152(s1)
    800001f0:	07f7f713          	andi	a4,a5,127
    800001f4:	9726                	add	a4,a4,s1
    800001f6:	01874703          	lbu	a4,24(a4)
    800001fa:	00070d1b          	sext.w	s10,a4
    if(c == C('D')){  // end-of-file
    800001fe:	077d0563          	beq	s10,s7,80000268 <consoleread+0x106>
    cbuf = c;
    80000202:	f8e40fa3          	sb	a4,-97(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000206:	4685                	li	a3,1
    80000208:	f9f40613          	addi	a2,s0,-97
    8000020c:	85d2                	mv	a1,s4
    8000020e:	8556                	mv	a0,s5
    80000210:	00002097          	auipc	ra,0x2
    80000214:	75c080e7          	jalr	1884(ra) # 8000296c <either_copyout>
    80000218:	01850663          	beq	a0,s8,80000224 <consoleread+0xc2>
    dst++;
    8000021c:	0a05                	addi	s4,s4,1
    --n;
    8000021e:	39fd                	addiw	s3,s3,-1
    if(c == '\n'){
    80000220:	f99d17e3          	bne	s10,s9,800001ae <consoleread+0x4c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80000224:	00012517          	auipc	a0,0x12
    80000228:	acc50513          	addi	a0,a0,-1332 # 80011cf0 <cons>
    8000022c:	00001097          	auipc	ra,0x1
    80000230:	b04080e7          	jalr	-1276(ra) # 80000d30 <release>

  return target - n;
    80000234:	413b053b          	subw	a0,s6,s3
    80000238:	a811                	j	8000024c <consoleread+0xea>
        release(&cons.lock);
    8000023a:	00012517          	auipc	a0,0x12
    8000023e:	ab650513          	addi	a0,a0,-1354 # 80011cf0 <cons>
    80000242:	00001097          	auipc	ra,0x1
    80000246:	aee080e7          	jalr	-1298(ra) # 80000d30 <release>
        return -1;
    8000024a:	557d                	li	a0,-1
}
    8000024c:	70a6                	ld	ra,104(sp)
    8000024e:	7406                	ld	s0,96(sp)
    80000250:	64e6                	ld	s1,88(sp)
    80000252:	6946                	ld	s2,80(sp)
    80000254:	69a6                	ld	s3,72(sp)
    80000256:	6a06                	ld	s4,64(sp)
    80000258:	7ae2                	ld	s5,56(sp)
    8000025a:	7b42                	ld	s6,48(sp)
    8000025c:	7ba2                	ld	s7,40(sp)
    8000025e:	7c02                	ld	s8,32(sp)
    80000260:	6ce2                	ld	s9,24(sp)
    80000262:	6d42                	ld	s10,16(sp)
    80000264:	6165                	addi	sp,sp,112
    80000266:	8082                	ret
      if(n < target){
    80000268:	0009871b          	sext.w	a4,s3
    8000026c:	fb677ce3          	bgeu	a4,s6,80000224 <consoleread+0xc2>
        cons.r--;
    80000270:	00012717          	auipc	a4,0x12
    80000274:	b0f72c23          	sw	a5,-1256(a4) # 80011d88 <cons+0x98>
    80000278:	b775                	j	80000224 <consoleread+0xc2>

000000008000027a <consputc>:
{
    8000027a:	1141                	addi	sp,sp,-16
    8000027c:	e406                	sd	ra,8(sp)
    8000027e:	e022                	sd	s0,0(sp)
    80000280:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80000282:	10000793          	li	a5,256
    80000286:	00f50a63          	beq	a0,a5,8000029a <consputc+0x20>
    uartputc_sync(c);
    8000028a:	00000097          	auipc	ra,0x0
    8000028e:	606080e7          	jalr	1542(ra) # 80000890 <uartputc_sync>
}
    80000292:	60a2                	ld	ra,8(sp)
    80000294:	6402                	ld	s0,0(sp)
    80000296:	0141                	addi	sp,sp,16
    80000298:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    8000029a:	4521                	li	a0,8
    8000029c:	00000097          	auipc	ra,0x0
    800002a0:	5f4080e7          	jalr	1524(ra) # 80000890 <uartputc_sync>
    800002a4:	02000513          	li	a0,32
    800002a8:	00000097          	auipc	ra,0x0
    800002ac:	5e8080e7          	jalr	1512(ra) # 80000890 <uartputc_sync>
    800002b0:	4521                	li	a0,8
    800002b2:	00000097          	auipc	ra,0x0
    800002b6:	5de080e7          	jalr	1502(ra) # 80000890 <uartputc_sync>
    800002ba:	bfe1                	j	80000292 <consputc+0x18>

00000000800002bc <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800002bc:	1101                	addi	sp,sp,-32
    800002be:	ec06                	sd	ra,24(sp)
    800002c0:	e822                	sd	s0,16(sp)
    800002c2:	e426                	sd	s1,8(sp)
    800002c4:	e04a                	sd	s2,0(sp)
    800002c6:	1000                	addi	s0,sp,32
    800002c8:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800002ca:	00012517          	auipc	a0,0x12
    800002ce:	a2650513          	addi	a0,a0,-1498 # 80011cf0 <cons>
    800002d2:	00001097          	auipc	ra,0x1
    800002d6:	9aa080e7          	jalr	-1622(ra) # 80000c7c <acquire>

  switch(c){
    800002da:	47d5                	li	a5,21
    800002dc:	0af48663          	beq	s1,a5,80000388 <consoleintr+0xcc>
    800002e0:	0297ca63          	blt	a5,s1,80000314 <consoleintr+0x58>
    800002e4:	47a1                	li	a5,8
    800002e6:	0ef48763          	beq	s1,a5,800003d4 <consoleintr+0x118>
    800002ea:	47c1                	li	a5,16
    800002ec:	10f49a63          	bne	s1,a5,80000400 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    800002f0:	00002097          	auipc	ra,0x2
    800002f4:	728080e7          	jalr	1832(ra) # 80002a18 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    800002f8:	00012517          	auipc	a0,0x12
    800002fc:	9f850513          	addi	a0,a0,-1544 # 80011cf0 <cons>
    80000300:	00001097          	auipc	ra,0x1
    80000304:	a30080e7          	jalr	-1488(ra) # 80000d30 <release>
}
    80000308:	60e2                	ld	ra,24(sp)
    8000030a:	6442                	ld	s0,16(sp)
    8000030c:	64a2                	ld	s1,8(sp)
    8000030e:	6902                	ld	s2,0(sp)
    80000310:	6105                	addi	sp,sp,32
    80000312:	8082                	ret
  switch(c){
    80000314:	07f00793          	li	a5,127
    80000318:	0af48e63          	beq	s1,a5,800003d4 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    8000031c:	00012717          	auipc	a4,0x12
    80000320:	9d470713          	addi	a4,a4,-1580 # 80011cf0 <cons>
    80000324:	0a072783          	lw	a5,160(a4)
    80000328:	09872703          	lw	a4,152(a4)
    8000032c:	9f99                	subw	a5,a5,a4
    8000032e:	07f00713          	li	a4,127
    80000332:	fcf763e3          	bltu	a4,a5,800002f8 <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80000336:	47b5                	li	a5,13
    80000338:	0cf48763          	beq	s1,a5,80000406 <consoleintr+0x14a>
      consputc(c);
    8000033c:	8526                	mv	a0,s1
    8000033e:	00000097          	auipc	ra,0x0
    80000342:	f3c080e7          	jalr	-196(ra) # 8000027a <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000346:	00012797          	auipc	a5,0x12
    8000034a:	9aa78793          	addi	a5,a5,-1622 # 80011cf0 <cons>
    8000034e:	0a07a683          	lw	a3,160(a5)
    80000352:	0016871b          	addiw	a4,a3,1
    80000356:	0007061b          	sext.w	a2,a4
    8000035a:	0ae7a023          	sw	a4,160(a5)
    8000035e:	07f6f693          	andi	a3,a3,127
    80000362:	97b6                	add	a5,a5,a3
    80000364:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80000368:	47a9                	li	a5,10
    8000036a:	0cf48563          	beq	s1,a5,80000434 <consoleintr+0x178>
    8000036e:	4791                	li	a5,4
    80000370:	0cf48263          	beq	s1,a5,80000434 <consoleintr+0x178>
    80000374:	00012797          	auipc	a5,0x12
    80000378:	a147a783          	lw	a5,-1516(a5) # 80011d88 <cons+0x98>
    8000037c:	9f1d                	subw	a4,a4,a5
    8000037e:	08000793          	li	a5,128
    80000382:	f6f71be3          	bne	a4,a5,800002f8 <consoleintr+0x3c>
    80000386:	a07d                	j	80000434 <consoleintr+0x178>
    while(cons.e != cons.w &&
    80000388:	00012717          	auipc	a4,0x12
    8000038c:	96870713          	addi	a4,a4,-1688 # 80011cf0 <cons>
    80000390:	0a072783          	lw	a5,160(a4)
    80000394:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80000398:	00012497          	auipc	s1,0x12
    8000039c:	95848493          	addi	s1,s1,-1704 # 80011cf0 <cons>
    while(cons.e != cons.w &&
    800003a0:	4929                	li	s2,10
    800003a2:	f4f70be3          	beq	a4,a5,800002f8 <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    800003a6:	37fd                	addiw	a5,a5,-1
    800003a8:	07f7f713          	andi	a4,a5,127
    800003ac:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800003ae:	01874703          	lbu	a4,24(a4)
    800003b2:	f52703e3          	beq	a4,s2,800002f8 <consoleintr+0x3c>
      cons.e--;
    800003b6:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800003ba:	10000513          	li	a0,256
    800003be:	00000097          	auipc	ra,0x0
    800003c2:	ebc080e7          	jalr	-324(ra) # 8000027a <consputc>
    while(cons.e != cons.w &&
    800003c6:	0a04a783          	lw	a5,160(s1)
    800003ca:	09c4a703          	lw	a4,156(s1)
    800003ce:	fcf71ce3          	bne	a4,a5,800003a6 <consoleintr+0xea>
    800003d2:	b71d                	j	800002f8 <consoleintr+0x3c>
    if(cons.e != cons.w){
    800003d4:	00012717          	auipc	a4,0x12
    800003d8:	91c70713          	addi	a4,a4,-1764 # 80011cf0 <cons>
    800003dc:	0a072783          	lw	a5,160(a4)
    800003e0:	09c72703          	lw	a4,156(a4)
    800003e4:	f0f70ae3          	beq	a4,a5,800002f8 <consoleintr+0x3c>
      cons.e--;
    800003e8:	37fd                	addiw	a5,a5,-1
    800003ea:	00012717          	auipc	a4,0x12
    800003ee:	9af72323          	sw	a5,-1626(a4) # 80011d90 <cons+0xa0>
      consputc(BACKSPACE);
    800003f2:	10000513          	li	a0,256
    800003f6:	00000097          	auipc	ra,0x0
    800003fa:	e84080e7          	jalr	-380(ra) # 8000027a <consputc>
    800003fe:	bded                	j	800002f8 <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80000400:	ee048ce3          	beqz	s1,800002f8 <consoleintr+0x3c>
    80000404:	bf21                	j	8000031c <consoleintr+0x60>
      consputc(c);
    80000406:	4529                	li	a0,10
    80000408:	00000097          	auipc	ra,0x0
    8000040c:	e72080e7          	jalr	-398(ra) # 8000027a <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000410:	00012797          	auipc	a5,0x12
    80000414:	8e078793          	addi	a5,a5,-1824 # 80011cf0 <cons>
    80000418:	0a07a703          	lw	a4,160(a5)
    8000041c:	0017069b          	addiw	a3,a4,1
    80000420:	0006861b          	sext.w	a2,a3
    80000424:	0ad7a023          	sw	a3,160(a5)
    80000428:	07f77713          	andi	a4,a4,127
    8000042c:	97ba                	add	a5,a5,a4
    8000042e:	4729                	li	a4,10
    80000430:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80000434:	00012797          	auipc	a5,0x12
    80000438:	94c7ac23          	sw	a2,-1704(a5) # 80011d8c <cons+0x9c>
        wakeup(&cons.r);
    8000043c:	00012517          	auipc	a0,0x12
    80000440:	94c50513          	addi	a0,a0,-1716 # 80011d88 <cons+0x98>
    80000444:	00002097          	auipc	ra,0x2
    80000448:	fca080e7          	jalr	-54(ra) # 8000240e <wakeup>
    8000044c:	b575                	j	800002f8 <consoleintr+0x3c>

000000008000044e <consoleinit>:

void
consoleinit(void)
{
    8000044e:	1141                	addi	sp,sp,-16
    80000450:	e406                	sd	ra,8(sp)
    80000452:	e022                	sd	s0,0(sp)
    80000454:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80000456:	00009597          	auipc	a1,0x9
    8000045a:	bba58593          	addi	a1,a1,-1094 # 80009010 <etext+0x10>
    8000045e:	00012517          	auipc	a0,0x12
    80000462:	89250513          	addi	a0,a0,-1902 # 80011cf0 <cons>
    80000466:	00000097          	auipc	ra,0x0
    8000046a:	786080e7          	jalr	1926(ra) # 80000bec <initlock>

  uartinit();
    8000046e:	00000097          	auipc	ra,0x0
    80000472:	3d2080e7          	jalr	978(ra) # 80000840 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80000476:	00023797          	auipc	a5,0x23
    8000047a:	c1278793          	addi	a5,a5,-1006 # 80023088 <devsw>
    8000047e:	00000717          	auipc	a4,0x0
    80000482:	ce470713          	addi	a4,a4,-796 # 80000162 <consoleread>
    80000486:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80000488:	00000717          	auipc	a4,0x0
    8000048c:	c7870713          	addi	a4,a4,-904 # 80000100 <consolewrite>
    80000490:	ef98                	sd	a4,24(a5)
}
    80000492:	60a2                	ld	ra,8(sp)
    80000494:	6402                	ld	s0,0(sp)
    80000496:	0141                	addi	sp,sp,16
    80000498:	8082                	ret

000000008000049a <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    8000049a:	7179                	addi	sp,sp,-48
    8000049c:	f406                	sd	ra,40(sp)
    8000049e:	f022                	sd	s0,32(sp)
    800004a0:	ec26                	sd	s1,24(sp)
    800004a2:	e84a                	sd	s2,16(sp)
    800004a4:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800004a6:	c219                	beqz	a2,800004ac <printint+0x12>
    800004a8:	08054663          	bltz	a0,80000534 <printint+0x9a>
    x = -xx;
  else
    x = xx;
    800004ac:	2501                	sext.w	a0,a0
    800004ae:	4881                	li	a7,0
    800004b0:	fd040693          	addi	a3,s0,-48

  i = 0;
    800004b4:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800004b6:	2581                	sext.w	a1,a1
    800004b8:	00009617          	auipc	a2,0x9
    800004bc:	ba860613          	addi	a2,a2,-1112 # 80009060 <digits>
    800004c0:	883a                	mv	a6,a4
    800004c2:	2705                	addiw	a4,a4,1
    800004c4:	02b577bb          	remuw	a5,a0,a1
    800004c8:	1782                	slli	a5,a5,0x20
    800004ca:	9381                	srli	a5,a5,0x20
    800004cc:	97b2                	add	a5,a5,a2
    800004ce:	0007c783          	lbu	a5,0(a5)
    800004d2:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    800004d6:	0005079b          	sext.w	a5,a0
    800004da:	02b5553b          	divuw	a0,a0,a1
    800004de:	0685                	addi	a3,a3,1
    800004e0:	feb7f0e3          	bgeu	a5,a1,800004c0 <printint+0x26>

  if(sign)
    800004e4:	00088b63          	beqz	a7,800004fa <printint+0x60>
    buf[i++] = '-';
    800004e8:	fe040793          	addi	a5,s0,-32
    800004ec:	973e                	add	a4,a4,a5
    800004ee:	02d00793          	li	a5,45
    800004f2:	fef70823          	sb	a5,-16(a4)
    800004f6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    800004fa:	02e05763          	blez	a4,80000528 <printint+0x8e>
    800004fe:	fd040793          	addi	a5,s0,-48
    80000502:	00e784b3          	add	s1,a5,a4
    80000506:	fff78913          	addi	s2,a5,-1
    8000050a:	993a                	add	s2,s2,a4
    8000050c:	377d                	addiw	a4,a4,-1
    8000050e:	1702                	slli	a4,a4,0x20
    80000510:	9301                	srli	a4,a4,0x20
    80000512:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80000516:	fff4c503          	lbu	a0,-1(s1)
    8000051a:	00000097          	auipc	ra,0x0
    8000051e:	d60080e7          	jalr	-672(ra) # 8000027a <consputc>
  while(--i >= 0)
    80000522:	14fd                	addi	s1,s1,-1
    80000524:	ff2499e3          	bne	s1,s2,80000516 <printint+0x7c>
}
    80000528:	70a2                	ld	ra,40(sp)
    8000052a:	7402                	ld	s0,32(sp)
    8000052c:	64e2                	ld	s1,24(sp)
    8000052e:	6942                	ld	s2,16(sp)
    80000530:	6145                	addi	sp,sp,48
    80000532:	8082                	ret
    x = -xx;
    80000534:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80000538:	4885                	li	a7,1
    x = -xx;
    8000053a:	bf9d                	j	800004b0 <printint+0x16>

000000008000053c <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    8000053c:	1101                	addi	sp,sp,-32
    8000053e:	ec06                	sd	ra,24(sp)
    80000540:	e822                	sd	s0,16(sp)
    80000542:	e426                	sd	s1,8(sp)
    80000544:	1000                	addi	s0,sp,32
    80000546:	84aa                	mv	s1,a0
  pr.locking = 0;
    80000548:	00012797          	auipc	a5,0x12
    8000054c:	8607a423          	sw	zero,-1944(a5) # 80011db0 <pr+0x18>
  printf("panic: ");
    80000550:	00009517          	auipc	a0,0x9
    80000554:	ac850513          	addi	a0,a0,-1336 # 80009018 <etext+0x18>
    80000558:	00000097          	auipc	ra,0x0
    8000055c:	02e080e7          	jalr	46(ra) # 80000586 <printf>
  printf(s);
    80000560:	8526                	mv	a0,s1
    80000562:	00000097          	auipc	ra,0x0
    80000566:	024080e7          	jalr	36(ra) # 80000586 <printf>
  printf("\n");
    8000056a:	00009517          	auipc	a0,0x9
    8000056e:	e3650513          	addi	a0,a0,-458 # 800093a0 <digits+0x340>
    80000572:	00000097          	auipc	ra,0x0
    80000576:	014080e7          	jalr	20(ra) # 80000586 <printf>
  panicked = 1; // freeze uart output from other CPUs
    8000057a:	4785                	li	a5,1
    8000057c:	00009717          	auipc	a4,0x9
    80000580:	5ef72a23          	sw	a5,1524(a4) # 80009b70 <panicked>
  for(;;)
    80000584:	a001                	j	80000584 <panic+0x48>

0000000080000586 <printf>:
{
    80000586:	7131                	addi	sp,sp,-192
    80000588:	fc86                	sd	ra,120(sp)
    8000058a:	f8a2                	sd	s0,112(sp)
    8000058c:	f4a6                	sd	s1,104(sp)
    8000058e:	f0ca                	sd	s2,96(sp)
    80000590:	ecce                	sd	s3,88(sp)
    80000592:	e8d2                	sd	s4,80(sp)
    80000594:	e4d6                	sd	s5,72(sp)
    80000596:	e0da                	sd	s6,64(sp)
    80000598:	fc5e                	sd	s7,56(sp)
    8000059a:	f862                	sd	s8,48(sp)
    8000059c:	f466                	sd	s9,40(sp)
    8000059e:	f06a                	sd	s10,32(sp)
    800005a0:	ec6e                	sd	s11,24(sp)
    800005a2:	0100                	addi	s0,sp,128
    800005a4:	8a2a                	mv	s4,a0
    800005a6:	e40c                	sd	a1,8(s0)
    800005a8:	e810                	sd	a2,16(s0)
    800005aa:	ec14                	sd	a3,24(s0)
    800005ac:	f018                	sd	a4,32(s0)
    800005ae:	f41c                	sd	a5,40(s0)
    800005b0:	03043823          	sd	a6,48(s0)
    800005b4:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800005b8:	00011d97          	auipc	s11,0x11
    800005bc:	7f8dad83          	lw	s11,2040(s11) # 80011db0 <pr+0x18>
  if(locking)
    800005c0:	020d9b63          	bnez	s11,800005f6 <printf+0x70>
  if (fmt == 0)
    800005c4:	040a0263          	beqz	s4,80000608 <printf+0x82>
  va_start(ap, fmt);
    800005c8:	00840793          	addi	a5,s0,8
    800005cc:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800005d0:	000a4503          	lbu	a0,0(s4)
    800005d4:	14050f63          	beqz	a0,80000732 <printf+0x1ac>
    800005d8:	4981                	li	s3,0
    if(c != '%'){
    800005da:	02500a93          	li	s5,37
    switch(c){
    800005de:	07000b93          	li	s7,112
  consputc('x');
    800005e2:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800005e4:	00009b17          	auipc	s6,0x9
    800005e8:	a7cb0b13          	addi	s6,s6,-1412 # 80009060 <digits>
    switch(c){
    800005ec:	07300c93          	li	s9,115
    800005f0:	06400c13          	li	s8,100
    800005f4:	a82d                	j	8000062e <printf+0xa8>
    acquire(&pr.lock);
    800005f6:	00011517          	auipc	a0,0x11
    800005fa:	7a250513          	addi	a0,a0,1954 # 80011d98 <pr>
    800005fe:	00000097          	auipc	ra,0x0
    80000602:	67e080e7          	jalr	1662(ra) # 80000c7c <acquire>
    80000606:	bf7d                	j	800005c4 <printf+0x3e>
    panic("null fmt");
    80000608:	00009517          	auipc	a0,0x9
    8000060c:	a2050513          	addi	a0,a0,-1504 # 80009028 <etext+0x28>
    80000610:	00000097          	auipc	ra,0x0
    80000614:	f2c080e7          	jalr	-212(ra) # 8000053c <panic>
      consputc(c);
    80000618:	00000097          	auipc	ra,0x0
    8000061c:	c62080e7          	jalr	-926(ra) # 8000027a <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000620:	2985                	addiw	s3,s3,1
    80000622:	013a07b3          	add	a5,s4,s3
    80000626:	0007c503          	lbu	a0,0(a5)
    8000062a:	10050463          	beqz	a0,80000732 <printf+0x1ac>
    if(c != '%'){
    8000062e:	ff5515e3          	bne	a0,s5,80000618 <printf+0x92>
    c = fmt[++i] & 0xff;
    80000632:	2985                	addiw	s3,s3,1
    80000634:	013a07b3          	add	a5,s4,s3
    80000638:	0007c783          	lbu	a5,0(a5)
    8000063c:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80000640:	cbed                	beqz	a5,80000732 <printf+0x1ac>
    switch(c){
    80000642:	05778a63          	beq	a5,s7,80000696 <printf+0x110>
    80000646:	02fbf663          	bgeu	s7,a5,80000672 <printf+0xec>
    8000064a:	09978863          	beq	a5,s9,800006da <printf+0x154>
    8000064e:	07800713          	li	a4,120
    80000652:	0ce79563          	bne	a5,a4,8000071c <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    80000656:	f8843783          	ld	a5,-120(s0)
    8000065a:	00878713          	addi	a4,a5,8
    8000065e:	f8e43423          	sd	a4,-120(s0)
    80000662:	4605                	li	a2,1
    80000664:	85ea                	mv	a1,s10
    80000666:	4388                	lw	a0,0(a5)
    80000668:	00000097          	auipc	ra,0x0
    8000066c:	e32080e7          	jalr	-462(ra) # 8000049a <printint>
      break;
    80000670:	bf45                	j	80000620 <printf+0x9a>
    switch(c){
    80000672:	09578f63          	beq	a5,s5,80000710 <printf+0x18a>
    80000676:	0b879363          	bne	a5,s8,8000071c <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    8000067a:	f8843783          	ld	a5,-120(s0)
    8000067e:	00878713          	addi	a4,a5,8
    80000682:	f8e43423          	sd	a4,-120(s0)
    80000686:	4605                	li	a2,1
    80000688:	45a9                	li	a1,10
    8000068a:	4388                	lw	a0,0(a5)
    8000068c:	00000097          	auipc	ra,0x0
    80000690:	e0e080e7          	jalr	-498(ra) # 8000049a <printint>
      break;
    80000694:	b771                	j	80000620 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80000696:	f8843783          	ld	a5,-120(s0)
    8000069a:	00878713          	addi	a4,a5,8
    8000069e:	f8e43423          	sd	a4,-120(s0)
    800006a2:	0007b903          	ld	s2,0(a5)
  consputc('0');
    800006a6:	03000513          	li	a0,48
    800006aa:	00000097          	auipc	ra,0x0
    800006ae:	bd0080e7          	jalr	-1072(ra) # 8000027a <consputc>
  consputc('x');
    800006b2:	07800513          	li	a0,120
    800006b6:	00000097          	auipc	ra,0x0
    800006ba:	bc4080e7          	jalr	-1084(ra) # 8000027a <consputc>
    800006be:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800006c0:	03c95793          	srli	a5,s2,0x3c
    800006c4:	97da                	add	a5,a5,s6
    800006c6:	0007c503          	lbu	a0,0(a5)
    800006ca:	00000097          	auipc	ra,0x0
    800006ce:	bb0080e7          	jalr	-1104(ra) # 8000027a <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800006d2:	0912                	slli	s2,s2,0x4
    800006d4:	34fd                	addiw	s1,s1,-1
    800006d6:	f4ed                	bnez	s1,800006c0 <printf+0x13a>
    800006d8:	b7a1                	j	80000620 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    800006da:	f8843783          	ld	a5,-120(s0)
    800006de:	00878713          	addi	a4,a5,8
    800006e2:	f8e43423          	sd	a4,-120(s0)
    800006e6:	6384                	ld	s1,0(a5)
    800006e8:	cc89                	beqz	s1,80000702 <printf+0x17c>
      for(; *s; s++)
    800006ea:	0004c503          	lbu	a0,0(s1)
    800006ee:	d90d                	beqz	a0,80000620 <printf+0x9a>
        consputc(*s);
    800006f0:	00000097          	auipc	ra,0x0
    800006f4:	b8a080e7          	jalr	-1142(ra) # 8000027a <consputc>
      for(; *s; s++)
    800006f8:	0485                	addi	s1,s1,1
    800006fa:	0004c503          	lbu	a0,0(s1)
    800006fe:	f96d                	bnez	a0,800006f0 <printf+0x16a>
    80000700:	b705                	j	80000620 <printf+0x9a>
        s = "(null)";
    80000702:	00009497          	auipc	s1,0x9
    80000706:	91e48493          	addi	s1,s1,-1762 # 80009020 <etext+0x20>
      for(; *s; s++)
    8000070a:	02800513          	li	a0,40
    8000070e:	b7cd                	j	800006f0 <printf+0x16a>
      consputc('%');
    80000710:	8556                	mv	a0,s5
    80000712:	00000097          	auipc	ra,0x0
    80000716:	b68080e7          	jalr	-1176(ra) # 8000027a <consputc>
      break;
    8000071a:	b719                	j	80000620 <printf+0x9a>
      consputc('%');
    8000071c:	8556                	mv	a0,s5
    8000071e:	00000097          	auipc	ra,0x0
    80000722:	b5c080e7          	jalr	-1188(ra) # 8000027a <consputc>
      consputc(c);
    80000726:	8526                	mv	a0,s1
    80000728:	00000097          	auipc	ra,0x0
    8000072c:	b52080e7          	jalr	-1198(ra) # 8000027a <consputc>
      break;
    80000730:	bdc5                	j	80000620 <printf+0x9a>
  if(locking)
    80000732:	020d9163          	bnez	s11,80000754 <printf+0x1ce>
}
    80000736:	70e6                	ld	ra,120(sp)
    80000738:	7446                	ld	s0,112(sp)
    8000073a:	74a6                	ld	s1,104(sp)
    8000073c:	7906                	ld	s2,96(sp)
    8000073e:	69e6                	ld	s3,88(sp)
    80000740:	6a46                	ld	s4,80(sp)
    80000742:	6aa6                	ld	s5,72(sp)
    80000744:	6b06                	ld	s6,64(sp)
    80000746:	7be2                	ld	s7,56(sp)
    80000748:	7c42                	ld	s8,48(sp)
    8000074a:	7ca2                	ld	s9,40(sp)
    8000074c:	7d02                	ld	s10,32(sp)
    8000074e:	6de2                	ld	s11,24(sp)
    80000750:	6129                	addi	sp,sp,192
    80000752:	8082                	ret
    release(&pr.lock);
    80000754:	00011517          	auipc	a0,0x11
    80000758:	64450513          	addi	a0,a0,1604 # 80011d98 <pr>
    8000075c:	00000097          	auipc	ra,0x0
    80000760:	5d4080e7          	jalr	1492(ra) # 80000d30 <release>
}
    80000764:	bfc9                	j	80000736 <printf+0x1b0>

0000000080000766 <printfinit>:
    ;
}

void
printfinit(void)
{
    80000766:	1101                	addi	sp,sp,-32
    80000768:	ec06                	sd	ra,24(sp)
    8000076a:	e822                	sd	s0,16(sp)
    8000076c:	e426                	sd	s1,8(sp)
    8000076e:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80000770:	00011497          	auipc	s1,0x11
    80000774:	62848493          	addi	s1,s1,1576 # 80011d98 <pr>
    80000778:	00009597          	auipc	a1,0x9
    8000077c:	8c058593          	addi	a1,a1,-1856 # 80009038 <etext+0x38>
    80000780:	8526                	mv	a0,s1
    80000782:	00000097          	auipc	ra,0x0
    80000786:	46a080e7          	jalr	1130(ra) # 80000bec <initlock>
  pr.locking = 1;
    8000078a:	4785                	li	a5,1
    8000078c:	cc9c                	sw	a5,24(s1)
}
    8000078e:	60e2                	ld	ra,24(sp)
    80000790:	6442                	ld	s0,16(sp)
    80000792:	64a2                	ld	s1,8(sp)
    80000794:	6105                	addi	sp,sp,32
    80000796:	8082                	ret

0000000080000798 <convertTicks>:

// Function to convert ticks to seconds (for more readability)
void convertTicks(int ticks) {
    80000798:	7179                	addi	sp,sp,-48
    8000079a:	f406                	sd	ra,40(sp)
    8000079c:	f022                	sd	s0,32(sp)
    8000079e:	ec26                	sd	s1,24(sp)
    800007a0:	e84a                	sd	s2,16(sp)
    800007a2:	e44e                	sd	s3,8(sp)
    800007a4:	1800                	addi	s0,sp,48
  uint minutes = ticks / 600; // 1 min = 60 * 100 ticks
    800007a6:	25800793          	li	a5,600
    800007aa:	02f549bb          	divw	s3,a0,a5
  ticks = ticks % 600;
    800007ae:	02f5653b          	remw	a0,a0,a5
  uint seconds = ticks / 10; // 1 sec = 10 ticks
    800007b2:	44a9                	li	s1,10
    800007b4:	0295493b          	divw	s2,a0,s1
  ticks = ticks % 10;
    800007b8:	029564bb          	remw	s1,a0,s1

  if (minutes < 10) printf("0"); 
    800007bc:	47a5                	li	a5,9
    800007be:	0537ff63          	bgeu	a5,s3,8000081c <convertTicks+0x84>
  printf("%d:", minutes); 
    800007c2:	85ce                	mv	a1,s3
    800007c4:	00009517          	auipc	a0,0x9
    800007c8:	88450513          	addi	a0,a0,-1916 # 80009048 <etext+0x48>
    800007cc:	00000097          	auipc	ra,0x0
    800007d0:	dba080e7          	jalr	-582(ra) # 80000586 <printf>
  if (seconds < 10) printf("0"); 
    800007d4:	47a5                	li	a5,9
    800007d6:	0527fc63          	bgeu	a5,s2,8000082e <convertTicks+0x96>
  printf("%d.", seconds); 
    800007da:	85ca                	mv	a1,s2
    800007dc:	00009517          	auipc	a0,0x9
    800007e0:	87450513          	addi	a0,a0,-1932 # 80009050 <etext+0x50>
    800007e4:	00000097          	auipc	ra,0x0
    800007e8:	da2080e7          	jalr	-606(ra) # 80000586 <printf>
  if (ticks < 10) printf("0"); 
    800007ec:	00009517          	auipc	a0,0x9
    800007f0:	85450513          	addi	a0,a0,-1964 # 80009040 <etext+0x40>
    800007f4:	00000097          	auipc	ra,0x0
    800007f8:	d92080e7          	jalr	-622(ra) # 80000586 <printf>
  printf("%d", ticks); 
    800007fc:	85a6                	mv	a1,s1
    800007fe:	00009517          	auipc	a0,0x9
    80000802:	85a50513          	addi	a0,a0,-1958 # 80009058 <etext+0x58>
    80000806:	00000097          	auipc	ra,0x0
    8000080a:	d80080e7          	jalr	-640(ra) # 80000586 <printf>
}
    8000080e:	70a2                	ld	ra,40(sp)
    80000810:	7402                	ld	s0,32(sp)
    80000812:	64e2                	ld	s1,24(sp)
    80000814:	6942                	ld	s2,16(sp)
    80000816:	69a2                	ld	s3,8(sp)
    80000818:	6145                	addi	sp,sp,48
    8000081a:	8082                	ret
  if (minutes < 10) printf("0"); 
    8000081c:	00009517          	auipc	a0,0x9
    80000820:	82450513          	addi	a0,a0,-2012 # 80009040 <etext+0x40>
    80000824:	00000097          	auipc	ra,0x0
    80000828:	d62080e7          	jalr	-670(ra) # 80000586 <printf>
    8000082c:	bf59                	j	800007c2 <convertTicks+0x2a>
  if (seconds < 10) printf("0"); 
    8000082e:	00009517          	auipc	a0,0x9
    80000832:	81250513          	addi	a0,a0,-2030 # 80009040 <etext+0x40>
    80000836:	00000097          	auipc	ra,0x0
    8000083a:	d50080e7          	jalr	-688(ra) # 80000586 <printf>
    8000083e:	bf71                	j	800007da <convertTicks+0x42>

0000000080000840 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80000840:	1141                	addi	sp,sp,-16
    80000842:	e406                	sd	ra,8(sp)
    80000844:	e022                	sd	s0,0(sp)
    80000846:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80000848:	100007b7          	lui	a5,0x10000
    8000084c:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80000850:	f8000713          	li	a4,-128
    80000854:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80000858:	470d                	li	a4,3
    8000085a:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    8000085e:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80000862:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80000866:	469d                	li	a3,7
    80000868:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    8000086c:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    80000870:	00009597          	auipc	a1,0x9
    80000874:	80858593          	addi	a1,a1,-2040 # 80009078 <digits+0x18>
    80000878:	00011517          	auipc	a0,0x11
    8000087c:	54050513          	addi	a0,a0,1344 # 80011db8 <uart_tx_lock>
    80000880:	00000097          	auipc	ra,0x0
    80000884:	36c080e7          	jalr	876(ra) # 80000bec <initlock>
}
    80000888:	60a2                	ld	ra,8(sp)
    8000088a:	6402                	ld	s0,0(sp)
    8000088c:	0141                	addi	sp,sp,16
    8000088e:	8082                	ret

0000000080000890 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80000890:	1101                	addi	sp,sp,-32
    80000892:	ec06                	sd	ra,24(sp)
    80000894:	e822                	sd	s0,16(sp)
    80000896:	e426                	sd	s1,8(sp)
    80000898:	1000                	addi	s0,sp,32
    8000089a:	84aa                	mv	s1,a0
  push_off();
    8000089c:	00000097          	auipc	ra,0x0
    800008a0:	394080e7          	jalr	916(ra) # 80000c30 <push_off>

  if(panicked){
    800008a4:	00009797          	auipc	a5,0x9
    800008a8:	2cc7a783          	lw	a5,716(a5) # 80009b70 <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800008ac:	10000737          	lui	a4,0x10000
  if(panicked){
    800008b0:	c391                	beqz	a5,800008b4 <uartputc_sync+0x24>
    for(;;)
    800008b2:	a001                	j	800008b2 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800008b4:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800008b8:	0207f793          	andi	a5,a5,32
    800008bc:	dfe5                	beqz	a5,800008b4 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    800008be:	0ff4f513          	andi	a0,s1,255
    800008c2:	100007b7          	lui	a5,0x10000
    800008c6:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    800008ca:	00000097          	auipc	ra,0x0
    800008ce:	406080e7          	jalr	1030(ra) # 80000cd0 <pop_off>
}
    800008d2:	60e2                	ld	ra,24(sp)
    800008d4:	6442                	ld	s0,16(sp)
    800008d6:	64a2                	ld	s1,8(sp)
    800008d8:	6105                	addi	sp,sp,32
    800008da:	8082                	ret

00000000800008dc <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    800008dc:	00009797          	auipc	a5,0x9
    800008e0:	29c7b783          	ld	a5,668(a5) # 80009b78 <uart_tx_r>
    800008e4:	00009717          	auipc	a4,0x9
    800008e8:	29c73703          	ld	a4,668(a4) # 80009b80 <uart_tx_w>
    800008ec:	06f70a63          	beq	a4,a5,80000960 <uartstart+0x84>
{
    800008f0:	7139                	addi	sp,sp,-64
    800008f2:	fc06                	sd	ra,56(sp)
    800008f4:	f822                	sd	s0,48(sp)
    800008f6:	f426                	sd	s1,40(sp)
    800008f8:	f04a                	sd	s2,32(sp)
    800008fa:	ec4e                	sd	s3,24(sp)
    800008fc:	e852                	sd	s4,16(sp)
    800008fe:	e456                	sd	s5,8(sp)
    80000900:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000902:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80000906:	00011a17          	auipc	s4,0x11
    8000090a:	4b2a0a13          	addi	s4,s4,1202 # 80011db8 <uart_tx_lock>
    uart_tx_r += 1;
    8000090e:	00009497          	auipc	s1,0x9
    80000912:	26a48493          	addi	s1,s1,618 # 80009b78 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    80000916:	00009997          	auipc	s3,0x9
    8000091a:	26a98993          	addi	s3,s3,618 # 80009b80 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000091e:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    80000922:	02077713          	andi	a4,a4,32
    80000926:	c705                	beqz	a4,8000094e <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80000928:	01f7f713          	andi	a4,a5,31
    8000092c:	9752                	add	a4,a4,s4
    8000092e:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    80000932:	0785                	addi	a5,a5,1
    80000934:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80000936:	8526                	mv	a0,s1
    80000938:	00002097          	auipc	ra,0x2
    8000093c:	ad6080e7          	jalr	-1322(ra) # 8000240e <wakeup>
    
    WriteReg(THR, c);
    80000940:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    80000944:	609c                	ld	a5,0(s1)
    80000946:	0009b703          	ld	a4,0(s3)
    8000094a:	fcf71ae3          	bne	a4,a5,8000091e <uartstart+0x42>
  }
}
    8000094e:	70e2                	ld	ra,56(sp)
    80000950:	7442                	ld	s0,48(sp)
    80000952:	74a2                	ld	s1,40(sp)
    80000954:	7902                	ld	s2,32(sp)
    80000956:	69e2                	ld	s3,24(sp)
    80000958:	6a42                	ld	s4,16(sp)
    8000095a:	6aa2                	ld	s5,8(sp)
    8000095c:	6121                	addi	sp,sp,64
    8000095e:	8082                	ret
    80000960:	8082                	ret

0000000080000962 <uartputc>:
{
    80000962:	7179                	addi	sp,sp,-48
    80000964:	f406                	sd	ra,40(sp)
    80000966:	f022                	sd	s0,32(sp)
    80000968:	ec26                	sd	s1,24(sp)
    8000096a:	e84a                	sd	s2,16(sp)
    8000096c:	e44e                	sd	s3,8(sp)
    8000096e:	e052                	sd	s4,0(sp)
    80000970:	1800                	addi	s0,sp,48
    80000972:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    80000974:	00011517          	auipc	a0,0x11
    80000978:	44450513          	addi	a0,a0,1092 # 80011db8 <uart_tx_lock>
    8000097c:	00000097          	auipc	ra,0x0
    80000980:	300080e7          	jalr	768(ra) # 80000c7c <acquire>
  if(panicked){
    80000984:	00009797          	auipc	a5,0x9
    80000988:	1ec7a783          	lw	a5,492(a5) # 80009b70 <panicked>
    8000098c:	e7c9                	bnez	a5,80000a16 <uartputc+0xb4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000098e:	00009717          	auipc	a4,0x9
    80000992:	1f273703          	ld	a4,498(a4) # 80009b80 <uart_tx_w>
    80000996:	00009797          	auipc	a5,0x9
    8000099a:	1e27b783          	ld	a5,482(a5) # 80009b78 <uart_tx_r>
    8000099e:	02078793          	addi	a5,a5,32
    sleep(&uart_tx_r, &uart_tx_lock);
    800009a2:	00011997          	auipc	s3,0x11
    800009a6:	41698993          	addi	s3,s3,1046 # 80011db8 <uart_tx_lock>
    800009aa:	00009497          	auipc	s1,0x9
    800009ae:	1ce48493          	addi	s1,s1,462 # 80009b78 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800009b2:	00009917          	auipc	s2,0x9
    800009b6:	1ce90913          	addi	s2,s2,462 # 80009b80 <uart_tx_w>
    800009ba:	00e79f63          	bne	a5,a4,800009d8 <uartputc+0x76>
    sleep(&uart_tx_r, &uart_tx_lock);
    800009be:	85ce                	mv	a1,s3
    800009c0:	8526                	mv	a0,s1
    800009c2:	00002097          	auipc	ra,0x2
    800009c6:	9e8080e7          	jalr	-1560(ra) # 800023aa <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800009ca:	00093703          	ld	a4,0(s2)
    800009ce:	609c                	ld	a5,0(s1)
    800009d0:	02078793          	addi	a5,a5,32
    800009d4:	fee785e3          	beq	a5,a4,800009be <uartputc+0x5c>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    800009d8:	00011497          	auipc	s1,0x11
    800009dc:	3e048493          	addi	s1,s1,992 # 80011db8 <uart_tx_lock>
    800009e0:	01f77793          	andi	a5,a4,31
    800009e4:	97a6                	add	a5,a5,s1
    800009e6:	01478c23          	sb	s4,24(a5)
  uart_tx_w += 1;
    800009ea:	0705                	addi	a4,a4,1
    800009ec:	00009797          	auipc	a5,0x9
    800009f0:	18e7ba23          	sd	a4,404(a5) # 80009b80 <uart_tx_w>
  uartstart();
    800009f4:	00000097          	auipc	ra,0x0
    800009f8:	ee8080e7          	jalr	-280(ra) # 800008dc <uartstart>
  release(&uart_tx_lock);
    800009fc:	8526                	mv	a0,s1
    800009fe:	00000097          	auipc	ra,0x0
    80000a02:	332080e7          	jalr	818(ra) # 80000d30 <release>
}
    80000a06:	70a2                	ld	ra,40(sp)
    80000a08:	7402                	ld	s0,32(sp)
    80000a0a:	64e2                	ld	s1,24(sp)
    80000a0c:	6942                	ld	s2,16(sp)
    80000a0e:	69a2                	ld	s3,8(sp)
    80000a10:	6a02                	ld	s4,0(sp)
    80000a12:	6145                	addi	sp,sp,48
    80000a14:	8082                	ret
    for(;;)
    80000a16:	a001                	j	80000a16 <uartputc+0xb4>

0000000080000a18 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80000a18:	1141                	addi	sp,sp,-16
    80000a1a:	e422                	sd	s0,8(sp)
    80000a1c:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000a1e:	100007b7          	lui	a5,0x10000
    80000a22:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80000a26:	8b85                	andi	a5,a5,1
    80000a28:	cb91                	beqz	a5,80000a3c <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80000a2a:	100007b7          	lui	a5,0x10000
    80000a2e:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    80000a32:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    80000a36:	6422                	ld	s0,8(sp)
    80000a38:	0141                	addi	sp,sp,16
    80000a3a:	8082                	ret
    return -1;
    80000a3c:	557d                	li	a0,-1
    80000a3e:	bfe5                	j	80000a36 <uartgetc+0x1e>

0000000080000a40 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    80000a40:	1101                	addi	sp,sp,-32
    80000a42:	ec06                	sd	ra,24(sp)
    80000a44:	e822                	sd	s0,16(sp)
    80000a46:	e426                	sd	s1,8(sp)
    80000a48:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80000a4a:	54fd                	li	s1,-1
    80000a4c:	a029                	j	80000a56 <uartintr+0x16>
      break;
    consoleintr(c);
    80000a4e:	00000097          	auipc	ra,0x0
    80000a52:	86e080e7          	jalr	-1938(ra) # 800002bc <consoleintr>
    int c = uartgetc();
    80000a56:	00000097          	auipc	ra,0x0
    80000a5a:	fc2080e7          	jalr	-62(ra) # 80000a18 <uartgetc>
    if(c == -1)
    80000a5e:	fe9518e3          	bne	a0,s1,80000a4e <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80000a62:	00011497          	auipc	s1,0x11
    80000a66:	35648493          	addi	s1,s1,854 # 80011db8 <uart_tx_lock>
    80000a6a:	8526                	mv	a0,s1
    80000a6c:	00000097          	auipc	ra,0x0
    80000a70:	210080e7          	jalr	528(ra) # 80000c7c <acquire>
  uartstart();
    80000a74:	00000097          	auipc	ra,0x0
    80000a78:	e68080e7          	jalr	-408(ra) # 800008dc <uartstart>
  release(&uart_tx_lock);
    80000a7c:	8526                	mv	a0,s1
    80000a7e:	00000097          	auipc	ra,0x0
    80000a82:	2b2080e7          	jalr	690(ra) # 80000d30 <release>
}
    80000a86:	60e2                	ld	ra,24(sp)
    80000a88:	6442                	ld	s0,16(sp)
    80000a8a:	64a2                	ld	s1,8(sp)
    80000a8c:	6105                	addi	sp,sp,32
    80000a8e:	8082                	ret

0000000080000a90 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80000a90:	1101                	addi	sp,sp,-32
    80000a92:	ec06                	sd	ra,24(sp)
    80000a94:	e822                	sd	s0,16(sp)
    80000a96:	e426                	sd	s1,8(sp)
    80000a98:	e04a                	sd	s2,0(sp)
    80000a9a:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000a9c:	03451793          	slli	a5,a0,0x34
    80000aa0:	ebb9                	bnez	a5,80000af6 <kfree+0x66>
    80000aa2:	84aa                	mv	s1,a0
    80000aa4:	00023797          	auipc	a5,0x23
    80000aa8:	77c78793          	addi	a5,a5,1916 # 80024220 <end>
    80000aac:	04f56563          	bltu	a0,a5,80000af6 <kfree+0x66>
    80000ab0:	47c5                	li	a5,17
    80000ab2:	07ee                	slli	a5,a5,0x1b
    80000ab4:	04f57163          	bgeu	a0,a5,80000af6 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000ab8:	6605                	lui	a2,0x1
    80000aba:	4585                	li	a1,1
    80000abc:	00000097          	auipc	ra,0x0
    80000ac0:	2bc080e7          	jalr	700(ra) # 80000d78 <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000ac4:	00011917          	auipc	s2,0x11
    80000ac8:	32c90913          	addi	s2,s2,812 # 80011df0 <kmem>
    80000acc:	854a                	mv	a0,s2
    80000ace:	00000097          	auipc	ra,0x0
    80000ad2:	1ae080e7          	jalr	430(ra) # 80000c7c <acquire>
  r->next = kmem.freelist;
    80000ad6:	01893783          	ld	a5,24(s2)
    80000ada:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000adc:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000ae0:	854a                	mv	a0,s2
    80000ae2:	00000097          	auipc	ra,0x0
    80000ae6:	24e080e7          	jalr	590(ra) # 80000d30 <release>
}
    80000aea:	60e2                	ld	ra,24(sp)
    80000aec:	6442                	ld	s0,16(sp)
    80000aee:	64a2                	ld	s1,8(sp)
    80000af0:	6902                	ld	s2,0(sp)
    80000af2:	6105                	addi	sp,sp,32
    80000af4:	8082                	ret
    panic("kfree");
    80000af6:	00008517          	auipc	a0,0x8
    80000afa:	58a50513          	addi	a0,a0,1418 # 80009080 <digits+0x20>
    80000afe:	00000097          	auipc	ra,0x0
    80000b02:	a3e080e7          	jalr	-1474(ra) # 8000053c <panic>

0000000080000b06 <freerange>:
{
    80000b06:	7179                	addi	sp,sp,-48
    80000b08:	f406                	sd	ra,40(sp)
    80000b0a:	f022                	sd	s0,32(sp)
    80000b0c:	ec26                	sd	s1,24(sp)
    80000b0e:	e84a                	sd	s2,16(sp)
    80000b10:	e44e                	sd	s3,8(sp)
    80000b12:	e052                	sd	s4,0(sp)
    80000b14:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    80000b16:	6785                	lui	a5,0x1
    80000b18:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80000b1c:	94aa                	add	s1,s1,a0
    80000b1e:	757d                	lui	a0,0xfffff
    80000b20:	8ce9                	and	s1,s1,a0
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000b22:	94be                	add	s1,s1,a5
    80000b24:	0095ee63          	bltu	a1,s1,80000b40 <freerange+0x3a>
    80000b28:	892e                	mv	s2,a1
    kfree(p);
    80000b2a:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000b2c:	6985                	lui	s3,0x1
    kfree(p);
    80000b2e:	01448533          	add	a0,s1,s4
    80000b32:	00000097          	auipc	ra,0x0
    80000b36:	f5e080e7          	jalr	-162(ra) # 80000a90 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000b3a:	94ce                	add	s1,s1,s3
    80000b3c:	fe9979e3          	bgeu	s2,s1,80000b2e <freerange+0x28>
}
    80000b40:	70a2                	ld	ra,40(sp)
    80000b42:	7402                	ld	s0,32(sp)
    80000b44:	64e2                	ld	s1,24(sp)
    80000b46:	6942                	ld	s2,16(sp)
    80000b48:	69a2                	ld	s3,8(sp)
    80000b4a:	6a02                	ld	s4,0(sp)
    80000b4c:	6145                	addi	sp,sp,48
    80000b4e:	8082                	ret

0000000080000b50 <kinit>:
{
    80000b50:	1141                	addi	sp,sp,-16
    80000b52:	e406                	sd	ra,8(sp)
    80000b54:	e022                	sd	s0,0(sp)
    80000b56:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000b58:	00008597          	auipc	a1,0x8
    80000b5c:	53058593          	addi	a1,a1,1328 # 80009088 <digits+0x28>
    80000b60:	00011517          	auipc	a0,0x11
    80000b64:	29050513          	addi	a0,a0,656 # 80011df0 <kmem>
    80000b68:	00000097          	auipc	ra,0x0
    80000b6c:	084080e7          	jalr	132(ra) # 80000bec <initlock>
  freerange(end, (void*)PHYSTOP);
    80000b70:	45c5                	li	a1,17
    80000b72:	05ee                	slli	a1,a1,0x1b
    80000b74:	00023517          	auipc	a0,0x23
    80000b78:	6ac50513          	addi	a0,a0,1708 # 80024220 <end>
    80000b7c:	00000097          	auipc	ra,0x0
    80000b80:	f8a080e7          	jalr	-118(ra) # 80000b06 <freerange>
}
    80000b84:	60a2                	ld	ra,8(sp)
    80000b86:	6402                	ld	s0,0(sp)
    80000b88:	0141                	addi	sp,sp,16
    80000b8a:	8082                	ret

0000000080000b8c <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000b8c:	1101                	addi	sp,sp,-32
    80000b8e:	ec06                	sd	ra,24(sp)
    80000b90:	e822                	sd	s0,16(sp)
    80000b92:	e426                	sd	s1,8(sp)
    80000b94:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000b96:	00011497          	auipc	s1,0x11
    80000b9a:	25a48493          	addi	s1,s1,602 # 80011df0 <kmem>
    80000b9e:	8526                	mv	a0,s1
    80000ba0:	00000097          	auipc	ra,0x0
    80000ba4:	0dc080e7          	jalr	220(ra) # 80000c7c <acquire>
  r = kmem.freelist;
    80000ba8:	6c84                	ld	s1,24(s1)
  if(r)
    80000baa:	c885                	beqz	s1,80000bda <kalloc+0x4e>
    kmem.freelist = r->next;
    80000bac:	609c                	ld	a5,0(s1)
    80000bae:	00011517          	auipc	a0,0x11
    80000bb2:	24250513          	addi	a0,a0,578 # 80011df0 <kmem>
    80000bb6:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000bb8:	00000097          	auipc	ra,0x0
    80000bbc:	178080e7          	jalr	376(ra) # 80000d30 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    80000bc0:	6605                	lui	a2,0x1
    80000bc2:	4595                	li	a1,5
    80000bc4:	8526                	mv	a0,s1
    80000bc6:	00000097          	auipc	ra,0x0
    80000bca:	1b2080e7          	jalr	434(ra) # 80000d78 <memset>
  return (void*)r;
}
    80000bce:	8526                	mv	a0,s1
    80000bd0:	60e2                	ld	ra,24(sp)
    80000bd2:	6442                	ld	s0,16(sp)
    80000bd4:	64a2                	ld	s1,8(sp)
    80000bd6:	6105                	addi	sp,sp,32
    80000bd8:	8082                	ret
  release(&kmem.lock);
    80000bda:	00011517          	auipc	a0,0x11
    80000bde:	21650513          	addi	a0,a0,534 # 80011df0 <kmem>
    80000be2:	00000097          	auipc	ra,0x0
    80000be6:	14e080e7          	jalr	334(ra) # 80000d30 <release>
  if(r)
    80000bea:	b7d5                	j	80000bce <kalloc+0x42>

0000000080000bec <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80000bec:	1141                	addi	sp,sp,-16
    80000bee:	e422                	sd	s0,8(sp)
    80000bf0:	0800                	addi	s0,sp,16
  lk->name = name;
    80000bf2:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80000bf4:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80000bf8:	00053823          	sd	zero,16(a0)
}
    80000bfc:	6422                	ld	s0,8(sp)
    80000bfe:	0141                	addi	sp,sp,16
    80000c00:	8082                	ret

0000000080000c02 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80000c02:	411c                	lw	a5,0(a0)
    80000c04:	e399                	bnez	a5,80000c0a <holding+0x8>
    80000c06:	4501                	li	a0,0
  return r;
}
    80000c08:	8082                	ret
{
    80000c0a:	1101                	addi	sp,sp,-32
    80000c0c:	ec06                	sd	ra,24(sp)
    80000c0e:	e822                	sd	s0,16(sp)
    80000c10:	e426                	sd	s1,8(sp)
    80000c12:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80000c14:	6904                	ld	s1,16(a0)
    80000c16:	00001097          	auipc	ra,0x1
    80000c1a:	f20080e7          	jalr	-224(ra) # 80001b36 <mycpu>
    80000c1e:	40a48533          	sub	a0,s1,a0
    80000c22:	00153513          	seqz	a0,a0
}
    80000c26:	60e2                	ld	ra,24(sp)
    80000c28:	6442                	ld	s0,16(sp)
    80000c2a:	64a2                	ld	s1,8(sp)
    80000c2c:	6105                	addi	sp,sp,32
    80000c2e:	8082                	ret

0000000080000c30 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80000c30:	1101                	addi	sp,sp,-32
    80000c32:	ec06                	sd	ra,24(sp)
    80000c34:	e822                	sd	s0,16(sp)
    80000c36:	e426                	sd	s1,8(sp)
    80000c38:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c3a:	100024f3          	csrr	s1,sstatus
    80000c3e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80000c42:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000c44:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80000c48:	00001097          	auipc	ra,0x1
    80000c4c:	eee080e7          	jalr	-274(ra) # 80001b36 <mycpu>
    80000c50:	5d3c                	lw	a5,120(a0)
    80000c52:	cf89                	beqz	a5,80000c6c <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80000c54:	00001097          	auipc	ra,0x1
    80000c58:	ee2080e7          	jalr	-286(ra) # 80001b36 <mycpu>
    80000c5c:	5d3c                	lw	a5,120(a0)
    80000c5e:	2785                	addiw	a5,a5,1
    80000c60:	dd3c                	sw	a5,120(a0)
}
    80000c62:	60e2                	ld	ra,24(sp)
    80000c64:	6442                	ld	s0,16(sp)
    80000c66:	64a2                	ld	s1,8(sp)
    80000c68:	6105                	addi	sp,sp,32
    80000c6a:	8082                	ret
    mycpu()->intena = old;
    80000c6c:	00001097          	auipc	ra,0x1
    80000c70:	eca080e7          	jalr	-310(ra) # 80001b36 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80000c74:	8085                	srli	s1,s1,0x1
    80000c76:	8885                	andi	s1,s1,1
    80000c78:	dd64                	sw	s1,124(a0)
    80000c7a:	bfe9                	j	80000c54 <push_off+0x24>

0000000080000c7c <acquire>:
{
    80000c7c:	1101                	addi	sp,sp,-32
    80000c7e:	ec06                	sd	ra,24(sp)
    80000c80:	e822                	sd	s0,16(sp)
    80000c82:	e426                	sd	s1,8(sp)
    80000c84:	1000                	addi	s0,sp,32
    80000c86:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80000c88:	00000097          	auipc	ra,0x0
    80000c8c:	fa8080e7          	jalr	-88(ra) # 80000c30 <push_off>
  if(holding(lk))
    80000c90:	8526                	mv	a0,s1
    80000c92:	00000097          	auipc	ra,0x0
    80000c96:	f70080e7          	jalr	-144(ra) # 80000c02 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000c9a:	4705                	li	a4,1
  if(holding(lk))
    80000c9c:	e115                	bnez	a0,80000cc0 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000c9e:	87ba                	mv	a5,a4
    80000ca0:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000ca4:	2781                	sext.w	a5,a5
    80000ca6:	ffe5                	bnez	a5,80000c9e <acquire+0x22>
  __sync_synchronize();
    80000ca8:	0ff0000f          	fence
  lk->cpu = mycpu();
    80000cac:	00001097          	auipc	ra,0x1
    80000cb0:	e8a080e7          	jalr	-374(ra) # 80001b36 <mycpu>
    80000cb4:	e888                	sd	a0,16(s1)
}
    80000cb6:	60e2                	ld	ra,24(sp)
    80000cb8:	6442                	ld	s0,16(sp)
    80000cba:	64a2                	ld	s1,8(sp)
    80000cbc:	6105                	addi	sp,sp,32
    80000cbe:	8082                	ret
    panic("acquire");
    80000cc0:	00008517          	auipc	a0,0x8
    80000cc4:	3d050513          	addi	a0,a0,976 # 80009090 <digits+0x30>
    80000cc8:	00000097          	auipc	ra,0x0
    80000ccc:	874080e7          	jalr	-1932(ra) # 8000053c <panic>

0000000080000cd0 <pop_off>:

void
pop_off(void)
{
    80000cd0:	1141                	addi	sp,sp,-16
    80000cd2:	e406                	sd	ra,8(sp)
    80000cd4:	e022                	sd	s0,0(sp)
    80000cd6:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80000cd8:	00001097          	auipc	ra,0x1
    80000cdc:	e5e080e7          	jalr	-418(ra) # 80001b36 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000ce0:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000ce4:	8b89                	andi	a5,a5,2
  if(intr_get())
    80000ce6:	e78d                	bnez	a5,80000d10 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80000ce8:	5d3c                	lw	a5,120(a0)
    80000cea:	02f05b63          	blez	a5,80000d20 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80000cee:	37fd                	addiw	a5,a5,-1
    80000cf0:	0007871b          	sext.w	a4,a5
    80000cf4:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80000cf6:	eb09                	bnez	a4,80000d08 <pop_off+0x38>
    80000cf8:	5d7c                	lw	a5,124(a0)
    80000cfa:	c799                	beqz	a5,80000d08 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000cfc:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80000d00:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000d04:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80000d08:	60a2                	ld	ra,8(sp)
    80000d0a:	6402                	ld	s0,0(sp)
    80000d0c:	0141                	addi	sp,sp,16
    80000d0e:	8082                	ret
    panic("pop_off - interruptible");
    80000d10:	00008517          	auipc	a0,0x8
    80000d14:	38850513          	addi	a0,a0,904 # 80009098 <digits+0x38>
    80000d18:	00000097          	auipc	ra,0x0
    80000d1c:	824080e7          	jalr	-2012(ra) # 8000053c <panic>
    panic("pop_off");
    80000d20:	00008517          	auipc	a0,0x8
    80000d24:	39050513          	addi	a0,a0,912 # 800090b0 <digits+0x50>
    80000d28:	00000097          	auipc	ra,0x0
    80000d2c:	814080e7          	jalr	-2028(ra) # 8000053c <panic>

0000000080000d30 <release>:
{
    80000d30:	1101                	addi	sp,sp,-32
    80000d32:	ec06                	sd	ra,24(sp)
    80000d34:	e822                	sd	s0,16(sp)
    80000d36:	e426                	sd	s1,8(sp)
    80000d38:	1000                	addi	s0,sp,32
    80000d3a:	84aa                	mv	s1,a0
  if(!holding(lk))
    80000d3c:	00000097          	auipc	ra,0x0
    80000d40:	ec6080e7          	jalr	-314(ra) # 80000c02 <holding>
    80000d44:	c115                	beqz	a0,80000d68 <release+0x38>
  lk->cpu = 0;
    80000d46:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80000d4a:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80000d4e:	0f50000f          	fence	iorw,ow
    80000d52:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80000d56:	00000097          	auipc	ra,0x0
    80000d5a:	f7a080e7          	jalr	-134(ra) # 80000cd0 <pop_off>
}
    80000d5e:	60e2                	ld	ra,24(sp)
    80000d60:	6442                	ld	s0,16(sp)
    80000d62:	64a2                	ld	s1,8(sp)
    80000d64:	6105                	addi	sp,sp,32
    80000d66:	8082                	ret
    panic("release");
    80000d68:	00008517          	auipc	a0,0x8
    80000d6c:	35050513          	addi	a0,a0,848 # 800090b8 <digits+0x58>
    80000d70:	fffff097          	auipc	ra,0xfffff
    80000d74:	7cc080e7          	jalr	1996(ra) # 8000053c <panic>

0000000080000d78 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000d78:	1141                	addi	sp,sp,-16
    80000d7a:	e422                	sd	s0,8(sp)
    80000d7c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000d7e:	ca19                	beqz	a2,80000d94 <memset+0x1c>
    80000d80:	87aa                	mv	a5,a0
    80000d82:	1602                	slli	a2,a2,0x20
    80000d84:	9201                	srli	a2,a2,0x20
    80000d86:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000d8a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000d8e:	0785                	addi	a5,a5,1
    80000d90:	fee79de3          	bne	a5,a4,80000d8a <memset+0x12>
  }
  return dst;
}
    80000d94:	6422                	ld	s0,8(sp)
    80000d96:	0141                	addi	sp,sp,16
    80000d98:	8082                	ret

0000000080000d9a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000d9a:	1141                	addi	sp,sp,-16
    80000d9c:	e422                	sd	s0,8(sp)
    80000d9e:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80000da0:	ca05                	beqz	a2,80000dd0 <memcmp+0x36>
    80000da2:	fff6069b          	addiw	a3,a2,-1
    80000da6:	1682                	slli	a3,a3,0x20
    80000da8:	9281                	srli	a3,a3,0x20
    80000daa:	0685                	addi	a3,a3,1
    80000dac:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    80000dae:	00054783          	lbu	a5,0(a0)
    80000db2:	0005c703          	lbu	a4,0(a1)
    80000db6:	00e79863          	bne	a5,a4,80000dc6 <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    80000dba:	0505                	addi	a0,a0,1
    80000dbc:	0585                	addi	a1,a1,1
  while(n-- > 0){
    80000dbe:	fed518e3          	bne	a0,a3,80000dae <memcmp+0x14>
  }

  return 0;
    80000dc2:	4501                	li	a0,0
    80000dc4:	a019                	j	80000dca <memcmp+0x30>
      return *s1 - *s2;
    80000dc6:	40e7853b          	subw	a0,a5,a4
}
    80000dca:	6422                	ld	s0,8(sp)
    80000dcc:	0141                	addi	sp,sp,16
    80000dce:	8082                	ret
  return 0;
    80000dd0:	4501                	li	a0,0
    80000dd2:	bfe5                	j	80000dca <memcmp+0x30>

0000000080000dd4 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80000dd4:	1141                	addi	sp,sp,-16
    80000dd6:	e422                	sd	s0,8(sp)
    80000dd8:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    80000dda:	c205                	beqz	a2,80000dfa <memmove+0x26>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    80000ddc:	02a5e263          	bltu	a1,a0,80000e00 <memmove+0x2c>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    80000de0:	1602                	slli	a2,a2,0x20
    80000de2:	9201                	srli	a2,a2,0x20
    80000de4:	00c587b3          	add	a5,a1,a2
{
    80000de8:	872a                	mv	a4,a0
      *d++ = *s++;
    80000dea:	0585                	addi	a1,a1,1
    80000dec:	0705                	addi	a4,a4,1
    80000dee:	fff5c683          	lbu	a3,-1(a1)
    80000df2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    80000df6:	fef59ae3          	bne	a1,a5,80000dea <memmove+0x16>

  return dst;
}
    80000dfa:	6422                	ld	s0,8(sp)
    80000dfc:	0141                	addi	sp,sp,16
    80000dfe:	8082                	ret
  if(s < d && s + n > d){
    80000e00:	02061693          	slli	a3,a2,0x20
    80000e04:	9281                	srli	a3,a3,0x20
    80000e06:	00d58733          	add	a4,a1,a3
    80000e0a:	fce57be3          	bgeu	a0,a4,80000de0 <memmove+0xc>
    d += n;
    80000e0e:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000e10:	fff6079b          	addiw	a5,a2,-1
    80000e14:	1782                	slli	a5,a5,0x20
    80000e16:	9381                	srli	a5,a5,0x20
    80000e18:	fff7c793          	not	a5,a5
    80000e1c:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000e1e:	177d                	addi	a4,a4,-1
    80000e20:	16fd                	addi	a3,a3,-1
    80000e22:	00074603          	lbu	a2,0(a4)
    80000e26:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000e2a:	fee79ae3          	bne	a5,a4,80000e1e <memmove+0x4a>
    80000e2e:	b7f1                	j	80000dfa <memmove+0x26>

0000000080000e30 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000e30:	1141                	addi	sp,sp,-16
    80000e32:	e406                	sd	ra,8(sp)
    80000e34:	e022                	sd	s0,0(sp)
    80000e36:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000e38:	00000097          	auipc	ra,0x0
    80000e3c:	f9c080e7          	jalr	-100(ra) # 80000dd4 <memmove>
}
    80000e40:	60a2                	ld	ra,8(sp)
    80000e42:	6402                	ld	s0,0(sp)
    80000e44:	0141                	addi	sp,sp,16
    80000e46:	8082                	ret

0000000080000e48 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000e48:	1141                	addi	sp,sp,-16
    80000e4a:	e422                	sd	s0,8(sp)
    80000e4c:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000e4e:	ce11                	beqz	a2,80000e6a <strncmp+0x22>
    80000e50:	00054783          	lbu	a5,0(a0)
    80000e54:	cf89                	beqz	a5,80000e6e <strncmp+0x26>
    80000e56:	0005c703          	lbu	a4,0(a1)
    80000e5a:	00f71a63          	bne	a4,a5,80000e6e <strncmp+0x26>
    n--, p++, q++;
    80000e5e:	367d                	addiw	a2,a2,-1
    80000e60:	0505                	addi	a0,a0,1
    80000e62:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000e64:	f675                	bnez	a2,80000e50 <strncmp+0x8>
  if(n == 0)
    return 0;
    80000e66:	4501                	li	a0,0
    80000e68:	a809                	j	80000e7a <strncmp+0x32>
    80000e6a:	4501                	li	a0,0
    80000e6c:	a039                	j	80000e7a <strncmp+0x32>
  if(n == 0)
    80000e6e:	ca09                	beqz	a2,80000e80 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000e70:	00054503          	lbu	a0,0(a0)
    80000e74:	0005c783          	lbu	a5,0(a1)
    80000e78:	9d1d                	subw	a0,a0,a5
}
    80000e7a:	6422                	ld	s0,8(sp)
    80000e7c:	0141                	addi	sp,sp,16
    80000e7e:	8082                	ret
    return 0;
    80000e80:	4501                	li	a0,0
    80000e82:	bfe5                	j	80000e7a <strncmp+0x32>

0000000080000e84 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000e84:	1141                	addi	sp,sp,-16
    80000e86:	e422                	sd	s0,8(sp)
    80000e88:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000e8a:	872a                	mv	a4,a0
    80000e8c:	8832                	mv	a6,a2
    80000e8e:	367d                	addiw	a2,a2,-1
    80000e90:	01005963          	blez	a6,80000ea2 <strncpy+0x1e>
    80000e94:	0705                	addi	a4,a4,1
    80000e96:	0005c783          	lbu	a5,0(a1)
    80000e9a:	fef70fa3          	sb	a5,-1(a4)
    80000e9e:	0585                	addi	a1,a1,1
    80000ea0:	f7f5                	bnez	a5,80000e8c <strncpy+0x8>
    ;
  while(n-- > 0)
    80000ea2:	86ba                	mv	a3,a4
    80000ea4:	00c05c63          	blez	a2,80000ebc <strncpy+0x38>
    *s++ = 0;
    80000ea8:	0685                	addi	a3,a3,1
    80000eaa:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    80000eae:	fff6c793          	not	a5,a3
    80000eb2:	9fb9                	addw	a5,a5,a4
    80000eb4:	010787bb          	addw	a5,a5,a6
    80000eb8:	fef048e3          	bgtz	a5,80000ea8 <strncpy+0x24>
  return os;
}
    80000ebc:	6422                	ld	s0,8(sp)
    80000ebe:	0141                	addi	sp,sp,16
    80000ec0:	8082                	ret

0000000080000ec2 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80000ec2:	1141                	addi	sp,sp,-16
    80000ec4:	e422                	sd	s0,8(sp)
    80000ec6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000ec8:	02c05363          	blez	a2,80000eee <safestrcpy+0x2c>
    80000ecc:	fff6069b          	addiw	a3,a2,-1
    80000ed0:	1682                	slli	a3,a3,0x20
    80000ed2:	9281                	srli	a3,a3,0x20
    80000ed4:	96ae                	add	a3,a3,a1
    80000ed6:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    80000ed8:	00d58963          	beq	a1,a3,80000eea <safestrcpy+0x28>
    80000edc:	0585                	addi	a1,a1,1
    80000ede:	0785                	addi	a5,a5,1
    80000ee0:	fff5c703          	lbu	a4,-1(a1)
    80000ee4:	fee78fa3          	sb	a4,-1(a5)
    80000ee8:	fb65                	bnez	a4,80000ed8 <safestrcpy+0x16>
    ;
  *s = 0;
    80000eea:	00078023          	sb	zero,0(a5)
  return os;
}
    80000eee:	6422                	ld	s0,8(sp)
    80000ef0:	0141                	addi	sp,sp,16
    80000ef2:	8082                	ret

0000000080000ef4 <strlen>:

int
strlen(const char *s)
{
    80000ef4:	1141                	addi	sp,sp,-16
    80000ef6:	e422                	sd	s0,8(sp)
    80000ef8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000efa:	00054783          	lbu	a5,0(a0)
    80000efe:	cf91                	beqz	a5,80000f1a <strlen+0x26>
    80000f00:	0505                	addi	a0,a0,1
    80000f02:	87aa                	mv	a5,a0
    80000f04:	4685                	li	a3,1
    80000f06:	9e89                	subw	a3,a3,a0
    80000f08:	00f6853b          	addw	a0,a3,a5
    80000f0c:	0785                	addi	a5,a5,1
    80000f0e:	fff7c703          	lbu	a4,-1(a5)
    80000f12:	fb7d                	bnez	a4,80000f08 <strlen+0x14>
    ;
  return n;
}
    80000f14:	6422                	ld	s0,8(sp)
    80000f16:	0141                	addi	sp,sp,16
    80000f18:	8082                	ret
  for(n = 0; s[n]; n++)
    80000f1a:	4501                	li	a0,0
    80000f1c:	bfe5                	j	80000f14 <strlen+0x20>

0000000080000f1e <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000f1e:	1141                	addi	sp,sp,-16
    80000f20:	e406                	sd	ra,8(sp)
    80000f22:	e022                	sd	s0,0(sp)
    80000f24:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80000f26:	00001097          	auipc	ra,0x1
    80000f2a:	c00080e7          	jalr	-1024(ra) # 80001b26 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000f2e:	00009717          	auipc	a4,0x9
    80000f32:	c5a70713          	addi	a4,a4,-934 # 80009b88 <started>
  if(cpuid() == 0){
    80000f36:	c139                	beqz	a0,80000f7c <main+0x5e>
    while(started == 0)
    80000f38:	431c                	lw	a5,0(a4)
    80000f3a:	2781                	sext.w	a5,a5
    80000f3c:	dff5                	beqz	a5,80000f38 <main+0x1a>
      ;
    __sync_synchronize();
    80000f3e:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000f42:	00001097          	auipc	ra,0x1
    80000f46:	be4080e7          	jalr	-1052(ra) # 80001b26 <cpuid>
    80000f4a:	85aa                	mv	a1,a0
    80000f4c:	00008517          	auipc	a0,0x8
    80000f50:	18c50513          	addi	a0,a0,396 # 800090d8 <digits+0x78>
    80000f54:	fffff097          	auipc	ra,0xfffff
    80000f58:	632080e7          	jalr	1586(ra) # 80000586 <printf>
    kvminithart();    // turn on paging
    80000f5c:	00000097          	auipc	ra,0x0
    80000f60:	0d8080e7          	jalr	216(ra) # 80001034 <kvminithart>
    trapinithart();   // install kernel trap vector
    80000f64:	00002097          	auipc	ra,0x2
    80000f68:	2c0080e7          	jalr	704(ra) # 80003224 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000f6c:	00006097          	auipc	ra,0x6
    80000f70:	b24080e7          	jalr	-1244(ra) # 80006a90 <plicinithart>
  }

  scheduler();        
    80000f74:	00001097          	auipc	ra,0x1
    80000f78:	11c080e7          	jalr	284(ra) # 80002090 <scheduler>
    consoleinit();
    80000f7c:	fffff097          	auipc	ra,0xfffff
    80000f80:	4d2080e7          	jalr	1234(ra) # 8000044e <consoleinit>
    printfinit();
    80000f84:	fffff097          	auipc	ra,0xfffff
    80000f88:	7e2080e7          	jalr	2018(ra) # 80000766 <printfinit>
    printf("\n");
    80000f8c:	00008517          	auipc	a0,0x8
    80000f90:	41450513          	addi	a0,a0,1044 # 800093a0 <digits+0x340>
    80000f94:	fffff097          	auipc	ra,0xfffff
    80000f98:	5f2080e7          	jalr	1522(ra) # 80000586 <printf>
    printf("xv6 kernel is booting\n");
    80000f9c:	00008517          	auipc	a0,0x8
    80000fa0:	12450513          	addi	a0,a0,292 # 800090c0 <digits+0x60>
    80000fa4:	fffff097          	auipc	ra,0xfffff
    80000fa8:	5e2080e7          	jalr	1506(ra) # 80000586 <printf>
    printf("\n");
    80000fac:	00008517          	auipc	a0,0x8
    80000fb0:	3f450513          	addi	a0,a0,1012 # 800093a0 <digits+0x340>
    80000fb4:	fffff097          	auipc	ra,0xfffff
    80000fb8:	5d2080e7          	jalr	1490(ra) # 80000586 <printf>
    kinit();         // physical page allocator
    80000fbc:	00000097          	auipc	ra,0x0
    80000fc0:	b94080e7          	jalr	-1132(ra) # 80000b50 <kinit>
    kvminit();       // create kernel page table
    80000fc4:	00000097          	auipc	ra,0x0
    80000fc8:	326080e7          	jalr	806(ra) # 800012ea <kvminit>
    kvminithart();   // turn on paging
    80000fcc:	00000097          	auipc	ra,0x0
    80000fd0:	068080e7          	jalr	104(ra) # 80001034 <kvminithart>
    procinit();      // process table
    80000fd4:	00001097          	auipc	ra,0x1
    80000fd8:	a9e080e7          	jalr	-1378(ra) # 80001a72 <procinit>
    trapinit();      // trap vectors
    80000fdc:	00002097          	auipc	ra,0x2
    80000fe0:	220080e7          	jalr	544(ra) # 800031fc <trapinit>
    trapinithart();  // install kernel trap vector
    80000fe4:	00002097          	auipc	ra,0x2
    80000fe8:	240080e7          	jalr	576(ra) # 80003224 <trapinithart>
    plicinit();      // set up interrupt controller
    80000fec:	00006097          	auipc	ra,0x6
    80000ff0:	a8e080e7          	jalr	-1394(ra) # 80006a7a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000ff4:	00006097          	auipc	ra,0x6
    80000ff8:	a9c080e7          	jalr	-1380(ra) # 80006a90 <plicinithart>
    binit();         // buffer cache
    80000ffc:	00003097          	auipc	ra,0x3
    80001000:	c5e080e7          	jalr	-930(ra) # 80003c5a <binit>
    iinit();         // inode table
    80001004:	00003097          	auipc	ra,0x3
    80001008:	302080e7          	jalr	770(ra) # 80004306 <iinit>
    fileinit();      // file table
    8000100c:	00004097          	auipc	ra,0x4
    80001010:	2a0080e7          	jalr	672(ra) # 800052ac <fileinit>
    virtio_disk_init(); // emulated hard disk
    80001014:	00006097          	auipc	ra,0x6
    80001018:	b84080e7          	jalr	-1148(ra) # 80006b98 <virtio_disk_init>
    userinit();      // first user process
    8000101c:	00001097          	auipc	ra,0x1
    80001020:	e38080e7          	jalr	-456(ra) # 80001e54 <userinit>
    __sync_synchronize();
    80001024:	0ff0000f          	fence
    started = 1;
    80001028:	4785                	li	a5,1
    8000102a:	00009717          	auipc	a4,0x9
    8000102e:	b4f72f23          	sw	a5,-1186(a4) # 80009b88 <started>
    80001032:	b789                	j	80000f74 <main+0x56>

0000000080001034 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80001034:	1141                	addi	sp,sp,-16
    80001036:	e422                	sd	s0,8(sp)
    80001038:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    8000103a:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    8000103e:	00009797          	auipc	a5,0x9
    80001042:	b527b783          	ld	a5,-1198(a5) # 80009b90 <kernel_pagetable>
    80001046:	83b1                	srli	a5,a5,0xc
    80001048:	577d                	li	a4,-1
    8000104a:	177e                	slli	a4,a4,0x3f
    8000104c:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    8000104e:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    80001052:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    80001056:	6422                	ld	s0,8(sp)
    80001058:	0141                	addi	sp,sp,16
    8000105a:	8082                	ret

000000008000105c <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    8000105c:	7139                	addi	sp,sp,-64
    8000105e:	fc06                	sd	ra,56(sp)
    80001060:	f822                	sd	s0,48(sp)
    80001062:	f426                	sd	s1,40(sp)
    80001064:	f04a                	sd	s2,32(sp)
    80001066:	ec4e                	sd	s3,24(sp)
    80001068:	e852                	sd	s4,16(sp)
    8000106a:	e456                	sd	s5,8(sp)
    8000106c:	e05a                	sd	s6,0(sp)
    8000106e:	0080                	addi	s0,sp,64
    80001070:	84aa                	mv	s1,a0
    80001072:	89ae                	mv	s3,a1
    80001074:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80001076:	57fd                	li	a5,-1
    80001078:	83e9                	srli	a5,a5,0x1a
    8000107a:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    8000107c:	4b31                	li	s6,12
  if(va >= MAXVA)
    8000107e:	04b7f263          	bgeu	a5,a1,800010c2 <walk+0x66>
    panic("walk");
    80001082:	00008517          	auipc	a0,0x8
    80001086:	06e50513          	addi	a0,a0,110 # 800090f0 <digits+0x90>
    8000108a:	fffff097          	auipc	ra,0xfffff
    8000108e:	4b2080e7          	jalr	1202(ra) # 8000053c <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80001092:	060a8663          	beqz	s5,800010fe <walk+0xa2>
    80001096:	00000097          	auipc	ra,0x0
    8000109a:	af6080e7          	jalr	-1290(ra) # 80000b8c <kalloc>
    8000109e:	84aa                	mv	s1,a0
    800010a0:	c529                	beqz	a0,800010ea <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    800010a2:	6605                	lui	a2,0x1
    800010a4:	4581                	li	a1,0
    800010a6:	00000097          	auipc	ra,0x0
    800010aa:	cd2080e7          	jalr	-814(ra) # 80000d78 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800010ae:	00c4d793          	srli	a5,s1,0xc
    800010b2:	07aa                	slli	a5,a5,0xa
    800010b4:	0017e793          	ori	a5,a5,1
    800010b8:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    800010bc:	3a5d                	addiw	s4,s4,-9
    800010be:	036a0063          	beq	s4,s6,800010de <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800010c2:	0149d933          	srl	s2,s3,s4
    800010c6:	1ff97913          	andi	s2,s2,511
    800010ca:	090e                	slli	s2,s2,0x3
    800010cc:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800010ce:	00093483          	ld	s1,0(s2)
    800010d2:	0014f793          	andi	a5,s1,1
    800010d6:	dfd5                	beqz	a5,80001092 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800010d8:	80a9                	srli	s1,s1,0xa
    800010da:	04b2                	slli	s1,s1,0xc
    800010dc:	b7c5                	j	800010bc <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    800010de:	00c9d513          	srli	a0,s3,0xc
    800010e2:	1ff57513          	andi	a0,a0,511
    800010e6:	050e                	slli	a0,a0,0x3
    800010e8:	9526                	add	a0,a0,s1
}
    800010ea:	70e2                	ld	ra,56(sp)
    800010ec:	7442                	ld	s0,48(sp)
    800010ee:	74a2                	ld	s1,40(sp)
    800010f0:	7902                	ld	s2,32(sp)
    800010f2:	69e2                	ld	s3,24(sp)
    800010f4:	6a42                	ld	s4,16(sp)
    800010f6:	6aa2                	ld	s5,8(sp)
    800010f8:	6b02                	ld	s6,0(sp)
    800010fa:	6121                	addi	sp,sp,64
    800010fc:	8082                	ret
        return 0;
    800010fe:	4501                	li	a0,0
    80001100:	b7ed                	j	800010ea <walk+0x8e>

0000000080001102 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80001102:	57fd                	li	a5,-1
    80001104:	83e9                	srli	a5,a5,0x1a
    80001106:	00b7f463          	bgeu	a5,a1,8000110e <walkaddr+0xc>
    return 0;
    8000110a:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    8000110c:	8082                	ret
{
    8000110e:	1141                	addi	sp,sp,-16
    80001110:	e406                	sd	ra,8(sp)
    80001112:	e022                	sd	s0,0(sp)
    80001114:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80001116:	4601                	li	a2,0
    80001118:	00000097          	auipc	ra,0x0
    8000111c:	f44080e7          	jalr	-188(ra) # 8000105c <walk>
  if(pte == 0)
    80001120:	c105                	beqz	a0,80001140 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80001122:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80001124:	0117f693          	andi	a3,a5,17
    80001128:	4745                	li	a4,17
    return 0;
    8000112a:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    8000112c:	00e68663          	beq	a3,a4,80001138 <walkaddr+0x36>
}
    80001130:	60a2                	ld	ra,8(sp)
    80001132:	6402                	ld	s0,0(sp)
    80001134:	0141                	addi	sp,sp,16
    80001136:	8082                	ret
  pa = PTE2PA(*pte);
    80001138:	00a7d513          	srli	a0,a5,0xa
    8000113c:	0532                	slli	a0,a0,0xc
  return pa;
    8000113e:	bfcd                	j	80001130 <walkaddr+0x2e>
    return 0;
    80001140:	4501                	li	a0,0
    80001142:	b7fd                	j	80001130 <walkaddr+0x2e>

0000000080001144 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80001144:	715d                	addi	sp,sp,-80
    80001146:	e486                	sd	ra,72(sp)
    80001148:	e0a2                	sd	s0,64(sp)
    8000114a:	fc26                	sd	s1,56(sp)
    8000114c:	f84a                	sd	s2,48(sp)
    8000114e:	f44e                	sd	s3,40(sp)
    80001150:	f052                	sd	s4,32(sp)
    80001152:	ec56                	sd	s5,24(sp)
    80001154:	e85a                	sd	s6,16(sp)
    80001156:	e45e                	sd	s7,8(sp)
    80001158:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    8000115a:	c639                	beqz	a2,800011a8 <mappages+0x64>
    8000115c:	8aaa                	mv	s5,a0
    8000115e:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    80001160:	77fd                	lui	a5,0xfffff
    80001162:	00f5fa33          	and	s4,a1,a5
  last = PGROUNDDOWN(va + size - 1);
    80001166:	15fd                	addi	a1,a1,-1
    80001168:	00c589b3          	add	s3,a1,a2
    8000116c:	00f9f9b3          	and	s3,s3,a5
  a = PGROUNDDOWN(va);
    80001170:	8952                	mv	s2,s4
    80001172:	41468a33          	sub	s4,a3,s4
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80001176:	6b85                	lui	s7,0x1
    80001178:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    8000117c:	4605                	li	a2,1
    8000117e:	85ca                	mv	a1,s2
    80001180:	8556                	mv	a0,s5
    80001182:	00000097          	auipc	ra,0x0
    80001186:	eda080e7          	jalr	-294(ra) # 8000105c <walk>
    8000118a:	cd1d                	beqz	a0,800011c8 <mappages+0x84>
    if(*pte & PTE_V)
    8000118c:	611c                	ld	a5,0(a0)
    8000118e:	8b85                	andi	a5,a5,1
    80001190:	e785                	bnez	a5,800011b8 <mappages+0x74>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80001192:	80b1                	srli	s1,s1,0xc
    80001194:	04aa                	slli	s1,s1,0xa
    80001196:	0164e4b3          	or	s1,s1,s6
    8000119a:	0014e493          	ori	s1,s1,1
    8000119e:	e104                	sd	s1,0(a0)
    if(a == last)
    800011a0:	05390063          	beq	s2,s3,800011e0 <mappages+0x9c>
    a += PGSIZE;
    800011a4:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800011a6:	bfc9                	j	80001178 <mappages+0x34>
    panic("mappages: size");
    800011a8:	00008517          	auipc	a0,0x8
    800011ac:	f5050513          	addi	a0,a0,-176 # 800090f8 <digits+0x98>
    800011b0:	fffff097          	auipc	ra,0xfffff
    800011b4:	38c080e7          	jalr	908(ra) # 8000053c <panic>
      panic("mappages: remap");
    800011b8:	00008517          	auipc	a0,0x8
    800011bc:	f5050513          	addi	a0,a0,-176 # 80009108 <digits+0xa8>
    800011c0:	fffff097          	auipc	ra,0xfffff
    800011c4:	37c080e7          	jalr	892(ra) # 8000053c <panic>
      return -1;
    800011c8:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    800011ca:	60a6                	ld	ra,72(sp)
    800011cc:	6406                	ld	s0,64(sp)
    800011ce:	74e2                	ld	s1,56(sp)
    800011d0:	7942                	ld	s2,48(sp)
    800011d2:	79a2                	ld	s3,40(sp)
    800011d4:	7a02                	ld	s4,32(sp)
    800011d6:	6ae2                	ld	s5,24(sp)
    800011d8:	6b42                	ld	s6,16(sp)
    800011da:	6ba2                	ld	s7,8(sp)
    800011dc:	6161                	addi	sp,sp,80
    800011de:	8082                	ret
  return 0;
    800011e0:	4501                	li	a0,0
    800011e2:	b7e5                	j	800011ca <mappages+0x86>

00000000800011e4 <kvmmap>:
{
    800011e4:	1141                	addi	sp,sp,-16
    800011e6:	e406                	sd	ra,8(sp)
    800011e8:	e022                	sd	s0,0(sp)
    800011ea:	0800                	addi	s0,sp,16
    800011ec:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    800011ee:	86b2                	mv	a3,a2
    800011f0:	863e                	mv	a2,a5
    800011f2:	00000097          	auipc	ra,0x0
    800011f6:	f52080e7          	jalr	-174(ra) # 80001144 <mappages>
    800011fa:	e509                	bnez	a0,80001204 <kvmmap+0x20>
}
    800011fc:	60a2                	ld	ra,8(sp)
    800011fe:	6402                	ld	s0,0(sp)
    80001200:	0141                	addi	sp,sp,16
    80001202:	8082                	ret
    panic("kvmmap");
    80001204:	00008517          	auipc	a0,0x8
    80001208:	f1450513          	addi	a0,a0,-236 # 80009118 <digits+0xb8>
    8000120c:	fffff097          	auipc	ra,0xfffff
    80001210:	330080e7          	jalr	816(ra) # 8000053c <panic>

0000000080001214 <kvmmake>:
{
    80001214:	1101                	addi	sp,sp,-32
    80001216:	ec06                	sd	ra,24(sp)
    80001218:	e822                	sd	s0,16(sp)
    8000121a:	e426                	sd	s1,8(sp)
    8000121c:	e04a                	sd	s2,0(sp)
    8000121e:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80001220:	00000097          	auipc	ra,0x0
    80001224:	96c080e7          	jalr	-1684(ra) # 80000b8c <kalloc>
    80001228:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    8000122a:	6605                	lui	a2,0x1
    8000122c:	4581                	li	a1,0
    8000122e:	00000097          	auipc	ra,0x0
    80001232:	b4a080e7          	jalr	-1206(ra) # 80000d78 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80001236:	4719                	li	a4,6
    80001238:	6685                	lui	a3,0x1
    8000123a:	10000637          	lui	a2,0x10000
    8000123e:	100005b7          	lui	a1,0x10000
    80001242:	8526                	mv	a0,s1
    80001244:	00000097          	auipc	ra,0x0
    80001248:	fa0080e7          	jalr	-96(ra) # 800011e4 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000124c:	4719                	li	a4,6
    8000124e:	6685                	lui	a3,0x1
    80001250:	10001637          	lui	a2,0x10001
    80001254:	100015b7          	lui	a1,0x10001
    80001258:	8526                	mv	a0,s1
    8000125a:	00000097          	auipc	ra,0x0
    8000125e:	f8a080e7          	jalr	-118(ra) # 800011e4 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80001262:	4719                	li	a4,6
    80001264:	004006b7          	lui	a3,0x400
    80001268:	0c000637          	lui	a2,0xc000
    8000126c:	0c0005b7          	lui	a1,0xc000
    80001270:	8526                	mv	a0,s1
    80001272:	00000097          	auipc	ra,0x0
    80001276:	f72080e7          	jalr	-142(ra) # 800011e4 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    8000127a:	00008917          	auipc	s2,0x8
    8000127e:	d8690913          	addi	s2,s2,-634 # 80009000 <etext>
    80001282:	4729                	li	a4,10
    80001284:	80008697          	auipc	a3,0x80008
    80001288:	d7c68693          	addi	a3,a3,-644 # 9000 <_entry-0x7fff7000>
    8000128c:	4605                	li	a2,1
    8000128e:	067e                	slli	a2,a2,0x1f
    80001290:	85b2                	mv	a1,a2
    80001292:	8526                	mv	a0,s1
    80001294:	00000097          	auipc	ra,0x0
    80001298:	f50080e7          	jalr	-176(ra) # 800011e4 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    8000129c:	4719                	li	a4,6
    8000129e:	46c5                	li	a3,17
    800012a0:	06ee                	slli	a3,a3,0x1b
    800012a2:	412686b3          	sub	a3,a3,s2
    800012a6:	864a                	mv	a2,s2
    800012a8:	85ca                	mv	a1,s2
    800012aa:	8526                	mv	a0,s1
    800012ac:	00000097          	auipc	ra,0x0
    800012b0:	f38080e7          	jalr	-200(ra) # 800011e4 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800012b4:	4729                	li	a4,10
    800012b6:	6685                	lui	a3,0x1
    800012b8:	00007617          	auipc	a2,0x7
    800012bc:	d4860613          	addi	a2,a2,-696 # 80008000 <_trampoline>
    800012c0:	040005b7          	lui	a1,0x4000
    800012c4:	15fd                	addi	a1,a1,-1
    800012c6:	05b2                	slli	a1,a1,0xc
    800012c8:	8526                	mv	a0,s1
    800012ca:	00000097          	auipc	ra,0x0
    800012ce:	f1a080e7          	jalr	-230(ra) # 800011e4 <kvmmap>
  proc_mapstacks(kpgtbl);
    800012d2:	8526                	mv	a0,s1
    800012d4:	00000097          	auipc	ra,0x0
    800012d8:	708080e7          	jalr	1800(ra) # 800019dc <proc_mapstacks>
}
    800012dc:	8526                	mv	a0,s1
    800012de:	60e2                	ld	ra,24(sp)
    800012e0:	6442                	ld	s0,16(sp)
    800012e2:	64a2                	ld	s1,8(sp)
    800012e4:	6902                	ld	s2,0(sp)
    800012e6:	6105                	addi	sp,sp,32
    800012e8:	8082                	ret

00000000800012ea <kvminit>:
{
    800012ea:	1141                	addi	sp,sp,-16
    800012ec:	e406                	sd	ra,8(sp)
    800012ee:	e022                	sd	s0,0(sp)
    800012f0:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    800012f2:	00000097          	auipc	ra,0x0
    800012f6:	f22080e7          	jalr	-222(ra) # 80001214 <kvmmake>
    800012fa:	00009797          	auipc	a5,0x9
    800012fe:	88a7bb23          	sd	a0,-1898(a5) # 80009b90 <kernel_pagetable>
}
    80001302:	60a2                	ld	ra,8(sp)
    80001304:	6402                	ld	s0,0(sp)
    80001306:	0141                	addi	sp,sp,16
    80001308:	8082                	ret

000000008000130a <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    8000130a:	715d                	addi	sp,sp,-80
    8000130c:	e486                	sd	ra,72(sp)
    8000130e:	e0a2                	sd	s0,64(sp)
    80001310:	fc26                	sd	s1,56(sp)
    80001312:	f84a                	sd	s2,48(sp)
    80001314:	f44e                	sd	s3,40(sp)
    80001316:	f052                	sd	s4,32(sp)
    80001318:	ec56                	sd	s5,24(sp)
    8000131a:	e85a                	sd	s6,16(sp)
    8000131c:	e45e                	sd	s7,8(sp)
    8000131e:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80001320:	03459793          	slli	a5,a1,0x34
    80001324:	e795                	bnez	a5,80001350 <uvmunmap+0x46>
    80001326:	8a2a                	mv	s4,a0
    80001328:	892e                	mv	s2,a1
    8000132a:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000132c:	0632                	slli	a2,a2,0xc
    8000132e:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0) 
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V) 
    80001332:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001334:	6b05                	lui	s6,0x1
    80001336:	0735e263          	bltu	a1,s3,8000139a <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    8000133a:	60a6                	ld	ra,72(sp)
    8000133c:	6406                	ld	s0,64(sp)
    8000133e:	74e2                	ld	s1,56(sp)
    80001340:	7942                	ld	s2,48(sp)
    80001342:	79a2                	ld	s3,40(sp)
    80001344:	7a02                	ld	s4,32(sp)
    80001346:	6ae2                	ld	s5,24(sp)
    80001348:	6b42                	ld	s6,16(sp)
    8000134a:	6ba2                	ld	s7,8(sp)
    8000134c:	6161                	addi	sp,sp,80
    8000134e:	8082                	ret
    panic("uvmunmap: not aligned");
    80001350:	00008517          	auipc	a0,0x8
    80001354:	dd050513          	addi	a0,a0,-560 # 80009120 <digits+0xc0>
    80001358:	fffff097          	auipc	ra,0xfffff
    8000135c:	1e4080e7          	jalr	484(ra) # 8000053c <panic>
      panic("uvmunmap: walk");
    80001360:	00008517          	auipc	a0,0x8
    80001364:	dd850513          	addi	a0,a0,-552 # 80009138 <digits+0xd8>
    80001368:	fffff097          	auipc	ra,0xfffff
    8000136c:	1d4080e7          	jalr	468(ra) # 8000053c <panic>
      panic("uvmunmap: not mapped");
    80001370:	00008517          	auipc	a0,0x8
    80001374:	dd850513          	addi	a0,a0,-552 # 80009148 <digits+0xe8>
    80001378:	fffff097          	auipc	ra,0xfffff
    8000137c:	1c4080e7          	jalr	452(ra) # 8000053c <panic>
      panic("uvmunmap: not a leaf");
    80001380:	00008517          	auipc	a0,0x8
    80001384:	de050513          	addi	a0,a0,-544 # 80009160 <digits+0x100>
    80001388:	fffff097          	auipc	ra,0xfffff
    8000138c:	1b4080e7          	jalr	436(ra) # 8000053c <panic>
    *pte = 0;
    80001390:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001394:	995a                	add	s2,s2,s6
    80001396:	fb3972e3          	bgeu	s2,s3,8000133a <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    8000139a:	4601                	li	a2,0
    8000139c:	85ca                	mv	a1,s2
    8000139e:	8552                	mv	a0,s4
    800013a0:	00000097          	auipc	ra,0x0
    800013a4:	cbc080e7          	jalr	-836(ra) # 8000105c <walk>
    800013a8:	84aa                	mv	s1,a0
    800013aa:	d95d                	beqz	a0,80001360 <uvmunmap+0x56>
    if((*pte & PTE_V) == 0) 
    800013ac:	6108                	ld	a0,0(a0)
    800013ae:	00157793          	andi	a5,a0,1
    800013b2:	dfdd                	beqz	a5,80001370 <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V) 
    800013b4:	3ff57793          	andi	a5,a0,1023
    800013b8:	fd7784e3          	beq	a5,s7,80001380 <uvmunmap+0x76>
    if(do_free){
    800013bc:	fc0a8ae3          	beqz	s5,80001390 <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    800013c0:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    800013c2:	0532                	slli	a0,a0,0xc
    800013c4:	fffff097          	auipc	ra,0xfffff
    800013c8:	6cc080e7          	jalr	1740(ra) # 80000a90 <kfree>
    800013cc:	b7d1                	j	80001390 <uvmunmap+0x86>

00000000800013ce <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800013ce:	1101                	addi	sp,sp,-32
    800013d0:	ec06                	sd	ra,24(sp)
    800013d2:	e822                	sd	s0,16(sp)
    800013d4:	e426                	sd	s1,8(sp)
    800013d6:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    800013d8:	fffff097          	auipc	ra,0xfffff
    800013dc:	7b4080e7          	jalr	1972(ra) # 80000b8c <kalloc>
    800013e0:	84aa                	mv	s1,a0
  if(pagetable == 0)
    800013e2:	c519                	beqz	a0,800013f0 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    800013e4:	6605                	lui	a2,0x1
    800013e6:	4581                	li	a1,0
    800013e8:	00000097          	auipc	ra,0x0
    800013ec:	990080e7          	jalr	-1648(ra) # 80000d78 <memset>
  return pagetable;
}
    800013f0:	8526                	mv	a0,s1
    800013f2:	60e2                	ld	ra,24(sp)
    800013f4:	6442                	ld	s0,16(sp)
    800013f6:	64a2                	ld	s1,8(sp)
    800013f8:	6105                	addi	sp,sp,32
    800013fa:	8082                	ret

00000000800013fc <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    800013fc:	7179                	addi	sp,sp,-48
    800013fe:	f406                	sd	ra,40(sp)
    80001400:	f022                	sd	s0,32(sp)
    80001402:	ec26                	sd	s1,24(sp)
    80001404:	e84a                	sd	s2,16(sp)
    80001406:	e44e                	sd	s3,8(sp)
    80001408:	e052                	sd	s4,0(sp)
    8000140a:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    8000140c:	6785                	lui	a5,0x1
    8000140e:	04f67863          	bgeu	a2,a5,8000145e <uvmfirst+0x62>
    80001412:	8a2a                	mv	s4,a0
    80001414:	89ae                	mv	s3,a1
    80001416:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    80001418:	fffff097          	auipc	ra,0xfffff
    8000141c:	774080e7          	jalr	1908(ra) # 80000b8c <kalloc>
    80001420:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80001422:	6605                	lui	a2,0x1
    80001424:	4581                	li	a1,0
    80001426:	00000097          	auipc	ra,0x0
    8000142a:	952080e7          	jalr	-1710(ra) # 80000d78 <memset>
  // mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
  mappages(pagetable, PGSIZE*3, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    8000142e:	4779                	li	a4,30
    80001430:	86ca                	mv	a3,s2
    80001432:	6605                	lui	a2,0x1
    80001434:	658d                	lui	a1,0x3
    80001436:	8552                	mv	a0,s4
    80001438:	00000097          	auipc	ra,0x0
    8000143c:	d0c080e7          	jalr	-756(ra) # 80001144 <mappages>
  memmove(mem, src, sz);
    80001440:	8626                	mv	a2,s1
    80001442:	85ce                	mv	a1,s3
    80001444:	854a                	mv	a0,s2
    80001446:	00000097          	auipc	ra,0x0
    8000144a:	98e080e7          	jalr	-1650(ra) # 80000dd4 <memmove>
}
    8000144e:	70a2                	ld	ra,40(sp)
    80001450:	7402                	ld	s0,32(sp)
    80001452:	64e2                	ld	s1,24(sp)
    80001454:	6942                	ld	s2,16(sp)
    80001456:	69a2                	ld	s3,8(sp)
    80001458:	6a02                	ld	s4,0(sp)
    8000145a:	6145                	addi	sp,sp,48
    8000145c:	8082                	ret
    panic("uvmfirst: more than a page");
    8000145e:	00008517          	auipc	a0,0x8
    80001462:	d1a50513          	addi	a0,a0,-742 # 80009178 <digits+0x118>
    80001466:	fffff097          	auipc	ra,0xfffff
    8000146a:	0d6080e7          	jalr	214(ra) # 8000053c <panic>

000000008000146e <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    8000146e:	1101                	addi	sp,sp,-32
    80001470:	ec06                	sd	ra,24(sp)
    80001472:	e822                	sd	s0,16(sp)
    80001474:	e426                	sd	s1,8(sp)
    80001476:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    80001478:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    8000147a:	00b67d63          	bgeu	a2,a1,80001494 <uvmdealloc+0x26>
    8000147e:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80001480:	6785                	lui	a5,0x1
    80001482:	17fd                	addi	a5,a5,-1
    80001484:	00f60733          	add	a4,a2,a5
    80001488:	767d                	lui	a2,0xfffff
    8000148a:	8f71                	and	a4,a4,a2
    8000148c:	97ae                	add	a5,a5,a1
    8000148e:	8ff1                	and	a5,a5,a2
    80001490:	00f76863          	bltu	a4,a5,800014a0 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80001494:	8526                	mv	a0,s1
    80001496:	60e2                	ld	ra,24(sp)
    80001498:	6442                	ld	s0,16(sp)
    8000149a:	64a2                	ld	s1,8(sp)
    8000149c:	6105                	addi	sp,sp,32
    8000149e:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800014a0:	8f99                	sub	a5,a5,a4
    800014a2:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800014a4:	4685                	li	a3,1
    800014a6:	0007861b          	sext.w	a2,a5
    800014aa:	85ba                	mv	a1,a4
    800014ac:	00000097          	auipc	ra,0x0
    800014b0:	e5e080e7          	jalr	-418(ra) # 8000130a <uvmunmap>
    800014b4:	b7c5                	j	80001494 <uvmdealloc+0x26>

00000000800014b6 <uvmalloc>:
  if(newsz > USERTOP)   // cannot alloc
    800014b6:	000a07b7          	lui	a5,0xa0
    800014ba:	0cc7e463          	bltu	a5,a2,80001582 <uvmalloc+0xcc>
{
    800014be:	715d                	addi	sp,sp,-80
    800014c0:	e486                	sd	ra,72(sp)
    800014c2:	e0a2                	sd	s0,64(sp)
    800014c4:	fc26                	sd	s1,56(sp)
    800014c6:	f84a                	sd	s2,48(sp)
    800014c8:	f44e                	sd	s3,40(sp)
    800014ca:	f052                	sd	s4,32(sp)
    800014cc:	ec56                	sd	s5,24(sp)
    800014ce:	e85a                	sd	s6,16(sp)
    800014d0:	e45e                	sd	s7,8(sp)
    800014d2:	0880                	addi	s0,sp,80
    800014d4:	8aaa                	mv	s5,a0
    800014d6:	8b32                	mv	s6,a2
    return oldsz;
    800014d8:	852e                	mv	a0,a1
  if(newsz < oldsz)
    800014da:	06b66b63          	bltu	a2,a1,80001550 <uvmalloc+0x9a>
  oldsz = PGROUNDUP(oldsz);
    800014de:	6985                	lui	s3,0x1
    800014e0:	19fd                	addi	s3,s3,-1
    800014e2:	95ce                	add	a1,a1,s3
    800014e4:	79fd                	lui	s3,0xfffff
    800014e6:	0135f9b3          	and	s3,a1,s3
  for(a = oldsz; a < newsz; a += PGSIZE){
    800014ea:	08c9fe63          	bgeu	s3,a2,80001586 <uvmalloc+0xd0>
    800014ee:	fff60b93          	addi	s7,a2,-1 # ffffffffffffefff <end+0xffffffff7ffdaddf>
    800014f2:	413b8bb3          	sub	s7,s7,s3
    800014f6:	77fd                	lui	a5,0xfffff
    800014f8:	00fbfbb3          	and	s7,s7,a5
    800014fc:	6785                	lui	a5,0x1
    800014fe:	97ce                	add	a5,a5,s3
    80001500:	9bbe                	add	s7,s7,a5
    80001502:	894e                	mv	s2,s3
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80001504:	0126ea13          	ori	s4,a3,18
    mem = kalloc();
    80001508:	fffff097          	auipc	ra,0xfffff
    8000150c:	684080e7          	jalr	1668(ra) # 80000b8c <kalloc>
    80001510:	84aa                	mv	s1,a0
    if(mem == 0){
    80001512:	c51d                	beqz	a0,80001540 <uvmalloc+0x8a>
    memset(mem, 0, PGSIZE);
    80001514:	6605                	lui	a2,0x1
    80001516:	4581                	li	a1,0
    80001518:	00000097          	auipc	ra,0x0
    8000151c:	860080e7          	jalr	-1952(ra) # 80000d78 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80001520:	8752                	mv	a4,s4
    80001522:	86a6                	mv	a3,s1
    80001524:	6605                	lui	a2,0x1
    80001526:	85ca                	mv	a1,s2
    80001528:	8556                	mv	a0,s5
    8000152a:	00000097          	auipc	ra,0x0
    8000152e:	c1a080e7          	jalr	-998(ra) # 80001144 <mappages>
    80001532:	e915                	bnez	a0,80001566 <uvmalloc+0xb0>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80001534:	6785                	lui	a5,0x1
    80001536:	993e                	add	s2,s2,a5
    80001538:	fd7918e3          	bne	s2,s7,80001508 <uvmalloc+0x52>
  return newsz;
    8000153c:	855a                	mv	a0,s6
    8000153e:	a809                	j	80001550 <uvmalloc+0x9a>
      uvmdealloc(pagetable, a, oldsz);
    80001540:	864e                	mv	a2,s3
    80001542:	85ca                	mv	a1,s2
    80001544:	8556                	mv	a0,s5
    80001546:	00000097          	auipc	ra,0x0
    8000154a:	f28080e7          	jalr	-216(ra) # 8000146e <uvmdealloc>
      return 0;
    8000154e:	4501                	li	a0,0
}
    80001550:	60a6                	ld	ra,72(sp)
    80001552:	6406                	ld	s0,64(sp)
    80001554:	74e2                	ld	s1,56(sp)
    80001556:	7942                	ld	s2,48(sp)
    80001558:	79a2                	ld	s3,40(sp)
    8000155a:	7a02                	ld	s4,32(sp)
    8000155c:	6ae2                	ld	s5,24(sp)
    8000155e:	6b42                	ld	s6,16(sp)
    80001560:	6ba2                	ld	s7,8(sp)
    80001562:	6161                	addi	sp,sp,80
    80001564:	8082                	ret
      kfree(mem);
    80001566:	8526                	mv	a0,s1
    80001568:	fffff097          	auipc	ra,0xfffff
    8000156c:	528080e7          	jalr	1320(ra) # 80000a90 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80001570:	864e                	mv	a2,s3
    80001572:	85ca                	mv	a1,s2
    80001574:	8556                	mv	a0,s5
    80001576:	00000097          	auipc	ra,0x0
    8000157a:	ef8080e7          	jalr	-264(ra) # 8000146e <uvmdealloc>
      return 0;
    8000157e:	4501                	li	a0,0
    80001580:	bfc1                	j	80001550 <uvmalloc+0x9a>
    return 0;           
    80001582:	4501                	li	a0,0
}
    80001584:	8082                	ret
  return newsz;
    80001586:	8532                	mv	a0,a2
    80001588:	b7e1                	j	80001550 <uvmalloc+0x9a>

000000008000158a <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    8000158a:	7179                	addi	sp,sp,-48
    8000158c:	f406                	sd	ra,40(sp)
    8000158e:	f022                	sd	s0,32(sp)
    80001590:	ec26                	sd	s1,24(sp)
    80001592:	e84a                	sd	s2,16(sp)
    80001594:	e44e                	sd	s3,8(sp)
    80001596:	e052                	sd	s4,0(sp)
    80001598:	1800                	addi	s0,sp,48
    8000159a:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    8000159c:	84aa                	mv	s1,a0
    8000159e:	6905                	lui	s2,0x1
    800015a0:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i]; 
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800015a2:	4985                	li	s3,1
    800015a4:	a821                	j	800015bc <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800015a6:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    800015a8:	0532                	slli	a0,a0,0xc
    800015aa:	00000097          	auipc	ra,0x0
    800015ae:	fe0080e7          	jalr	-32(ra) # 8000158a <freewalk>
      pagetable[i] = 0;
    800015b2:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    800015b6:	04a1                	addi	s1,s1,8
    800015b8:	03248163          	beq	s1,s2,800015da <freewalk+0x50>
    pte_t pte = pagetable[i]; 
    800015bc:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800015be:	00f57793          	andi	a5,a0,15
    800015c2:	ff3782e3          	beq	a5,s3,800015a6 <freewalk+0x1c>
    } else if(pte & PTE_V){
    800015c6:	8905                	andi	a0,a0,1
    800015c8:	d57d                	beqz	a0,800015b6 <freewalk+0x2c>
      panic("freewalk: leaf");
    800015ca:	00008517          	auipc	a0,0x8
    800015ce:	bce50513          	addi	a0,a0,-1074 # 80009198 <digits+0x138>
    800015d2:	fffff097          	auipc	ra,0xfffff
    800015d6:	f6a080e7          	jalr	-150(ra) # 8000053c <panic>
    }
  }
  kfree((void*)pagetable);
    800015da:	8552                	mv	a0,s4
    800015dc:	fffff097          	auipc	ra,0xfffff
    800015e0:	4b4080e7          	jalr	1204(ra) # 80000a90 <kfree>
}
    800015e4:	70a2                	ld	ra,40(sp)
    800015e6:	7402                	ld	s0,32(sp)
    800015e8:	64e2                	ld	s1,24(sp)
    800015ea:	6942                	ld	s2,16(sp)
    800015ec:	69a2                	ld	s3,8(sp)
    800015ee:	6a02                	ld	s4,0(sp)
    800015f0:	6145                	addi	sp,sp,48
    800015f2:	8082                	ret

00000000800015f4 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    800015f4:	7179                	addi	sp,sp,-48
    800015f6:	f406                	sd	ra,40(sp)
    800015f8:	f022                	sd	s0,32(sp)
    800015fa:	ec26                	sd	s1,24(sp)
    800015fc:	e84a                	sd	s2,16(sp)
    800015fe:	e44e                	sd	s3,8(sp)
    80001600:	1800                	addi	s0,sp,48
    80001602:	892a                	mv	s2,a0
    80001604:	84ae                	mv	s1,a1
  if(sz > PGSIZE*3) {
    80001606:	678d                	lui	a5,0x3
    80001608:	00b7ef63          	bltu	a5,a1,80001626 <uvmfree+0x32>
    struct proc *p = myproc(); 
    uvmunmap(pagetable, PGSIZE*3, PGROUNDUP(sz - PGSIZE*3)/PGSIZE, 1);
    uvmunmap(pagetable, p->stack_sz, PGROUNDUP(USERTOP - p->stack_sz)/PGSIZE, 1); 
  }
  else if(sz > 0) {
    8000160c:	e9b9                	bnez	a1,80001662 <uvmfree+0x6e>
    uvmunmap(pagetable, PGSIZE*3, PGROUNDUP(sz)/PGSIZE, 1);
  }
  freewalk(pagetable);
    8000160e:	854a                	mv	a0,s2
    80001610:	00000097          	auipc	ra,0x0
    80001614:	f7a080e7          	jalr	-134(ra) # 8000158a <freewalk>
}
    80001618:	70a2                	ld	ra,40(sp)
    8000161a:	7402                	ld	s0,32(sp)
    8000161c:	64e2                	ld	s1,24(sp)
    8000161e:	6942                	ld	s2,16(sp)
    80001620:	69a2                	ld	s3,8(sp)
    80001622:	6145                	addi	sp,sp,48
    80001624:	8082                	ret
    struct proc *p = myproc(); 
    80001626:	00000097          	auipc	ra,0x0
    8000162a:	52c080e7          	jalr	1324(ra) # 80001b52 <myproc>
    8000162e:	89aa                	mv	s3,a0
    uvmunmap(pagetable, PGSIZE*3, PGROUNDUP(sz - PGSIZE*3)/PGSIZE, 1);
    80001630:	7679                	lui	a2,0xffffe
    80001632:	167d                	addi	a2,a2,-1
    80001634:	9626                	add	a2,a2,s1
    80001636:	4685                	li	a3,1
    80001638:	8231                	srli	a2,a2,0xc
    8000163a:	658d                	lui	a1,0x3
    8000163c:	854a                	mv	a0,s2
    8000163e:	00000097          	auipc	ra,0x0
    80001642:	ccc080e7          	jalr	-820(ra) # 8000130a <uvmunmap>
    uvmunmap(pagetable, p->stack_sz, PGROUNDUP(USERTOP - p->stack_sz)/PGSIZE, 1); 
    80001646:	0489b583          	ld	a1,72(s3) # fffffffffffff048 <end+0xffffffff7ffdae28>
    8000164a:	000a1637          	lui	a2,0xa1
    8000164e:	167d                	addi	a2,a2,-1
    80001650:	8e0d                	sub	a2,a2,a1
    80001652:	4685                	li	a3,1
    80001654:	8231                	srli	a2,a2,0xc
    80001656:	854a                	mv	a0,s2
    80001658:	00000097          	auipc	ra,0x0
    8000165c:	cb2080e7          	jalr	-846(ra) # 8000130a <uvmunmap>
    80001660:	b77d                	j	8000160e <uvmfree+0x1a>
    uvmunmap(pagetable, PGSIZE*3, PGROUNDUP(sz)/PGSIZE, 1);
    80001662:	6605                	lui	a2,0x1
    80001664:	167d                	addi	a2,a2,-1
    80001666:	962e                	add	a2,a2,a1
    80001668:	4685                	li	a3,1
    8000166a:	8231                	srli	a2,a2,0xc
    8000166c:	658d                	lui	a1,0x3
    8000166e:	00000097          	auipc	ra,0x0
    80001672:	c9c080e7          	jalr	-868(ra) # 8000130a <uvmunmap>
    80001676:	bf61                	j	8000160e <uvmfree+0x1a>

0000000080001678 <uvmcopy>:
// physical memory.
// returns 0 on success, -1 on failure.
// frees any allocated pages on failure.
int
uvmcopy(pagetable_t old, pagetable_t new, uint64 sz)
{
    80001678:	715d                	addi	sp,sp,-80
    8000167a:	e486                	sd	ra,72(sp)
    8000167c:	e0a2                	sd	s0,64(sp)
    8000167e:	fc26                	sd	s1,56(sp)
    80001680:	f84a                	sd	s2,48(sp)
    80001682:	f44e                	sd	s3,40(sp)
    80001684:	f052                	sd	s4,32(sp)
    80001686:	ec56                	sd	s5,24(sp)
    80001688:	e85a                	sd	s6,16(sp)
    8000168a:	e45e                	sd	s7,8(sp)
    8000168c:	0880                	addi	s0,sp,80
    8000168e:	8aaa                	mv	s5,a0
    80001690:	8a2e                	mv	s4,a1
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;
  // for(i = 0; i < sz; i += PGSIZE){
  for(i = PGSIZE*3; i < sz; i += PGSIZE){
    80001692:	678d                	lui	a5,0x3
    80001694:	06c7f063          	bgeu	a5,a2,800016f4 <uvmcopy+0x7c>
    80001698:	8b32                	mv	s6,a2
    8000169a:	648d                	lui	s1,0x3
    if((pte = walk(old, i, 0)) == 0)
    8000169c:	4601                	li	a2,0
    8000169e:	85a6                	mv	a1,s1
    800016a0:	8556                	mv	a0,s5
    800016a2:	00000097          	auipc	ra,0x0
    800016a6:	9ba080e7          	jalr	-1606(ra) # 8000105c <walk>
    800016aa:	cd4d                	beqz	a0,80001764 <uvmcopy+0xec>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0) 
    800016ac:	6118                	ld	a4,0(a0)
    800016ae:	00177793          	andi	a5,a4,1
    800016b2:	c3e9                	beqz	a5,80001774 <uvmcopy+0xfc>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    800016b4:	00a75593          	srli	a1,a4,0xa
    800016b8:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    800016bc:	3ff77913          	andi	s2,a4,1023
    if((mem = kalloc()) == 0)
    800016c0:	fffff097          	auipc	ra,0xfffff
    800016c4:	4cc080e7          	jalr	1228(ra) # 80000b8c <kalloc>
    800016c8:	89aa                	mv	s3,a0
    800016ca:	c171                	beqz	a0,8000178e <uvmcopy+0x116>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    800016cc:	6605                	lui	a2,0x1
    800016ce:	85de                	mv	a1,s7
    800016d0:	fffff097          	auipc	ra,0xfffff
    800016d4:	704080e7          	jalr	1796(ra) # 80000dd4 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    800016d8:	874a                	mv	a4,s2
    800016da:	86ce                	mv	a3,s3
    800016dc:	6605                	lui	a2,0x1
    800016de:	85a6                	mv	a1,s1
    800016e0:	8552                	mv	a0,s4
    800016e2:	00000097          	auipc	ra,0x0
    800016e6:	a62080e7          	jalr	-1438(ra) # 80001144 <mappages>
    800016ea:	ed49                	bnez	a0,80001784 <uvmcopy+0x10c>
  for(i = PGSIZE*3; i < sz; i += PGSIZE){
    800016ec:	6785                	lui	a5,0x1
    800016ee:	94be                	add	s1,s1,a5
    800016f0:	fb64e6e3          	bltu	s1,s6,8000169c <uvmcopy+0x24>
      kfree(mem);
      goto err;
    }
  }   

  struct proc *p = myproc(); 
    800016f4:	00000097          	auipc	ra,0x0
    800016f8:	45e080e7          	jalr	1118(ra) # 80001b52 <myproc>
  for(i = p->stack_sz; i < USERTOP; i += PGSIZE){
    800016fc:	6524                	ld	s1,72(a0)
    800016fe:	000a07b7          	lui	a5,0xa0
    80001702:	0cf4fb63          	bgeu	s1,a5,800017d8 <uvmcopy+0x160>
    80001706:	000a0b37          	lui	s6,0xa0
    // Copy the last page which is the new stack
    if((pte = walk(old, i, 0)) == 0)
    8000170a:	4601                	li	a2,0
    8000170c:	85a6                	mv	a1,s1
    8000170e:	8556                	mv	a0,s5
    80001710:	00000097          	auipc	ra,0x0
    80001714:	94c080e7          	jalr	-1716(ra) # 8000105c <walk>
    80001718:	c145                	beqz	a0,800017b8 <uvmcopy+0x140>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0) 
    8000171a:	6118                	ld	a4,0(a0)
    8000171c:	00177793          	andi	a5,a4,1
    80001720:	c7c5                	beqz	a5,800017c8 <uvmcopy+0x150>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);      // what pa are they getting from pte
    80001722:	00a75593          	srli	a1,a4,0xa
    80001726:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    8000172a:	3ff77913          	andi	s2,a4,1023
    if((mem = kalloc()) == 0)
    8000172e:	fffff097          	auipc	ra,0xfffff
    80001732:	45e080e7          	jalr	1118(ra) # 80000b8c <kalloc>
    80001736:	89aa                	mv	s3,a0
    80001738:	c939                	beqz	a0,8000178e <uvmcopy+0x116>
      goto err;
    memmove(mem, (char*)pa, PGSIZE); // copying some stuff.. figure out what 1 page is and copying it
    8000173a:	6605                	lui	a2,0x1
    8000173c:	85de                	mv	a1,s7
    8000173e:	fffff097          	auipc	ra,0xfffff
    80001742:	696080e7          	jalr	1686(ra) # 80000dd4 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0) // mapping into new address space and making it valid
    80001746:	874a                	mv	a4,s2
    80001748:	86ce                	mv	a3,s3
    8000174a:	6605                	lui	a2,0x1
    8000174c:	85a6                	mv	a1,s1
    8000174e:	8552                	mv	a0,s4
    80001750:	00000097          	auipc	ra,0x0
    80001754:	9f4080e7          	jalr	-1548(ra) # 80001144 <mappages>
    80001758:	e91d                	bnez	a0,8000178e <uvmcopy+0x116>
  for(i = p->stack_sz; i < USERTOP; i += PGSIZE){
    8000175a:	6785                	lui	a5,0x1
    8000175c:	94be                	add	s1,s1,a5
    8000175e:	fb64e6e3          	bltu	s1,s6,8000170a <uvmcopy+0x92>
    80001762:	a081                	j	800017a2 <uvmcopy+0x12a>
      panic("uvmcopy: pte should exist");
    80001764:	00008517          	auipc	a0,0x8
    80001768:	a4450513          	addi	a0,a0,-1468 # 800091a8 <digits+0x148>
    8000176c:	fffff097          	auipc	ra,0xfffff
    80001770:	dd0080e7          	jalr	-560(ra) # 8000053c <panic>
      panic("uvmcopy: page not present");
    80001774:	00008517          	auipc	a0,0x8
    80001778:	a5450513          	addi	a0,a0,-1452 # 800091c8 <digits+0x168>
    8000177c:	fffff097          	auipc	ra,0xfffff
    80001780:	dc0080e7          	jalr	-576(ra) # 8000053c <panic>
      kfree(mem);
    80001784:	854e                	mv	a0,s3
    80001786:	fffff097          	auipc	ra,0xfffff
    8000178a:	30a080e7          	jalr	778(ra) # 80000a90 <kfree>

  return 0;

 err:
  // uvmunmap(new, 0, i / PGSIZE, 1);
  uvmunmap(new, PGSIZE*3, i / PGSIZE, 1);
    8000178e:	4685                	li	a3,1
    80001790:	00c4d613          	srli	a2,s1,0xc
    80001794:	658d                	lui	a1,0x3
    80001796:	8552                	mv	a0,s4
    80001798:	00000097          	auipc	ra,0x0
    8000179c:	b72080e7          	jalr	-1166(ra) # 8000130a <uvmunmap>
  return -1;
    800017a0:	557d                	li	a0,-1
}
    800017a2:	60a6                	ld	ra,72(sp)
    800017a4:	6406                	ld	s0,64(sp)
    800017a6:	74e2                	ld	s1,56(sp)
    800017a8:	7942                	ld	s2,48(sp)
    800017aa:	79a2                	ld	s3,40(sp)
    800017ac:	7a02                	ld	s4,32(sp)
    800017ae:	6ae2                	ld	s5,24(sp)
    800017b0:	6b42                	ld	s6,16(sp)
    800017b2:	6ba2                	ld	s7,8(sp)
    800017b4:	6161                	addi	sp,sp,80
    800017b6:	8082                	ret
      panic("uvmcopy: pte should exist");
    800017b8:	00008517          	auipc	a0,0x8
    800017bc:	9f050513          	addi	a0,a0,-1552 # 800091a8 <digits+0x148>
    800017c0:	fffff097          	auipc	ra,0xfffff
    800017c4:	d7c080e7          	jalr	-644(ra) # 8000053c <panic>
      panic("uvmcopy: page not present");
    800017c8:	00008517          	auipc	a0,0x8
    800017cc:	a0050513          	addi	a0,a0,-1536 # 800091c8 <digits+0x168>
    800017d0:	fffff097          	auipc	ra,0xfffff
    800017d4:	d6c080e7          	jalr	-660(ra) # 8000053c <panic>
  return 0;
    800017d8:	4501                	li	a0,0
    800017da:	b7e1                	j	800017a2 <uvmcopy+0x12a>

00000000800017dc <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    800017dc:	1141                	addi	sp,sp,-16
    800017de:	e406                	sd	ra,8(sp)
    800017e0:	e022                	sd	s0,0(sp)
    800017e2:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    800017e4:	4601                	li	a2,0
    800017e6:	00000097          	auipc	ra,0x0
    800017ea:	876080e7          	jalr	-1930(ra) # 8000105c <walk>
  if(pte == 0)
    800017ee:	c901                	beqz	a0,800017fe <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    800017f0:	611c                	ld	a5,0(a0)
    800017f2:	9bbd                	andi	a5,a5,-17
    800017f4:	e11c                	sd	a5,0(a0)
}
    800017f6:	60a2                	ld	ra,8(sp)
    800017f8:	6402                	ld	s0,0(sp)
    800017fa:	0141                	addi	sp,sp,16
    800017fc:	8082                	ret
    panic("uvmclear");
    800017fe:	00008517          	auipc	a0,0x8
    80001802:	9ea50513          	addi	a0,a0,-1558 # 800091e8 <digits+0x188>
    80001806:	fffff097          	auipc	ra,0xfffff
    8000180a:	d36080e7          	jalr	-714(ra) # 8000053c <panic>

000000008000180e <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    8000180e:	c6bd                	beqz	a3,8000187c <copyout+0x6e>
{
    80001810:	715d                	addi	sp,sp,-80
    80001812:	e486                	sd	ra,72(sp)
    80001814:	e0a2                	sd	s0,64(sp)
    80001816:	fc26                	sd	s1,56(sp)
    80001818:	f84a                	sd	s2,48(sp)
    8000181a:	f44e                	sd	s3,40(sp)
    8000181c:	f052                	sd	s4,32(sp)
    8000181e:	ec56                	sd	s5,24(sp)
    80001820:	e85a                	sd	s6,16(sp)
    80001822:	e45e                	sd	s7,8(sp)
    80001824:	e062                	sd	s8,0(sp)
    80001826:	0880                	addi	s0,sp,80
    80001828:	8b2a                	mv	s6,a0
    8000182a:	8c2e                	mv	s8,a1
    8000182c:	8a32                	mv	s4,a2
    8000182e:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80001830:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80001832:	6a85                	lui	s5,0x1
    80001834:	a015                	j	80001858 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80001836:	9562                	add	a0,a0,s8
    80001838:	0004861b          	sext.w	a2,s1
    8000183c:	85d2                	mv	a1,s4
    8000183e:	41250533          	sub	a0,a0,s2
    80001842:	fffff097          	auipc	ra,0xfffff
    80001846:	592080e7          	jalr	1426(ra) # 80000dd4 <memmove>

    len -= n;
    8000184a:	409989b3          	sub	s3,s3,s1
    src += n;
    8000184e:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80001850:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80001854:	02098263          	beqz	s3,80001878 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80001858:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    8000185c:	85ca                	mv	a1,s2
    8000185e:	855a                	mv	a0,s6
    80001860:	00000097          	auipc	ra,0x0
    80001864:	8a2080e7          	jalr	-1886(ra) # 80001102 <walkaddr>
    if(pa0 == 0)
    80001868:	cd01                	beqz	a0,80001880 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    8000186a:	418904b3          	sub	s1,s2,s8
    8000186e:	94d6                	add	s1,s1,s5
    if(n > len)
    80001870:	fc99f3e3          	bgeu	s3,s1,80001836 <copyout+0x28>
    80001874:	84ce                	mv	s1,s3
    80001876:	b7c1                	j	80001836 <copyout+0x28>
  }
  return 0;
    80001878:	4501                	li	a0,0
    8000187a:	a021                	j	80001882 <copyout+0x74>
    8000187c:	4501                	li	a0,0
}
    8000187e:	8082                	ret
      return -1;
    80001880:	557d                	li	a0,-1
}
    80001882:	60a6                	ld	ra,72(sp)
    80001884:	6406                	ld	s0,64(sp)
    80001886:	74e2                	ld	s1,56(sp)
    80001888:	7942                	ld	s2,48(sp)
    8000188a:	79a2                	ld	s3,40(sp)
    8000188c:	7a02                	ld	s4,32(sp)
    8000188e:	6ae2                	ld	s5,24(sp)
    80001890:	6b42                	ld	s6,16(sp)
    80001892:	6ba2                	ld	s7,8(sp)
    80001894:	6c02                	ld	s8,0(sp)
    80001896:	6161                	addi	sp,sp,80
    80001898:	8082                	ret

000000008000189a <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    8000189a:	caa5                	beqz	a3,8000190a <copyin+0x70>
{
    8000189c:	715d                	addi	sp,sp,-80
    8000189e:	e486                	sd	ra,72(sp)
    800018a0:	e0a2                	sd	s0,64(sp)
    800018a2:	fc26                	sd	s1,56(sp)
    800018a4:	f84a                	sd	s2,48(sp)
    800018a6:	f44e                	sd	s3,40(sp)
    800018a8:	f052                	sd	s4,32(sp)
    800018aa:	ec56                	sd	s5,24(sp)
    800018ac:	e85a                	sd	s6,16(sp)
    800018ae:	e45e                	sd	s7,8(sp)
    800018b0:	e062                	sd	s8,0(sp)
    800018b2:	0880                	addi	s0,sp,80
    800018b4:	8b2a                	mv	s6,a0
    800018b6:	8a2e                	mv	s4,a1
    800018b8:	8c32                	mv	s8,a2
    800018ba:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    800018bc:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    800018be:	6a85                	lui	s5,0x1
    800018c0:	a01d                	j	800018e6 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    800018c2:	018505b3          	add	a1,a0,s8
    800018c6:	0004861b          	sext.w	a2,s1
    800018ca:	412585b3          	sub	a1,a1,s2
    800018ce:	8552                	mv	a0,s4
    800018d0:	fffff097          	auipc	ra,0xfffff
    800018d4:	504080e7          	jalr	1284(ra) # 80000dd4 <memmove>

    len -= n;
    800018d8:	409989b3          	sub	s3,s3,s1
    dst += n;
    800018dc:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    800018de:	01590c33          	add	s8,s2,s5
  while(len > 0){
    800018e2:	02098263          	beqz	s3,80001906 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    800018e6:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    800018ea:	85ca                	mv	a1,s2
    800018ec:	855a                	mv	a0,s6
    800018ee:	00000097          	auipc	ra,0x0
    800018f2:	814080e7          	jalr	-2028(ra) # 80001102 <walkaddr>
    if(pa0 == 0)
    800018f6:	cd01                	beqz	a0,8000190e <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    800018f8:	418904b3          	sub	s1,s2,s8
    800018fc:	94d6                	add	s1,s1,s5
    if(n > len)
    800018fe:	fc99f2e3          	bgeu	s3,s1,800018c2 <copyin+0x28>
    80001902:	84ce                	mv	s1,s3
    80001904:	bf7d                	j	800018c2 <copyin+0x28>
  }
  return 0;
    80001906:	4501                	li	a0,0
    80001908:	a021                	j	80001910 <copyin+0x76>
    8000190a:	4501                	li	a0,0
}
    8000190c:	8082                	ret
      return -1;
    8000190e:	557d                	li	a0,-1
}
    80001910:	60a6                	ld	ra,72(sp)
    80001912:	6406                	ld	s0,64(sp)
    80001914:	74e2                	ld	s1,56(sp)
    80001916:	7942                	ld	s2,48(sp)
    80001918:	79a2                	ld	s3,40(sp)
    8000191a:	7a02                	ld	s4,32(sp)
    8000191c:	6ae2                	ld	s5,24(sp)
    8000191e:	6b42                	ld	s6,16(sp)
    80001920:	6ba2                	ld	s7,8(sp)
    80001922:	6c02                	ld	s8,0(sp)
    80001924:	6161                	addi	sp,sp,80
    80001926:	8082                	ret

0000000080001928 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80001928:	c6c5                	beqz	a3,800019d0 <copyinstr+0xa8>
{
    8000192a:	715d                	addi	sp,sp,-80
    8000192c:	e486                	sd	ra,72(sp)
    8000192e:	e0a2                	sd	s0,64(sp)
    80001930:	fc26                	sd	s1,56(sp)
    80001932:	f84a                	sd	s2,48(sp)
    80001934:	f44e                	sd	s3,40(sp)
    80001936:	f052                	sd	s4,32(sp)
    80001938:	ec56                	sd	s5,24(sp)
    8000193a:	e85a                	sd	s6,16(sp)
    8000193c:	e45e                	sd	s7,8(sp)
    8000193e:	0880                	addi	s0,sp,80
    80001940:	8a2a                	mv	s4,a0
    80001942:	8b2e                	mv	s6,a1
    80001944:	8bb2                	mv	s7,a2
    80001946:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80001948:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    8000194a:	6985                	lui	s3,0x1
    8000194c:	a035                	j	80001978 <copyinstr+0x50>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    8000194e:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80001952:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80001954:	0017b793          	seqz	a5,a5
    80001958:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    8000195c:	60a6                	ld	ra,72(sp)
    8000195e:	6406                	ld	s0,64(sp)
    80001960:	74e2                	ld	s1,56(sp)
    80001962:	7942                	ld	s2,48(sp)
    80001964:	79a2                	ld	s3,40(sp)
    80001966:	7a02                	ld	s4,32(sp)
    80001968:	6ae2                	ld	s5,24(sp)
    8000196a:	6b42                	ld	s6,16(sp)
    8000196c:	6ba2                	ld	s7,8(sp)
    8000196e:	6161                	addi	sp,sp,80
    80001970:	8082                	ret
    srcva = va0 + PGSIZE;
    80001972:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80001976:	c8a9                	beqz	s1,800019c8 <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    80001978:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    8000197c:	85ca                	mv	a1,s2
    8000197e:	8552                	mv	a0,s4
    80001980:	fffff097          	auipc	ra,0xfffff
    80001984:	782080e7          	jalr	1922(ra) # 80001102 <walkaddr>
    if(pa0 == 0)
    80001988:	c131                	beqz	a0,800019cc <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    8000198a:	41790833          	sub	a6,s2,s7
    8000198e:	984e                	add	a6,a6,s3
    if(n > max)
    80001990:	0104f363          	bgeu	s1,a6,80001996 <copyinstr+0x6e>
    80001994:	8826                	mv	a6,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80001996:	955e                	add	a0,a0,s7
    80001998:	41250533          	sub	a0,a0,s2
    while(n > 0){
    8000199c:	fc080be3          	beqz	a6,80001972 <copyinstr+0x4a>
    800019a0:	985a                	add	a6,a6,s6
    800019a2:	87da                	mv	a5,s6
      if(*p == '\0'){
    800019a4:	41650633          	sub	a2,a0,s6
    800019a8:	14fd                	addi	s1,s1,-1
    800019aa:	9b26                	add	s6,s6,s1
    800019ac:	00f60733          	add	a4,a2,a5
    800019b0:	00074703          	lbu	a4,0(a4)
    800019b4:	df49                	beqz	a4,8000194e <copyinstr+0x26>
        *dst = *p;
    800019b6:	00e78023          	sb	a4,0(a5)
      --max;
    800019ba:	40fb04b3          	sub	s1,s6,a5
      dst++;
    800019be:	0785                	addi	a5,a5,1
    while(n > 0){
    800019c0:	ff0796e3          	bne	a5,a6,800019ac <copyinstr+0x84>
      dst++;
    800019c4:	8b42                	mv	s6,a6
    800019c6:	b775                	j	80001972 <copyinstr+0x4a>
    800019c8:	4781                	li	a5,0
    800019ca:	b769                	j	80001954 <copyinstr+0x2c>
      return -1;
    800019cc:	557d                	li	a0,-1
    800019ce:	b779                	j	8000195c <copyinstr+0x34>
  int got_null = 0;
    800019d0:	4781                	li	a5,0
  if(got_null){
    800019d2:	0017b793          	seqz	a5,a5
    800019d6:	40f00533          	neg	a0,a5
}
    800019da:	8082                	ret

00000000800019dc <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    800019dc:	7139                	addi	sp,sp,-64
    800019de:	fc06                	sd	ra,56(sp)
    800019e0:	f822                	sd	s0,48(sp)
    800019e2:	f426                	sd	s1,40(sp)
    800019e4:	f04a                	sd	s2,32(sp)
    800019e6:	ec4e                	sd	s3,24(sp)
    800019e8:	e852                	sd	s4,16(sp)
    800019ea:	e456                	sd	s5,8(sp)
    800019ec:	e05a                	sd	s6,0(sp)
    800019ee:	0080                	addi	s0,sp,64
    800019f0:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    800019f2:	00011497          	auipc	s1,0x11
    800019f6:	84e48493          	addi	s1,s1,-1970 # 80012240 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    800019fa:	8b26                	mv	s6,s1
    800019fc:	00007a97          	auipc	s5,0x7
    80001a00:	604a8a93          	addi	s5,s5,1540 # 80009000 <etext>
    80001a04:	04000937          	lui	s2,0x4000
    80001a08:	197d                	addi	s2,s2,-1
    80001a0a:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80001a0c:	00017a17          	auipc	s4,0x17
    80001a10:	434a0a13          	addi	s4,s4,1076 # 80018e40 <tickslock>
    char *pa = kalloc();
    80001a14:	fffff097          	auipc	ra,0xfffff
    80001a18:	178080e7          	jalr	376(ra) # 80000b8c <kalloc>
    80001a1c:	862a                	mv	a2,a0
    if(pa == 0)
    80001a1e:	c131                	beqz	a0,80001a62 <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80001a20:	416485b3          	sub	a1,s1,s6
    80001a24:	8591                	srai	a1,a1,0x4
    80001a26:	000ab783          	ld	a5,0(s5)
    80001a2a:	02f585b3          	mul	a1,a1,a5
    80001a2e:	2585                	addiw	a1,a1,1
    80001a30:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80001a34:	4719                	li	a4,6
    80001a36:	6685                	lui	a3,0x1
    80001a38:	40b905b3          	sub	a1,s2,a1
    80001a3c:	854e                	mv	a0,s3
    80001a3e:	fffff097          	auipc	ra,0xfffff
    80001a42:	7a6080e7          	jalr	1958(ra) # 800011e4 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001a46:	1b048493          	addi	s1,s1,432
    80001a4a:	fd4495e3          	bne	s1,s4,80001a14 <proc_mapstacks+0x38>
  }
}
    80001a4e:	70e2                	ld	ra,56(sp)
    80001a50:	7442                	ld	s0,48(sp)
    80001a52:	74a2                	ld	s1,40(sp)
    80001a54:	7902                	ld	s2,32(sp)
    80001a56:	69e2                	ld	s3,24(sp)
    80001a58:	6a42                	ld	s4,16(sp)
    80001a5a:	6aa2                	ld	s5,8(sp)
    80001a5c:	6b02                	ld	s6,0(sp)
    80001a5e:	6121                	addi	sp,sp,64
    80001a60:	8082                	ret
      panic("kalloc");
    80001a62:	00007517          	auipc	a0,0x7
    80001a66:	79650513          	addi	a0,a0,1942 # 800091f8 <digits+0x198>
    80001a6a:	fffff097          	auipc	ra,0xfffff
    80001a6e:	ad2080e7          	jalr	-1326(ra) # 8000053c <panic>

0000000080001a72 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80001a72:	7139                	addi	sp,sp,-64
    80001a74:	fc06                	sd	ra,56(sp)
    80001a76:	f822                	sd	s0,48(sp)
    80001a78:	f426                	sd	s1,40(sp)
    80001a7a:	f04a                	sd	s2,32(sp)
    80001a7c:	ec4e                	sd	s3,24(sp)
    80001a7e:	e852                	sd	s4,16(sp)
    80001a80:	e456                	sd	s5,8(sp)
    80001a82:	e05a                	sd	s6,0(sp)
    80001a84:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80001a86:	00007597          	auipc	a1,0x7
    80001a8a:	77a58593          	addi	a1,a1,1914 # 80009200 <digits+0x1a0>
    80001a8e:	00010517          	auipc	a0,0x10
    80001a92:	38250513          	addi	a0,a0,898 # 80011e10 <pid_lock>
    80001a96:	fffff097          	auipc	ra,0xfffff
    80001a9a:	156080e7          	jalr	342(ra) # 80000bec <initlock>
  initlock(&wait_lock, "wait_lock");
    80001a9e:	00007597          	auipc	a1,0x7
    80001aa2:	76a58593          	addi	a1,a1,1898 # 80009208 <digits+0x1a8>
    80001aa6:	00010517          	auipc	a0,0x10
    80001aaa:	38250513          	addi	a0,a0,898 # 80011e28 <wait_lock>
    80001aae:	fffff097          	auipc	ra,0xfffff
    80001ab2:	13e080e7          	jalr	318(ra) # 80000bec <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001ab6:	00010497          	auipc	s1,0x10
    80001aba:	78a48493          	addi	s1,s1,1930 # 80012240 <proc>
      initlock(&p->lock, "proc");
    80001abe:	00007b17          	auipc	s6,0x7
    80001ac2:	75ab0b13          	addi	s6,s6,1882 # 80009218 <digits+0x1b8>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80001ac6:	8aa6                	mv	s5,s1
    80001ac8:	00007a17          	auipc	s4,0x7
    80001acc:	538a0a13          	addi	s4,s4,1336 # 80009000 <etext>
    80001ad0:	04000937          	lui	s2,0x4000
    80001ad4:	197d                	addi	s2,s2,-1
    80001ad6:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80001ad8:	00017997          	auipc	s3,0x17
    80001adc:	36898993          	addi	s3,s3,872 # 80018e40 <tickslock>
      initlock(&p->lock, "proc");
    80001ae0:	85da                	mv	a1,s6
    80001ae2:	8526                	mv	a0,s1
    80001ae4:	fffff097          	auipc	ra,0xfffff
    80001ae8:	108080e7          	jalr	264(ra) # 80000bec <initlock>
      p->state = UNUSED;
    80001aec:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    80001af0:	415487b3          	sub	a5,s1,s5
    80001af4:	8791                	srai	a5,a5,0x4
    80001af6:	000a3703          	ld	a4,0(s4)
    80001afa:	02e787b3          	mul	a5,a5,a4
    80001afe:	2785                	addiw	a5,a5,1
    80001b00:	00d7979b          	slliw	a5,a5,0xd
    80001b04:	40f907b3          	sub	a5,s2,a5
    80001b08:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80001b0a:	1b048493          	addi	s1,s1,432
    80001b0e:	fd3499e3          	bne	s1,s3,80001ae0 <procinit+0x6e>
  }
}
    80001b12:	70e2                	ld	ra,56(sp)
    80001b14:	7442                	ld	s0,48(sp)
    80001b16:	74a2                	ld	s1,40(sp)
    80001b18:	7902                	ld	s2,32(sp)
    80001b1a:	69e2                	ld	s3,24(sp)
    80001b1c:	6a42                	ld	s4,16(sp)
    80001b1e:	6aa2                	ld	s5,8(sp)
    80001b20:	6b02                	ld	s6,0(sp)
    80001b22:	6121                	addi	sp,sp,64
    80001b24:	8082                	ret

0000000080001b26 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80001b26:	1141                	addi	sp,sp,-16
    80001b28:	e422                	sd	s0,8(sp)
    80001b2a:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80001b2c:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80001b2e:	2501                	sext.w	a0,a0
    80001b30:	6422                	ld	s0,8(sp)
    80001b32:	0141                	addi	sp,sp,16
    80001b34:	8082                	ret

0000000080001b36 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80001b36:	1141                	addi	sp,sp,-16
    80001b38:	e422                	sd	s0,8(sp)
    80001b3a:	0800                	addi	s0,sp,16
    80001b3c:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80001b3e:	2781                	sext.w	a5,a5
    80001b40:	079e                	slli	a5,a5,0x7
  return c;
}
    80001b42:	00010517          	auipc	a0,0x10
    80001b46:	2fe50513          	addi	a0,a0,766 # 80011e40 <cpus>
    80001b4a:	953e                	add	a0,a0,a5
    80001b4c:	6422                	ld	s0,8(sp)
    80001b4e:	0141                	addi	sp,sp,16
    80001b50:	8082                	ret

0000000080001b52 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80001b52:	1101                	addi	sp,sp,-32
    80001b54:	ec06                	sd	ra,24(sp)
    80001b56:	e822                	sd	s0,16(sp)
    80001b58:	e426                	sd	s1,8(sp)
    80001b5a:	1000                	addi	s0,sp,32
  push_off();
    80001b5c:	fffff097          	auipc	ra,0xfffff
    80001b60:	0d4080e7          	jalr	212(ra) # 80000c30 <push_off>
    80001b64:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80001b66:	2781                	sext.w	a5,a5
    80001b68:	079e                	slli	a5,a5,0x7
    80001b6a:	00010717          	auipc	a4,0x10
    80001b6e:	2a670713          	addi	a4,a4,678 # 80011e10 <pid_lock>
    80001b72:	97ba                	add	a5,a5,a4
    80001b74:	7b84                	ld	s1,48(a5)
  pop_off();
    80001b76:	fffff097          	auipc	ra,0xfffff
    80001b7a:	15a080e7          	jalr	346(ra) # 80000cd0 <pop_off>
  return p;
}
    80001b7e:	8526                	mv	a0,s1
    80001b80:	60e2                	ld	ra,24(sp)
    80001b82:	6442                	ld	s0,16(sp)
    80001b84:	64a2                	ld	s1,8(sp)
    80001b86:	6105                	addi	sp,sp,32
    80001b88:	8082                	ret

0000000080001b8a <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80001b8a:	1141                	addi	sp,sp,-16
    80001b8c:	e406                	sd	ra,8(sp)
    80001b8e:	e022                	sd	s0,0(sp)
    80001b90:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80001b92:	00000097          	auipc	ra,0x0
    80001b96:	fc0080e7          	jalr	-64(ra) # 80001b52 <myproc>
    80001b9a:	fffff097          	auipc	ra,0xfffff
    80001b9e:	196080e7          	jalr	406(ra) # 80000d30 <release>

  if (first) {
    80001ba2:	00008797          	auipc	a5,0x8
    80001ba6:	f5e7a783          	lw	a5,-162(a5) # 80009b00 <first.1>
    80001baa:	eb89                	bnez	a5,80001bbc <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80001bac:	00001097          	auipc	ra,0x1
    80001bb0:	690080e7          	jalr	1680(ra) # 8000323c <usertrapret>
}
    80001bb4:	60a2                	ld	ra,8(sp)
    80001bb6:	6402                	ld	s0,0(sp)
    80001bb8:	0141                	addi	sp,sp,16
    80001bba:	8082                	ret
    first = 0;
    80001bbc:	00008797          	auipc	a5,0x8
    80001bc0:	f407a223          	sw	zero,-188(a5) # 80009b00 <first.1>
    fsinit(ROOTDEV);
    80001bc4:	4505                	li	a0,1
    80001bc6:	00002097          	auipc	ra,0x2
    80001bca:	6c0080e7          	jalr	1728(ra) # 80004286 <fsinit>
    80001bce:	bff9                	j	80001bac <forkret+0x22>

0000000080001bd0 <allocpid>:
{
    80001bd0:	1101                	addi	sp,sp,-32
    80001bd2:	ec06                	sd	ra,24(sp)
    80001bd4:	e822                	sd	s0,16(sp)
    80001bd6:	e426                	sd	s1,8(sp)
    80001bd8:	e04a                	sd	s2,0(sp)
    80001bda:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80001bdc:	00010917          	auipc	s2,0x10
    80001be0:	23490913          	addi	s2,s2,564 # 80011e10 <pid_lock>
    80001be4:	854a                	mv	a0,s2
    80001be6:	fffff097          	auipc	ra,0xfffff
    80001bea:	096080e7          	jalr	150(ra) # 80000c7c <acquire>
  pid = nextpid;
    80001bee:	00008797          	auipc	a5,0x8
    80001bf2:	f1678793          	addi	a5,a5,-234 # 80009b04 <nextpid>
    80001bf6:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80001bf8:	0014871b          	addiw	a4,s1,1
    80001bfc:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80001bfe:	854a                	mv	a0,s2
    80001c00:	fffff097          	auipc	ra,0xfffff
    80001c04:	130080e7          	jalr	304(ra) # 80000d30 <release>
}
    80001c08:	8526                	mv	a0,s1
    80001c0a:	60e2                	ld	ra,24(sp)
    80001c0c:	6442                	ld	s0,16(sp)
    80001c0e:	64a2                	ld	s1,8(sp)
    80001c10:	6902                	ld	s2,0(sp)
    80001c12:	6105                	addi	sp,sp,32
    80001c14:	8082                	ret

0000000080001c16 <proc_pagetable>:
{
    80001c16:	1101                	addi	sp,sp,-32
    80001c18:	ec06                	sd	ra,24(sp)
    80001c1a:	e822                	sd	s0,16(sp)
    80001c1c:	e426                	sd	s1,8(sp)
    80001c1e:	e04a                	sd	s2,0(sp)
    80001c20:	1000                	addi	s0,sp,32
    80001c22:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001c24:	fffff097          	auipc	ra,0xfffff
    80001c28:	7aa080e7          	jalr	1962(ra) # 800013ce <uvmcreate>
    80001c2c:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001c2e:	c121                	beqz	a0,80001c6e <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80001c30:	4729                	li	a4,10
    80001c32:	00006697          	auipc	a3,0x6
    80001c36:	3ce68693          	addi	a3,a3,974 # 80008000 <_trampoline>
    80001c3a:	6605                	lui	a2,0x1
    80001c3c:	040005b7          	lui	a1,0x4000
    80001c40:	15fd                	addi	a1,a1,-1
    80001c42:	05b2                	slli	a1,a1,0xc
    80001c44:	fffff097          	auipc	ra,0xfffff
    80001c48:	500080e7          	jalr	1280(ra) # 80001144 <mappages>
    80001c4c:	02054863          	bltz	a0,80001c7c <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80001c50:	4719                	li	a4,6
    80001c52:	06093683          	ld	a3,96(s2)
    80001c56:	6605                	lui	a2,0x1
    80001c58:	020005b7          	lui	a1,0x2000
    80001c5c:	15fd                	addi	a1,a1,-1
    80001c5e:	05b6                	slli	a1,a1,0xd
    80001c60:	8526                	mv	a0,s1
    80001c62:	fffff097          	auipc	ra,0xfffff
    80001c66:	4e2080e7          	jalr	1250(ra) # 80001144 <mappages>
    80001c6a:	02054163          	bltz	a0,80001c8c <proc_pagetable+0x76>
}
    80001c6e:	8526                	mv	a0,s1
    80001c70:	60e2                	ld	ra,24(sp)
    80001c72:	6442                	ld	s0,16(sp)
    80001c74:	64a2                	ld	s1,8(sp)
    80001c76:	6902                	ld	s2,0(sp)
    80001c78:	6105                	addi	sp,sp,32
    80001c7a:	8082                	ret
    uvmfree(pagetable, 0);
    80001c7c:	4581                	li	a1,0
    80001c7e:	8526                	mv	a0,s1
    80001c80:	00000097          	auipc	ra,0x0
    80001c84:	974080e7          	jalr	-1676(ra) # 800015f4 <uvmfree>
    return 0;
    80001c88:	4481                	li	s1,0
    80001c8a:	b7d5                	j	80001c6e <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001c8c:	4681                	li	a3,0
    80001c8e:	4605                	li	a2,1
    80001c90:	040005b7          	lui	a1,0x4000
    80001c94:	15fd                	addi	a1,a1,-1
    80001c96:	05b2                	slli	a1,a1,0xc
    80001c98:	8526                	mv	a0,s1
    80001c9a:	fffff097          	auipc	ra,0xfffff
    80001c9e:	670080e7          	jalr	1648(ra) # 8000130a <uvmunmap>
    uvmfree(pagetable, 0);
    80001ca2:	4581                	li	a1,0
    80001ca4:	8526                	mv	a0,s1
    80001ca6:	00000097          	auipc	ra,0x0
    80001caa:	94e080e7          	jalr	-1714(ra) # 800015f4 <uvmfree>
    return 0;
    80001cae:	4481                	li	s1,0
    80001cb0:	bf7d                	j	80001c6e <proc_pagetable+0x58>

0000000080001cb2 <proc_freepagetable>:
{
    80001cb2:	1101                	addi	sp,sp,-32
    80001cb4:	ec06                	sd	ra,24(sp)
    80001cb6:	e822                	sd	s0,16(sp)
    80001cb8:	e426                	sd	s1,8(sp)
    80001cba:	e04a                	sd	s2,0(sp)
    80001cbc:	1000                	addi	s0,sp,32
    80001cbe:	84aa                	mv	s1,a0
    80001cc0:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001cc2:	4681                	li	a3,0
    80001cc4:	4605                	li	a2,1
    80001cc6:	040005b7          	lui	a1,0x4000
    80001cca:	15fd                	addi	a1,a1,-1
    80001ccc:	05b2                	slli	a1,a1,0xc
    80001cce:	fffff097          	auipc	ra,0xfffff
    80001cd2:	63c080e7          	jalr	1596(ra) # 8000130a <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001cd6:	4681                	li	a3,0
    80001cd8:	4605                	li	a2,1
    80001cda:	020005b7          	lui	a1,0x2000
    80001cde:	15fd                	addi	a1,a1,-1
    80001ce0:	05b6                	slli	a1,a1,0xd
    80001ce2:	8526                	mv	a0,s1
    80001ce4:	fffff097          	auipc	ra,0xfffff
    80001ce8:	626080e7          	jalr	1574(ra) # 8000130a <uvmunmap>
  uvmfree(pagetable, sz);
    80001cec:	85ca                	mv	a1,s2
    80001cee:	8526                	mv	a0,s1
    80001cf0:	00000097          	auipc	ra,0x0
    80001cf4:	904080e7          	jalr	-1788(ra) # 800015f4 <uvmfree>
}
    80001cf8:	60e2                	ld	ra,24(sp)
    80001cfa:	6442                	ld	s0,16(sp)
    80001cfc:	64a2                	ld	s1,8(sp)
    80001cfe:	6902                	ld	s2,0(sp)
    80001d00:	6105                	addi	sp,sp,32
    80001d02:	8082                	ret

0000000080001d04 <freeproc>:
{
    80001d04:	1101                	addi	sp,sp,-32
    80001d06:	ec06                	sd	ra,24(sp)
    80001d08:	e822                	sd	s0,16(sp)
    80001d0a:	e426                	sd	s1,8(sp)
    80001d0c:	1000                	addi	s0,sp,32
    80001d0e:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001d10:	7128                	ld	a0,96(a0)
    80001d12:	c509                	beqz	a0,80001d1c <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001d14:	fffff097          	auipc	ra,0xfffff
    80001d18:	d7c080e7          	jalr	-644(ra) # 80000a90 <kfree>
  p->trapframe = 0;
    80001d1c:	0604b023          	sd	zero,96(s1)
  if(p->pagetable) 
    80001d20:	6ca8                	ld	a0,88(s1)
    80001d22:	c511                	beqz	a0,80001d2e <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001d24:	68ac                	ld	a1,80(s1)
    80001d26:	00000097          	auipc	ra,0x0
    80001d2a:	f8c080e7          	jalr	-116(ra) # 80001cb2 <proc_freepagetable>
  p->pagetable = 0;
    80001d2e:	0404bc23          	sd	zero,88(s1)
  p->sz = 0;
    80001d32:	0404b823          	sd	zero,80(s1)
  p->pid = 0;
    80001d36:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001d3a:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80001d3e:	16048023          	sb	zero,352(s1)
  p->chan = 0;
    80001d42:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001d46:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001d4a:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001d4e:	0004ac23          	sw	zero,24(s1)
}
    80001d52:	60e2                	ld	ra,24(sp)
    80001d54:	6442                	ld	s0,16(sp)
    80001d56:	64a2                	ld	s1,8(sp)
    80001d58:	6105                	addi	sp,sp,32
    80001d5a:	8082                	ret

0000000080001d5c <allocproc>:
{
    80001d5c:	1101                	addi	sp,sp,-32
    80001d5e:	ec06                	sd	ra,24(sp)
    80001d60:	e822                	sd	s0,16(sp)
    80001d62:	e426                	sd	s1,8(sp)
    80001d64:	e04a                	sd	s2,0(sp)
    80001d66:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001d68:	00010497          	auipc	s1,0x10
    80001d6c:	4d848493          	addi	s1,s1,1240 # 80012240 <proc>
    80001d70:	00017917          	auipc	s2,0x17
    80001d74:	0d090913          	addi	s2,s2,208 # 80018e40 <tickslock>
    acquire(&p->lock);
    80001d78:	8526                	mv	a0,s1
    80001d7a:	fffff097          	auipc	ra,0xfffff
    80001d7e:	f02080e7          	jalr	-254(ra) # 80000c7c <acquire>
    if(p->state == UNUSED) {
    80001d82:	4c9c                	lw	a5,24(s1)
    80001d84:	cf81                	beqz	a5,80001d9c <allocproc+0x40>
      release(&p->lock);
    80001d86:	8526                	mv	a0,s1
    80001d88:	fffff097          	auipc	ra,0xfffff
    80001d8c:	fa8080e7          	jalr	-88(ra) # 80000d30 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001d90:	1b048493          	addi	s1,s1,432
    80001d94:	ff2492e3          	bne	s1,s2,80001d78 <allocproc+0x1c>
  return 0;
    80001d98:	4481                	li	s1,0
    80001d9a:	a8b5                	j	80001e16 <allocproc+0xba>
  p->pid = allocpid();
    80001d9c:	00000097          	auipc	ra,0x0
    80001da0:	e34080e7          	jalr	-460(ra) # 80001bd0 <allocpid>
    80001da4:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001da6:	4785                	li	a5,1
    80001da8:	cc9c                	sw	a5,24(s1)
  p->creation_time = ticks; 
    80001daa:	00008797          	auipc	a5,0x8
    80001dae:	dfe7e783          	lwu	a5,-514(a5) # 80009ba8 <ticks>
    80001db2:	16f4b823          	sd	a5,368(s1)
  p->priority = DEF_PRIORITY; 
    80001db6:	47a9                	li	a5,10
    80001db8:	18f4b823          	sd	a5,400(s1)
  p->num_times_scheduled = 0;  
    80001dbc:	1a04b423          	sd	zero,424(s1)
  p->start_time = 0; 
    80001dc0:	1604bc23          	sd	zero,376(s1)
  p->run_time = 0; 
    80001dc4:	1804bc23          	sd	zero,408(s1)
  p->sleep_time = 0;
    80001dc8:	1a04b023          	sd	zero,416(s1)
  p->total_time = 0; 
    80001dcc:	1804b423          	sd	zero,392(s1)
  p->end_time = 0; 
    80001dd0:	1804b023          	sd	zero,384(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001dd4:	fffff097          	auipc	ra,0xfffff
    80001dd8:	db8080e7          	jalr	-584(ra) # 80000b8c <kalloc>
    80001ddc:	892a                	mv	s2,a0
    80001dde:	f0a8                	sd	a0,96(s1)
    80001de0:	c131                	beqz	a0,80001e24 <allocproc+0xc8>
  p->pagetable = proc_pagetable(p);
    80001de2:	8526                	mv	a0,s1
    80001de4:	00000097          	auipc	ra,0x0
    80001de8:	e32080e7          	jalr	-462(ra) # 80001c16 <proc_pagetable>
    80001dec:	892a                	mv	s2,a0
    80001dee:	eca8                	sd	a0,88(s1)
  if(p->pagetable == 0){
    80001df0:	c531                	beqz	a0,80001e3c <allocproc+0xe0>
  memset(&p->context, 0, sizeof(p->context));
    80001df2:	07000613          	li	a2,112
    80001df6:	4581                	li	a1,0
    80001df8:	06848513          	addi	a0,s1,104
    80001dfc:	fffff097          	auipc	ra,0xfffff
    80001e00:	f7c080e7          	jalr	-132(ra) # 80000d78 <memset>
  p->context.ra = (uint64)forkret;
    80001e04:	00000797          	auipc	a5,0x0
    80001e08:	d8678793          	addi	a5,a5,-634 # 80001b8a <forkret>
    80001e0c:	f4bc                	sd	a5,104(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001e0e:	60bc                	ld	a5,64(s1)
    80001e10:	6705                	lui	a4,0x1
    80001e12:	97ba                	add	a5,a5,a4
    80001e14:	f8bc                	sd	a5,112(s1)
}
    80001e16:	8526                	mv	a0,s1
    80001e18:	60e2                	ld	ra,24(sp)
    80001e1a:	6442                	ld	s0,16(sp)
    80001e1c:	64a2                	ld	s1,8(sp)
    80001e1e:	6902                	ld	s2,0(sp)
    80001e20:	6105                	addi	sp,sp,32
    80001e22:	8082                	ret
    freeproc(p);
    80001e24:	8526                	mv	a0,s1
    80001e26:	00000097          	auipc	ra,0x0
    80001e2a:	ede080e7          	jalr	-290(ra) # 80001d04 <freeproc>
    release(&p->lock);
    80001e2e:	8526                	mv	a0,s1
    80001e30:	fffff097          	auipc	ra,0xfffff
    80001e34:	f00080e7          	jalr	-256(ra) # 80000d30 <release>
    return 0;
    80001e38:	84ca                	mv	s1,s2
    80001e3a:	bff1                	j	80001e16 <allocproc+0xba>
    freeproc(p);
    80001e3c:	8526                	mv	a0,s1
    80001e3e:	00000097          	auipc	ra,0x0
    80001e42:	ec6080e7          	jalr	-314(ra) # 80001d04 <freeproc>
    release(&p->lock);
    80001e46:	8526                	mv	a0,s1
    80001e48:	fffff097          	auipc	ra,0xfffff
    80001e4c:	ee8080e7          	jalr	-280(ra) # 80000d30 <release>
    return 0;
    80001e50:	84ca                	mv	s1,s2
    80001e52:	b7d1                	j	80001e16 <allocproc+0xba>

0000000080001e54 <userinit>:
{
    80001e54:	1101                	addi	sp,sp,-32
    80001e56:	ec06                	sd	ra,24(sp)
    80001e58:	e822                	sd	s0,16(sp)
    80001e5a:	e426                	sd	s1,8(sp)
    80001e5c:	1000                	addi	s0,sp,32
  p = allocproc();
    80001e5e:	00000097          	auipc	ra,0x0
    80001e62:	efe080e7          	jalr	-258(ra) # 80001d5c <allocproc>
    80001e66:	84aa                	mv	s1,a0
  initproc = p;
    80001e68:	00008797          	auipc	a5,0x8
    80001e6c:	d2a7bc23          	sd	a0,-712(a5) # 80009ba0 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    80001e70:	03400613          	li	a2,52
    80001e74:	00008597          	auipc	a1,0x8
    80001e78:	c9c58593          	addi	a1,a1,-868 # 80009b10 <initcode>
    80001e7c:	6d28                	ld	a0,88(a0)
    80001e7e:	fffff097          	auipc	ra,0xfffff
    80001e82:	57e080e7          	jalr	1406(ra) # 800013fc <uvmfirst>
  p->sz = PGSIZE;
    80001e86:	6785                	lui	a5,0x1
    80001e88:	e8bc                	sd	a5,80(s1)
  p->trapframe->epc = PGSIZE*3;             // user program counter
    80001e8a:	70bc                	ld	a5,96(s1)
    80001e8c:	670d                	lui	a4,0x3
    80001e8e:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = USERTOP;               // user stack pointer
    80001e90:	70bc                	ld	a5,96(s1)
    80001e92:	000a0737          	lui	a4,0xa0
    80001e96:	fb98                	sd	a4,48(a5)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001e98:	4641                	li	a2,16
    80001e9a:	00007597          	auipc	a1,0x7
    80001e9e:	38658593          	addi	a1,a1,902 # 80009220 <digits+0x1c0>
    80001ea2:	16048513          	addi	a0,s1,352
    80001ea6:	fffff097          	auipc	ra,0xfffff
    80001eaa:	01c080e7          	jalr	28(ra) # 80000ec2 <safestrcpy>
  p->cwd = namei("/");
    80001eae:	00007517          	auipc	a0,0x7
    80001eb2:	38250513          	addi	a0,a0,898 # 80009230 <digits+0x1d0>
    80001eb6:	00003097          	auipc	ra,0x3
    80001eba:	df2080e7          	jalr	-526(ra) # 80004ca8 <namei>
    80001ebe:	14a4bc23          	sd	a0,344(s1)
  p->state = RUNNABLE;
    80001ec2:	478d                	li	a5,3
    80001ec4:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001ec6:	8526                	mv	a0,s1
    80001ec8:	fffff097          	auipc	ra,0xfffff
    80001ecc:	e68080e7          	jalr	-408(ra) # 80000d30 <release>
}
    80001ed0:	60e2                	ld	ra,24(sp)
    80001ed2:	6442                	ld	s0,16(sp)
    80001ed4:	64a2                	ld	s1,8(sp)
    80001ed6:	6105                	addi	sp,sp,32
    80001ed8:	8082                	ret

0000000080001eda <growproc>:
{
    80001eda:	1101                	addi	sp,sp,-32
    80001edc:	ec06                	sd	ra,24(sp)
    80001ede:	e822                	sd	s0,16(sp)
    80001ee0:	e426                	sd	s1,8(sp)
    80001ee2:	e04a                	sd	s2,0(sp)
    80001ee4:	1000                	addi	s0,sp,32
    80001ee6:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001ee8:	00000097          	auipc	ra,0x0
    80001eec:	c6a080e7          	jalr	-918(ra) # 80001b52 <myproc>
  sz = p->sz;
    80001ef0:	692c                	ld	a1,80(a0)
  if((sz + n + 5*PGSIZE) > (proc->stack_sz))
    80001ef2:	00b48633          	add	a2,s1,a1
    80001ef6:	6795                	lui	a5,0x5
    80001ef8:	97b2                	add	a5,a5,a2
    80001efa:	00010717          	auipc	a4,0x10
    80001efe:	38e73703          	ld	a4,910(a4) # 80012288 <proc+0x48>
    80001f02:	04f76163          	bltu	a4,a5,80001f44 <growproc+0x6a>
    80001f06:	892a                	mv	s2,a0
  if(n > 0){
    80001f08:	00904d63          	bgtz	s1,80001f22 <growproc+0x48>
  } else if(n < 0){
    80001f0c:	0204c563          	bltz	s1,80001f36 <growproc+0x5c>
  p->sz = sz;
    80001f10:	04b93823          	sd	a1,80(s2)
  return 0;
    80001f14:	4501                	li	a0,0
}
    80001f16:	60e2                	ld	ra,24(sp)
    80001f18:	6442                	ld	s0,16(sp)
    80001f1a:	64a2                	ld	s1,8(sp)
    80001f1c:	6902                	ld	s2,0(sp)
    80001f1e:	6105                	addi	sp,sp,32
    80001f20:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001f22:	4691                	li	a3,4
    80001f24:	6d28                	ld	a0,88(a0)
    80001f26:	fffff097          	auipc	ra,0xfffff
    80001f2a:	590080e7          	jalr	1424(ra) # 800014b6 <uvmalloc>
    80001f2e:	85aa                	mv	a1,a0
    80001f30:	f165                	bnez	a0,80001f10 <growproc+0x36>
      return -1;
    80001f32:	557d                	li	a0,-1
    80001f34:	b7cd                	j	80001f16 <growproc+0x3c>
    sz = uvmdealloc(p->pagetable, sz, sz + n); 
    80001f36:	6d28                	ld	a0,88(a0)
    80001f38:	fffff097          	auipc	ra,0xfffff
    80001f3c:	536080e7          	jalr	1334(ra) # 8000146e <uvmdealloc>
    80001f40:	85aa                	mv	a1,a0
    80001f42:	b7f9                	j	80001f10 <growproc+0x36>
      return -1;
    80001f44:	557d                	li	a0,-1
    80001f46:	bfc1                	j	80001f16 <growproc+0x3c>

0000000080001f48 <fork>:
{
    80001f48:	7139                	addi	sp,sp,-64
    80001f4a:	fc06                	sd	ra,56(sp)
    80001f4c:	f822                	sd	s0,48(sp)
    80001f4e:	f426                	sd	s1,40(sp)
    80001f50:	f04a                	sd	s2,32(sp)
    80001f52:	ec4e                	sd	s3,24(sp)
    80001f54:	e852                	sd	s4,16(sp)
    80001f56:	e456                	sd	s5,8(sp)
    80001f58:	0080                	addi	s0,sp,64
  struct proc *p = myproc();  
    80001f5a:	00000097          	auipc	ra,0x0
    80001f5e:	bf8080e7          	jalr	-1032(ra) # 80001b52 <myproc>
    80001f62:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001f64:	00000097          	auipc	ra,0x0
    80001f68:	df8080e7          	jalr	-520(ra) # 80001d5c <allocproc>
    80001f6c:	12050063          	beqz	a0,8000208c <fork+0x144>
    80001f70:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001f72:	050ab603          	ld	a2,80(s5)
    80001f76:	6d2c                	ld	a1,88(a0)
    80001f78:	058ab503          	ld	a0,88(s5)
    80001f7c:	fffff097          	auipc	ra,0xfffff
    80001f80:	6fc080e7          	jalr	1788(ra) # 80001678 <uvmcopy>
    80001f84:	04054c63          	bltz	a0,80001fdc <fork+0x94>
  np->sz = p->sz;
    80001f88:	050ab783          	ld	a5,80(s5)
    80001f8c:	04f9b823          	sd	a5,80(s3)
  np->stack_sz = p->stack_sz;
    80001f90:	048ab783          	ld	a5,72(s5)
    80001f94:	04f9b423          	sd	a5,72(s3)
  *(np->trapframe) = *(p->trapframe);
    80001f98:	060ab683          	ld	a3,96(s5)
    80001f9c:	87b6                	mv	a5,a3
    80001f9e:	0609b703          	ld	a4,96(s3)
    80001fa2:	12068693          	addi	a3,a3,288
    80001fa6:	0007b803          	ld	a6,0(a5) # 5000 <_entry-0x7fffb000>
    80001faa:	6788                	ld	a0,8(a5)
    80001fac:	6b8c                	ld	a1,16(a5)
    80001fae:	6f90                	ld	a2,24(a5)
    80001fb0:	01073023          	sd	a6,0(a4)
    80001fb4:	e708                	sd	a0,8(a4)
    80001fb6:	eb0c                	sd	a1,16(a4)
    80001fb8:	ef10                	sd	a2,24(a4)
    80001fba:	02078793          	addi	a5,a5,32
    80001fbe:	02070713          	addi	a4,a4,32
    80001fc2:	fed792e3          	bne	a5,a3,80001fa6 <fork+0x5e>
  np->trapframe->a0 = 0;
    80001fc6:	0609b783          	ld	a5,96(s3)
    80001fca:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001fce:	0d8a8493          	addi	s1,s5,216
    80001fd2:	0d898913          	addi	s2,s3,216
    80001fd6:	158a8a13          	addi	s4,s5,344
    80001fda:	a00d                	j	80001ffc <fork+0xb4>
    freeproc(np);
    80001fdc:	854e                	mv	a0,s3
    80001fde:	00000097          	auipc	ra,0x0
    80001fe2:	d26080e7          	jalr	-730(ra) # 80001d04 <freeproc>
    release(&np->lock);
    80001fe6:	854e                	mv	a0,s3
    80001fe8:	fffff097          	auipc	ra,0xfffff
    80001fec:	d48080e7          	jalr	-696(ra) # 80000d30 <release>
    return -1;
    80001ff0:	597d                	li	s2,-1
    80001ff2:	a059                	j	80002078 <fork+0x130>
  for(i = 0; i < NOFILE; i++)
    80001ff4:	04a1                	addi	s1,s1,8
    80001ff6:	0921                	addi	s2,s2,8
    80001ff8:	01448b63          	beq	s1,s4,8000200e <fork+0xc6>
    if(p->ofile[i])
    80001ffc:	6088                	ld	a0,0(s1)
    80001ffe:	d97d                	beqz	a0,80001ff4 <fork+0xac>
      np->ofile[i] = filedup(p->ofile[i]);
    80002000:	00003097          	auipc	ra,0x3
    80002004:	33e080e7          	jalr	830(ra) # 8000533e <filedup>
    80002008:	00a93023          	sd	a0,0(s2)
    8000200c:	b7e5                	j	80001ff4 <fork+0xac>
  np->cwd = idup(p->cwd);
    8000200e:	158ab503          	ld	a0,344(s5)
    80002012:	00002097          	auipc	ra,0x2
    80002016:	4b2080e7          	jalr	1202(ra) # 800044c4 <idup>
    8000201a:	14a9bc23          	sd	a0,344(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    8000201e:	4641                	li	a2,16
    80002020:	160a8593          	addi	a1,s5,352
    80002024:	16098513          	addi	a0,s3,352
    80002028:	fffff097          	auipc	ra,0xfffff
    8000202c:	e9a080e7          	jalr	-358(ra) # 80000ec2 <safestrcpy>
  pid = np->pid;
    80002030:	0309a903          	lw	s2,48(s3)
  release(&np->lock);
    80002034:	854e                	mv	a0,s3
    80002036:	fffff097          	auipc	ra,0xfffff
    8000203a:	cfa080e7          	jalr	-774(ra) # 80000d30 <release>
  acquire(&wait_lock);
    8000203e:	00010497          	auipc	s1,0x10
    80002042:	dea48493          	addi	s1,s1,-534 # 80011e28 <wait_lock>
    80002046:	8526                	mv	a0,s1
    80002048:	fffff097          	auipc	ra,0xfffff
    8000204c:	c34080e7          	jalr	-972(ra) # 80000c7c <acquire>
  np->parent = p;
    80002050:	0359bc23          	sd	s5,56(s3)
  release(&wait_lock);
    80002054:	8526                	mv	a0,s1
    80002056:	fffff097          	auipc	ra,0xfffff
    8000205a:	cda080e7          	jalr	-806(ra) # 80000d30 <release>
  acquire(&np->lock);
    8000205e:	854e                	mv	a0,s3
    80002060:	fffff097          	auipc	ra,0xfffff
    80002064:	c1c080e7          	jalr	-996(ra) # 80000c7c <acquire>
  np->state = RUNNABLE;
    80002068:	478d                	li	a5,3
    8000206a:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    8000206e:	854e                	mv	a0,s3
    80002070:	fffff097          	auipc	ra,0xfffff
    80002074:	cc0080e7          	jalr	-832(ra) # 80000d30 <release>
}
    80002078:	854a                	mv	a0,s2
    8000207a:	70e2                	ld	ra,56(sp)
    8000207c:	7442                	ld	s0,48(sp)
    8000207e:	74a2                	ld	s1,40(sp)
    80002080:	7902                	ld	s2,32(sp)
    80002082:	69e2                	ld	s3,24(sp)
    80002084:	6a42                	ld	s4,16(sp)
    80002086:	6aa2                	ld	s5,8(sp)
    80002088:	6121                	addi	sp,sp,64
    8000208a:	8082                	ret
    return -1;
    8000208c:	597d                	li	s2,-1
    8000208e:	b7ed                	j	80002078 <fork+0x130>

0000000080002090 <scheduler>:
{
    80002090:	715d                	addi	sp,sp,-80
    80002092:	e486                	sd	ra,72(sp)
    80002094:	e0a2                	sd	s0,64(sp)
    80002096:	fc26                	sd	s1,56(sp)
    80002098:	f84a                	sd	s2,48(sp)
    8000209a:	f44e                	sd	s3,40(sp)
    8000209c:	f052                	sd	s4,32(sp)
    8000209e:	ec56                	sd	s5,24(sp)
    800020a0:	e85a                	sd	s6,16(sp)
    800020a2:	e45e                	sd	s7,8(sp)
    800020a4:	e062                	sd	s8,0(sp)
    800020a6:	0880                	addi	s0,sp,80
    800020a8:	8792                	mv	a5,tp
  int id = r_tp();
    800020aa:	2781                	sext.w	a5,a5
  c->proc = 0;
    800020ac:	00779a13          	slli	s4,a5,0x7
    800020b0:	00010717          	auipc	a4,0x10
    800020b4:	d6070713          	addi	a4,a4,-672 # 80011e10 <pid_lock>
    800020b8:	9752                	add	a4,a4,s4
    800020ba:	02073823          	sd	zero,48(a4)
          swtch(&c->context, &high->context);
    800020be:	00010717          	auipc	a4,0x10
    800020c2:	d8a70713          	addi	a4,a4,-630 # 80011e48 <cpus+0x8>
    800020c6:	9a3a                	add	s4,s4,a4
    switch(scheduler_type) {
    800020c8:	00008b17          	auipc	s6,0x8
    800020cc:	ad0b0b13          	addi	s6,s6,-1328 # 80009b98 <scheduler_type>
        for (p = proc; p < &proc[NPROC]; p++) {
    800020d0:	00017917          	auipc	s2,0x17
    800020d4:	d7090913          	addi	s2,s2,-656 # 80018e40 <tickslock>
            c->proc = min;
    800020d8:	079e                	slli	a5,a5,0x7
    800020da:	00010997          	auipc	s3,0x10
    800020de:	d3698993          	addi	s3,s3,-714 # 80011e10 <pid_lock>
    800020e2:	99be                	add	s3,s3,a5
            min->start_time = ticks; 
    800020e4:	00008a97          	auipc	s5,0x8
    800020e8:	ac4a8a93          	addi	s5,s5,-1340 # 80009ba8 <ticks>
    800020ec:	a0e5                	j	800021d4 <scheduler+0x144>
          release(&p->lock);
    800020ee:	8526                	mv	a0,s1
    800020f0:	fffff097          	auipc	ra,0xfffff
    800020f4:	c40080e7          	jalr	-960(ra) # 80000d30 <release>
        for(p = proc; p < &proc[NPROC]; p++) {
    800020f8:	1b048493          	addi	s1,s1,432
    800020fc:	0d248c63          	beq	s1,s2,800021d4 <scheduler+0x144>
          acquire(&p->lock);
    80002100:	8526                	mv	a0,s1
    80002102:	fffff097          	auipc	ra,0xfffff
    80002106:	b7a080e7          	jalr	-1158(ra) # 80000c7c <acquire>
          if(p->state == RUNNABLE) {
    8000210a:	4c9c                	lw	a5,24(s1)
    8000210c:	ff7791e3          	bne	a5,s7,800020ee <scheduler+0x5e>
            p->state = RUNNING;
    80002110:	0184ac23          	sw	s8,24(s1)
            c->proc = p;
    80002114:	0299b823          	sd	s1,48(s3)
            p->start_time = ticks; 
    80002118:	000ae783          	lwu	a5,0(s5)
    8000211c:	16f4bc23          	sd	a5,376(s1)
            p->num_times_scheduled++; 
    80002120:	1a84b783          	ld	a5,424(s1)
    80002124:	0785                	addi	a5,a5,1
    80002126:	1af4b423          	sd	a5,424(s1)
            swtch(&c->context, &p->context);
    8000212a:	06848593          	addi	a1,s1,104
    8000212e:	8552                	mv	a0,s4
    80002130:	00001097          	auipc	ra,0x1
    80002134:	062080e7          	jalr	98(ra) # 80003192 <swtch>
            c->proc = 0;
    80002138:	0209b823          	sd	zero,48(s3)
    8000213c:	bf4d                	j	800020ee <scheduler+0x5e>
        struct proc *min = 0;
    8000213e:	4b81                	li	s7,0
        for (p = proc; p < &proc[NPROC]; p++) {
    80002140:	00010497          	auipc	s1,0x10
    80002144:	10048493          	addi	s1,s1,256 # 80012240 <proc>
          if (p->state == RUNNABLE) {
    80002148:	4c0d                	li	s8,3
    8000214a:	a811                	j	8000215e <scheduler+0xce>
          release(&p->lock); 
    8000214c:	8526                	mv	a0,s1
    8000214e:	fffff097          	auipc	ra,0xfffff
    80002152:	be2080e7          	jalr	-1054(ra) # 80000d30 <release>
        for (p = proc; p < &proc[NPROC]; p++) {
    80002156:	1b048493          	addi	s1,s1,432
    8000215a:	03248b63          	beq	s1,s2,80002190 <scheduler+0x100>
          acquire(&p->lock); 
    8000215e:	8526                	mv	a0,s1
    80002160:	fffff097          	auipc	ra,0xfffff
    80002164:	b1c080e7          	jalr	-1252(ra) # 80000c7c <acquire>
          if (p->state == RUNNABLE) {
    80002168:	4c9c                	lw	a5,24(s1)
    8000216a:	ff8791e3          	bne	a5,s8,8000214c <scheduler+0xbc>
            if (!min || p->creation_time < min->creation_time) {
    8000216e:	000b8f63          	beqz	s7,8000218c <scheduler+0xfc>
    80002172:	1704b703          	ld	a4,368(s1)
    80002176:	170bb783          	ld	a5,368(s7) # fffffffffffff170 <end+0xffffffff7ffdaf50>
    8000217a:	fcf779e3          	bgeu	a4,a5,8000214c <scheduler+0xbc>
                release(&min->lock);
    8000217e:	855e                	mv	a0,s7
    80002180:	fffff097          	auipc	ra,0xfffff
    80002184:	bb0080e7          	jalr	-1104(ra) # 80000d30 <release>
    80002188:	8ba6                	mv	s7,s1
    8000218a:	b7f1                	j	80002156 <scheduler+0xc6>
    8000218c:	8ba6                	mv	s7,s1
    8000218e:	b7e1                	j	80002156 <scheduler+0xc6>
        if (min) {
    80002190:	040b8263          	beqz	s7,800021d4 <scheduler+0x144>
            min->state = RUNNING;
    80002194:	4791                	li	a5,4
    80002196:	00fbac23          	sw	a5,24(s7)
            c->proc = min;
    8000219a:	0379b823          	sd	s7,48(s3)
            p->num_times_scheduled++;
    8000219e:	00017717          	auipc	a4,0x17
    800021a2:	0a270713          	addi	a4,a4,162 # 80019240 <bcache+0x3e8>
    800021a6:	da873783          	ld	a5,-600(a4)
    800021aa:	0785                	addi	a5,a5,1
    800021ac:	daf73423          	sd	a5,-600(a4)
            min->start_time = ticks; 
    800021b0:	000ae783          	lwu	a5,0(s5)
    800021b4:	16fbbc23          	sd	a5,376(s7)
            swtch(&c->context, &min->context);
    800021b8:	068b8593          	addi	a1,s7,104
    800021bc:	8552                	mv	a0,s4
    800021be:	00001097          	auipc	ra,0x1
    800021c2:	fd4080e7          	jalr	-44(ra) # 80003192 <swtch>
            c->proc = 0;
    800021c6:	0209b823          	sd	zero,48(s3)
            release(&min->lock);
    800021ca:	855e                	mv	a0,s7
    800021cc:	fffff097          	auipc	ra,0xfffff
    800021d0:	b64080e7          	jalr	-1180(ra) # 80000d30 <release>
    switch(scheduler_type) {
    800021d4:	000b2703          	lw	a4,0(s6)
    800021d8:	4605                	li	a2,1
    800021da:	4689                	li	a3,2
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800021dc:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800021e0:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800021e4:	10079073          	csrw	sstatus,a5
    800021e8:	f4c70be3          	beq	a4,a2,8000213e <scheduler+0xae>
    800021ec:	00d70a63          	beq	a4,a3,80002200 <scheduler+0x170>
    800021f0:	f775                	bnez	a4,800021dc <scheduler+0x14c>
        for(p = proc; p < &proc[NPROC]; p++) {
    800021f2:	00010497          	auipc	s1,0x10
    800021f6:	04e48493          	addi	s1,s1,78 # 80012240 <proc>
          if(p->state == RUNNABLE) {
    800021fa:	4b8d                	li	s7,3
            p->state = RUNNING;
    800021fc:	4c11                	li	s8,4
    800021fe:	b709                	j	80002100 <scheduler+0x70>
        struct proc *high = 0; 
    80002200:	4b81                	li	s7,0
        for (p = proc; p < &proc[NPROC]; p++)
    80002202:	00010497          	auipc	s1,0x10
    80002206:	03e48493          	addi	s1,s1,62 # 80012240 <proc>
          if (p->state == RUNNABLE) {
    8000220a:	4c0d                	li	s8,3
    8000220c:	a811                	j	80002220 <scheduler+0x190>
          release(&p->lock);
    8000220e:	8526                	mv	a0,s1
    80002210:	fffff097          	auipc	ra,0xfffff
    80002214:	b20080e7          	jalr	-1248(ra) # 80000d30 <release>
        for (p = proc; p < &proc[NPROC]; p++)
    80002218:	1b048493          	addi	s1,s1,432
    8000221c:	03248b63          	beq	s1,s2,80002252 <scheduler+0x1c2>
          acquire(&p->lock);
    80002220:	8526                	mv	a0,s1
    80002222:	fffff097          	auipc	ra,0xfffff
    80002226:	a5a080e7          	jalr	-1446(ra) # 80000c7c <acquire>
          if (p->state == RUNNABLE) {
    8000222a:	4c9c                	lw	a5,24(s1)
    8000222c:	ff8791e3          	bne	a5,s8,8000220e <scheduler+0x17e>
            if (!high || high->priority > p->priority) {
    80002230:	000b8f63          	beqz	s7,8000224e <scheduler+0x1be>
    80002234:	190bb703          	ld	a4,400(s7)
    80002238:	1904b783          	ld	a5,400(s1)
    8000223c:	fce7f9e3          	bgeu	a5,a4,8000220e <scheduler+0x17e>
                release(&high->lock);
    80002240:	855e                	mv	a0,s7
    80002242:	fffff097          	auipc	ra,0xfffff
    80002246:	aee080e7          	jalr	-1298(ra) # 80000d30 <release>
    8000224a:	8ba6                	mv	s7,s1
    8000224c:	b7f1                	j	80002218 <scheduler+0x188>
    8000224e:	8ba6                	mv	s7,s1
    80002250:	b7e1                	j	80002218 <scheduler+0x188>
        if (high) {
    80002252:	f80b81e3          	beqz	s7,800021d4 <scheduler+0x144>
          high->num_times_scheduled++;
    80002256:	1a8bb783          	ld	a5,424(s7)
    8000225a:	0785                	addi	a5,a5,1
    8000225c:	1afbb423          	sd	a5,424(s7)
          high->start_time = ticks; 
    80002260:	000ae783          	lwu	a5,0(s5)
    80002264:	16fbbc23          	sd	a5,376(s7)
          high->state = RUNNING;
    80002268:	4791                	li	a5,4
    8000226a:	00fbac23          	sw	a5,24(s7)
          high->run_time = 0;
    8000226e:	180bbc23          	sd	zero,408(s7)
          high->sleep_time = 0;
    80002272:	1a0bb023          	sd	zero,416(s7)
          c->proc = high;
    80002276:	0379b823          	sd	s7,48(s3)
          swtch(&c->context, &high->context);
    8000227a:	068b8593          	addi	a1,s7,104
    8000227e:	8552                	mv	a0,s4
    80002280:	00001097          	auipc	ra,0x1
    80002284:	f12080e7          	jalr	-238(ra) # 80003192 <swtch>
          c->proc = 0;
    80002288:	0209b823          	sd	zero,48(s3)
          release(&high->lock);
    8000228c:	855e                	mv	a0,s7
    8000228e:	fffff097          	auipc	ra,0xfffff
    80002292:	aa2080e7          	jalr	-1374(ra) # 80000d30 <release>
    80002296:	bf3d                	j	800021d4 <scheduler+0x144>

0000000080002298 <sched>:
{
    80002298:	7179                	addi	sp,sp,-48
    8000229a:	f406                	sd	ra,40(sp)
    8000229c:	f022                	sd	s0,32(sp)
    8000229e:	ec26                	sd	s1,24(sp)
    800022a0:	e84a                	sd	s2,16(sp)
    800022a2:	e44e                	sd	s3,8(sp)
    800022a4:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    800022a6:	00000097          	auipc	ra,0x0
    800022aa:	8ac080e7          	jalr	-1876(ra) # 80001b52 <myproc>
    800022ae:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    800022b0:	fffff097          	auipc	ra,0xfffff
    800022b4:	952080e7          	jalr	-1710(ra) # 80000c02 <holding>
    800022b8:	c93d                	beqz	a0,8000232e <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    800022ba:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    800022bc:	2781                	sext.w	a5,a5
    800022be:	079e                	slli	a5,a5,0x7
    800022c0:	00010717          	auipc	a4,0x10
    800022c4:	b5070713          	addi	a4,a4,-1200 # 80011e10 <pid_lock>
    800022c8:	97ba                	add	a5,a5,a4
    800022ca:	0a87a703          	lw	a4,168(a5)
    800022ce:	4785                	li	a5,1
    800022d0:	06f71763          	bne	a4,a5,8000233e <sched+0xa6>
  if(p->state == RUNNING)
    800022d4:	4c98                	lw	a4,24(s1)
    800022d6:	4791                	li	a5,4
    800022d8:	06f70b63          	beq	a4,a5,8000234e <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800022dc:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800022e0:	8b89                	andi	a5,a5,2
  if(intr_get())
    800022e2:	efb5                	bnez	a5,8000235e <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    800022e4:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800022e6:	00010917          	auipc	s2,0x10
    800022ea:	b2a90913          	addi	s2,s2,-1238 # 80011e10 <pid_lock>
    800022ee:	2781                	sext.w	a5,a5
    800022f0:	079e                	slli	a5,a5,0x7
    800022f2:	97ca                	add	a5,a5,s2
    800022f4:	0ac7a983          	lw	s3,172(a5)
    800022f8:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800022fa:	2781                	sext.w	a5,a5
    800022fc:	079e                	slli	a5,a5,0x7
    800022fe:	00010597          	auipc	a1,0x10
    80002302:	b4a58593          	addi	a1,a1,-1206 # 80011e48 <cpus+0x8>
    80002306:	95be                	add	a1,a1,a5
    80002308:	06848513          	addi	a0,s1,104
    8000230c:	00001097          	auipc	ra,0x1
    80002310:	e86080e7          	jalr	-378(ra) # 80003192 <swtch>
    80002314:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80002316:	2781                	sext.w	a5,a5
    80002318:	079e                	slli	a5,a5,0x7
    8000231a:	97ca                	add	a5,a5,s2
    8000231c:	0b37a623          	sw	s3,172(a5)
}
    80002320:	70a2                	ld	ra,40(sp)
    80002322:	7402                	ld	s0,32(sp)
    80002324:	64e2                	ld	s1,24(sp)
    80002326:	6942                	ld	s2,16(sp)
    80002328:	69a2                	ld	s3,8(sp)
    8000232a:	6145                	addi	sp,sp,48
    8000232c:	8082                	ret
    panic("sched p->lock");
    8000232e:	00007517          	auipc	a0,0x7
    80002332:	f0a50513          	addi	a0,a0,-246 # 80009238 <digits+0x1d8>
    80002336:	ffffe097          	auipc	ra,0xffffe
    8000233a:	206080e7          	jalr	518(ra) # 8000053c <panic>
    panic("sched locks");
    8000233e:	00007517          	auipc	a0,0x7
    80002342:	f0a50513          	addi	a0,a0,-246 # 80009248 <digits+0x1e8>
    80002346:	ffffe097          	auipc	ra,0xffffe
    8000234a:	1f6080e7          	jalr	502(ra) # 8000053c <panic>
    panic("sched running");
    8000234e:	00007517          	auipc	a0,0x7
    80002352:	f0a50513          	addi	a0,a0,-246 # 80009258 <digits+0x1f8>
    80002356:	ffffe097          	auipc	ra,0xffffe
    8000235a:	1e6080e7          	jalr	486(ra) # 8000053c <panic>
    panic("sched interruptible");
    8000235e:	00007517          	auipc	a0,0x7
    80002362:	f0a50513          	addi	a0,a0,-246 # 80009268 <digits+0x208>
    80002366:	ffffe097          	auipc	ra,0xffffe
    8000236a:	1d6080e7          	jalr	470(ra) # 8000053c <panic>

000000008000236e <yield>:
{
    8000236e:	1101                	addi	sp,sp,-32
    80002370:	ec06                	sd	ra,24(sp)
    80002372:	e822                	sd	s0,16(sp)
    80002374:	e426                	sd	s1,8(sp)
    80002376:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80002378:	fffff097          	auipc	ra,0xfffff
    8000237c:	7da080e7          	jalr	2010(ra) # 80001b52 <myproc>
    80002380:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80002382:	fffff097          	auipc	ra,0xfffff
    80002386:	8fa080e7          	jalr	-1798(ra) # 80000c7c <acquire>
  p->state = RUNNABLE;
    8000238a:	478d                	li	a5,3
    8000238c:	cc9c                	sw	a5,24(s1)
  sched();
    8000238e:	00000097          	auipc	ra,0x0
    80002392:	f0a080e7          	jalr	-246(ra) # 80002298 <sched>
  release(&p->lock);
    80002396:	8526                	mv	a0,s1
    80002398:	fffff097          	auipc	ra,0xfffff
    8000239c:	998080e7          	jalr	-1640(ra) # 80000d30 <release>
}
    800023a0:	60e2                	ld	ra,24(sp)
    800023a2:	6442                	ld	s0,16(sp)
    800023a4:	64a2                	ld	s1,8(sp)
    800023a6:	6105                	addi	sp,sp,32
    800023a8:	8082                	ret

00000000800023aa <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    800023aa:	7179                	addi	sp,sp,-48
    800023ac:	f406                	sd	ra,40(sp)
    800023ae:	f022                	sd	s0,32(sp)
    800023b0:	ec26                	sd	s1,24(sp)
    800023b2:	e84a                	sd	s2,16(sp)
    800023b4:	e44e                	sd	s3,8(sp)
    800023b6:	1800                	addi	s0,sp,48
    800023b8:	89aa                	mv	s3,a0
    800023ba:	892e                	mv	s2,a1
  struct proc *p = myproc();
    800023bc:	fffff097          	auipc	ra,0xfffff
    800023c0:	796080e7          	jalr	1942(ra) # 80001b52 <myproc>
    800023c4:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    800023c6:	fffff097          	auipc	ra,0xfffff
    800023ca:	8b6080e7          	jalr	-1866(ra) # 80000c7c <acquire>
  release(lk);
    800023ce:	854a                	mv	a0,s2
    800023d0:	fffff097          	auipc	ra,0xfffff
    800023d4:	960080e7          	jalr	-1696(ra) # 80000d30 <release>

  // Go to sleep.
  p->chan = chan;
    800023d8:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    800023dc:	4789                	li	a5,2
    800023de:	cc9c                	sw	a5,24(s1)

  sched();
    800023e0:	00000097          	auipc	ra,0x0
    800023e4:	eb8080e7          	jalr	-328(ra) # 80002298 <sched>

  // Tidy up.
  p->chan = 0;
    800023e8:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    800023ec:	8526                	mv	a0,s1
    800023ee:	fffff097          	auipc	ra,0xfffff
    800023f2:	942080e7          	jalr	-1726(ra) # 80000d30 <release>
  acquire(lk);
    800023f6:	854a                	mv	a0,s2
    800023f8:	fffff097          	auipc	ra,0xfffff
    800023fc:	884080e7          	jalr	-1916(ra) # 80000c7c <acquire>
}
    80002400:	70a2                	ld	ra,40(sp)
    80002402:	7402                	ld	s0,32(sp)
    80002404:	64e2                	ld	s1,24(sp)
    80002406:	6942                	ld	s2,16(sp)
    80002408:	69a2                	ld	s3,8(sp)
    8000240a:	6145                	addi	sp,sp,48
    8000240c:	8082                	ret

000000008000240e <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    8000240e:	7139                	addi	sp,sp,-64
    80002410:	fc06                	sd	ra,56(sp)
    80002412:	f822                	sd	s0,48(sp)
    80002414:	f426                	sd	s1,40(sp)
    80002416:	f04a                	sd	s2,32(sp)
    80002418:	ec4e                	sd	s3,24(sp)
    8000241a:	e852                	sd	s4,16(sp)
    8000241c:	e456                	sd	s5,8(sp)
    8000241e:	0080                	addi	s0,sp,64
    80002420:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80002422:	00010497          	auipc	s1,0x10
    80002426:	e1e48493          	addi	s1,s1,-482 # 80012240 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    8000242a:	4989                	li	s3,2
        p->state = RUNNABLE;
    8000242c:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    8000242e:	00017917          	auipc	s2,0x17
    80002432:	a1290913          	addi	s2,s2,-1518 # 80018e40 <tickslock>
    80002436:	a811                	j	8000244a <wakeup+0x3c>
      }
      release(&p->lock);
    80002438:	8526                	mv	a0,s1
    8000243a:	fffff097          	auipc	ra,0xfffff
    8000243e:	8f6080e7          	jalr	-1802(ra) # 80000d30 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002442:	1b048493          	addi	s1,s1,432
    80002446:	03248663          	beq	s1,s2,80002472 <wakeup+0x64>
    if(p != myproc()){
    8000244a:	fffff097          	auipc	ra,0xfffff
    8000244e:	708080e7          	jalr	1800(ra) # 80001b52 <myproc>
    80002452:	fea488e3          	beq	s1,a0,80002442 <wakeup+0x34>
      acquire(&p->lock);
    80002456:	8526                	mv	a0,s1
    80002458:	fffff097          	auipc	ra,0xfffff
    8000245c:	824080e7          	jalr	-2012(ra) # 80000c7c <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80002460:	4c9c                	lw	a5,24(s1)
    80002462:	fd379be3          	bne	a5,s3,80002438 <wakeup+0x2a>
    80002466:	709c                	ld	a5,32(s1)
    80002468:	fd4798e3          	bne	a5,s4,80002438 <wakeup+0x2a>
        p->state = RUNNABLE;
    8000246c:	0154ac23          	sw	s5,24(s1)
    80002470:	b7e1                	j	80002438 <wakeup+0x2a>
    }
  }
}
    80002472:	70e2                	ld	ra,56(sp)
    80002474:	7442                	ld	s0,48(sp)
    80002476:	74a2                	ld	s1,40(sp)
    80002478:	7902                	ld	s2,32(sp)
    8000247a:	69e2                	ld	s3,24(sp)
    8000247c:	6a42                	ld	s4,16(sp)
    8000247e:	6aa2                	ld	s5,8(sp)
    80002480:	6121                	addi	sp,sp,64
    80002482:	8082                	ret

0000000080002484 <reparent>:
{
    80002484:	7179                	addi	sp,sp,-48
    80002486:	f406                	sd	ra,40(sp)
    80002488:	f022                	sd	s0,32(sp)
    8000248a:	ec26                	sd	s1,24(sp)
    8000248c:	e84a                	sd	s2,16(sp)
    8000248e:	e44e                	sd	s3,8(sp)
    80002490:	e052                	sd	s4,0(sp)
    80002492:	1800                	addi	s0,sp,48
    80002494:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002496:	00010497          	auipc	s1,0x10
    8000249a:	daa48493          	addi	s1,s1,-598 # 80012240 <proc>
      pp->parent = initproc;
    8000249e:	00007a17          	auipc	s4,0x7
    800024a2:	702a0a13          	addi	s4,s4,1794 # 80009ba0 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800024a6:	00017997          	auipc	s3,0x17
    800024aa:	99a98993          	addi	s3,s3,-1638 # 80018e40 <tickslock>
    800024ae:	a029                	j	800024b8 <reparent+0x34>
    800024b0:	1b048493          	addi	s1,s1,432
    800024b4:	01348d63          	beq	s1,s3,800024ce <reparent+0x4a>
    if(pp->parent == p){
    800024b8:	7c9c                	ld	a5,56(s1)
    800024ba:	ff279be3          	bne	a5,s2,800024b0 <reparent+0x2c>
      pp->parent = initproc;
    800024be:	000a3503          	ld	a0,0(s4)
    800024c2:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    800024c4:	00000097          	auipc	ra,0x0
    800024c8:	f4a080e7          	jalr	-182(ra) # 8000240e <wakeup>
    800024cc:	b7d5                	j	800024b0 <reparent+0x2c>
}
    800024ce:	70a2                	ld	ra,40(sp)
    800024d0:	7402                	ld	s0,32(sp)
    800024d2:	64e2                	ld	s1,24(sp)
    800024d4:	6942                	ld	s2,16(sp)
    800024d6:	69a2                	ld	s3,8(sp)
    800024d8:	6a02                	ld	s4,0(sp)
    800024da:	6145                	addi	sp,sp,48
    800024dc:	8082                	ret

00000000800024de <exit>:
{
    800024de:	7179                	addi	sp,sp,-48
    800024e0:	f406                	sd	ra,40(sp)
    800024e2:	f022                	sd	s0,32(sp)
    800024e4:	ec26                	sd	s1,24(sp)
    800024e6:	e84a                	sd	s2,16(sp)
    800024e8:	e44e                	sd	s3,8(sp)
    800024ea:	e052                	sd	s4,0(sp)
    800024ec:	1800                	addi	s0,sp,48
    800024ee:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800024f0:	fffff097          	auipc	ra,0xfffff
    800024f4:	662080e7          	jalr	1634(ra) # 80001b52 <myproc>
    800024f8:	89aa                	mv	s3,a0
  if(p == initproc)
    800024fa:	00007797          	auipc	a5,0x7
    800024fe:	6a67b783          	ld	a5,1702(a5) # 80009ba0 <initproc>
    80002502:	0d850493          	addi	s1,a0,216
    80002506:	15850913          	addi	s2,a0,344
    8000250a:	02a79363          	bne	a5,a0,80002530 <exit+0x52>
    panic("init exiting");
    8000250e:	00007517          	auipc	a0,0x7
    80002512:	d7250513          	addi	a0,a0,-654 # 80009280 <digits+0x220>
    80002516:	ffffe097          	auipc	ra,0xffffe
    8000251a:	026080e7          	jalr	38(ra) # 8000053c <panic>
      fileclose(f);
    8000251e:	00003097          	auipc	ra,0x3
    80002522:	e72080e7          	jalr	-398(ra) # 80005390 <fileclose>
      p->ofile[fd] = 0;
    80002526:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    8000252a:	04a1                	addi	s1,s1,8
    8000252c:	01248563          	beq	s1,s2,80002536 <exit+0x58>
    if(p->ofile[fd]){
    80002530:	6088                	ld	a0,0(s1)
    80002532:	f575                	bnez	a0,8000251e <exit+0x40>
    80002534:	bfdd                	j	8000252a <exit+0x4c>
  begin_op();
    80002536:	00003097          	auipc	ra,0x3
    8000253a:	98e080e7          	jalr	-1650(ra) # 80004ec4 <begin_op>
  iput(p->cwd);
    8000253e:	1589b503          	ld	a0,344(s3)
    80002542:	00002097          	auipc	ra,0x2
    80002546:	17a080e7          	jalr	378(ra) # 800046bc <iput>
  end_op();
    8000254a:	00003097          	auipc	ra,0x3
    8000254e:	9fa080e7          	jalr	-1542(ra) # 80004f44 <end_op>
  p->cwd = 0;
    80002552:	1409bc23          	sd	zero,344(s3)
  acquire(&wait_lock);
    80002556:	00010497          	auipc	s1,0x10
    8000255a:	8d248493          	addi	s1,s1,-1838 # 80011e28 <wait_lock>
    8000255e:	8526                	mv	a0,s1
    80002560:	ffffe097          	auipc	ra,0xffffe
    80002564:	71c080e7          	jalr	1820(ra) # 80000c7c <acquire>
  reparent(p);
    80002568:	854e                	mv	a0,s3
    8000256a:	00000097          	auipc	ra,0x0
    8000256e:	f1a080e7          	jalr	-230(ra) # 80002484 <reparent>
  wakeup(p->parent);
    80002572:	0389b503          	ld	a0,56(s3)
    80002576:	00000097          	auipc	ra,0x0
    8000257a:	e98080e7          	jalr	-360(ra) # 8000240e <wakeup>
  acquire(&p->lock);
    8000257e:	854e                	mv	a0,s3
    80002580:	ffffe097          	auipc	ra,0xffffe
    80002584:	6fc080e7          	jalr	1788(ra) # 80000c7c <acquire>
  p->xstate = status;
    80002588:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    8000258c:	4795                	li	a5,5
    8000258e:	00f9ac23          	sw	a5,24(s3)
  p->end_time = ticks;
    80002592:	00007797          	auipc	a5,0x7
    80002596:	6167e783          	lwu	a5,1558(a5) # 80009ba8 <ticks>
    8000259a:	18f9b023          	sd	a5,384(s3)
  p->total_time = p->end_time - p->creation_time; 
    8000259e:	1709b703          	ld	a4,368(s3)
    800025a2:	8f99                	sub	a5,a5,a4
    800025a4:	18f9b423          	sd	a5,392(s3)
  release(&wait_lock);
    800025a8:	8526                	mv	a0,s1
    800025aa:	ffffe097          	auipc	ra,0xffffe
    800025ae:	786080e7          	jalr	1926(ra) # 80000d30 <release>
  sched();
    800025b2:	00000097          	auipc	ra,0x0
    800025b6:	ce6080e7          	jalr	-794(ra) # 80002298 <sched>
  panic("zombie exit");
    800025ba:	00007517          	auipc	a0,0x7
    800025be:	cd650513          	addi	a0,a0,-810 # 80009290 <digits+0x230>
    800025c2:	ffffe097          	auipc	ra,0xffffe
    800025c6:	f7a080e7          	jalr	-134(ra) # 8000053c <panic>

00000000800025ca <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800025ca:	7179                	addi	sp,sp,-48
    800025cc:	f406                	sd	ra,40(sp)
    800025ce:	f022                	sd	s0,32(sp)
    800025d0:	ec26                	sd	s1,24(sp)
    800025d2:	e84a                	sd	s2,16(sp)
    800025d4:	e44e                	sd	s3,8(sp)
    800025d6:	1800                	addi	s0,sp,48
    800025d8:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800025da:	00010497          	auipc	s1,0x10
    800025de:	c6648493          	addi	s1,s1,-922 # 80012240 <proc>
    800025e2:	00017997          	auipc	s3,0x17
    800025e6:	85e98993          	addi	s3,s3,-1954 # 80018e40 <tickslock>
    acquire(&p->lock);
    800025ea:	8526                	mv	a0,s1
    800025ec:	ffffe097          	auipc	ra,0xffffe
    800025f0:	690080e7          	jalr	1680(ra) # 80000c7c <acquire>
    if(p->pid == pid){
    800025f4:	589c                	lw	a5,48(s1)
    800025f6:	01278d63          	beq	a5,s2,80002610 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800025fa:	8526                	mv	a0,s1
    800025fc:	ffffe097          	auipc	ra,0xffffe
    80002600:	734080e7          	jalr	1844(ra) # 80000d30 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80002604:	1b048493          	addi	s1,s1,432
    80002608:	ff3491e3          	bne	s1,s3,800025ea <kill+0x20>
  }
  return -1;
    8000260c:	557d                	li	a0,-1
    8000260e:	a829                	j	80002628 <kill+0x5e>
      p->killed = 1;
    80002610:	4785                	li	a5,1
    80002612:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    80002614:	4c98                	lw	a4,24(s1)
    80002616:	4789                	li	a5,2
    80002618:	00f70f63          	beq	a4,a5,80002636 <kill+0x6c>
      release(&p->lock);
    8000261c:	8526                	mv	a0,s1
    8000261e:	ffffe097          	auipc	ra,0xffffe
    80002622:	712080e7          	jalr	1810(ra) # 80000d30 <release>
      return 0;
    80002626:	4501                	li	a0,0
}
    80002628:	70a2                	ld	ra,40(sp)
    8000262a:	7402                	ld	s0,32(sp)
    8000262c:	64e2                	ld	s1,24(sp)
    8000262e:	6942                	ld	s2,16(sp)
    80002630:	69a2                	ld	s3,8(sp)
    80002632:	6145                	addi	sp,sp,48
    80002634:	8082                	ret
        p->state = RUNNABLE;
    80002636:	478d                	li	a5,3
    80002638:	cc9c                	sw	a5,24(s1)
    8000263a:	b7cd                	j	8000261c <kill+0x52>

000000008000263c <setkilled>:

void
setkilled(struct proc *p)
{
    8000263c:	1101                	addi	sp,sp,-32
    8000263e:	ec06                	sd	ra,24(sp)
    80002640:	e822                	sd	s0,16(sp)
    80002642:	e426                	sd	s1,8(sp)
    80002644:	1000                	addi	s0,sp,32
    80002646:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80002648:	ffffe097          	auipc	ra,0xffffe
    8000264c:	634080e7          	jalr	1588(ra) # 80000c7c <acquire>
  p->killed = 1;
    80002650:	4785                	li	a5,1
    80002652:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    80002654:	8526                	mv	a0,s1
    80002656:	ffffe097          	auipc	ra,0xffffe
    8000265a:	6da080e7          	jalr	1754(ra) # 80000d30 <release>
}
    8000265e:	60e2                	ld	ra,24(sp)
    80002660:	6442                	ld	s0,16(sp)
    80002662:	64a2                	ld	s1,8(sp)
    80002664:	6105                	addi	sp,sp,32
    80002666:	8082                	ret

0000000080002668 <killed>:

int
killed(struct proc *p)
{
    80002668:	1101                	addi	sp,sp,-32
    8000266a:	ec06                	sd	ra,24(sp)
    8000266c:	e822                	sd	s0,16(sp)
    8000266e:	e426                	sd	s1,8(sp)
    80002670:	e04a                	sd	s2,0(sp)
    80002672:	1000                	addi	s0,sp,32
    80002674:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    80002676:	ffffe097          	auipc	ra,0xffffe
    8000267a:	606080e7          	jalr	1542(ra) # 80000c7c <acquire>
  k = p->killed;
    8000267e:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    80002682:	8526                	mv	a0,s1
    80002684:	ffffe097          	auipc	ra,0xffffe
    80002688:	6ac080e7          	jalr	1708(ra) # 80000d30 <release>
  return k;
}
    8000268c:	854a                	mv	a0,s2
    8000268e:	60e2                	ld	ra,24(sp)
    80002690:	6442                	ld	s0,16(sp)
    80002692:	64a2                	ld	s1,8(sp)
    80002694:	6902                	ld	s2,0(sp)
    80002696:	6105                	addi	sp,sp,32
    80002698:	8082                	ret

000000008000269a <wait>:
{
    8000269a:	715d                	addi	sp,sp,-80
    8000269c:	e486                	sd	ra,72(sp)
    8000269e:	e0a2                	sd	s0,64(sp)
    800026a0:	fc26                	sd	s1,56(sp)
    800026a2:	f84a                	sd	s2,48(sp)
    800026a4:	f44e                	sd	s3,40(sp)
    800026a6:	f052                	sd	s4,32(sp)
    800026a8:	ec56                	sd	s5,24(sp)
    800026aa:	e85a                	sd	s6,16(sp)
    800026ac:	e45e                	sd	s7,8(sp)
    800026ae:	e062                	sd	s8,0(sp)
    800026b0:	0880                	addi	s0,sp,80
    800026b2:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    800026b4:	fffff097          	auipc	ra,0xfffff
    800026b8:	49e080e7          	jalr	1182(ra) # 80001b52 <myproc>
    800026bc:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800026be:	0000f517          	auipc	a0,0xf
    800026c2:	76a50513          	addi	a0,a0,1898 # 80011e28 <wait_lock>
    800026c6:	ffffe097          	auipc	ra,0xffffe
    800026ca:	5b6080e7          	jalr	1462(ra) # 80000c7c <acquire>
    havekids = 0;
    800026ce:	4b81                	li	s7,0
        if(pp->state == ZOMBIE){
    800026d0:	4a15                	li	s4,5
        havekids = 1;
    800026d2:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800026d4:	00016997          	auipc	s3,0x16
    800026d8:	76c98993          	addi	s3,s3,1900 # 80018e40 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800026dc:	0000fc17          	auipc	s8,0xf
    800026e0:	74cc0c13          	addi	s8,s8,1868 # 80011e28 <wait_lock>
    havekids = 0;
    800026e4:	875e                	mv	a4,s7
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800026e6:	00010497          	auipc	s1,0x10
    800026ea:	b5a48493          	addi	s1,s1,-1190 # 80012240 <proc>
    800026ee:	a0bd                	j	8000275c <wait+0xc2>
          pid = pp->pid;
    800026f0:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    800026f4:	000b0e63          	beqz	s6,80002710 <wait+0x76>
    800026f8:	4691                	li	a3,4
    800026fa:	02c48613          	addi	a2,s1,44
    800026fe:	85da                	mv	a1,s6
    80002700:	05893503          	ld	a0,88(s2)
    80002704:	fffff097          	auipc	ra,0xfffff
    80002708:	10a080e7          	jalr	266(ra) # 8000180e <copyout>
    8000270c:	02054563          	bltz	a0,80002736 <wait+0x9c>
          freeproc(pp);
    80002710:	8526                	mv	a0,s1
    80002712:	fffff097          	auipc	ra,0xfffff
    80002716:	5f2080e7          	jalr	1522(ra) # 80001d04 <freeproc>
          release(&pp->lock);
    8000271a:	8526                	mv	a0,s1
    8000271c:	ffffe097          	auipc	ra,0xffffe
    80002720:	614080e7          	jalr	1556(ra) # 80000d30 <release>
          release(&wait_lock);
    80002724:	0000f517          	auipc	a0,0xf
    80002728:	70450513          	addi	a0,a0,1796 # 80011e28 <wait_lock>
    8000272c:	ffffe097          	auipc	ra,0xffffe
    80002730:	604080e7          	jalr	1540(ra) # 80000d30 <release>
          return pid;
    80002734:	a0b5                	j	800027a0 <wait+0x106>
            release(&pp->lock);
    80002736:	8526                	mv	a0,s1
    80002738:	ffffe097          	auipc	ra,0xffffe
    8000273c:	5f8080e7          	jalr	1528(ra) # 80000d30 <release>
            release(&wait_lock);
    80002740:	0000f517          	auipc	a0,0xf
    80002744:	6e850513          	addi	a0,a0,1768 # 80011e28 <wait_lock>
    80002748:	ffffe097          	auipc	ra,0xffffe
    8000274c:	5e8080e7          	jalr	1512(ra) # 80000d30 <release>
            return -1;
    80002750:	59fd                	li	s3,-1
    80002752:	a0b9                	j	800027a0 <wait+0x106>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80002754:	1b048493          	addi	s1,s1,432
    80002758:	03348463          	beq	s1,s3,80002780 <wait+0xe6>
      if(pp->parent == p){
    8000275c:	7c9c                	ld	a5,56(s1)
    8000275e:	ff279be3          	bne	a5,s2,80002754 <wait+0xba>
        acquire(&pp->lock);
    80002762:	8526                	mv	a0,s1
    80002764:	ffffe097          	auipc	ra,0xffffe
    80002768:	518080e7          	jalr	1304(ra) # 80000c7c <acquire>
        if(pp->state == ZOMBIE){
    8000276c:	4c9c                	lw	a5,24(s1)
    8000276e:	f94781e3          	beq	a5,s4,800026f0 <wait+0x56>
        release(&pp->lock);
    80002772:	8526                	mv	a0,s1
    80002774:	ffffe097          	auipc	ra,0xffffe
    80002778:	5bc080e7          	jalr	1468(ra) # 80000d30 <release>
        havekids = 1;
    8000277c:	8756                	mv	a4,s5
    8000277e:	bfd9                	j	80002754 <wait+0xba>
    if(!havekids || killed(p)){
    80002780:	c719                	beqz	a4,8000278e <wait+0xf4>
    80002782:	854a                	mv	a0,s2
    80002784:	00000097          	auipc	ra,0x0
    80002788:	ee4080e7          	jalr	-284(ra) # 80002668 <killed>
    8000278c:	c51d                	beqz	a0,800027ba <wait+0x120>
      release(&wait_lock);
    8000278e:	0000f517          	auipc	a0,0xf
    80002792:	69a50513          	addi	a0,a0,1690 # 80011e28 <wait_lock>
    80002796:	ffffe097          	auipc	ra,0xffffe
    8000279a:	59a080e7          	jalr	1434(ra) # 80000d30 <release>
      return -1;
    8000279e:	59fd                	li	s3,-1
}
    800027a0:	854e                	mv	a0,s3
    800027a2:	60a6                	ld	ra,72(sp)
    800027a4:	6406                	ld	s0,64(sp)
    800027a6:	74e2                	ld	s1,56(sp)
    800027a8:	7942                	ld	s2,48(sp)
    800027aa:	79a2                	ld	s3,40(sp)
    800027ac:	7a02                	ld	s4,32(sp)
    800027ae:	6ae2                	ld	s5,24(sp)
    800027b0:	6b42                	ld	s6,16(sp)
    800027b2:	6ba2                	ld	s7,8(sp)
    800027b4:	6c02                	ld	s8,0(sp)
    800027b6:	6161                	addi	sp,sp,80
    800027b8:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800027ba:	85e2                	mv	a1,s8
    800027bc:	854a                	mv	a0,s2
    800027be:	00000097          	auipc	ra,0x0
    800027c2:	bec080e7          	jalr	-1044(ra) # 800023aa <sleep>
    havekids = 0;
    800027c6:	bf39                	j	800026e4 <wait+0x4a>

00000000800027c8 <waitx>:
{
    800027c8:	7119                	addi	sp,sp,-128
    800027ca:	fc86                	sd	ra,120(sp)
    800027cc:	f8a2                	sd	s0,112(sp)
    800027ce:	f4a6                	sd	s1,104(sp)
    800027d0:	f0ca                	sd	s2,96(sp)
    800027d2:	ecce                	sd	s3,88(sp)
    800027d4:	e8d2                	sd	s4,80(sp)
    800027d6:	e4d6                	sd	s5,72(sp)
    800027d8:	e0da                	sd	s6,64(sp)
    800027da:	fc5e                	sd	s7,56(sp)
    800027dc:	f862                	sd	s8,48(sp)
    800027de:	f466                	sd	s9,40(sp)
    800027e0:	f06a                	sd	s10,32(sp)
    800027e2:	0100                	addi	s0,sp,128
    800027e4:	8b2a                	mv	s6,a0
    800027e6:	8c2e                	mv	s8,a1
    800027e8:	8bb2                	mv	s7,a2
  struct proc *p = myproc();
    800027ea:	fffff097          	auipc	ra,0xfffff
    800027ee:	368080e7          	jalr	872(ra) # 80001b52 <myproc>
    800027f2:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800027f4:	0000f517          	auipc	a0,0xf
    800027f8:	63450513          	addi	a0,a0,1588 # 80011e28 <wait_lock>
    800027fc:	ffffe097          	auipc	ra,0xffffe
    80002800:	480080e7          	jalr	1152(ra) # 80000c7c <acquire>
    havekids = 0;
    80002804:	4c81                	li	s9,0
        if(pp->state == ZOMBIE){
    80002806:	4a15                	li	s4,5
        havekids = 1;
    80002808:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000280a:	00016997          	auipc	s3,0x16
    8000280e:	63698993          	addi	s3,s3,1590 # 80018e40 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80002812:	0000fd17          	auipc	s10,0xf
    80002816:	616d0d13          	addi	s10,s10,1558 # 80011e28 <wait_lock>
    havekids = 0;
    8000281a:	8766                	mv	a4,s9
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000281c:	00010497          	auipc	s1,0x10
    80002820:	a2448493          	addi	s1,s1,-1500 # 80012240 <proc>
    80002824:	a8e1                	j	800028fc <waitx+0x134>
          pid = pp->pid;
    80002826:	0304a983          	lw	s3,48(s1)
          printf("\nProcess #%d: %s\nPriority: %d\nState: %s\nCreation time: %d\nStart time: %d\nEnd time: %d\nTotal time: %d\n", pp->pid, pp->name, pp->priority, states[pp->state], pp->creation_time, pp->start_time, pp->end_time, pp->total_time);
    8000282a:	1884b783          	ld	a5,392(s1)
    8000282e:	e03e                	sd	a5,0(sp)
    80002830:	1804b883          	ld	a7,384(s1)
    80002834:	1784b803          	ld	a6,376(s1)
    80002838:	1704b783          	ld	a5,368(s1)
    8000283c:	00007717          	auipc	a4,0x7
    80002840:	a6470713          	addi	a4,a4,-1436 # 800092a0 <digits+0x240>
    80002844:	1904b683          	ld	a3,400(s1)
    80002848:	16048613          	addi	a2,s1,352
    8000284c:	85ce                	mv	a1,s3
    8000284e:	00007517          	auipc	a0,0x7
    80002852:	a5a50513          	addi	a0,a0,-1446 # 800092a8 <digits+0x248>
    80002856:	ffffe097          	auipc	ra,0xffffe
    8000285a:	d30080e7          	jalr	-720(ra) # 80000586 <printf>
          uint64 wtime = pp->start_time - pp->creation_time; 
    8000285e:	1784b783          	ld	a5,376(s1)
    80002862:	1704b703          	ld	a4,368(s1)
    80002866:	8f99                	sub	a5,a5,a4
    80002868:	f8f43c23          	sd	a5,-104(s0)
          copyout(p->pagetable, (uint64)wait_time, (char *)&wtime, sizeof(int));
    8000286c:	4691                	li	a3,4
    8000286e:	f9840613          	addi	a2,s0,-104
    80002872:	85e2                	mv	a1,s8
    80002874:	05893503          	ld	a0,88(s2)
    80002878:	fffff097          	auipc	ra,0xfffff
    8000287c:	f96080e7          	jalr	-106(ra) # 8000180e <copyout>
          copyout(p->pagetable, (uint64)turnaround_time, (char *)&pp->total_time, sizeof(int));  
    80002880:	4691                	li	a3,4
    80002882:	18848613          	addi	a2,s1,392
    80002886:	85de                	mv	a1,s7
    80002888:	05893503          	ld	a0,88(s2)
    8000288c:	fffff097          	auipc	ra,0xfffff
    80002890:	f82080e7          	jalr	-126(ra) # 8000180e <copyout>
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    80002894:	000b0e63          	beqz	s6,800028b0 <waitx+0xe8>
    80002898:	4691                	li	a3,4
    8000289a:	02c48613          	addi	a2,s1,44
    8000289e:	85da                	mv	a1,s6
    800028a0:	05893503          	ld	a0,88(s2)
    800028a4:	fffff097          	auipc	ra,0xfffff
    800028a8:	f6a080e7          	jalr	-150(ra) # 8000180e <copyout>
    800028ac:	02054563          	bltz	a0,800028d6 <waitx+0x10e>
          freeproc(pp);
    800028b0:	8526                	mv	a0,s1
    800028b2:	fffff097          	auipc	ra,0xfffff
    800028b6:	452080e7          	jalr	1106(ra) # 80001d04 <freeproc>
          release(&pp->lock);
    800028ba:	8526                	mv	a0,s1
    800028bc:	ffffe097          	auipc	ra,0xffffe
    800028c0:	474080e7          	jalr	1140(ra) # 80000d30 <release>
          release(&wait_lock);
    800028c4:	0000f517          	auipc	a0,0xf
    800028c8:	56450513          	addi	a0,a0,1380 # 80011e28 <wait_lock>
    800028cc:	ffffe097          	auipc	ra,0xffffe
    800028d0:	464080e7          	jalr	1124(ra) # 80000d30 <release>
          return pid;
    800028d4:	a0b5                	j	80002940 <waitx+0x178>
            release(&pp->lock);
    800028d6:	8526                	mv	a0,s1
    800028d8:	ffffe097          	auipc	ra,0xffffe
    800028dc:	458080e7          	jalr	1112(ra) # 80000d30 <release>
            release(&wait_lock);
    800028e0:	0000f517          	auipc	a0,0xf
    800028e4:	54850513          	addi	a0,a0,1352 # 80011e28 <wait_lock>
    800028e8:	ffffe097          	auipc	ra,0xffffe
    800028ec:	448080e7          	jalr	1096(ra) # 80000d30 <release>
            return -1;
    800028f0:	59fd                	li	s3,-1
    800028f2:	a0b9                	j	80002940 <waitx+0x178>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800028f4:	1b048493          	addi	s1,s1,432
    800028f8:	03348463          	beq	s1,s3,80002920 <waitx+0x158>
      if(pp->parent == p){
    800028fc:	7c9c                	ld	a5,56(s1)
    800028fe:	ff279be3          	bne	a5,s2,800028f4 <waitx+0x12c>
        acquire(&pp->lock);
    80002902:	8526                	mv	a0,s1
    80002904:	ffffe097          	auipc	ra,0xffffe
    80002908:	378080e7          	jalr	888(ra) # 80000c7c <acquire>
        if(pp->state == ZOMBIE){
    8000290c:	4c9c                	lw	a5,24(s1)
    8000290e:	f1478ce3          	beq	a5,s4,80002826 <waitx+0x5e>
        release(&pp->lock);
    80002912:	8526                	mv	a0,s1
    80002914:	ffffe097          	auipc	ra,0xffffe
    80002918:	41c080e7          	jalr	1052(ra) # 80000d30 <release>
        havekids = 1;
    8000291c:	8756                	mv	a4,s5
    8000291e:	bfd9                	j	800028f4 <waitx+0x12c>
    if(!havekids || killed(p)){
    80002920:	c719                	beqz	a4,8000292e <waitx+0x166>
    80002922:	854a                	mv	a0,s2
    80002924:	00000097          	auipc	ra,0x0
    80002928:	d44080e7          	jalr	-700(ra) # 80002668 <killed>
    8000292c:	c90d                	beqz	a0,8000295e <waitx+0x196>
      release(&wait_lock);
    8000292e:	0000f517          	auipc	a0,0xf
    80002932:	4fa50513          	addi	a0,a0,1274 # 80011e28 <wait_lock>
    80002936:	ffffe097          	auipc	ra,0xffffe
    8000293a:	3fa080e7          	jalr	1018(ra) # 80000d30 <release>
      return -1;
    8000293e:	59fd                	li	s3,-1
}
    80002940:	854e                	mv	a0,s3
    80002942:	70e6                	ld	ra,120(sp)
    80002944:	7446                	ld	s0,112(sp)
    80002946:	74a6                	ld	s1,104(sp)
    80002948:	7906                	ld	s2,96(sp)
    8000294a:	69e6                	ld	s3,88(sp)
    8000294c:	6a46                	ld	s4,80(sp)
    8000294e:	6aa6                	ld	s5,72(sp)
    80002950:	6b06                	ld	s6,64(sp)
    80002952:	7be2                	ld	s7,56(sp)
    80002954:	7c42                	ld	s8,48(sp)
    80002956:	7ca2                	ld	s9,40(sp)
    80002958:	7d02                	ld	s10,32(sp)
    8000295a:	6109                	addi	sp,sp,128
    8000295c:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000295e:	85ea                	mv	a1,s10
    80002960:	854a                	mv	a0,s2
    80002962:	00000097          	auipc	ra,0x0
    80002966:	a48080e7          	jalr	-1464(ra) # 800023aa <sleep>
    havekids = 0;
    8000296a:	bd45                	j	8000281a <waitx+0x52>

000000008000296c <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    8000296c:	7179                	addi	sp,sp,-48
    8000296e:	f406                	sd	ra,40(sp)
    80002970:	f022                	sd	s0,32(sp)
    80002972:	ec26                	sd	s1,24(sp)
    80002974:	e84a                	sd	s2,16(sp)
    80002976:	e44e                	sd	s3,8(sp)
    80002978:	e052                	sd	s4,0(sp)
    8000297a:	1800                	addi	s0,sp,48
    8000297c:	84aa                	mv	s1,a0
    8000297e:	892e                	mv	s2,a1
    80002980:	89b2                	mv	s3,a2
    80002982:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80002984:	fffff097          	auipc	ra,0xfffff
    80002988:	1ce080e7          	jalr	462(ra) # 80001b52 <myproc>
  if(user_dst){
    8000298c:	c08d                	beqz	s1,800029ae <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    8000298e:	86d2                	mv	a3,s4
    80002990:	864e                	mv	a2,s3
    80002992:	85ca                	mv	a1,s2
    80002994:	6d28                	ld	a0,88(a0)
    80002996:	fffff097          	auipc	ra,0xfffff
    8000299a:	e78080e7          	jalr	-392(ra) # 8000180e <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    8000299e:	70a2                	ld	ra,40(sp)
    800029a0:	7402                	ld	s0,32(sp)
    800029a2:	64e2                	ld	s1,24(sp)
    800029a4:	6942                	ld	s2,16(sp)
    800029a6:	69a2                	ld	s3,8(sp)
    800029a8:	6a02                	ld	s4,0(sp)
    800029aa:	6145                	addi	sp,sp,48
    800029ac:	8082                	ret
    memmove((char *)dst, src, len);
    800029ae:	000a061b          	sext.w	a2,s4
    800029b2:	85ce                	mv	a1,s3
    800029b4:	854a                	mv	a0,s2
    800029b6:	ffffe097          	auipc	ra,0xffffe
    800029ba:	41e080e7          	jalr	1054(ra) # 80000dd4 <memmove>
    return 0;
    800029be:	8526                	mv	a0,s1
    800029c0:	bff9                	j	8000299e <either_copyout+0x32>

00000000800029c2 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800029c2:	7179                	addi	sp,sp,-48
    800029c4:	f406                	sd	ra,40(sp)
    800029c6:	f022                	sd	s0,32(sp)
    800029c8:	ec26                	sd	s1,24(sp)
    800029ca:	e84a                	sd	s2,16(sp)
    800029cc:	e44e                	sd	s3,8(sp)
    800029ce:	e052                	sd	s4,0(sp)
    800029d0:	1800                	addi	s0,sp,48
    800029d2:	892a                	mv	s2,a0
    800029d4:	84ae                	mv	s1,a1
    800029d6:	89b2                	mv	s3,a2
    800029d8:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800029da:	fffff097          	auipc	ra,0xfffff
    800029de:	178080e7          	jalr	376(ra) # 80001b52 <myproc>
  if(user_src){
    800029e2:	c08d                	beqz	s1,80002a04 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    800029e4:	86d2                	mv	a3,s4
    800029e6:	864e                	mv	a2,s3
    800029e8:	85ca                	mv	a1,s2
    800029ea:	6d28                	ld	a0,88(a0)
    800029ec:	fffff097          	auipc	ra,0xfffff
    800029f0:	eae080e7          	jalr	-338(ra) # 8000189a <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    800029f4:	70a2                	ld	ra,40(sp)
    800029f6:	7402                	ld	s0,32(sp)
    800029f8:	64e2                	ld	s1,24(sp)
    800029fa:	6942                	ld	s2,16(sp)
    800029fc:	69a2                	ld	s3,8(sp)
    800029fe:	6a02                	ld	s4,0(sp)
    80002a00:	6145                	addi	sp,sp,48
    80002a02:	8082                	ret
    memmove(dst, (char*)src, len);
    80002a04:	000a061b          	sext.w	a2,s4
    80002a08:	85ce                	mv	a1,s3
    80002a0a:	854a                	mv	a0,s2
    80002a0c:	ffffe097          	auipc	ra,0xffffe
    80002a10:	3c8080e7          	jalr	968(ra) # 80000dd4 <memmove>
    return 0;
    80002a14:	8526                	mv	a0,s1
    80002a16:	bff9                	j	800029f4 <either_copyin+0x32>

0000000080002a18 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80002a18:	715d                	addi	sp,sp,-80
    80002a1a:	e486                	sd	ra,72(sp)
    80002a1c:	e0a2                	sd	s0,64(sp)
    80002a1e:	fc26                	sd	s1,56(sp)
    80002a20:	f84a                	sd	s2,48(sp)
    80002a22:	f44e                	sd	s3,40(sp)
    80002a24:	f052                	sd	s4,32(sp)
    80002a26:	ec56                	sd	s5,24(sp)
    80002a28:	e85a                	sd	s6,16(sp)
    80002a2a:	e45e                	sd	s7,8(sp)
    80002a2c:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80002a2e:	00007517          	auipc	a0,0x7
    80002a32:	97250513          	addi	a0,a0,-1678 # 800093a0 <digits+0x340>
    80002a36:	ffffe097          	auipc	ra,0xffffe
    80002a3a:	b50080e7          	jalr	-1200(ra) # 80000586 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80002a3e:	00010497          	auipc	s1,0x10
    80002a42:	96248493          	addi	s1,s1,-1694 # 800123a0 <proc+0x160>
    80002a46:	00016917          	auipc	s2,0x16
    80002a4a:	55a90913          	addi	s2,s2,1370 # 80018fa0 <bcache+0x148>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002a4e:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80002a50:	00007997          	auipc	s3,0x7
    80002a54:	8c098993          	addi	s3,s3,-1856 # 80009310 <digits+0x2b0>
    printf("%d %s %s", p->pid, state, p->name);
    80002a58:	00007a97          	auipc	s5,0x7
    80002a5c:	8c0a8a93          	addi	s5,s5,-1856 # 80009318 <digits+0x2b8>
    printf("\n");
    80002a60:	00007a17          	auipc	s4,0x7
    80002a64:	940a0a13          	addi	s4,s4,-1728 # 800093a0 <digits+0x340>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002a68:	00007b97          	auipc	s7,0x7
    80002a6c:	ab8b8b93          	addi	s7,s7,-1352 # 80009520 <states.0>
    80002a70:	a00d                	j	80002a92 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80002a72:	ed06a583          	lw	a1,-304(a3)
    80002a76:	8556                	mv	a0,s5
    80002a78:	ffffe097          	auipc	ra,0xffffe
    80002a7c:	b0e080e7          	jalr	-1266(ra) # 80000586 <printf>
    printf("\n");
    80002a80:	8552                	mv	a0,s4
    80002a82:	ffffe097          	auipc	ra,0xffffe
    80002a86:	b04080e7          	jalr	-1276(ra) # 80000586 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80002a8a:	1b048493          	addi	s1,s1,432
    80002a8e:	03248163          	beq	s1,s2,80002ab0 <procdump+0x98>
    if(p->state == UNUSED)
    80002a92:	86a6                	mv	a3,s1
    80002a94:	eb84a783          	lw	a5,-328(s1)
    80002a98:	dbed                	beqz	a5,80002a8a <procdump+0x72>
      state = "???";
    80002a9a:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002a9c:	fcfb6be3          	bltu	s6,a5,80002a72 <procdump+0x5a>
    80002aa0:	1782                	slli	a5,a5,0x20
    80002aa2:	9381                	srli	a5,a5,0x20
    80002aa4:	078e                	slli	a5,a5,0x3
    80002aa6:	97de                	add	a5,a5,s7
    80002aa8:	6390                	ld	a2,0(a5)
    80002aaa:	f661                	bnez	a2,80002a72 <procdump+0x5a>
      state = "???";
    80002aac:	864e                	mv	a2,s3
    80002aae:	b7d1                	j	80002a72 <procdump+0x5a>
  }
}
    80002ab0:	60a6                	ld	ra,72(sp)
    80002ab2:	6406                	ld	s0,64(sp)
    80002ab4:	74e2                	ld	s1,56(sp)
    80002ab6:	7942                	ld	s2,48(sp)
    80002ab8:	79a2                	ld	s3,40(sp)
    80002aba:	7a02                	ld	s4,32(sp)
    80002abc:	6ae2                	ld	s5,24(sp)
    80002abe:	6b42                	ld	s6,16(sp)
    80002ac0:	6ba2                	ld	s7,8(sp)
    80002ac2:	6161                	addi	sp,sp,80
    80002ac4:	8082                	ret

0000000080002ac6 <to_lower>:

// Helper function to convert char to lowercase
int to_lower(int c) {
    80002ac6:	1141                	addi	sp,sp,-16
    80002ac8:	e422                	sd	s0,8(sp)
    80002aca:	0800                	addi	s0,sp,16
  if (c >= 'A' && c <= 'Z')
    80002acc:	fbf5071b          	addiw	a4,a0,-65
    80002ad0:	47e5                	li	a5,25
    80002ad2:	00e7f563          	bgeu	a5,a4,80002adc <to_lower+0x16>
    return c + ('a' - 'A');
  return c;
}
    80002ad6:	6422                	ld	s0,8(sp)
    80002ad8:	0141                	addi	sp,sp,16
    80002ada:	8082                	ret
    return c + ('a' - 'A');
    80002adc:	0205051b          	addiw	a0,a0,32
    80002ae0:	bfdd                	j	80002ad6 <to_lower+0x10>

0000000080002ae2 <my_strcasecmp>:

// Helper function to compare chars with insensitive case
int my_strcasecmp(const char *str1, const char *str2) {
    80002ae2:	7179                	addi	sp,sp,-48
    80002ae4:	f406                	sd	ra,40(sp)
    80002ae6:	f022                	sd	s0,32(sp)
    80002ae8:	ec26                	sd	s1,24(sp)
    80002aea:	e84a                	sd	s2,16(sp)
    80002aec:	e44e                	sd	s3,8(sp)
    80002aee:	e052                	sd	s4,0(sp)
    80002af0:	1800                	addi	s0,sp,48
    80002af2:	89aa                	mv	s3,a0
    80002af4:	892e                	mv	s2,a1
  while (*str1 && to_lower(*str1) == to_lower(*str2))
    80002af6:	00054a03          	lbu	s4,0(a0)
    80002afa:	020a0663          	beqz	s4,80002b26 <my_strcasecmp+0x44>
    80002afe:	8552                	mv	a0,s4
    80002b00:	00000097          	auipc	ra,0x0
    80002b04:	fc6080e7          	jalr	-58(ra) # 80002ac6 <to_lower>
    80002b08:	84aa                	mv	s1,a0
    80002b0a:	00094503          	lbu	a0,0(s2)
    80002b0e:	00000097          	auipc	ra,0x0
    80002b12:	fb8080e7          	jalr	-72(ra) # 80002ac6 <to_lower>
    80002b16:	00a49863          	bne	s1,a0,80002b26 <my_strcasecmp+0x44>
    str1++, str2++;
    80002b1a:	0985                	addi	s3,s3,1
    80002b1c:	0905                	addi	s2,s2,1
  while (*str1 && to_lower(*str1) == to_lower(*str2))
    80002b1e:	0009ca03          	lbu	s4,0(s3)
    80002b22:	fc0a1ee3          	bnez	s4,80002afe <my_strcasecmp+0x1c>
  return (unsigned char)to_lower(*str1) - (unsigned char)to_lower(*str2);
    80002b26:	8552                	mv	a0,s4
    80002b28:	00000097          	auipc	ra,0x0
    80002b2c:	f9e080e7          	jalr	-98(ra) # 80002ac6 <to_lower>
    80002b30:	84aa                	mv	s1,a0
    80002b32:	00094503          	lbu	a0,0(s2)
    80002b36:	00000097          	auipc	ra,0x0
    80002b3a:	f90080e7          	jalr	-112(ra) # 80002ac6 <to_lower>
    80002b3e:	0ff4f493          	andi	s1,s1,255
    80002b42:	0ff57513          	andi	a0,a0,255
}
    80002b46:	40a4853b          	subw	a0,s1,a0
    80002b4a:	70a2                	ld	ra,40(sp)
    80002b4c:	7402                	ld	s0,32(sp)
    80002b4e:	64e2                	ld	s1,24(sp)
    80002b50:	6942                	ld	s2,16(sp)
    80002b52:	69a2                	ld	s3,8(sp)
    80002b54:	6a02                	ld	s4,0(sp)
    80002b56:	6145                	addi	sp,sp,48
    80002b58:	8082                	ret

0000000080002b5a <print_str>:

// Helper function to print line depending on flags for uniq command
void print_str(const char *str, const int repeated, const int printed, const int c_flag, const int d_flag) {
  if (!printed) {
    80002b5a:	ea39                	bnez	a2,80002bb0 <print_str+0x56>
void print_str(const char *str, const int repeated, const int printed, const int c_flag, const int d_flag) {
    80002b5c:	7179                	addi	sp,sp,-48
    80002b5e:	f406                	sd	ra,40(sp)
    80002b60:	f022                	sd	s0,32(sp)
    80002b62:	ec26                	sd	s1,24(sp)
    80002b64:	e84a                	sd	s2,16(sp)
    80002b66:	e44e                	sd	s3,8(sp)
    80002b68:	1800                	addi	s0,sp,48
    80002b6a:	89aa                	mv	s3,a0
    80002b6c:	84ae                	mv	s1,a1
    80002b6e:	893a                	mv	s2,a4
    if (c_flag) { 
    80002b70:	ce89                	beqz	a3,80002b8a <print_str+0x30>
      // if d_flag and line is not repeated, don't print non-duplicate lines
      if (repeated || !d_flag)
    80002b72:	e191                	bnez	a1,80002b76 <print_str+0x1c>
    80002b74:	e71d                	bnez	a4,80002ba2 <print_str+0x48>
        printf("%d ", repeated + 1);
    80002b76:	0014859b          	addiw	a1,s1,1
    80002b7a:	00006517          	auipc	a0,0x6
    80002b7e:	7ae50513          	addi	a0,a0,1966 # 80009328 <digits+0x2c8>
    80002b82:	ffffe097          	auipc	ra,0xffffe
    80002b86:	a04080e7          	jalr	-1532(ra) # 80000586 <printf>
    }
    if (repeated || !d_flag) 
    80002b8a:	e099                	bnez	s1,80002b90 <print_str+0x36>
    80002b8c:	00091b63          	bnez	s2,80002ba2 <print_str+0x48>
      printf("%s", str);
    80002b90:	85ce                	mv	a1,s3
    80002b92:	00006517          	auipc	a0,0x6
    80002b96:	79e50513          	addi	a0,a0,1950 # 80009330 <digits+0x2d0>
    80002b9a:	ffffe097          	auipc	ra,0xffffe
    80002b9e:	9ec080e7          	jalr	-1556(ra) # 80000586 <printf>
  }  
}
    80002ba2:	70a2                	ld	ra,40(sp)
    80002ba4:	7402                	ld	s0,32(sp)
    80002ba6:	64e2                	ld	s1,24(sp)
    80002ba8:	6942                	ld	s2,16(sp)
    80002baa:	69a2                	ld	s3,8(sp)
    80002bac:	6145                	addi	sp,sp,48
    80002bae:	8082                	ret
    80002bb0:	8082                	ret

0000000080002bb2 <uniq_k>:

void uniq_k(int fd, uint64 addr, int c_flag, int d_flag, int i_flag) {
    80002bb2:	99010113          	addi	sp,sp,-1648
    80002bb6:	66113423          	sd	ra,1640(sp)
    80002bba:	66813023          	sd	s0,1632(sp)
    80002bbe:	64913c23          	sd	s1,1624(sp)
    80002bc2:	65213823          	sd	s2,1616(sp)
    80002bc6:	65313423          	sd	s3,1608(sp)
    80002bca:	65413023          	sd	s4,1600(sp)
    80002bce:	63513c23          	sd	s5,1592(sp)
    80002bd2:	63613823          	sd	s6,1584(sp)
    80002bd6:	63713423          	sd	s7,1576(sp)
    80002bda:	63813023          	sd	s8,1568(sp)
    80002bde:	61913c23          	sd	s9,1560(sp)
    80002be2:	61a13823          	sd	s10,1552(sp)
    80002be6:	61b13423          	sd	s11,1544(sp)
    80002bea:	67010413          	addi	s0,sp,1648
    80002bee:	84aa                	mv	s1,a0
    80002bf0:	8c2e                	mv	s8,a1
    80002bf2:	8d32                	mv	s10,a2
    80002bf4:	8cb6                	mv	s9,a3
    80002bf6:	8b3a                	mv	s6,a4
  char buf[BUF_SIZE]; 
  char line[BUF_SIZE];
  char prev_line[BUF_SIZE] = ""; 
    80002bf8:	98043823          	sd	zero,-1648(s0)
    80002bfc:	1f800613          	li	a2,504
    80002c00:	4581                	li	a1,0
    80002c02:	99840513          	addi	a0,s0,-1640
    80002c06:	ffffe097          	auipc	ra,0xffffe
    80002c0a:	172080e7          	jalr	370(ra) # 80000d78 <memset>
  int repeated = 0, n, i, j, printed = 1;  
  printf("Uniq command is getting executed in kernel mode.\n");
    80002c0e:	00006517          	auipc	a0,0x6
    80002c12:	72a50513          	addi	a0,a0,1834 # 80009338 <digits+0x2d8>
    80002c16:	ffffe097          	auipc	ra,0xffffe
    80002c1a:	970080e7          	jalr	-1680(ra) # 80000586 <printf>
  
  struct file *f = myproc()->ofile[fd];
    80002c1e:	fffff097          	auipc	ra,0xfffff
    80002c22:	f34080e7          	jalr	-204(ra) # 80001b52 <myproc>
    80002c26:	01a48793          	addi	a5,s1,26
    80002c2a:	078e                	slli	a5,a5,0x3
    80002c2c:	97aa                	add	a5,a5,a0
    80002c2e:	0087bd83          	ld	s11,8(a5)
  int repeated = 0, n, i, j, printed = 1;  
    80002c32:	4b85                	li	s7,1
    80002c34:	4a01                	li	s4,0
  while ((n = fileread(f, addr, BUF_SIZE)) > 0) {
    // Copy string from user virtual address to kernel buffer
    copyinstr(myproc()->pagetable, buf, addr, n);
    for (i = 0, j = 0; i < n; i++) {
    80002c36:	4a81                	li	s5,0
  while ((n = fileread(f, addr, BUF_SIZE)) > 0) {
    80002c38:	a861                	j	80002cd0 <uniq_k+0x11e>
      line[j++] = buf[i]; 
      if (buf[i] == '\n') {
      line[j] = '\0';  
      int res = i_flag ? my_strcasecmp(line, prev_line) : strncmp(line, prev_line, BUF_SIZE); 
    80002c3a:	20000613          	li	a2,512
    80002c3e:	99040593          	addi	a1,s0,-1648
    80002c42:	b9040513          	addi	a0,s0,-1136
    80002c46:	ffffe097          	auipc	ra,0xffffe
    80002c4a:	202080e7          	jalr	514(ra) # 80000e48 <strncmp>
        if (!res) {
    80002c4e:	ed1d                	bnez	a0,80002c8c <uniq_k+0xda>
          repeated++; 
    80002c50:	2a05                	addiw	s4,s4,1
    for (i = 0, j = 0; i < n; i++) {
    80002c52:	0485                	addi	s1,s1,1
    80002c54:	07248463          	beq	s1,s2,80002cbc <uniq_k+0x10a>
      line[j++] = buf[i]; 
    80002c58:	0015079b          	addiw	a5,a0,1
    80002c5c:	0004c703          	lbu	a4,0(s1)
    80002c60:	f9040693          	addi	a3,s0,-112
    80002c64:	9536                	add	a0,a0,a3
    80002c66:	c0e50023          	sb	a4,-1024(a0)
    80002c6a:	853e                	mv	a0,a5
      if (buf[i] == '\n') {
    80002c6c:	ff3713e3          	bne	a4,s3,80002c52 <uniq_k+0xa0>
      line[j] = '\0';  
    80002c70:	97b6                	add	a5,a5,a3
    80002c72:	c0078023          	sb	zero,-1024(a5)
      int res = i_flag ? my_strcasecmp(line, prev_line) : strncmp(line, prev_line, BUF_SIZE); 
    80002c76:	fc0b02e3          	beqz	s6,80002c3a <uniq_k+0x88>
    80002c7a:	99040593          	addi	a1,s0,-1648
    80002c7e:	b9040513          	addi	a0,s0,-1136
    80002c82:	00000097          	auipc	ra,0x0
    80002c86:	e60080e7          	jalr	-416(ra) # 80002ae2 <my_strcasecmp>
    80002c8a:	b7d1                	j	80002c4e <uniq_k+0x9c>
        } else {
          print_str(prev_line, repeated, printed, c_flag, d_flag); 
    80002c8c:	8766                	mv	a4,s9
    80002c8e:	86ea                	mv	a3,s10
    80002c90:	865e                	mv	a2,s7
    80002c92:	85d2                	mv	a1,s4
    80002c94:	99040513          	addi	a0,s0,-1648
    80002c98:	00000097          	auipc	ra,0x0
    80002c9c:	ec2080e7          	jalr	-318(ra) # 80002b5a <print_str>
          strncpy(prev_line, line, BUF_SIZE);
    80002ca0:	20000613          	li	a2,512
    80002ca4:	b9040593          	addi	a1,s0,-1136
    80002ca8:	99040513          	addi	a0,s0,-1648
    80002cac:	ffffe097          	auipc	ra,0xffffe
    80002cb0:	1d8080e7          	jalr	472(ra) # 80000e84 <strncpy>
          repeated = 0;
          printed = 0; 	  
    80002cb4:	8bd6                	mv	s7,s5
        } 
	      j = 0; 
    80002cb6:	8556                	mv	a0,s5
          repeated = 0;
    80002cb8:	8a56                	mv	s4,s5
    80002cba:	bf61                	j	80002c52 <uniq_k+0xa0>
      }
    }
    // for last line
    print_str(prev_line, repeated, printed, c_flag, d_flag); 
    80002cbc:	8766                	mv	a4,s9
    80002cbe:	86ea                	mv	a3,s10
    80002cc0:	865e                	mv	a2,s7
    80002cc2:	85d2                	mv	a1,s4
    80002cc4:	99040513          	addi	a0,s0,-1648
    80002cc8:	00000097          	auipc	ra,0x0
    80002ccc:	e92080e7          	jalr	-366(ra) # 80002b5a <print_str>
  while ((n = fileread(f, addr, BUF_SIZE)) > 0) {
    80002cd0:	20000613          	li	a2,512
    80002cd4:	85e2                	mv	a1,s8
    80002cd6:	856e                	mv	a0,s11
    80002cd8:	00002097          	auipc	ra,0x2
    80002cdc:	7f2080e7          	jalr	2034(ra) # 800054ca <fileread>
    80002ce0:	892a                	mv	s2,a0
    80002ce2:	02a05b63          	blez	a0,80002d18 <uniq_k+0x166>
    copyinstr(myproc()->pagetable, buf, addr, n);
    80002ce6:	fffff097          	auipc	ra,0xfffff
    80002cea:	e6c080e7          	jalr	-404(ra) # 80001b52 <myproc>
    80002cee:	86ca                	mv	a3,s2
    80002cf0:	8662                	mv	a2,s8
    80002cf2:	d9040593          	addi	a1,s0,-624
    80002cf6:	6d28                	ld	a0,88(a0)
    80002cf8:	fffff097          	auipc	ra,0xfffff
    80002cfc:	c30080e7          	jalr	-976(ra) # 80001928 <copyinstr>
    for (i = 0, j = 0; i < n; i++) {
    80002d00:	d9040493          	addi	s1,s0,-624
    80002d04:	397d                	addiw	s2,s2,-1
    80002d06:	1902                	slli	s2,s2,0x20
    80002d08:	02095913          	srli	s2,s2,0x20
    80002d0c:	d9140793          	addi	a5,s0,-623
    80002d10:	993e                	add	s2,s2,a5
    80002d12:	8556                	mv	a0,s5
      if (buf[i] == '\n') {
    80002d14:	49a9                	li	s3,10
    80002d16:	b789                	j	80002c58 <uniq_k+0xa6>
  } 
}
    80002d18:	66813083          	ld	ra,1640(sp)
    80002d1c:	66013403          	ld	s0,1632(sp)
    80002d20:	65813483          	ld	s1,1624(sp)
    80002d24:	65013903          	ld	s2,1616(sp)
    80002d28:	64813983          	ld	s3,1608(sp)
    80002d2c:	64013a03          	ld	s4,1600(sp)
    80002d30:	63813a83          	ld	s5,1592(sp)
    80002d34:	63013b03          	ld	s6,1584(sp)
    80002d38:	62813b83          	ld	s7,1576(sp)
    80002d3c:	62013c03          	ld	s8,1568(sp)
    80002d40:	61813c83          	ld	s9,1560(sp)
    80002d44:	61013d03          	ld	s10,1552(sp)
    80002d48:	60813d83          	ld	s11,1544(sp)
    80002d4c:	67010113          	addi	sp,sp,1648
    80002d50:	8082                	ret

0000000080002d52 <head_k>:

void head_k(int fd, uint64 addr, const int count) {
    80002d52:	db010113          	addi	sp,sp,-592
    80002d56:	24113423          	sd	ra,584(sp)
    80002d5a:	24813023          	sd	s0,576(sp)
    80002d5e:	22913c23          	sd	s1,568(sp)
    80002d62:	23213823          	sd	s2,560(sp)
    80002d66:	23313423          	sd	s3,552(sp)
    80002d6a:	23413023          	sd	s4,544(sp)
    80002d6e:	21513c23          	sd	s5,536(sp)
    80002d72:	21613823          	sd	s6,528(sp)
    80002d76:	21713423          	sd	s7,520(sp)
    80002d7a:	21813023          	sd	s8,512(sp)
    80002d7e:	0c80                	addi	s0,sp,592
    80002d80:	84aa                	mv	s1,a0
    80002d82:	8a2e                	mv	s4,a1
    80002d84:	8ab2                	mv	s5,a2
  int n, i, line = 1;
  char buf[BUF_SIZE]; 

  printf("Head command is getting executed in kernel mode.\n");
    80002d86:	00006517          	auipc	a0,0x6
    80002d8a:	5ea50513          	addi	a0,a0,1514 # 80009370 <digits+0x310>
    80002d8e:	ffffd097          	auipc	ra,0xffffd
    80002d92:	7f8080e7          	jalr	2040(ra) # 80000586 <printf>
 
  struct file *f = myproc()->ofile[fd];
    80002d96:	fffff097          	auipc	ra,0xfffff
    80002d9a:	dbc080e7          	jalr	-580(ra) # 80001b52 <myproc>
    80002d9e:	01a48793          	addi	a5,s1,26
    80002da2:	078e                	slli	a5,a5,0x3
    80002da4:	97aa                	add	a5,a5,a0
    80002da6:	0087bc03          	ld	s8,8(a5)
  struct file *out_fd = myproc()->ofile[1];  
    80002daa:	fffff097          	auipc	ra,0xfffff
    80002dae:	da8080e7          	jalr	-600(ra) # 80001b52 <myproc>
    80002db2:	0e053b03          	ld	s6,224(a0)
  if (line > count) 
    80002db6:	4985                	li	s3,1
        break;  
      if (filewrite(out_fd, addr+i, 1) != 1) {
        printf("head: write error\n");
        exit(1);
      }
      if (buf[i] == '\n')
    80002db8:	4ba9                	li	s7,10
  if (line > count) 
    80002dba:	07504063          	bgtz	s5,80002e1a <head_k+0xc8>
    exit(0); 
    80002dbe:	4501                	li	a0,0
    80002dc0:	fffff097          	auipc	ra,0xfffff
    80002dc4:	71e080e7          	jalr	1822(ra) # 800024de <exit>
        printf("head: write error\n");
    80002dc8:	00006517          	auipc	a0,0x6
    80002dcc:	5e050513          	addi	a0,a0,1504 # 800093a8 <digits+0x348>
    80002dd0:	ffffd097          	auipc	ra,0xffffd
    80002dd4:	7b6080e7          	jalr	1974(ra) # 80000586 <printf>
        exit(1);
    80002dd8:	4505                	li	a0,1
    80002dda:	fffff097          	auipc	ra,0xfffff
    80002dde:	704080e7          	jalr	1796(ra) # 800024de <exit>
    for (i = 0; i < n; i++) {
    80002de2:	03248a63          	beq	s1,s2,80002e16 <head_k+0xc4>
      if (line > count)
    80002de6:	0485                	addi	s1,s1,1
    80002de8:	073acc63          	blt	s5,s3,80002e60 <head_k+0x10e>
      if (filewrite(out_fd, addr+i, 1) != 1) {
    80002dec:	4605                	li	a2,1
    80002dee:	85a6                	mv	a1,s1
    80002df0:	855a                	mv	a0,s6
    80002df2:	00002097          	auipc	ra,0x2
    80002df6:	79a080e7          	jalr	1946(ra) # 8000558c <filewrite>
    80002dfa:	4785                	li	a5,1
    80002dfc:	fcf516e3          	bne	a0,a5,80002dc8 <head_k+0x76>
      if (buf[i] == '\n')
    80002e00:	414487b3          	sub	a5,s1,s4
    80002e04:	db040713          	addi	a4,s0,-592
    80002e08:	97ba                	add	a5,a5,a4
    80002e0a:	0007c783          	lbu	a5,0(a5)
    80002e0e:	fd779ae3          	bne	a5,s7,80002de2 <head_k+0x90>
        line++;
    80002e12:	2985                	addiw	s3,s3,1
    80002e14:	b7f9                	j	80002de2 <head_k+0x90>
    }
    if (line > count)
    80002e16:	053ac563          	blt	s5,s3,80002e60 <head_k+0x10e>
  while ((n = fileread(f, addr, BUF_SIZE)) > 0) {
    80002e1a:	20000613          	li	a2,512
    80002e1e:	85d2                	mv	a1,s4
    80002e20:	8562                	mv	a0,s8
    80002e22:	00002097          	auipc	ra,0x2
    80002e26:	6a8080e7          	jalr	1704(ra) # 800054ca <fileread>
    80002e2a:	892a                	mv	s2,a0
    80002e2c:	02a05863          	blez	a0,80002e5c <head_k+0x10a>
    copyinstr(myproc()->pagetable, buf, addr, n); 
    80002e30:	fffff097          	auipc	ra,0xfffff
    80002e34:	d22080e7          	jalr	-734(ra) # 80001b52 <myproc>
    80002e38:	86ca                	mv	a3,s2
    80002e3a:	8652                	mv	a2,s4
    80002e3c:	db040593          	addi	a1,s0,-592
    80002e40:	6d28                	ld	a0,88(a0)
    80002e42:	fffff097          	auipc	ra,0xfffff
    80002e46:	ae6080e7          	jalr	-1306(ra) # 80001928 <copyinstr>
      if (line > count)
    80002e4a:	013acb63          	blt	s5,s3,80002e60 <head_k+0x10e>
    80002e4e:	397d                	addiw	s2,s2,-1
    80002e50:	1902                	slli	s2,s2,0x20
    80002e52:	02095913          	srli	s2,s2,0x20
    80002e56:	9952                	add	s2,s2,s4
    80002e58:	84d2                	mv	s1,s4
    80002e5a:	bf49                	j	80002dec <head_k+0x9a>
      break;
  }
  if (n < 0) {
    80002e5c:	02054963          	bltz	a0,80002e8e <head_k+0x13c>
    printf("head: read error\n");
    exit(1);
  }
}
    80002e60:	24813083          	ld	ra,584(sp)
    80002e64:	24013403          	ld	s0,576(sp)
    80002e68:	23813483          	ld	s1,568(sp)
    80002e6c:	23013903          	ld	s2,560(sp)
    80002e70:	22813983          	ld	s3,552(sp)
    80002e74:	22013a03          	ld	s4,544(sp)
    80002e78:	21813a83          	ld	s5,536(sp)
    80002e7c:	21013b03          	ld	s6,528(sp)
    80002e80:	20813b83          	ld	s7,520(sp)
    80002e84:	20013c03          	ld	s8,512(sp)
    80002e88:	25010113          	addi	sp,sp,592
    80002e8c:	8082                	ret
    printf("head: read error\n");
    80002e8e:	00006517          	auipc	a0,0x6
    80002e92:	53250513          	addi	a0,a0,1330 # 800093c0 <digits+0x360>
    80002e96:	ffffd097          	auipc	ra,0xffffd
    80002e9a:	6f0080e7          	jalr	1776(ra) # 80000586 <printf>
    exit(1);
    80002e9e:	4505                	li	a0,1
    80002ea0:	fffff097          	auipc	ra,0xfffff
    80002ea4:	63e080e7          	jalr	1598(ra) # 800024de <exit>

0000000080002ea8 <printProcInfo>:
		
void printProcInfo(struct proc *p) {
    80002ea8:	1101                	addi	sp,sp,-32
    80002eaa:	ec06                	sd	ra,24(sp)
    80002eac:	e822                	sd	s0,16(sp)
    80002eae:	1000                	addi	s0,sp,32
  printf("%d\t| %s\t| %s\t| %d\t\t| %d\t\t| %d\t\t| %d\t\t| %d\n", p->pid, p->name, states[p->state], p->priority, p->creation_time, p->start_time, p->end_time, p->total_time); 
    80002eb0:	01856683          	lwu	a3,24(a0)
    80002eb4:	00369793          	slli	a5,a3,0x3
    80002eb8:	00006697          	auipc	a3,0x6
    80002ebc:	66868693          	addi	a3,a3,1640 # 80009520 <states.0>
    80002ec0:	96be                	add	a3,a3,a5
    80002ec2:	18853783          	ld	a5,392(a0)
    80002ec6:	e03e                	sd	a5,0(sp)
    80002ec8:	18053883          	ld	a7,384(a0)
    80002ecc:	17853803          	ld	a6,376(a0)
    80002ed0:	17053783          	ld	a5,368(a0)
    80002ed4:	19053703          	ld	a4,400(a0)
    80002ed8:	7a94                	ld	a3,48(a3)
    80002eda:	16050613          	addi	a2,a0,352
    80002ede:	590c                	lw	a1,48(a0)
    80002ee0:	00006517          	auipc	a0,0x6
    80002ee4:	4f850513          	addi	a0,a0,1272 # 800093d8 <digits+0x378>
    80002ee8:	ffffd097          	auipc	ra,0xffffd
    80002eec:	69e080e7          	jalr	1694(ra) # 80000586 <printf>
}
    80002ef0:	60e2                	ld	ra,24(sp)
    80002ef2:	6442                	ld	s0,16(sp)
    80002ef4:	6105                	addi	sp,sp,32
    80002ef6:	8082                	ret

0000000080002ef8 <ps>:
// Get information about a process (using pid/name) or all processes
// option: 
// 0 : print all processes
// 1: print process with pid
// 2: print process with name (at addr)
void ps(int option, int value, uint64 addr) {
    80002ef8:	7139                	addi	sp,sp,-64
    80002efa:	fc06                	sd	ra,56(sp)
    80002efc:	f822                	sd	s0,48(sp)
    80002efe:	f426                	sd	s1,40(sp)
    80002f00:	f04a                	sd	s2,32(sp)
    80002f02:	ec4e                	sd	s3,24(sp)
    80002f04:	e852                	sd	s4,16(sp)
    80002f06:	e456                	sd	s5,8(sp)
    80002f08:	0080                	addi	s0,sp,64
    80002f0a:	84aa                	mv	s1,a0
    80002f0c:	892e                	mv	s2,a1
    80002f0e:	89b2                	mv	s3,a2
  struct proc *p;

  printf("PID \t| Name \t| State \t| Priority \t| Creation \t| Start \t| End\t\t| Total \n");
    80002f10:	00006517          	auipc	a0,0x6
    80002f14:	4f850513          	addi	a0,a0,1272 # 80009408 <digits+0x3a8>
    80002f18:	ffffd097          	auipc	ra,0xffffd
    80002f1c:	66e080e7          	jalr	1646(ra) # 80000586 <printf>
  
  if (option == 0) {
    80002f20:	e495                	bnez	s1,80002f4c <ps+0x54>
    for (p = proc; p < &proc[NPROC]; p++) {
    80002f22:	0000f497          	auipc	s1,0xf
    80002f26:	31e48493          	addi	s1,s1,798 # 80012240 <proc>
    80002f2a:	00016917          	auipc	s2,0x16
    80002f2e:	f1690913          	addi	s2,s2,-234 # 80018e40 <tickslock>
    80002f32:	a029                	j	80002f3c <ps+0x44>
    80002f34:	1b048493          	addi	s1,s1,432
    80002f38:	03248863          	beq	s1,s2,80002f68 <ps+0x70>
      if (p->state != UNUSED)
    80002f3c:	4c9c                	lw	a5,24(s1)
    80002f3e:	dbfd                	beqz	a5,80002f34 <ps+0x3c>
        printProcInfo(p); 
    80002f40:	8526                	mv	a0,s1
    80002f42:	00000097          	auipc	ra,0x0
    80002f46:	f66080e7          	jalr	-154(ra) # 80002ea8 <printProcInfo>
    80002f4a:	b7ed                	j	80002f34 <ps+0x3c>
    }
  } else if (option == 1) {
    80002f4c:	4785                	li	a5,1
    80002f4e:	02f48863          	beq	s1,a5,80002f7e <ps+0x86>
	      break; 
      }
    }
    if (p == &proc[NPROC]) 
      printf("ps: cannot find process with pid %d\n", value); 
  } else if (option == 2) {
    80002f52:	4789                	li	a5,2
    80002f54:	06f48a63          	beq	s1,a5,80002fc8 <ps+0xd0>
      }
    }
    if (p == &proc[NPROC])
      printf("ps: cannot find process with name %s\n", name); 
  } else {
    printf("ps: invalid option\n"); 
    80002f58:	00006517          	auipc	a0,0x6
    80002f5c:	54850513          	addi	a0,a0,1352 # 800094a0 <digits+0x440>
    80002f60:	ffffd097          	auipc	ra,0xffffd
    80002f64:	626080e7          	jalr	1574(ra) # 80000586 <printf>
  }
}
    80002f68:	fc040113          	addi	sp,s0,-64
    80002f6c:	70e2                	ld	ra,56(sp)
    80002f6e:	7442                	ld	s0,48(sp)
    80002f70:	74a2                	ld	s1,40(sp)
    80002f72:	7902                	ld	s2,32(sp)
    80002f74:	69e2                	ld	s3,24(sp)
    80002f76:	6a42                	ld	s4,16(sp)
    80002f78:	6aa2                	ld	s5,8(sp)
    80002f7a:	6121                	addi	sp,sp,64
    80002f7c:	8082                	ret
    for (p = proc; p < &proc[NPROC]; p++) {
    80002f7e:	0000f497          	auipc	s1,0xf
    80002f82:	2c248493          	addi	s1,s1,706 # 80012240 <proc>
    80002f86:	00016717          	auipc	a4,0x16
    80002f8a:	eba70713          	addi	a4,a4,-326 # 80018e40 <tickslock>
      if (p->pid == value) {
    80002f8e:	589c                	lw	a5,48(s1)
    80002f90:	03278063          	beq	a5,s2,80002fb0 <ps+0xb8>
    for (p = proc; p < &proc[NPROC]; p++) {
    80002f94:	1b048493          	addi	s1,s1,432
    80002f98:	fee49be3          	bne	s1,a4,80002f8e <ps+0x96>
      printf("ps: cannot find process with pid %d\n", value); 
    80002f9c:	85ca                	mv	a1,s2
    80002f9e:	00006517          	auipc	a0,0x6
    80002fa2:	4b250513          	addi	a0,a0,1202 # 80009450 <digits+0x3f0>
    80002fa6:	ffffd097          	auipc	ra,0xffffd
    80002faa:	5e0080e7          	jalr	1504(ra) # 80000586 <printf>
    80002fae:	bf6d                	j	80002f68 <ps+0x70>
        printProcInfo(p); 
    80002fb0:	8526                	mv	a0,s1
    80002fb2:	00000097          	auipc	ra,0x0
    80002fb6:	ef6080e7          	jalr	-266(ra) # 80002ea8 <printProcInfo>
    if (p == &proc[NPROC]) 
    80002fba:	00016797          	auipc	a5,0x16
    80002fbe:	e8678793          	addi	a5,a5,-378 # 80018e40 <tickslock>
    80002fc2:	faf493e3          	bne	s1,a5,80002f68 <ps+0x70>
    80002fc6:	bfd9                	j	80002f9c <ps+0xa4>
  } else if (option == 2) {
    80002fc8:	8a8a                	mv	s5,sp
    char name[value+1]; 
    80002fca:	0019079b          	addiw	a5,s2,1
    80002fce:	07bd                	addi	a5,a5,15
    80002fd0:	9bc1                	andi	a5,a5,-16
    80002fd2:	40f10133          	sub	sp,sp,a5
    80002fd6:	8a0a                	mv	s4,sp
    copyinstr(myproc()->pagetable, name, addr, value); 
    80002fd8:	fffff097          	auipc	ra,0xfffff
    80002fdc:	b7a080e7          	jalr	-1158(ra) # 80001b52 <myproc>
    80002fe0:	86ca                	mv	a3,s2
    80002fe2:	864e                	mv	a2,s3
    80002fe4:	858a                	mv	a1,sp
    80002fe6:	6d28                	ld	a0,88(a0)
    80002fe8:	fffff097          	auipc	ra,0xfffff
    80002fec:	940080e7          	jalr	-1728(ra) # 80001928 <copyinstr>
    for (p = proc; p < &proc[NPROC]; p++) {
    80002ff0:	0000f497          	auipc	s1,0xf
    80002ff4:	25048493          	addi	s1,s1,592 # 80012240 <proc>
      if (!strncmp(p->name, name, value)) {
    80002ff8:	2901                	sext.w	s2,s2
    for (p = proc; p < &proc[NPROC]; p++) {
    80002ffa:	00016997          	auipc	s3,0x16
    80002ffe:	e4698993          	addi	s3,s3,-442 # 80018e40 <tickslock>
      if (!strncmp(p->name, name, value)) {
    80003002:	864a                	mv	a2,s2
    80003004:	85d2                	mv	a1,s4
    80003006:	16048513          	addi	a0,s1,352
    8000300a:	ffffe097          	auipc	ra,0xffffe
    8000300e:	e3e080e7          	jalr	-450(ra) # 80000e48 <strncmp>
    80003012:	cd19                	beqz	a0,80003030 <ps+0x138>
    for (p = proc; p < &proc[NPROC]; p++) {
    80003014:	1b048493          	addi	s1,s1,432
    80003018:	ff3495e3          	bne	s1,s3,80003002 <ps+0x10a>
      printf("ps: cannot find process with name %s\n", name); 
    8000301c:	85d2                	mv	a1,s4
    8000301e:	00006517          	auipc	a0,0x6
    80003022:	45a50513          	addi	a0,a0,1114 # 80009478 <digits+0x418>
    80003026:	ffffd097          	auipc	ra,0xffffd
    8000302a:	560080e7          	jalr	1376(ra) # 80000586 <printf>
    8000302e:	a821                	j	80003046 <ps+0x14e>
        printProcInfo(p); 
    80003030:	8526                	mv	a0,s1
    80003032:	00000097          	auipc	ra,0x0
    80003036:	e76080e7          	jalr	-394(ra) # 80002ea8 <printProcInfo>
    if (p == &proc[NPROC])
    8000303a:	00016797          	auipc	a5,0x16
    8000303e:	e0678793          	addi	a5,a5,-506 # 80018e40 <tickslock>
    80003042:	fcf48de3          	beq	s1,a5,8000301c <ps+0x124>
    80003046:	8156                	mv	sp,s5
    80003048:	b705                	j	80002f68 <ps+0x70>

000000008000304a <updateTime>:

void updateTime() {
    8000304a:	7179                	addi	sp,sp,-48
    8000304c:	f406                	sd	ra,40(sp)
    8000304e:	f022                	sd	s0,32(sp)
    80003050:	ec26                	sd	s1,24(sp)
    80003052:	e84a                	sd	s2,16(sp)
    80003054:	e44e                	sd	s3,8(sp)
    80003056:	e052                	sd	s4,0(sp)
    80003058:	1800                	addi	s0,sp,48
  struct proc *p;
  for (p = proc; p < &proc[NPROC]; p++) {
    8000305a:	0000f497          	auipc	s1,0xf
    8000305e:	1e648493          	addi	s1,s1,486 # 80012240 <proc>
    acquire(&p->lock);
    if (p->state == RUNNING) {
    80003062:	4991                	li	s3,4
      p->run_time++;
    }
    if (p->state == SLEEPING)
    80003064:	4a09                	li	s4,2
  for (p = proc; p < &proc[NPROC]; p++) {
    80003066:	00016917          	auipc	s2,0x16
    8000306a:	dda90913          	addi	s2,s2,-550 # 80018e40 <tickslock>
    8000306e:	a839                	j	8000308c <updateTime+0x42>
      p->run_time++;
    80003070:	1984b783          	ld	a5,408(s1)
    80003074:	0785                	addi	a5,a5,1
    80003076:	18f4bc23          	sd	a5,408(s1)
      p->sleep_time++;
    release(&p->lock);
    8000307a:	8526                	mv	a0,s1
    8000307c:	ffffe097          	auipc	ra,0xffffe
    80003080:	cb4080e7          	jalr	-844(ra) # 80000d30 <release>
  for (p = proc; p < &proc[NPROC]; p++) {
    80003084:	1b048493          	addi	s1,s1,432
    80003088:	03248263          	beq	s1,s2,800030ac <updateTime+0x62>
    acquire(&p->lock);
    8000308c:	8526                	mv	a0,s1
    8000308e:	ffffe097          	auipc	ra,0xffffe
    80003092:	bee080e7          	jalr	-1042(ra) # 80000c7c <acquire>
    if (p->state == RUNNING) {
    80003096:	4c9c                	lw	a5,24(s1)
    80003098:	fd378ce3          	beq	a5,s3,80003070 <updateTime+0x26>
    if (p->state == SLEEPING)
    8000309c:	fd479fe3          	bne	a5,s4,8000307a <updateTime+0x30>
      p->sleep_time++;
    800030a0:	1a04b783          	ld	a5,416(s1)
    800030a4:	0785                	addi	a5,a5,1
    800030a6:	1af4b023          	sd	a5,416(s1)
    800030aa:	bfc1                	j	8000307a <updateTime+0x30>
  }
}
    800030ac:	70a2                	ld	ra,40(sp)
    800030ae:	7402                	ld	s0,32(sp)
    800030b0:	64e2                	ld	s1,24(sp)
    800030b2:	6942                	ld	s2,16(sp)
    800030b4:	69a2                	ld	s3,8(sp)
    800030b6:	6a02                	ld	s4,0(sp)
    800030b8:	6145                	addi	sp,sp,48
    800030ba:	8082                	ret

00000000800030bc <set_scheduler>:

void set_scheduler(int scheduler) {
    800030bc:	1101                	addi	sp,sp,-32
    800030be:	ec06                	sd	ra,24(sp)
    800030c0:	e822                	sd	s0,16(sp)
    800030c2:	e426                	sd	s1,8(sp)
    800030c4:	1000                	addi	s0,sp,32
    800030c6:	84aa                	mv	s1,a0
  acquire(&proc->lock);
    800030c8:	0000f517          	auipc	a0,0xf
    800030cc:	17850513          	addi	a0,a0,376 # 80012240 <proc>
    800030d0:	ffffe097          	auipc	ra,0xffffe
    800030d4:	bac080e7          	jalr	-1108(ra) # 80000c7c <acquire>
  scheduler_type = scheduler; 
    800030d8:	00007797          	auipc	a5,0x7
    800030dc:	ac97a023          	sw	s1,-1344(a5) # 80009b98 <scheduler_type>
  release(&proc->lock);
    800030e0:	0000f517          	auipc	a0,0xf
    800030e4:	16050513          	addi	a0,a0,352 # 80012240 <proc>
    800030e8:	ffffe097          	auipc	ra,0xffffe
    800030ec:	c48080e7          	jalr	-952(ra) # 80000d30 <release>
}
    800030f0:	60e2                	ld	ra,24(sp)
    800030f2:	6442                	ld	s0,16(sp)
    800030f4:	64a2                	ld	s1,8(sp)
    800030f6:	6105                	addi	sp,sp,32
    800030f8:	8082                	ret

00000000800030fa <set_priority>:

int set_priority(int pid, int priority) {
    800030fa:	7179                	addi	sp,sp,-48
    800030fc:	f406                	sd	ra,40(sp)
    800030fe:	f022                	sd	s0,32(sp)
    80003100:	ec26                	sd	s1,24(sp)
    80003102:	e84a                	sd	s2,16(sp)
    80003104:	e44e                	sd	s3,8(sp)
    80003106:	e052                	sd	s4,0(sp)
    80003108:	1800                	addi	s0,sp,48
    8000310a:	892a                	mv	s2,a0
    8000310c:	8a2e                	mv	s4,a1
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    8000310e:	0000f497          	auipc	s1,0xf
    80003112:	13248493          	addi	s1,s1,306 # 80012240 <proc>
    80003116:	00016997          	auipc	s3,0x16
    8000311a:	d2a98993          	addi	s3,s3,-726 # 80018e40 <tickslock>
    acquire(&p->lock);
    8000311e:	8526                	mv	a0,s1
    80003120:	ffffe097          	auipc	ra,0xffffe
    80003124:	b5c080e7          	jalr	-1188(ra) # 80000c7c <acquire>
    
    if(p->pid == pid) {
    80003128:	589c                	lw	a5,48(s1)
    8000312a:	01278d63          	beq	a5,s2,80003144 <set_priority+0x4a>

      if (val > priority)
        yield();
      return val;
    }
    release(&p->lock);
    8000312e:	8526                	mv	a0,s1
    80003130:	ffffe097          	auipc	ra,0xffffe
    80003134:	c00080e7          	jalr	-1024(ra) # 80000d30 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80003138:	1b048493          	addi	s1,s1,432
    8000313c:	ff3491e3          	bne	s1,s3,8000311e <set_priority+0x24>
  }
  return -1;
    80003140:	597d                	li	s2,-1
    80003142:	a005                	j	80003162 <set_priority+0x68>
      int val = p->priority;
    80003144:	1904a903          	lw	s2,400(s1)
      p->priority = priority;
    80003148:	1944b823          	sd	s4,400(s1)
      p->run_time = 0;
    8000314c:	1804bc23          	sd	zero,408(s1)
      p->sleep_time = 0;
    80003150:	1a04b023          	sd	zero,416(s1)
      release(&p->lock);
    80003154:	8526                	mv	a0,s1
    80003156:	ffffe097          	auipc	ra,0xffffe
    8000315a:	bda080e7          	jalr	-1062(ra) # 80000d30 <release>
      if (val > priority)
    8000315e:	012a4b63          	blt	s4,s2,80003174 <set_priority+0x7a>
}
    80003162:	854a                	mv	a0,s2
    80003164:	70a2                	ld	ra,40(sp)
    80003166:	7402                	ld	s0,32(sp)
    80003168:	64e2                	ld	s1,24(sp)
    8000316a:	6942                	ld	s2,16(sp)
    8000316c:	69a2                	ld	s3,8(sp)
    8000316e:	6a02                	ld	s4,0(sp)
    80003170:	6145                	addi	sp,sp,48
    80003172:	8082                	ret
        yield();
    80003174:	fffff097          	auipc	ra,0xfffff
    80003178:	1fa080e7          	jalr	506(ra) # 8000236e <yield>
    8000317c:	b7dd                	j	80003162 <set_priority+0x68>

000000008000317e <get_scheduler>:

int get_scheduler() {
    8000317e:	1141                	addi	sp,sp,-16
    80003180:	e422                	sd	s0,8(sp)
    80003182:	0800                	addi	s0,sp,16
  return scheduler_type; 
    80003184:	00007517          	auipc	a0,0x7
    80003188:	a1452503          	lw	a0,-1516(a0) # 80009b98 <scheduler_type>
    8000318c:	6422                	ld	s0,8(sp)
    8000318e:	0141                	addi	sp,sp,16
    80003190:	8082                	ret

0000000080003192 <swtch>:
    80003192:	00153023          	sd	ra,0(a0)
    80003196:	00253423          	sd	sp,8(a0)
    8000319a:	e900                	sd	s0,16(a0)
    8000319c:	ed04                	sd	s1,24(a0)
    8000319e:	03253023          	sd	s2,32(a0)
    800031a2:	03353423          	sd	s3,40(a0)
    800031a6:	03453823          	sd	s4,48(a0)
    800031aa:	03553c23          	sd	s5,56(a0)
    800031ae:	05653023          	sd	s6,64(a0)
    800031b2:	05753423          	sd	s7,72(a0)
    800031b6:	05853823          	sd	s8,80(a0)
    800031ba:	05953c23          	sd	s9,88(a0)
    800031be:	07a53023          	sd	s10,96(a0)
    800031c2:	07b53423          	sd	s11,104(a0)
    800031c6:	0005b083          	ld	ra,0(a1)
    800031ca:	0085b103          	ld	sp,8(a1)
    800031ce:	6980                	ld	s0,16(a1)
    800031d0:	6d84                	ld	s1,24(a1)
    800031d2:	0205b903          	ld	s2,32(a1)
    800031d6:	0285b983          	ld	s3,40(a1)
    800031da:	0305ba03          	ld	s4,48(a1)
    800031de:	0385ba83          	ld	s5,56(a1)
    800031e2:	0405bb03          	ld	s6,64(a1)
    800031e6:	0485bb83          	ld	s7,72(a1)
    800031ea:	0505bc03          	ld	s8,80(a1)
    800031ee:	0585bc83          	ld	s9,88(a1)
    800031f2:	0605bd03          	ld	s10,96(a1)
    800031f6:	0685bd83          	ld	s11,104(a1)
    800031fa:	8082                	ret

00000000800031fc <trapinit>:

extern int devintr();

void
trapinit(void)
{
    800031fc:	1141                	addi	sp,sp,-16
    800031fe:	e406                	sd	ra,8(sp)
    80003200:	e022                	sd	s0,0(sp)
    80003202:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80003204:	00006597          	auipc	a1,0x6
    80003208:	37c58593          	addi	a1,a1,892 # 80009580 <states+0x30>
    8000320c:	00016517          	auipc	a0,0x16
    80003210:	c3450513          	addi	a0,a0,-972 # 80018e40 <tickslock>
    80003214:	ffffe097          	auipc	ra,0xffffe
    80003218:	9d8080e7          	jalr	-1576(ra) # 80000bec <initlock>
}
    8000321c:	60a2                	ld	ra,8(sp)
    8000321e:	6402                	ld	s0,0(sp)
    80003220:	0141                	addi	sp,sp,16
    80003222:	8082                	ret

0000000080003224 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80003224:	1141                	addi	sp,sp,-16
    80003226:	e422                	sd	s0,8(sp)
    80003228:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    8000322a:	00003797          	auipc	a5,0x3
    8000322e:	79678793          	addi	a5,a5,1942 # 800069c0 <kernelvec>
    80003232:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80003236:	6422                	ld	s0,8(sp)
    80003238:	0141                	addi	sp,sp,16
    8000323a:	8082                	ret

000000008000323c <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    8000323c:	1141                	addi	sp,sp,-16
    8000323e:	e406                	sd	ra,8(sp)
    80003240:	e022                	sd	s0,0(sp)
    80003242:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80003244:	fffff097          	auipc	ra,0xfffff
    80003248:	90e080e7          	jalr	-1778(ra) # 80001b52 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000324c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80003250:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80003252:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80003256:	00005617          	auipc	a2,0x5
    8000325a:	daa60613          	addi	a2,a2,-598 # 80008000 <_trampoline>
    8000325e:	00005697          	auipc	a3,0x5
    80003262:	da268693          	addi	a3,a3,-606 # 80008000 <_trampoline>
    80003266:	8e91                	sub	a3,a3,a2
    80003268:	040007b7          	lui	a5,0x4000
    8000326c:	17fd                	addi	a5,a5,-1
    8000326e:	07b2                	slli	a5,a5,0xc
    80003270:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80003272:	10569073          	csrw	stvec,a3
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80003276:	7138                	ld	a4,96(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80003278:	180026f3          	csrr	a3,satp
    8000327c:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    8000327e:	7138                	ld	a4,96(a0)
    80003280:	6134                	ld	a3,64(a0)
    80003282:	6585                	lui	a1,0x1
    80003284:	96ae                	add	a3,a3,a1
    80003286:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80003288:	7138                	ld	a4,96(a0)
    8000328a:	00000697          	auipc	a3,0x0
    8000328e:	13e68693          	addi	a3,a3,318 # 800033c8 <usertrap>
    80003292:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80003294:	7138                	ld	a4,96(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80003296:	8692                	mv	a3,tp
    80003298:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000329a:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    8000329e:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800032a2:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800032a6:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    800032aa:	7138                	ld	a4,96(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    800032ac:	6f18                	ld	a4,24(a4)
    800032ae:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    800032b2:	6d28                	ld	a0,88(a0)
    800032b4:	8131                	srli	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    800032b6:	00005717          	auipc	a4,0x5
    800032ba:	de670713          	addi	a4,a4,-538 # 8000809c <userret>
    800032be:	8f11                	sub	a4,a4,a2
    800032c0:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    800032c2:	577d                	li	a4,-1
    800032c4:	177e                	slli	a4,a4,0x3f
    800032c6:	8d59                	or	a0,a0,a4
    800032c8:	9782                	jalr	a5
}
    800032ca:	60a2                	ld	ra,8(sp)
    800032cc:	6402                	ld	s0,0(sp)
    800032ce:	0141                	addi	sp,sp,16
    800032d0:	8082                	ret

00000000800032d2 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    800032d2:	1101                	addi	sp,sp,-32
    800032d4:	ec06                	sd	ra,24(sp)
    800032d6:	e822                	sd	s0,16(sp)
    800032d8:	e426                	sd	s1,8(sp)
    800032da:	e04a                	sd	s2,0(sp)
    800032dc:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    800032de:	00016917          	auipc	s2,0x16
    800032e2:	b6290913          	addi	s2,s2,-1182 # 80018e40 <tickslock>
    800032e6:	854a                	mv	a0,s2
    800032e8:	ffffe097          	auipc	ra,0xffffe
    800032ec:	994080e7          	jalr	-1644(ra) # 80000c7c <acquire>
  ticks++;
    800032f0:	00007497          	auipc	s1,0x7
    800032f4:	8b848493          	addi	s1,s1,-1864 # 80009ba8 <ticks>
    800032f8:	409c                	lw	a5,0(s1)
    800032fa:	2785                	addiw	a5,a5,1
    800032fc:	c09c                	sw	a5,0(s1)
  updateTime();
    800032fe:	00000097          	auipc	ra,0x0
    80003302:	d4c080e7          	jalr	-692(ra) # 8000304a <updateTime>
  wakeup(&ticks);
    80003306:	8526                	mv	a0,s1
    80003308:	fffff097          	auipc	ra,0xfffff
    8000330c:	106080e7          	jalr	262(ra) # 8000240e <wakeup>
  release(&tickslock);
    80003310:	854a                	mv	a0,s2
    80003312:	ffffe097          	auipc	ra,0xffffe
    80003316:	a1e080e7          	jalr	-1506(ra) # 80000d30 <release>
}
    8000331a:	60e2                	ld	ra,24(sp)
    8000331c:	6442                	ld	s0,16(sp)
    8000331e:	64a2                	ld	s1,8(sp)
    80003320:	6902                	ld	s2,0(sp)
    80003322:	6105                	addi	sp,sp,32
    80003324:	8082                	ret

0000000080003326 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80003326:	1101                	addi	sp,sp,-32
    80003328:	ec06                	sd	ra,24(sp)
    8000332a:	e822                	sd	s0,16(sp)
    8000332c:	e426                	sd	s1,8(sp)
    8000332e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80003330:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80003334:	00074d63          	bltz	a4,8000334e <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80003338:	57fd                	li	a5,-1
    8000333a:	17fe                	slli	a5,a5,0x3f
    8000333c:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    8000333e:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80003340:	06f70363          	beq	a4,a5,800033a6 <devintr+0x80>
  }
}
    80003344:	60e2                	ld	ra,24(sp)
    80003346:	6442                	ld	s0,16(sp)
    80003348:	64a2                	ld	s1,8(sp)
    8000334a:	6105                	addi	sp,sp,32
    8000334c:	8082                	ret
     (scause & 0xff) == 9){
    8000334e:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    80003352:	46a5                	li	a3,9
    80003354:	fed792e3          	bne	a5,a3,80003338 <devintr+0x12>
    int irq = plic_claim();
    80003358:	00003097          	auipc	ra,0x3
    8000335c:	770080e7          	jalr	1904(ra) # 80006ac8 <plic_claim>
    80003360:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80003362:	47a9                	li	a5,10
    80003364:	02f50763          	beq	a0,a5,80003392 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80003368:	4785                	li	a5,1
    8000336a:	02f50963          	beq	a0,a5,8000339c <devintr+0x76>
    return 1;
    8000336e:	4505                	li	a0,1
    } else if(irq){
    80003370:	d8f1                	beqz	s1,80003344 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80003372:	85a6                	mv	a1,s1
    80003374:	00006517          	auipc	a0,0x6
    80003378:	21450513          	addi	a0,a0,532 # 80009588 <states+0x38>
    8000337c:	ffffd097          	auipc	ra,0xffffd
    80003380:	20a080e7          	jalr	522(ra) # 80000586 <printf>
      plic_complete(irq);
    80003384:	8526                	mv	a0,s1
    80003386:	00003097          	auipc	ra,0x3
    8000338a:	766080e7          	jalr	1894(ra) # 80006aec <plic_complete>
    return 1;
    8000338e:	4505                	li	a0,1
    80003390:	bf55                	j	80003344 <devintr+0x1e>
      uartintr();
    80003392:	ffffd097          	auipc	ra,0xffffd
    80003396:	6ae080e7          	jalr	1710(ra) # 80000a40 <uartintr>
    8000339a:	b7ed                	j	80003384 <devintr+0x5e>
      virtio_disk_intr();
    8000339c:	00004097          	auipc	ra,0x4
    800033a0:	c1c080e7          	jalr	-996(ra) # 80006fb8 <virtio_disk_intr>
    800033a4:	b7c5                	j	80003384 <devintr+0x5e>
    if(cpuid() == 0){
    800033a6:	ffffe097          	auipc	ra,0xffffe
    800033aa:	780080e7          	jalr	1920(ra) # 80001b26 <cpuid>
    800033ae:	c901                	beqz	a0,800033be <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    800033b0:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    800033b4:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    800033b6:	14479073          	csrw	sip,a5
    return 2;
    800033ba:	4509                	li	a0,2
    800033bc:	b761                	j	80003344 <devintr+0x1e>
      clockintr();
    800033be:	00000097          	auipc	ra,0x0
    800033c2:	f14080e7          	jalr	-236(ra) # 800032d2 <clockintr>
    800033c6:	b7ed                	j	800033b0 <devintr+0x8a>

00000000800033c8 <usertrap>:
{
    800033c8:	1101                	addi	sp,sp,-32
    800033ca:	ec06                	sd	ra,24(sp)
    800033cc:	e822                	sd	s0,16(sp)
    800033ce:	e426                	sd	s1,8(sp)
    800033d0:	e04a                	sd	s2,0(sp)
    800033d2:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800033d4:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    800033d8:	1007f793          	andi	a5,a5,256
    800033dc:	efd5                	bnez	a5,80003498 <usertrap+0xd0>
  asm volatile("csrw stvec, %0" : : "r" (x));
    800033de:	00003797          	auipc	a5,0x3
    800033e2:	5e278793          	addi	a5,a5,1506 # 800069c0 <kernelvec>
    800033e6:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    800033ea:	ffffe097          	auipc	ra,0xffffe
    800033ee:	768080e7          	jalr	1896(ra) # 80001b52 <myproc>
    800033f2:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    800033f4:	713c                	ld	a5,96(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800033f6:	14102773          	csrr	a4,sepc
    800033fa:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    800033fc:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80003400:	47a1                	li	a5,8
    80003402:	0af70363          	beq	a4,a5,800034a8 <usertrap+0xe0>
    80003406:	14202773          	csrr	a4,scause
  } else if (r_scause() == 14 || r_scause() == 15) {
    8000340a:	47b9                	li	a5,14
    8000340c:	00f70763          	beq	a4,a5,8000341a <usertrap+0x52>
    80003410:	14202773          	csrr	a4,scause
    80003414:	47bd                	li	a5,15
    80003416:	12f71063          	bne	a4,a5,80003536 <usertrap+0x16e>
    if(p->trapframe->sp < p->stack_sz){
    8000341a:	64b0                	ld	a2,72(s1)
    8000341c:	70bc                	ld	a5,96(s1)
    8000341e:	7b9c                	ld	a5,48(a5)
    80003420:	0cc7fe63          	bgeu	a5,a2,800034fc <usertrap+0x134>
  asm volatile("csrr %0, stval" : "=r" (x) );
    80003424:	143027f3          	csrr	a5,stval
      if (stack_addr <= p->stack_sz && stack_addr >= p->stack_sz-PGSIZE && p->stack_sz-PGSIZE*6 >= p->sz) {
    80003428:	00f66b63          	bltu	a2,a5,8000343e <usertrap+0x76>
    8000342c:	75fd                	lui	a1,0xfffff
    8000342e:	95b2                	add	a1,a1,a2
    80003430:	00b7e763          	bltu	a5,a1,8000343e <usertrap+0x76>
    80003434:	77e9                	lui	a5,0xffffa
    80003436:	97b2                	add	a5,a5,a2
    80003438:	68b8                	ld	a4,80(s1)
    8000343a:	0ae7f163          	bgeu	a5,a4,800034dc <usertrap+0x114>
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000343e:	142025f3          	csrr	a1,scause
        printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80003442:	5890                	lw	a2,48(s1)
    80003444:	00006517          	auipc	a0,0x6
    80003448:	18450513          	addi	a0,a0,388 # 800095c8 <states+0x78>
    8000344c:	ffffd097          	auipc	ra,0xffffd
    80003450:	13a080e7          	jalr	314(ra) # 80000586 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80003454:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80003458:	14302673          	csrr	a2,stval
        printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    8000345c:	00006517          	auipc	a0,0x6
    80003460:	19c50513          	addi	a0,a0,412 # 800095f8 <states+0xa8>
    80003464:	ffffd097          	auipc	ra,0xffffd
    80003468:	122080e7          	jalr	290(ra) # 80000586 <printf>
        setkilled(p);
    8000346c:	8526                	mv	a0,s1
    8000346e:	fffff097          	auipc	ra,0xfffff
    80003472:	1ce080e7          	jalr	462(ra) # 8000263c <setkilled>
  if(killed(p))
    80003476:	8526                	mv	a0,s1
    80003478:	fffff097          	auipc	ra,0xfffff
    8000347c:	1f0080e7          	jalr	496(ra) # 80002668 <killed>
    80003480:	10051563          	bnez	a0,8000358a <usertrap+0x1c2>
  usertrapret();
    80003484:	00000097          	auipc	ra,0x0
    80003488:	db8080e7          	jalr	-584(ra) # 8000323c <usertrapret>
}
    8000348c:	60e2                	ld	ra,24(sp)
    8000348e:	6442                	ld	s0,16(sp)
    80003490:	64a2                	ld	s1,8(sp)
    80003492:	6902                	ld	s2,0(sp)
    80003494:	6105                	addi	sp,sp,32
    80003496:	8082                	ret
    panic("usertrap: not from user mode");
    80003498:	00006517          	auipc	a0,0x6
    8000349c:	11050513          	addi	a0,a0,272 # 800095a8 <states+0x58>
    800034a0:	ffffd097          	auipc	ra,0xffffd
    800034a4:	09c080e7          	jalr	156(ra) # 8000053c <panic>
    if(killed(p))
    800034a8:	fffff097          	auipc	ra,0xfffff
    800034ac:	1c0080e7          	jalr	448(ra) # 80002668 <killed>
    800034b0:	e105                	bnez	a0,800034d0 <usertrap+0x108>
    p->trapframe->epc += 4;
    800034b2:	70b8                	ld	a4,96(s1)
    800034b4:	6f1c                	ld	a5,24(a4)
    800034b6:	0791                	addi	a5,a5,4
    800034b8:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800034ba:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800034be:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800034c2:	10079073          	csrw	sstatus,a5
    syscall();
    800034c6:	00000097          	auipc	ra,0x0
    800034ca:	37e080e7          	jalr	894(ra) # 80003844 <syscall>
    800034ce:	b765                	j	80003476 <usertrap+0xae>
      exit(-1);
    800034d0:	557d                	li	a0,-1
    800034d2:	fffff097          	auipc	ra,0xfffff
    800034d6:	00c080e7          	jalr	12(ra) # 800024de <exit>
    800034da:	bfe1                	j	800034b2 <usertrap+0xea>
        if((uvmalloc(p->pagetable, p->stack_sz-PGSIZE, p->stack_sz, PTE_W)) != 0) {
    800034dc:	4691                	li	a3,4
    800034de:	6ca8                	ld	a0,88(s1)
    800034e0:	ffffe097          	auipc	ra,0xffffe
    800034e4:	fd6080e7          	jalr	-42(ra) # 800014b6 <uvmalloc>
    800034e8:	d559                	beqz	a0,80003476 <usertrap+0xae>
          p->stack_sz -= PGSIZE; 
    800034ea:	76fd                	lui	a3,0xfffff
    800034ec:	64b8                	ld	a4,72(s1)
    800034ee:	9736                	add	a4,a4,a3
    800034f0:	e4b8                	sd	a4,72(s1)
          p->parent->stack_sz -= PGSIZE;
    800034f2:	7c98                	ld	a4,56(s1)
    800034f4:	673c                	ld	a5,72(a4)
    800034f6:	97b6                	add	a5,a5,a3
    800034f8:	e73c                	sd	a5,72(a4)
    800034fa:	bfb5                	j	80003476 <usertrap+0xae>
  asm volatile("csrr %0, scause" : "=r" (x) );
    800034fc:	142025f3          	csrr	a1,scause
      printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80003500:	5890                	lw	a2,48(s1)
    80003502:	00006517          	auipc	a0,0x6
    80003506:	0c650513          	addi	a0,a0,198 # 800095c8 <states+0x78>
    8000350a:	ffffd097          	auipc	ra,0xffffd
    8000350e:	07c080e7          	jalr	124(ra) # 80000586 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80003512:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80003516:	14302673          	csrr	a2,stval
      printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    8000351a:	00006517          	auipc	a0,0x6
    8000351e:	0de50513          	addi	a0,a0,222 # 800095f8 <states+0xa8>
    80003522:	ffffd097          	auipc	ra,0xffffd
    80003526:	064080e7          	jalr	100(ra) # 80000586 <printf>
      setkilled(p);
    8000352a:	8526                	mv	a0,s1
    8000352c:	fffff097          	auipc	ra,0xfffff
    80003530:	110080e7          	jalr	272(ra) # 8000263c <setkilled>
    80003534:	b789                	j	80003476 <usertrap+0xae>
  } else if((which_dev = devintr()) != 0){
    80003536:	00000097          	auipc	ra,0x0
    8000353a:	df0080e7          	jalr	-528(ra) # 80003326 <devintr>
    8000353e:	892a                	mv	s2,a0
    80003540:	c901                	beqz	a0,80003550 <usertrap+0x188>
  if(killed(p))
    80003542:	8526                	mv	a0,s1
    80003544:	fffff097          	auipc	ra,0xfffff
    80003548:	124080e7          	jalr	292(ra) # 80002668 <killed>
    8000354c:	c529                	beqz	a0,80003596 <usertrap+0x1ce>
    8000354e:	a83d                	j	8000358c <usertrap+0x1c4>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80003550:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80003554:	5890                	lw	a2,48(s1)
    80003556:	00006517          	auipc	a0,0x6
    8000355a:	07250513          	addi	a0,a0,114 # 800095c8 <states+0x78>
    8000355e:	ffffd097          	auipc	ra,0xffffd
    80003562:	028080e7          	jalr	40(ra) # 80000586 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80003566:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    8000356a:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    8000356e:	00006517          	auipc	a0,0x6
    80003572:	08a50513          	addi	a0,a0,138 # 800095f8 <states+0xa8>
    80003576:	ffffd097          	auipc	ra,0xffffd
    8000357a:	010080e7          	jalr	16(ra) # 80000586 <printf>
    setkilled(p);
    8000357e:	8526                	mv	a0,s1
    80003580:	fffff097          	auipc	ra,0xfffff
    80003584:	0bc080e7          	jalr	188(ra) # 8000263c <setkilled>
    80003588:	b5fd                	j	80003476 <usertrap+0xae>
  if(killed(p))
    8000358a:	4901                	li	s2,0
    exit(-1);
    8000358c:	557d                	li	a0,-1
    8000358e:	fffff097          	auipc	ra,0xfffff
    80003592:	f50080e7          	jalr	-176(ra) # 800024de <exit>
  if(which_dev == 2) {
    80003596:	4789                	li	a5,2
    80003598:	eef916e3          	bne	s2,a5,80003484 <usertrap+0xbc>
    yield(); 
    8000359c:	fffff097          	auipc	ra,0xfffff
    800035a0:	dd2080e7          	jalr	-558(ra) # 8000236e <yield>
    800035a4:	b5c5                	j	80003484 <usertrap+0xbc>

00000000800035a6 <kerneltrap>:
{
    800035a6:	7179                	addi	sp,sp,-48
    800035a8:	f406                	sd	ra,40(sp)
    800035aa:	f022                	sd	s0,32(sp)
    800035ac:	ec26                	sd	s1,24(sp)
    800035ae:	e84a                	sd	s2,16(sp)
    800035b0:	e44e                	sd	s3,8(sp)
    800035b2:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800035b4:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800035b8:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    800035bc:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    800035c0:	1004f793          	andi	a5,s1,256
    800035c4:	cb85                	beqz	a5,800035f4 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800035c6:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800035ca:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    800035cc:	ef85                	bnez	a5,80003604 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    800035ce:	00000097          	auipc	ra,0x0
    800035d2:	d58080e7          	jalr	-680(ra) # 80003326 <devintr>
    800035d6:	cd1d                	beqz	a0,80003614 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    800035d8:	4789                	li	a5,2
    800035da:	06f50a63          	beq	a0,a5,8000364e <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    800035de:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800035e2:	10049073          	csrw	sstatus,s1
}
    800035e6:	70a2                	ld	ra,40(sp)
    800035e8:	7402                	ld	s0,32(sp)
    800035ea:	64e2                	ld	s1,24(sp)
    800035ec:	6942                	ld	s2,16(sp)
    800035ee:	69a2                	ld	s3,8(sp)
    800035f0:	6145                	addi	sp,sp,48
    800035f2:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    800035f4:	00006517          	auipc	a0,0x6
    800035f8:	02450513          	addi	a0,a0,36 # 80009618 <states+0xc8>
    800035fc:	ffffd097          	auipc	ra,0xffffd
    80003600:	f40080e7          	jalr	-192(ra) # 8000053c <panic>
    panic("kerneltrap: interrupts enabled");
    80003604:	00006517          	auipc	a0,0x6
    80003608:	03c50513          	addi	a0,a0,60 # 80009640 <states+0xf0>
    8000360c:	ffffd097          	auipc	ra,0xffffd
    80003610:	f30080e7          	jalr	-208(ra) # 8000053c <panic>
    printf("scause %p\n", scause);
    80003614:	85ce                	mv	a1,s3
    80003616:	00006517          	auipc	a0,0x6
    8000361a:	04a50513          	addi	a0,a0,74 # 80009660 <states+0x110>
    8000361e:	ffffd097          	auipc	ra,0xffffd
    80003622:	f68080e7          	jalr	-152(ra) # 80000586 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80003626:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    8000362a:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    8000362e:	00006517          	auipc	a0,0x6
    80003632:	04250513          	addi	a0,a0,66 # 80009670 <states+0x120>
    80003636:	ffffd097          	auipc	ra,0xffffd
    8000363a:	f50080e7          	jalr	-176(ra) # 80000586 <printf>
    panic("kerneltrap");
    8000363e:	00006517          	auipc	a0,0x6
    80003642:	04a50513          	addi	a0,a0,74 # 80009688 <states+0x138>
    80003646:	ffffd097          	auipc	ra,0xffffd
    8000364a:	ef6080e7          	jalr	-266(ra) # 8000053c <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    8000364e:	ffffe097          	auipc	ra,0xffffe
    80003652:	504080e7          	jalr	1284(ra) # 80001b52 <myproc>
    80003656:	d541                	beqz	a0,800035de <kerneltrap+0x38>
    80003658:	ffffe097          	auipc	ra,0xffffe
    8000365c:	4fa080e7          	jalr	1274(ra) # 80001b52 <myproc>
    80003660:	4d18                	lw	a4,24(a0)
    80003662:	4791                	li	a5,4
    80003664:	f6f71de3          	bne	a4,a5,800035de <kerneltrap+0x38>
    yield();
    80003668:	fffff097          	auipc	ra,0xfffff
    8000366c:	d06080e7          	jalr	-762(ra) # 8000236e <yield>
    80003670:	b7bd                	j	800035de <kerneltrap+0x38>

0000000080003672 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80003672:	1101                	addi	sp,sp,-32
    80003674:	ec06                	sd	ra,24(sp)
    80003676:	e822                	sd	s0,16(sp)
    80003678:	e426                	sd	s1,8(sp)
    8000367a:	1000                	addi	s0,sp,32
    8000367c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    8000367e:	ffffe097          	auipc	ra,0xffffe
    80003682:	4d4080e7          	jalr	1236(ra) # 80001b52 <myproc>
  switch (n) {
    80003686:	4795                	li	a5,5
    80003688:	0497e163          	bltu	a5,s1,800036ca <argraw+0x58>
    8000368c:	048a                	slli	s1,s1,0x2
    8000368e:	00006717          	auipc	a4,0x6
    80003692:	03270713          	addi	a4,a4,50 # 800096c0 <states+0x170>
    80003696:	94ba                	add	s1,s1,a4
    80003698:	409c                	lw	a5,0(s1)
    8000369a:	97ba                	add	a5,a5,a4
    8000369c:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    8000369e:	713c                	ld	a5,96(a0)
    800036a0:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    800036a2:	60e2                	ld	ra,24(sp)
    800036a4:	6442                	ld	s0,16(sp)
    800036a6:	64a2                	ld	s1,8(sp)
    800036a8:	6105                	addi	sp,sp,32
    800036aa:	8082                	ret
    return p->trapframe->a1;
    800036ac:	713c                	ld	a5,96(a0)
    800036ae:	7fa8                	ld	a0,120(a5)
    800036b0:	bfcd                	j	800036a2 <argraw+0x30>
    return p->trapframe->a2;
    800036b2:	713c                	ld	a5,96(a0)
    800036b4:	63c8                	ld	a0,128(a5)
    800036b6:	b7f5                	j	800036a2 <argraw+0x30>
    return p->trapframe->a3;
    800036b8:	713c                	ld	a5,96(a0)
    800036ba:	67c8                	ld	a0,136(a5)
    800036bc:	b7dd                	j	800036a2 <argraw+0x30>
    return p->trapframe->a4;
    800036be:	713c                	ld	a5,96(a0)
    800036c0:	6bc8                	ld	a0,144(a5)
    800036c2:	b7c5                	j	800036a2 <argraw+0x30>
    return p->trapframe->a5;
    800036c4:	713c                	ld	a5,96(a0)
    800036c6:	6fc8                	ld	a0,152(a5)
    800036c8:	bfe9                	j	800036a2 <argraw+0x30>
  panic("argraw");
    800036ca:	00006517          	auipc	a0,0x6
    800036ce:	fce50513          	addi	a0,a0,-50 # 80009698 <states+0x148>
    800036d2:	ffffd097          	auipc	ra,0xffffd
    800036d6:	e6a080e7          	jalr	-406(ra) # 8000053c <panic>

00000000800036da <fetchaddr>:
{
    800036da:	1101                	addi	sp,sp,-32
    800036dc:	ec06                	sd	ra,24(sp)
    800036de:	e822                	sd	s0,16(sp)
    800036e0:	e426                	sd	s1,8(sp)
    800036e2:	e04a                	sd	s2,0(sp)
    800036e4:	1000                	addi	s0,sp,32
    800036e6:	84aa                	mv	s1,a0
    800036e8:	892e                	mv	s2,a1
  struct proc *p = myproc();
    800036ea:	ffffe097          	auipc	ra,0xffffe
    800036ee:	468080e7          	jalr	1128(ra) # 80001b52 <myproc>
  if (p->pid == 1 && p->stack_sz == 0) {
    800036f2:	5918                	lw	a4,48(a0)
    800036f4:	4785                	li	a5,1
    800036f6:	04f70a63          	beq	a4,a5,8000374a <fetchaddr+0x70>
    if((addr >= p->sz + PGSIZE*3 && addr < p->stack_sz) ||
    800036fa:	6938                	ld	a4,80(a0)
    800036fc:	678d                	lui	a5,0x3
    800036fe:	97ba                	add	a5,a5,a4
    80003700:	00f4e563          	bltu	s1,a5,8000370a <fetchaddr+0x30>
    80003704:	6538                	ld	a4,72(a0)
    80003706:	06e4e163          	bltu	s1,a4,80003768 <fetchaddr+0x8e>
        (addr+4 > p->sz + PGSIZE*3 && addr+4 < p->stack_sz) ||
    8000370a:	00448713          	addi	a4,s1,4
    if((addr >= p->sz + PGSIZE*3 && addr < p->stack_sz) ||
    8000370e:	00e7f563          	bgeu	a5,a4,80003718 <fetchaddr+0x3e>
        (addr+4 > p->sz + PGSIZE*3 && addr+4 < p->stack_sz) ||
    80003712:	653c                	ld	a5,72(a0)
    80003714:	04f76c63          	bltu	a4,a5,8000376c <fetchaddr+0x92>
    80003718:	678d                	lui	a5,0x3
    8000371a:	04f4eb63          	bltu	s1,a5,80003770 <fetchaddr+0x96>
        addr < PGSIZE*3 || addr+4 > USERTOP) 
    8000371e:	000a07b7          	lui	a5,0xa0
    80003722:	04e7e963          	bltu	a5,a4,80003774 <fetchaddr+0x9a>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0) 
    80003726:	46a1                	li	a3,8
    80003728:	8626                	mv	a2,s1
    8000372a:	85ca                	mv	a1,s2
    8000372c:	6d28                	ld	a0,88(a0)
    8000372e:	ffffe097          	auipc	ra,0xffffe
    80003732:	16c080e7          	jalr	364(ra) # 8000189a <copyin>
    80003736:	00a03533          	snez	a0,a0
    8000373a:	40a00533          	neg	a0,a0
}
    8000373e:	60e2                	ld	ra,24(sp)
    80003740:	6442                	ld	s0,16(sp)
    80003742:	64a2                	ld	s1,8(sp)
    80003744:	6902                	ld	s2,0(sp)
    80003746:	6105                	addi	sp,sp,32
    80003748:	8082                	ret
  if (p->pid == 1 && p->stack_sz == 0) {
    8000374a:	653c                	ld	a5,72(a0)
    8000374c:	f7dd                	bnez	a5,800036fa <fetchaddr+0x20>
    if(addr >= p->sz + PGSIZE*3 || addr+sizeof(uint64) > p->sz + PGSIZE*3) // both tests needed, in case of overflow 
    8000374e:	6938                	ld	a4,80(a0)
    80003750:	678d                	lui	a5,0x3
    80003752:	97ba                	add	a5,a5,a4
    80003754:	00f4f863          	bgeu	s1,a5,80003764 <fetchaddr+0x8a>
    80003758:	00848713          	addi	a4,s1,8
    8000375c:	fce7f5e3          	bgeu	a5,a4,80003726 <fetchaddr+0x4c>
      return -1;
    80003760:	557d                	li	a0,-1
    80003762:	bff1                	j	8000373e <fetchaddr+0x64>
    80003764:	557d                	li	a0,-1
    80003766:	bfe1                	j	8000373e <fetchaddr+0x64>
          return -1;
    80003768:	557d                	li	a0,-1
    8000376a:	bfd1                	j	8000373e <fetchaddr+0x64>
    8000376c:	557d                	li	a0,-1
    8000376e:	bfc1                	j	8000373e <fetchaddr+0x64>
    80003770:	557d                	li	a0,-1
    80003772:	b7f1                	j	8000373e <fetchaddr+0x64>
    80003774:	557d                	li	a0,-1
    80003776:	b7e1                	j	8000373e <fetchaddr+0x64>

0000000080003778 <fetchstr>:
{
    80003778:	7179                	addi	sp,sp,-48
    8000377a:	f406                	sd	ra,40(sp)
    8000377c:	f022                	sd	s0,32(sp)
    8000377e:	ec26                	sd	s1,24(sp)
    80003780:	e84a                	sd	s2,16(sp)
    80003782:	e44e                	sd	s3,8(sp)
    80003784:	1800                	addi	s0,sp,48
    80003786:	84aa                	mv	s1,a0
    80003788:	892e                	mv	s2,a1
    8000378a:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    8000378c:	ffffe097          	auipc	ra,0xffffe
    80003790:	3c6080e7          	jalr	966(ra) # 80001b52 <myproc>
  if (addr < PGSIZE*3) addr += PGSIZE*3; 
    80003794:	678d                	lui	a5,0x3
    80003796:	00f4f363          	bgeu	s1,a5,8000379c <fetchstr+0x24>
    8000379a:	94be                	add	s1,s1,a5
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    8000379c:	86ce                	mv	a3,s3
    8000379e:	8626                	mv	a2,s1
    800037a0:	85ca                	mv	a1,s2
    800037a2:	6d28                	ld	a0,88(a0)
    800037a4:	ffffe097          	auipc	ra,0xffffe
    800037a8:	184080e7          	jalr	388(ra) # 80001928 <copyinstr>
    800037ac:	00054e63          	bltz	a0,800037c8 <fetchstr+0x50>
  return strlen(buf);
    800037b0:	854a                	mv	a0,s2
    800037b2:	ffffd097          	auipc	ra,0xffffd
    800037b6:	742080e7          	jalr	1858(ra) # 80000ef4 <strlen>
}
    800037ba:	70a2                	ld	ra,40(sp)
    800037bc:	7402                	ld	s0,32(sp)
    800037be:	64e2                	ld	s1,24(sp)
    800037c0:	6942                	ld	s2,16(sp)
    800037c2:	69a2                	ld	s3,8(sp)
    800037c4:	6145                	addi	sp,sp,48
    800037c6:	8082                	ret
    return -1;
    800037c8:	557d                	li	a0,-1
    800037ca:	bfc5                	j	800037ba <fetchstr+0x42>

00000000800037cc <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    800037cc:	1101                	addi	sp,sp,-32
    800037ce:	ec06                	sd	ra,24(sp)
    800037d0:	e822                	sd	s0,16(sp)
    800037d2:	e426                	sd	s1,8(sp)
    800037d4:	1000                	addi	s0,sp,32
    800037d6:	84ae                	mv	s1,a1
  *ip = argraw(n);
    800037d8:	00000097          	auipc	ra,0x0
    800037dc:	e9a080e7          	jalr	-358(ra) # 80003672 <argraw>
    800037e0:	c088                	sw	a0,0(s1)
}
    800037e2:	60e2                	ld	ra,24(sp)
    800037e4:	6442                	ld	s0,16(sp)
    800037e6:	64a2                	ld	s1,8(sp)
    800037e8:	6105                	addi	sp,sp,32
    800037ea:	8082                	ret

00000000800037ec <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    800037ec:	1101                	addi	sp,sp,-32
    800037ee:	ec06                	sd	ra,24(sp)
    800037f0:	e822                	sd	s0,16(sp)
    800037f2:	e426                	sd	s1,8(sp)
    800037f4:	1000                	addi	s0,sp,32
    800037f6:	84ae                	mv	s1,a1
  *ip = argraw(n);
    800037f8:	00000097          	auipc	ra,0x0
    800037fc:	e7a080e7          	jalr	-390(ra) # 80003672 <argraw>
    80003800:	e088                	sd	a0,0(s1)
}
    80003802:	60e2                	ld	ra,24(sp)
    80003804:	6442                	ld	s0,16(sp)
    80003806:	64a2                	ld	s1,8(sp)
    80003808:	6105                	addi	sp,sp,32
    8000380a:	8082                	ret

000000008000380c <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    8000380c:	7179                	addi	sp,sp,-48
    8000380e:	f406                	sd	ra,40(sp)
    80003810:	f022                	sd	s0,32(sp)
    80003812:	ec26                	sd	s1,24(sp)
    80003814:	e84a                	sd	s2,16(sp)
    80003816:	1800                	addi	s0,sp,48
    80003818:	84ae                	mv	s1,a1
    8000381a:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    8000381c:	fd840593          	addi	a1,s0,-40
    80003820:	00000097          	auipc	ra,0x0
    80003824:	fcc080e7          	jalr	-52(ra) # 800037ec <argaddr>
  return fetchstr(addr, buf, max);
    80003828:	864a                	mv	a2,s2
    8000382a:	85a6                	mv	a1,s1
    8000382c:	fd843503          	ld	a0,-40(s0)
    80003830:	00000097          	auipc	ra,0x0
    80003834:	f48080e7          	jalr	-184(ra) # 80003778 <fetchstr>
}
    80003838:	70a2                	ld	ra,40(sp)
    8000383a:	7402                	ld	s0,32(sp)
    8000383c:	64e2                	ld	s1,24(sp)
    8000383e:	6942                	ld	s2,16(sp)
    80003840:	6145                	addi	sp,sp,48
    80003842:	8082                	ret

0000000080003844 <syscall>:
[SYS_set_priority] sys_set_priority
};

void
syscall(void)
{
    80003844:	1101                	addi	sp,sp,-32
    80003846:	ec06                	sd	ra,24(sp)
    80003848:	e822                	sd	s0,16(sp)
    8000384a:	e426                	sd	s1,8(sp)
    8000384c:	e04a                	sd	s2,0(sp)
    8000384e:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80003850:	ffffe097          	auipc	ra,0xffffe
    80003854:	302080e7          	jalr	770(ra) # 80001b52 <myproc>
    80003858:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    8000385a:	06053903          	ld	s2,96(a0)
    8000385e:	0a893783          	ld	a5,168(s2)
    80003862:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80003866:	37fd                	addiw	a5,a5,-1
    80003868:	4769                	li	a4,26
    8000386a:	00f76f63          	bltu	a4,a5,80003888 <syscall+0x44>
    8000386e:	00369713          	slli	a4,a3,0x3
    80003872:	00006797          	auipc	a5,0x6
    80003876:	e6678793          	addi	a5,a5,-410 # 800096d8 <syscalls>
    8000387a:	97ba                	add	a5,a5,a4
    8000387c:	639c                	ld	a5,0(a5)
    8000387e:	c789                	beqz	a5,80003888 <syscall+0x44>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    80003880:	9782                	jalr	a5
    80003882:	06a93823          	sd	a0,112(s2)
    80003886:	a839                	j	800038a4 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80003888:	16048613          	addi	a2,s1,352
    8000388c:	588c                	lw	a1,48(s1)
    8000388e:	00006517          	auipc	a0,0x6
    80003892:	e1250513          	addi	a0,a0,-494 # 800096a0 <states+0x150>
    80003896:	ffffd097          	auipc	ra,0xffffd
    8000389a:	cf0080e7          	jalr	-784(ra) # 80000586 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    8000389e:	70bc                	ld	a5,96(s1)
    800038a0:	577d                	li	a4,-1
    800038a2:	fbb8                	sd	a4,112(a5)
  }
}
    800038a4:	60e2                	ld	ra,24(sp)
    800038a6:	6442                	ld	s0,16(sp)
    800038a8:	64a2                	ld	s1,8(sp)
    800038aa:	6902                	ld	s2,0(sp)
    800038ac:	6105                	addi	sp,sp,32
    800038ae:	8082                	ret

00000000800038b0 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    800038b0:	1101                	addi	sp,sp,-32
    800038b2:	ec06                	sd	ra,24(sp)
    800038b4:	e822                	sd	s0,16(sp)
    800038b6:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    800038b8:	fec40593          	addi	a1,s0,-20
    800038bc:	4501                	li	a0,0
    800038be:	00000097          	auipc	ra,0x0
    800038c2:	f0e080e7          	jalr	-242(ra) # 800037cc <argint>
  exit(n);
    800038c6:	fec42503          	lw	a0,-20(s0)
    800038ca:	fffff097          	auipc	ra,0xfffff
    800038ce:	c14080e7          	jalr	-1004(ra) # 800024de <exit>
  return 0;  // not reached
}
    800038d2:	4501                	li	a0,0
    800038d4:	60e2                	ld	ra,24(sp)
    800038d6:	6442                	ld	s0,16(sp)
    800038d8:	6105                	addi	sp,sp,32
    800038da:	8082                	ret

00000000800038dc <sys_getpid>:

uint64
sys_getpid(void)
{
    800038dc:	1141                	addi	sp,sp,-16
    800038de:	e406                	sd	ra,8(sp)
    800038e0:	e022                	sd	s0,0(sp)
    800038e2:	0800                	addi	s0,sp,16
  return myproc()->pid;
    800038e4:	ffffe097          	auipc	ra,0xffffe
    800038e8:	26e080e7          	jalr	622(ra) # 80001b52 <myproc>
}
    800038ec:	5908                	lw	a0,48(a0)
    800038ee:	60a2                	ld	ra,8(sp)
    800038f0:	6402                	ld	s0,0(sp)
    800038f2:	0141                	addi	sp,sp,16
    800038f4:	8082                	ret

00000000800038f6 <sys_fork>:

uint64
sys_fork(void)
{
    800038f6:	1141                	addi	sp,sp,-16
    800038f8:	e406                	sd	ra,8(sp)
    800038fa:	e022                	sd	s0,0(sp)
    800038fc:	0800                	addi	s0,sp,16
  return fork();
    800038fe:	ffffe097          	auipc	ra,0xffffe
    80003902:	64a080e7          	jalr	1610(ra) # 80001f48 <fork>
}
    80003906:	60a2                	ld	ra,8(sp)
    80003908:	6402                	ld	s0,0(sp)
    8000390a:	0141                	addi	sp,sp,16
    8000390c:	8082                	ret

000000008000390e <sys_wait>:

uint64
sys_wait(void)
{
    8000390e:	1101                	addi	sp,sp,-32
    80003910:	ec06                	sd	ra,24(sp)
    80003912:	e822                	sd	s0,16(sp)
    80003914:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80003916:	fe840593          	addi	a1,s0,-24
    8000391a:	4501                	li	a0,0
    8000391c:	00000097          	auipc	ra,0x0
    80003920:	ed0080e7          	jalr	-304(ra) # 800037ec <argaddr>
  return wait(p);
    80003924:	fe843503          	ld	a0,-24(s0)
    80003928:	fffff097          	auipc	ra,0xfffff
    8000392c:	d72080e7          	jalr	-654(ra) # 8000269a <wait>
}
    80003930:	60e2                	ld	ra,24(sp)
    80003932:	6442                	ld	s0,16(sp)
    80003934:	6105                	addi	sp,sp,32
    80003936:	8082                	ret

0000000080003938 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80003938:	7179                	addi	sp,sp,-48
    8000393a:	f406                	sd	ra,40(sp)
    8000393c:	f022                	sd	s0,32(sp)
    8000393e:	ec26                	sd	s1,24(sp)
    80003940:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    80003942:	fdc40593          	addi	a1,s0,-36
    80003946:	4501                	li	a0,0
    80003948:	00000097          	auipc	ra,0x0
    8000394c:	e84080e7          	jalr	-380(ra) # 800037cc <argint>
  addr = myproc()->sz;
    80003950:	ffffe097          	auipc	ra,0xffffe
    80003954:	202080e7          	jalr	514(ra) # 80001b52 <myproc>
    80003958:	6924                	ld	s1,80(a0)
  if(growproc(n) < 0)
    8000395a:	fdc42503          	lw	a0,-36(s0)
    8000395e:	ffffe097          	auipc	ra,0xffffe
    80003962:	57c080e7          	jalr	1404(ra) # 80001eda <growproc>
    80003966:	00054863          	bltz	a0,80003976 <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    8000396a:	8526                	mv	a0,s1
    8000396c:	70a2                	ld	ra,40(sp)
    8000396e:	7402                	ld	s0,32(sp)
    80003970:	64e2                	ld	s1,24(sp)
    80003972:	6145                	addi	sp,sp,48
    80003974:	8082                	ret
    return -1;
    80003976:	54fd                	li	s1,-1
    80003978:	bfcd                	j	8000396a <sys_sbrk+0x32>

000000008000397a <sys_sleep>:

uint64
sys_sleep(void)
{
    8000397a:	7139                	addi	sp,sp,-64
    8000397c:	fc06                	sd	ra,56(sp)
    8000397e:	f822                	sd	s0,48(sp)
    80003980:	f426                	sd	s1,40(sp)
    80003982:	f04a                	sd	s2,32(sp)
    80003984:	ec4e                	sd	s3,24(sp)
    80003986:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    80003988:	fcc40593          	addi	a1,s0,-52
    8000398c:	4501                	li	a0,0
    8000398e:	00000097          	auipc	ra,0x0
    80003992:	e3e080e7          	jalr	-450(ra) # 800037cc <argint>
  acquire(&tickslock);
    80003996:	00015517          	auipc	a0,0x15
    8000399a:	4aa50513          	addi	a0,a0,1194 # 80018e40 <tickslock>
    8000399e:	ffffd097          	auipc	ra,0xffffd
    800039a2:	2de080e7          	jalr	734(ra) # 80000c7c <acquire>
  ticks0 = ticks;
    800039a6:	00006917          	auipc	s2,0x6
    800039aa:	20292903          	lw	s2,514(s2) # 80009ba8 <ticks>
  while(ticks - ticks0 < n){
    800039ae:	fcc42783          	lw	a5,-52(s0)
    800039b2:	cf9d                	beqz	a5,800039f0 <sys_sleep+0x76>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800039b4:	00015997          	auipc	s3,0x15
    800039b8:	48c98993          	addi	s3,s3,1164 # 80018e40 <tickslock>
    800039bc:	00006497          	auipc	s1,0x6
    800039c0:	1ec48493          	addi	s1,s1,492 # 80009ba8 <ticks>
    if(killed(myproc())){
    800039c4:	ffffe097          	auipc	ra,0xffffe
    800039c8:	18e080e7          	jalr	398(ra) # 80001b52 <myproc>
    800039cc:	fffff097          	auipc	ra,0xfffff
    800039d0:	c9c080e7          	jalr	-868(ra) # 80002668 <killed>
    800039d4:	ed15                	bnez	a0,80003a10 <sys_sleep+0x96>
    sleep(&ticks, &tickslock);
    800039d6:	85ce                	mv	a1,s3
    800039d8:	8526                	mv	a0,s1
    800039da:	fffff097          	auipc	ra,0xfffff
    800039de:	9d0080e7          	jalr	-1584(ra) # 800023aa <sleep>
  while(ticks - ticks0 < n){
    800039e2:	409c                	lw	a5,0(s1)
    800039e4:	412787bb          	subw	a5,a5,s2
    800039e8:	fcc42703          	lw	a4,-52(s0)
    800039ec:	fce7ece3          	bltu	a5,a4,800039c4 <sys_sleep+0x4a>
  }
  release(&tickslock);
    800039f0:	00015517          	auipc	a0,0x15
    800039f4:	45050513          	addi	a0,a0,1104 # 80018e40 <tickslock>
    800039f8:	ffffd097          	auipc	ra,0xffffd
    800039fc:	338080e7          	jalr	824(ra) # 80000d30 <release>
  return 0;
    80003a00:	4501                	li	a0,0
}
    80003a02:	70e2                	ld	ra,56(sp)
    80003a04:	7442                	ld	s0,48(sp)
    80003a06:	74a2                	ld	s1,40(sp)
    80003a08:	7902                	ld	s2,32(sp)
    80003a0a:	69e2                	ld	s3,24(sp)
    80003a0c:	6121                	addi	sp,sp,64
    80003a0e:	8082                	ret
      release(&tickslock);
    80003a10:	00015517          	auipc	a0,0x15
    80003a14:	43050513          	addi	a0,a0,1072 # 80018e40 <tickslock>
    80003a18:	ffffd097          	auipc	ra,0xffffd
    80003a1c:	318080e7          	jalr	792(ra) # 80000d30 <release>
      return -1;
    80003a20:	557d                	li	a0,-1
    80003a22:	b7c5                	j	80003a02 <sys_sleep+0x88>

0000000080003a24 <sys_kill>:

uint64
sys_kill(void)
{
    80003a24:	1101                	addi	sp,sp,-32
    80003a26:	ec06                	sd	ra,24(sp)
    80003a28:	e822                	sd	s0,16(sp)
    80003a2a:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80003a2c:	fec40593          	addi	a1,s0,-20
    80003a30:	4501                	li	a0,0
    80003a32:	00000097          	auipc	ra,0x0
    80003a36:	d9a080e7          	jalr	-614(ra) # 800037cc <argint>
  return kill(pid);
    80003a3a:	fec42503          	lw	a0,-20(s0)
    80003a3e:	fffff097          	auipc	ra,0xfffff
    80003a42:	b8c080e7          	jalr	-1140(ra) # 800025ca <kill>
}
    80003a46:	60e2                	ld	ra,24(sp)
    80003a48:	6442                	ld	s0,16(sp)
    80003a4a:	6105                	addi	sp,sp,32
    80003a4c:	8082                	ret

0000000080003a4e <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80003a4e:	1101                	addi	sp,sp,-32
    80003a50:	ec06                	sd	ra,24(sp)
    80003a52:	e822                	sd	s0,16(sp)
    80003a54:	e426                	sd	s1,8(sp)
    80003a56:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80003a58:	00015517          	auipc	a0,0x15
    80003a5c:	3e850513          	addi	a0,a0,1000 # 80018e40 <tickslock>
    80003a60:	ffffd097          	auipc	ra,0xffffd
    80003a64:	21c080e7          	jalr	540(ra) # 80000c7c <acquire>
  xticks = ticks;
    80003a68:	00006497          	auipc	s1,0x6
    80003a6c:	1404a483          	lw	s1,320(s1) # 80009ba8 <ticks>
  release(&tickslock);
    80003a70:	00015517          	auipc	a0,0x15
    80003a74:	3d050513          	addi	a0,a0,976 # 80018e40 <tickslock>
    80003a78:	ffffd097          	auipc	ra,0xffffd
    80003a7c:	2b8080e7          	jalr	696(ra) # 80000d30 <release>
  return xticks;
}
    80003a80:	02049513          	slli	a0,s1,0x20
    80003a84:	9101                	srli	a0,a0,0x20
    80003a86:	60e2                	ld	ra,24(sp)
    80003a88:	6442                	ld	s0,16(sp)
    80003a8a:	64a2                	ld	s1,8(sp)
    80003a8c:	6105                	addi	sp,sp,32
    80003a8e:	8082                	ret

0000000080003a90 <sys_uniq_k>:

uint64
sys_uniq_k(void)
{
    80003a90:	7179                	addi	sp,sp,-48
    80003a92:	f406                	sd	ra,40(sp)
    80003a94:	f022                	sd	s0,32(sp)
    80003a96:	1800                	addi	s0,sp,48
  int fd, c_flag, d_flag, i_flag;  
  uint64 addr; 

  argint(0, &fd);
    80003a98:	fec40593          	addi	a1,s0,-20
    80003a9c:	4501                	li	a0,0
    80003a9e:	00000097          	auipc	ra,0x0
    80003aa2:	d2e080e7          	jalr	-722(ra) # 800037cc <argint>
  argaddr(1, &addr);
    80003aa6:	fd840593          	addi	a1,s0,-40
    80003aaa:	4505                	li	a0,1
    80003aac:	00000097          	auipc	ra,0x0
    80003ab0:	d40080e7          	jalr	-704(ra) # 800037ec <argaddr>
  argint(2, &c_flag);
    80003ab4:	fe840593          	addi	a1,s0,-24
    80003ab8:	4509                	li	a0,2
    80003aba:	00000097          	auipc	ra,0x0
    80003abe:	d12080e7          	jalr	-750(ra) # 800037cc <argint>
  argint(3, &d_flag);
    80003ac2:	fe440593          	addi	a1,s0,-28
    80003ac6:	450d                	li	a0,3
    80003ac8:	00000097          	auipc	ra,0x0
    80003acc:	d04080e7          	jalr	-764(ra) # 800037cc <argint>
  argint(4, &i_flag); 
    80003ad0:	fe040593          	addi	a1,s0,-32
    80003ad4:	4511                	li	a0,4
    80003ad6:	00000097          	auipc	ra,0x0
    80003ada:	cf6080e7          	jalr	-778(ra) # 800037cc <argint>
  uniq_k(fd, addr, c_flag, d_flag, i_flag);
    80003ade:	fe042703          	lw	a4,-32(s0)
    80003ae2:	fe442683          	lw	a3,-28(s0)
    80003ae6:	fe842603          	lw	a2,-24(s0)
    80003aea:	fd843583          	ld	a1,-40(s0)
    80003aee:	fec42503          	lw	a0,-20(s0)
    80003af2:	fffff097          	auipc	ra,0xfffff
    80003af6:	0c0080e7          	jalr	192(ra) # 80002bb2 <uniq_k>
  return 0;  
}
    80003afa:	4501                	li	a0,0
    80003afc:	70a2                	ld	ra,40(sp)
    80003afe:	7402                	ld	s0,32(sp)
    80003b00:	6145                	addi	sp,sp,48
    80003b02:	8082                	ret

0000000080003b04 <sys_head_k>:

uint64
sys_head_k(void)
{
    80003b04:	1101                	addi	sp,sp,-32
    80003b06:	ec06                	sd	ra,24(sp)
    80003b08:	e822                	sd	s0,16(sp)
    80003b0a:	1000                	addi	s0,sp,32
  int fd, count;  
  uint64 addr; 

  argint(0, &fd); 
    80003b0c:	fec40593          	addi	a1,s0,-20
    80003b10:	4501                	li	a0,0
    80003b12:	00000097          	auipc	ra,0x0
    80003b16:	cba080e7          	jalr	-838(ra) # 800037cc <argint>
  argaddr(1, &addr); 
    80003b1a:	fe040593          	addi	a1,s0,-32
    80003b1e:	4505                	li	a0,1
    80003b20:	00000097          	auipc	ra,0x0
    80003b24:	ccc080e7          	jalr	-820(ra) # 800037ec <argaddr>
  argint(2, &count); 
    80003b28:	fe840593          	addi	a1,s0,-24
    80003b2c:	4509                	li	a0,2
    80003b2e:	00000097          	auipc	ra,0x0
    80003b32:	c9e080e7          	jalr	-866(ra) # 800037cc <argint>
  head_k(fd, addr, count);
    80003b36:	fe842603          	lw	a2,-24(s0)
    80003b3a:	fe043583          	ld	a1,-32(s0)
    80003b3e:	fec42503          	lw	a0,-20(s0)
    80003b42:	fffff097          	auipc	ra,0xfffff
    80003b46:	210080e7          	jalr	528(ra) # 80002d52 <head_k>
  return 0;
}
    80003b4a:	4501                	li	a0,0
    80003b4c:	60e2                	ld	ra,24(sp)
    80003b4e:	6442                	ld	s0,16(sp)
    80003b50:	6105                	addi	sp,sp,32
    80003b52:	8082                	ret

0000000080003b54 <sys_waitx>:

uint64
sys_waitx(void)
{
    80003b54:	7179                	addi	sp,sp,-48
    80003b56:	f406                	sd	ra,40(sp)
    80003b58:	f022                	sd	s0,32(sp)
    80003b5a:	1800                	addi	s0,sp,48
  uint64 addr; 
  int *wait_time, *turnaround_time; 
 
  argaddr(0, &addr); 
    80003b5c:	fe840593          	addi	a1,s0,-24
    80003b60:	4501                	li	a0,0
    80003b62:	00000097          	auipc	ra,0x0
    80003b66:	c8a080e7          	jalr	-886(ra) # 800037ec <argaddr>
  argaddr(1, (uint64*)&wait_time); 
    80003b6a:	fe040593          	addi	a1,s0,-32
    80003b6e:	4505                	li	a0,1
    80003b70:	00000097          	auipc	ra,0x0
    80003b74:	c7c080e7          	jalr	-900(ra) # 800037ec <argaddr>
  argaddr(2, (uint64*)&turnaround_time);
    80003b78:	fd840593          	addi	a1,s0,-40
    80003b7c:	4509                	li	a0,2
    80003b7e:	00000097          	auipc	ra,0x0
    80003b82:	c6e080e7          	jalr	-914(ra) # 800037ec <argaddr>
  return waitx(addr, wait_time, turnaround_time); 
    80003b86:	fd843603          	ld	a2,-40(s0)
    80003b8a:	fe043583          	ld	a1,-32(s0)
    80003b8e:	fe843503          	ld	a0,-24(s0)
    80003b92:	fffff097          	auipc	ra,0xfffff
    80003b96:	c36080e7          	jalr	-970(ra) # 800027c8 <waitx>
}
    80003b9a:	70a2                	ld	ra,40(sp)
    80003b9c:	7402                	ld	s0,32(sp)
    80003b9e:	6145                	addi	sp,sp,48
    80003ba0:	8082                	ret

0000000080003ba2 <sys_ps>:

uint64
sys_ps(void) {
    80003ba2:	1101                	addi	sp,sp,-32
    80003ba4:	ec06                	sd	ra,24(sp)
    80003ba6:	e822                	sd	s0,16(sp)
    80003ba8:	1000                	addi	s0,sp,32
  int option, value; 
  uint64 addr; 

  argint(0, &option);
    80003baa:	fec40593          	addi	a1,s0,-20
    80003bae:	4501                	li	a0,0
    80003bb0:	00000097          	auipc	ra,0x0
    80003bb4:	c1c080e7          	jalr	-996(ra) # 800037cc <argint>
  argint(1, &value); 
    80003bb8:	fe840593          	addi	a1,s0,-24
    80003bbc:	4505                	li	a0,1
    80003bbe:	00000097          	auipc	ra,0x0
    80003bc2:	c0e080e7          	jalr	-1010(ra) # 800037cc <argint>
  argaddr(2, &addr);
    80003bc6:	fe040593          	addi	a1,s0,-32
    80003bca:	4509                	li	a0,2
    80003bcc:	00000097          	auipc	ra,0x0
    80003bd0:	c20080e7          	jalr	-992(ra) # 800037ec <argaddr>
  ps(option, value, addr);
    80003bd4:	fe043603          	ld	a2,-32(s0)
    80003bd8:	fe842583          	lw	a1,-24(s0)
    80003bdc:	fec42503          	lw	a0,-20(s0)
    80003be0:	fffff097          	auipc	ra,0xfffff
    80003be4:	318080e7          	jalr	792(ra) # 80002ef8 <ps>
  return 0;  
}
    80003be8:	4501                	li	a0,0
    80003bea:	60e2                	ld	ra,24(sp)
    80003bec:	6442                	ld	s0,16(sp)
    80003bee:	6105                	addi	sp,sp,32
    80003bf0:	8082                	ret

0000000080003bf2 <sys_set_scheduler>:

uint64 
sys_set_scheduler(void) {
    80003bf2:	1101                	addi	sp,sp,-32
    80003bf4:	ec06                	sd	ra,24(sp)
    80003bf6:	e822                	sd	s0,16(sp)
    80003bf8:	1000                	addi	s0,sp,32
  int scheduler; 

  argint(0, &scheduler);
    80003bfa:	fec40593          	addi	a1,s0,-20
    80003bfe:	4501                	li	a0,0
    80003c00:	00000097          	auipc	ra,0x0
    80003c04:	bcc080e7          	jalr	-1076(ra) # 800037cc <argint>
  set_scheduler(scheduler);
    80003c08:	fec42503          	lw	a0,-20(s0)
    80003c0c:	fffff097          	auipc	ra,0xfffff
    80003c10:	4b0080e7          	jalr	1200(ra) # 800030bc <set_scheduler>
  return 0; 
}
    80003c14:	4501                	li	a0,0
    80003c16:	60e2                	ld	ra,24(sp)
    80003c18:	6442                	ld	s0,16(sp)
    80003c1a:	6105                	addi	sp,sp,32
    80003c1c:	8082                	ret

0000000080003c1e <sys_set_priority>:

uint64 
sys_set_priority(void) {
    80003c1e:	1101                	addi	sp,sp,-32
    80003c20:	ec06                	sd	ra,24(sp)
    80003c22:	e822                	sd	s0,16(sp)
    80003c24:	1000                	addi	s0,sp,32
  int pid, priority;

  argint(0, &pid);
    80003c26:	fec40593          	addi	a1,s0,-20
    80003c2a:	4501                	li	a0,0
    80003c2c:	00000097          	auipc	ra,0x0
    80003c30:	ba0080e7          	jalr	-1120(ra) # 800037cc <argint>
  argint(1, &priority);
    80003c34:	fe840593          	addi	a1,s0,-24
    80003c38:	4505                	li	a0,1
    80003c3a:	00000097          	auipc	ra,0x0
    80003c3e:	b92080e7          	jalr	-1134(ra) # 800037cc <argint>
  return set_priority(pid, priority);
    80003c42:	fe842583          	lw	a1,-24(s0)
    80003c46:	fec42503          	lw	a0,-20(s0)
    80003c4a:	fffff097          	auipc	ra,0xfffff
    80003c4e:	4b0080e7          	jalr	1200(ra) # 800030fa <set_priority>
}
    80003c52:	60e2                	ld	ra,24(sp)
    80003c54:	6442                	ld	s0,16(sp)
    80003c56:	6105                	addi	sp,sp,32
    80003c58:	8082                	ret

0000000080003c5a <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80003c5a:	7179                	addi	sp,sp,-48
    80003c5c:	f406                	sd	ra,40(sp)
    80003c5e:	f022                	sd	s0,32(sp)
    80003c60:	ec26                	sd	s1,24(sp)
    80003c62:	e84a                	sd	s2,16(sp)
    80003c64:	e44e                	sd	s3,8(sp)
    80003c66:	e052                	sd	s4,0(sp)
    80003c68:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80003c6a:	00006597          	auipc	a1,0x6
    80003c6e:	b4e58593          	addi	a1,a1,-1202 # 800097b8 <syscalls+0xe0>
    80003c72:	00015517          	auipc	a0,0x15
    80003c76:	1e650513          	addi	a0,a0,486 # 80018e58 <bcache>
    80003c7a:	ffffd097          	auipc	ra,0xffffd
    80003c7e:	f72080e7          	jalr	-142(ra) # 80000bec <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80003c82:	0001d797          	auipc	a5,0x1d
    80003c86:	1d678793          	addi	a5,a5,470 # 80020e58 <bcache+0x8000>
    80003c8a:	0001d717          	auipc	a4,0x1d
    80003c8e:	43670713          	addi	a4,a4,1078 # 800210c0 <bcache+0x8268>
    80003c92:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80003c96:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80003c9a:	00015497          	auipc	s1,0x15
    80003c9e:	1d648493          	addi	s1,s1,470 # 80018e70 <bcache+0x18>
    b->next = bcache.head.next;
    80003ca2:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80003ca4:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80003ca6:	00006a17          	auipc	s4,0x6
    80003caa:	b1aa0a13          	addi	s4,s4,-1254 # 800097c0 <syscalls+0xe8>
    b->next = bcache.head.next;
    80003cae:	2b893783          	ld	a5,696(s2)
    80003cb2:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80003cb4:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80003cb8:	85d2                	mv	a1,s4
    80003cba:	01048513          	addi	a0,s1,16
    80003cbe:	00001097          	auipc	ra,0x1
    80003cc2:	4c4080e7          	jalr	1220(ra) # 80005182 <initsleeplock>
    bcache.head.next->prev = b;
    80003cc6:	2b893783          	ld	a5,696(s2)
    80003cca:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80003ccc:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80003cd0:	45848493          	addi	s1,s1,1112
    80003cd4:	fd349de3          	bne	s1,s3,80003cae <binit+0x54>
  }
}
    80003cd8:	70a2                	ld	ra,40(sp)
    80003cda:	7402                	ld	s0,32(sp)
    80003cdc:	64e2                	ld	s1,24(sp)
    80003cde:	6942                	ld	s2,16(sp)
    80003ce0:	69a2                	ld	s3,8(sp)
    80003ce2:	6a02                	ld	s4,0(sp)
    80003ce4:	6145                	addi	sp,sp,48
    80003ce6:	8082                	ret

0000000080003ce8 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80003ce8:	7179                	addi	sp,sp,-48
    80003cea:	f406                	sd	ra,40(sp)
    80003cec:	f022                	sd	s0,32(sp)
    80003cee:	ec26                	sd	s1,24(sp)
    80003cf0:	e84a                	sd	s2,16(sp)
    80003cf2:	e44e                	sd	s3,8(sp)
    80003cf4:	1800                	addi	s0,sp,48
    80003cf6:	892a                	mv	s2,a0
    80003cf8:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80003cfa:	00015517          	auipc	a0,0x15
    80003cfe:	15e50513          	addi	a0,a0,350 # 80018e58 <bcache>
    80003d02:	ffffd097          	auipc	ra,0xffffd
    80003d06:	f7a080e7          	jalr	-134(ra) # 80000c7c <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80003d0a:	0001d497          	auipc	s1,0x1d
    80003d0e:	4064b483          	ld	s1,1030(s1) # 80021110 <bcache+0x82b8>
    80003d12:	0001d797          	auipc	a5,0x1d
    80003d16:	3ae78793          	addi	a5,a5,942 # 800210c0 <bcache+0x8268>
    80003d1a:	02f48f63          	beq	s1,a5,80003d58 <bread+0x70>
    80003d1e:	873e                	mv	a4,a5
    80003d20:	a021                	j	80003d28 <bread+0x40>
    80003d22:	68a4                	ld	s1,80(s1)
    80003d24:	02e48a63          	beq	s1,a4,80003d58 <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80003d28:	449c                	lw	a5,8(s1)
    80003d2a:	ff279ce3          	bne	a5,s2,80003d22 <bread+0x3a>
    80003d2e:	44dc                	lw	a5,12(s1)
    80003d30:	ff3799e3          	bne	a5,s3,80003d22 <bread+0x3a>
      b->refcnt++;
    80003d34:	40bc                	lw	a5,64(s1)
    80003d36:	2785                	addiw	a5,a5,1
    80003d38:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80003d3a:	00015517          	auipc	a0,0x15
    80003d3e:	11e50513          	addi	a0,a0,286 # 80018e58 <bcache>
    80003d42:	ffffd097          	auipc	ra,0xffffd
    80003d46:	fee080e7          	jalr	-18(ra) # 80000d30 <release>
      acquiresleep(&b->lock);
    80003d4a:	01048513          	addi	a0,s1,16
    80003d4e:	00001097          	auipc	ra,0x1
    80003d52:	46e080e7          	jalr	1134(ra) # 800051bc <acquiresleep>
      return b;
    80003d56:	a8b9                	j	80003db4 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80003d58:	0001d497          	auipc	s1,0x1d
    80003d5c:	3b04b483          	ld	s1,944(s1) # 80021108 <bcache+0x82b0>
    80003d60:	0001d797          	auipc	a5,0x1d
    80003d64:	36078793          	addi	a5,a5,864 # 800210c0 <bcache+0x8268>
    80003d68:	00f48863          	beq	s1,a5,80003d78 <bread+0x90>
    80003d6c:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80003d6e:	40bc                	lw	a5,64(s1)
    80003d70:	cf81                	beqz	a5,80003d88 <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80003d72:	64a4                	ld	s1,72(s1)
    80003d74:	fee49de3          	bne	s1,a4,80003d6e <bread+0x86>
  panic("bget: no buffers");
    80003d78:	00006517          	auipc	a0,0x6
    80003d7c:	a5050513          	addi	a0,a0,-1456 # 800097c8 <syscalls+0xf0>
    80003d80:	ffffc097          	auipc	ra,0xffffc
    80003d84:	7bc080e7          	jalr	1980(ra) # 8000053c <panic>
      b->dev = dev;
    80003d88:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80003d8c:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80003d90:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80003d94:	4785                	li	a5,1
    80003d96:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80003d98:	00015517          	auipc	a0,0x15
    80003d9c:	0c050513          	addi	a0,a0,192 # 80018e58 <bcache>
    80003da0:	ffffd097          	auipc	ra,0xffffd
    80003da4:	f90080e7          	jalr	-112(ra) # 80000d30 <release>
      acquiresleep(&b->lock);
    80003da8:	01048513          	addi	a0,s1,16
    80003dac:	00001097          	auipc	ra,0x1
    80003db0:	410080e7          	jalr	1040(ra) # 800051bc <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80003db4:	409c                	lw	a5,0(s1)
    80003db6:	cb89                	beqz	a5,80003dc8 <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80003db8:	8526                	mv	a0,s1
    80003dba:	70a2                	ld	ra,40(sp)
    80003dbc:	7402                	ld	s0,32(sp)
    80003dbe:	64e2                	ld	s1,24(sp)
    80003dc0:	6942                	ld	s2,16(sp)
    80003dc2:	69a2                	ld	s3,8(sp)
    80003dc4:	6145                	addi	sp,sp,48
    80003dc6:	8082                	ret
    virtio_disk_rw(b, 0);
    80003dc8:	4581                	li	a1,0
    80003dca:	8526                	mv	a0,s1
    80003dcc:	00003097          	auipc	ra,0x3
    80003dd0:	fb8080e7          	jalr	-72(ra) # 80006d84 <virtio_disk_rw>
    b->valid = 1;
    80003dd4:	4785                	li	a5,1
    80003dd6:	c09c                	sw	a5,0(s1)
  return b;
    80003dd8:	b7c5                	j	80003db8 <bread+0xd0>

0000000080003dda <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80003dda:	1101                	addi	sp,sp,-32
    80003ddc:	ec06                	sd	ra,24(sp)
    80003dde:	e822                	sd	s0,16(sp)
    80003de0:	e426                	sd	s1,8(sp)
    80003de2:	1000                	addi	s0,sp,32
    80003de4:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80003de6:	0541                	addi	a0,a0,16
    80003de8:	00001097          	auipc	ra,0x1
    80003dec:	46e080e7          	jalr	1134(ra) # 80005256 <holdingsleep>
    80003df0:	cd01                	beqz	a0,80003e08 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80003df2:	4585                	li	a1,1
    80003df4:	8526                	mv	a0,s1
    80003df6:	00003097          	auipc	ra,0x3
    80003dfa:	f8e080e7          	jalr	-114(ra) # 80006d84 <virtio_disk_rw>
}
    80003dfe:	60e2                	ld	ra,24(sp)
    80003e00:	6442                	ld	s0,16(sp)
    80003e02:	64a2                	ld	s1,8(sp)
    80003e04:	6105                	addi	sp,sp,32
    80003e06:	8082                	ret
    panic("bwrite");
    80003e08:	00006517          	auipc	a0,0x6
    80003e0c:	9d850513          	addi	a0,a0,-1576 # 800097e0 <syscalls+0x108>
    80003e10:	ffffc097          	auipc	ra,0xffffc
    80003e14:	72c080e7          	jalr	1836(ra) # 8000053c <panic>

0000000080003e18 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80003e18:	1101                	addi	sp,sp,-32
    80003e1a:	ec06                	sd	ra,24(sp)
    80003e1c:	e822                	sd	s0,16(sp)
    80003e1e:	e426                	sd	s1,8(sp)
    80003e20:	e04a                	sd	s2,0(sp)
    80003e22:	1000                	addi	s0,sp,32
    80003e24:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80003e26:	01050913          	addi	s2,a0,16
    80003e2a:	854a                	mv	a0,s2
    80003e2c:	00001097          	auipc	ra,0x1
    80003e30:	42a080e7          	jalr	1066(ra) # 80005256 <holdingsleep>
    80003e34:	c92d                	beqz	a0,80003ea6 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80003e36:	854a                	mv	a0,s2
    80003e38:	00001097          	auipc	ra,0x1
    80003e3c:	3da080e7          	jalr	986(ra) # 80005212 <releasesleep>

  acquire(&bcache.lock);
    80003e40:	00015517          	auipc	a0,0x15
    80003e44:	01850513          	addi	a0,a0,24 # 80018e58 <bcache>
    80003e48:	ffffd097          	auipc	ra,0xffffd
    80003e4c:	e34080e7          	jalr	-460(ra) # 80000c7c <acquire>
  b->refcnt--;
    80003e50:	40bc                	lw	a5,64(s1)
    80003e52:	37fd                	addiw	a5,a5,-1
    80003e54:	0007871b          	sext.w	a4,a5
    80003e58:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80003e5a:	eb05                	bnez	a4,80003e8a <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80003e5c:	68bc                	ld	a5,80(s1)
    80003e5e:	64b8                	ld	a4,72(s1)
    80003e60:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80003e62:	64bc                	ld	a5,72(s1)
    80003e64:	68b8                	ld	a4,80(s1)
    80003e66:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80003e68:	0001d797          	auipc	a5,0x1d
    80003e6c:	ff078793          	addi	a5,a5,-16 # 80020e58 <bcache+0x8000>
    80003e70:	2b87b703          	ld	a4,696(a5)
    80003e74:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80003e76:	0001d717          	auipc	a4,0x1d
    80003e7a:	24a70713          	addi	a4,a4,586 # 800210c0 <bcache+0x8268>
    80003e7e:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80003e80:	2b87b703          	ld	a4,696(a5)
    80003e84:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80003e86:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    80003e8a:	00015517          	auipc	a0,0x15
    80003e8e:	fce50513          	addi	a0,a0,-50 # 80018e58 <bcache>
    80003e92:	ffffd097          	auipc	ra,0xffffd
    80003e96:	e9e080e7          	jalr	-354(ra) # 80000d30 <release>
}
    80003e9a:	60e2                	ld	ra,24(sp)
    80003e9c:	6442                	ld	s0,16(sp)
    80003e9e:	64a2                	ld	s1,8(sp)
    80003ea0:	6902                	ld	s2,0(sp)
    80003ea2:	6105                	addi	sp,sp,32
    80003ea4:	8082                	ret
    panic("brelse");
    80003ea6:	00006517          	auipc	a0,0x6
    80003eaa:	94250513          	addi	a0,a0,-1726 # 800097e8 <syscalls+0x110>
    80003eae:	ffffc097          	auipc	ra,0xffffc
    80003eb2:	68e080e7          	jalr	1678(ra) # 8000053c <panic>

0000000080003eb6 <bpin>:

void
bpin(struct buf *b) {
    80003eb6:	1101                	addi	sp,sp,-32
    80003eb8:	ec06                	sd	ra,24(sp)
    80003eba:	e822                	sd	s0,16(sp)
    80003ebc:	e426                	sd	s1,8(sp)
    80003ebe:	1000                	addi	s0,sp,32
    80003ec0:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003ec2:	00015517          	auipc	a0,0x15
    80003ec6:	f9650513          	addi	a0,a0,-106 # 80018e58 <bcache>
    80003eca:	ffffd097          	auipc	ra,0xffffd
    80003ece:	db2080e7          	jalr	-590(ra) # 80000c7c <acquire>
  b->refcnt++;
    80003ed2:	40bc                	lw	a5,64(s1)
    80003ed4:	2785                	addiw	a5,a5,1
    80003ed6:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80003ed8:	00015517          	auipc	a0,0x15
    80003edc:	f8050513          	addi	a0,a0,-128 # 80018e58 <bcache>
    80003ee0:	ffffd097          	auipc	ra,0xffffd
    80003ee4:	e50080e7          	jalr	-432(ra) # 80000d30 <release>
}
    80003ee8:	60e2                	ld	ra,24(sp)
    80003eea:	6442                	ld	s0,16(sp)
    80003eec:	64a2                	ld	s1,8(sp)
    80003eee:	6105                	addi	sp,sp,32
    80003ef0:	8082                	ret

0000000080003ef2 <bunpin>:

void
bunpin(struct buf *b) {
    80003ef2:	1101                	addi	sp,sp,-32
    80003ef4:	ec06                	sd	ra,24(sp)
    80003ef6:	e822                	sd	s0,16(sp)
    80003ef8:	e426                	sd	s1,8(sp)
    80003efa:	1000                	addi	s0,sp,32
    80003efc:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003efe:	00015517          	auipc	a0,0x15
    80003f02:	f5a50513          	addi	a0,a0,-166 # 80018e58 <bcache>
    80003f06:	ffffd097          	auipc	ra,0xffffd
    80003f0a:	d76080e7          	jalr	-650(ra) # 80000c7c <acquire>
  b->refcnt--;
    80003f0e:	40bc                	lw	a5,64(s1)
    80003f10:	37fd                	addiw	a5,a5,-1
    80003f12:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80003f14:	00015517          	auipc	a0,0x15
    80003f18:	f4450513          	addi	a0,a0,-188 # 80018e58 <bcache>
    80003f1c:	ffffd097          	auipc	ra,0xffffd
    80003f20:	e14080e7          	jalr	-492(ra) # 80000d30 <release>
}
    80003f24:	60e2                	ld	ra,24(sp)
    80003f26:	6442                	ld	s0,16(sp)
    80003f28:	64a2                	ld	s1,8(sp)
    80003f2a:	6105                	addi	sp,sp,32
    80003f2c:	8082                	ret

0000000080003f2e <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80003f2e:	1101                	addi	sp,sp,-32
    80003f30:	ec06                	sd	ra,24(sp)
    80003f32:	e822                	sd	s0,16(sp)
    80003f34:	e426                	sd	s1,8(sp)
    80003f36:	e04a                	sd	s2,0(sp)
    80003f38:	1000                	addi	s0,sp,32
    80003f3a:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80003f3c:	00d5d59b          	srliw	a1,a1,0xd
    80003f40:	0001d797          	auipc	a5,0x1d
    80003f44:	5f47a783          	lw	a5,1524(a5) # 80021534 <sb+0x1c>
    80003f48:	9dbd                	addw	a1,a1,a5
    80003f4a:	00000097          	auipc	ra,0x0
    80003f4e:	d9e080e7          	jalr	-610(ra) # 80003ce8 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80003f52:	0074f713          	andi	a4,s1,7
    80003f56:	4785                	li	a5,1
    80003f58:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    80003f5c:	14ce                	slli	s1,s1,0x33
    80003f5e:	90d9                	srli	s1,s1,0x36
    80003f60:	00950733          	add	a4,a0,s1
    80003f64:	05874703          	lbu	a4,88(a4)
    80003f68:	00e7f6b3          	and	a3,a5,a4
    80003f6c:	c69d                	beqz	a3,80003f9a <bfree+0x6c>
    80003f6e:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80003f70:	94aa                	add	s1,s1,a0
    80003f72:	fff7c793          	not	a5,a5
    80003f76:	8ff9                	and	a5,a5,a4
    80003f78:	04f48c23          	sb	a5,88(s1)
  log_write(bp);
    80003f7c:	00001097          	auipc	ra,0x1
    80003f80:	120080e7          	jalr	288(ra) # 8000509c <log_write>
  brelse(bp);
    80003f84:	854a                	mv	a0,s2
    80003f86:	00000097          	auipc	ra,0x0
    80003f8a:	e92080e7          	jalr	-366(ra) # 80003e18 <brelse>
}
    80003f8e:	60e2                	ld	ra,24(sp)
    80003f90:	6442                	ld	s0,16(sp)
    80003f92:	64a2                	ld	s1,8(sp)
    80003f94:	6902                	ld	s2,0(sp)
    80003f96:	6105                	addi	sp,sp,32
    80003f98:	8082                	ret
    panic("freeing free block");
    80003f9a:	00006517          	auipc	a0,0x6
    80003f9e:	85650513          	addi	a0,a0,-1962 # 800097f0 <syscalls+0x118>
    80003fa2:	ffffc097          	auipc	ra,0xffffc
    80003fa6:	59a080e7          	jalr	1434(ra) # 8000053c <panic>

0000000080003faa <balloc>:
{
    80003faa:	711d                	addi	sp,sp,-96
    80003fac:	ec86                	sd	ra,88(sp)
    80003fae:	e8a2                	sd	s0,80(sp)
    80003fb0:	e4a6                	sd	s1,72(sp)
    80003fb2:	e0ca                	sd	s2,64(sp)
    80003fb4:	fc4e                	sd	s3,56(sp)
    80003fb6:	f852                	sd	s4,48(sp)
    80003fb8:	f456                	sd	s5,40(sp)
    80003fba:	f05a                	sd	s6,32(sp)
    80003fbc:	ec5e                	sd	s7,24(sp)
    80003fbe:	e862                	sd	s8,16(sp)
    80003fc0:	e466                	sd	s9,8(sp)
    80003fc2:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80003fc4:	0001d797          	auipc	a5,0x1d
    80003fc8:	5587a783          	lw	a5,1368(a5) # 8002151c <sb+0x4>
    80003fcc:	10078163          	beqz	a5,800040ce <balloc+0x124>
    80003fd0:	8baa                	mv	s7,a0
    80003fd2:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80003fd4:	0001db17          	auipc	s6,0x1d
    80003fd8:	544b0b13          	addi	s6,s6,1348 # 80021518 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003fdc:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    80003fde:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003fe0:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80003fe2:	6c89                	lui	s9,0x2
    80003fe4:	a061                	j	8000406c <balloc+0xc2>
        bp->data[bi/8] |= m;  // Mark block in use.
    80003fe6:	974a                	add	a4,a4,s2
    80003fe8:	8fd5                	or	a5,a5,a3
    80003fea:	04f70c23          	sb	a5,88(a4)
        log_write(bp);
    80003fee:	854a                	mv	a0,s2
    80003ff0:	00001097          	auipc	ra,0x1
    80003ff4:	0ac080e7          	jalr	172(ra) # 8000509c <log_write>
        brelse(bp);
    80003ff8:	854a                	mv	a0,s2
    80003ffa:	00000097          	auipc	ra,0x0
    80003ffe:	e1e080e7          	jalr	-482(ra) # 80003e18 <brelse>
  bp = bread(dev, bno);
    80004002:	85a6                	mv	a1,s1
    80004004:	855e                	mv	a0,s7
    80004006:	00000097          	auipc	ra,0x0
    8000400a:	ce2080e7          	jalr	-798(ra) # 80003ce8 <bread>
    8000400e:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    80004010:	40000613          	li	a2,1024
    80004014:	4581                	li	a1,0
    80004016:	05850513          	addi	a0,a0,88
    8000401a:	ffffd097          	auipc	ra,0xffffd
    8000401e:	d5e080e7          	jalr	-674(ra) # 80000d78 <memset>
  log_write(bp);
    80004022:	854a                	mv	a0,s2
    80004024:	00001097          	auipc	ra,0x1
    80004028:	078080e7          	jalr	120(ra) # 8000509c <log_write>
  brelse(bp);
    8000402c:	854a                	mv	a0,s2
    8000402e:	00000097          	auipc	ra,0x0
    80004032:	dea080e7          	jalr	-534(ra) # 80003e18 <brelse>
}
    80004036:	8526                	mv	a0,s1
    80004038:	60e6                	ld	ra,88(sp)
    8000403a:	6446                	ld	s0,80(sp)
    8000403c:	64a6                	ld	s1,72(sp)
    8000403e:	6906                	ld	s2,64(sp)
    80004040:	79e2                	ld	s3,56(sp)
    80004042:	7a42                	ld	s4,48(sp)
    80004044:	7aa2                	ld	s5,40(sp)
    80004046:	7b02                	ld	s6,32(sp)
    80004048:	6be2                	ld	s7,24(sp)
    8000404a:	6c42                	ld	s8,16(sp)
    8000404c:	6ca2                	ld	s9,8(sp)
    8000404e:	6125                	addi	sp,sp,96
    80004050:	8082                	ret
    brelse(bp);
    80004052:	854a                	mv	a0,s2
    80004054:	00000097          	auipc	ra,0x0
    80004058:	dc4080e7          	jalr	-572(ra) # 80003e18 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000405c:	015c87bb          	addw	a5,s9,s5
    80004060:	00078a9b          	sext.w	s5,a5
    80004064:	004b2703          	lw	a4,4(s6)
    80004068:	06eaf363          	bgeu	s5,a4,800040ce <balloc+0x124>
    bp = bread(dev, BBLOCK(b, sb));
    8000406c:	41fad79b          	sraiw	a5,s5,0x1f
    80004070:	0137d79b          	srliw	a5,a5,0x13
    80004074:	015787bb          	addw	a5,a5,s5
    80004078:	40d7d79b          	sraiw	a5,a5,0xd
    8000407c:	01cb2583          	lw	a1,28(s6)
    80004080:	9dbd                	addw	a1,a1,a5
    80004082:	855e                	mv	a0,s7
    80004084:	00000097          	auipc	ra,0x0
    80004088:	c64080e7          	jalr	-924(ra) # 80003ce8 <bread>
    8000408c:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000408e:	004b2503          	lw	a0,4(s6)
    80004092:	000a849b          	sext.w	s1,s5
    80004096:	8662                	mv	a2,s8
    80004098:	faa4fde3          	bgeu	s1,a0,80004052 <balloc+0xa8>
      m = 1 << (bi % 8);
    8000409c:	41f6579b          	sraiw	a5,a2,0x1f
    800040a0:	01d7d69b          	srliw	a3,a5,0x1d
    800040a4:	00c6873b          	addw	a4,a3,a2
    800040a8:	00777793          	andi	a5,a4,7
    800040ac:	9f95                	subw	a5,a5,a3
    800040ae:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800040b2:	4037571b          	sraiw	a4,a4,0x3
    800040b6:	00e906b3          	add	a3,s2,a4
    800040ba:	0586c683          	lbu	a3,88(a3) # fffffffffffff058 <end+0xffffffff7ffdae38>
    800040be:	00d7f5b3          	and	a1,a5,a3
    800040c2:	d195                	beqz	a1,80003fe6 <balloc+0x3c>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800040c4:	2605                	addiw	a2,a2,1
    800040c6:	2485                	addiw	s1,s1,1
    800040c8:	fd4618e3          	bne	a2,s4,80004098 <balloc+0xee>
    800040cc:	b759                	j	80004052 <balloc+0xa8>
  printf("balloc: out of blocks\n");
    800040ce:	00005517          	auipc	a0,0x5
    800040d2:	73a50513          	addi	a0,a0,1850 # 80009808 <syscalls+0x130>
    800040d6:	ffffc097          	auipc	ra,0xffffc
    800040da:	4b0080e7          	jalr	1200(ra) # 80000586 <printf>
  return 0;
    800040de:	4481                	li	s1,0
    800040e0:	bf99                	j	80004036 <balloc+0x8c>

00000000800040e2 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    800040e2:	7179                	addi	sp,sp,-48
    800040e4:	f406                	sd	ra,40(sp)
    800040e6:	f022                	sd	s0,32(sp)
    800040e8:	ec26                	sd	s1,24(sp)
    800040ea:	e84a                	sd	s2,16(sp)
    800040ec:	e44e                	sd	s3,8(sp)
    800040ee:	e052                	sd	s4,0(sp)
    800040f0:	1800                	addi	s0,sp,48
    800040f2:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800040f4:	47ad                	li	a5,11
    800040f6:	02b7e763          	bltu	a5,a1,80004124 <bmap+0x42>
    if((addr = ip->addrs[bn]) == 0){
    800040fa:	02059493          	slli	s1,a1,0x20
    800040fe:	9081                	srli	s1,s1,0x20
    80004100:	048a                	slli	s1,s1,0x2
    80004102:	94aa                	add	s1,s1,a0
    80004104:	0504a903          	lw	s2,80(s1)
    80004108:	06091e63          	bnez	s2,80004184 <bmap+0xa2>
      addr = balloc(ip->dev);
    8000410c:	4108                	lw	a0,0(a0)
    8000410e:	00000097          	auipc	ra,0x0
    80004112:	e9c080e7          	jalr	-356(ra) # 80003faa <balloc>
    80004116:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    8000411a:	06090563          	beqz	s2,80004184 <bmap+0xa2>
        return 0;
      ip->addrs[bn] = addr;
    8000411e:	0524a823          	sw	s2,80(s1)
    80004122:	a08d                	j	80004184 <bmap+0xa2>
    }
    return addr;
  }
  bn -= NDIRECT;
    80004124:	ff45849b          	addiw	s1,a1,-12
    80004128:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    8000412c:	0ff00793          	li	a5,255
    80004130:	08e7e563          	bltu	a5,a4,800041ba <bmap+0xd8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    80004134:	08052903          	lw	s2,128(a0)
    80004138:	00091d63          	bnez	s2,80004152 <bmap+0x70>
      addr = balloc(ip->dev);
    8000413c:	4108                	lw	a0,0(a0)
    8000413e:	00000097          	auipc	ra,0x0
    80004142:	e6c080e7          	jalr	-404(ra) # 80003faa <balloc>
    80004146:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    8000414a:	02090d63          	beqz	s2,80004184 <bmap+0xa2>
        return 0;
      ip->addrs[NDIRECT] = addr;
    8000414e:	0929a023          	sw	s2,128(s3)
    }
    bp = bread(ip->dev, addr);
    80004152:	85ca                	mv	a1,s2
    80004154:	0009a503          	lw	a0,0(s3)
    80004158:	00000097          	auipc	ra,0x0
    8000415c:	b90080e7          	jalr	-1136(ra) # 80003ce8 <bread>
    80004160:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80004162:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80004166:	02049593          	slli	a1,s1,0x20
    8000416a:	9181                	srli	a1,a1,0x20
    8000416c:	058a                	slli	a1,a1,0x2
    8000416e:	00b784b3          	add	s1,a5,a1
    80004172:	0004a903          	lw	s2,0(s1)
    80004176:	02090063          	beqz	s2,80004196 <bmap+0xb4>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    8000417a:	8552                	mv	a0,s4
    8000417c:	00000097          	auipc	ra,0x0
    80004180:	c9c080e7          	jalr	-868(ra) # 80003e18 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    80004184:	854a                	mv	a0,s2
    80004186:	70a2                	ld	ra,40(sp)
    80004188:	7402                	ld	s0,32(sp)
    8000418a:	64e2                	ld	s1,24(sp)
    8000418c:	6942                	ld	s2,16(sp)
    8000418e:	69a2                	ld	s3,8(sp)
    80004190:	6a02                	ld	s4,0(sp)
    80004192:	6145                	addi	sp,sp,48
    80004194:	8082                	ret
      addr = balloc(ip->dev);
    80004196:	0009a503          	lw	a0,0(s3)
    8000419a:	00000097          	auipc	ra,0x0
    8000419e:	e10080e7          	jalr	-496(ra) # 80003faa <balloc>
    800041a2:	0005091b          	sext.w	s2,a0
      if(addr){
    800041a6:	fc090ae3          	beqz	s2,8000417a <bmap+0x98>
        a[bn] = addr;
    800041aa:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    800041ae:	8552                	mv	a0,s4
    800041b0:	00001097          	auipc	ra,0x1
    800041b4:	eec080e7          	jalr	-276(ra) # 8000509c <log_write>
    800041b8:	b7c9                	j	8000417a <bmap+0x98>
  panic("bmap: out of range");
    800041ba:	00005517          	auipc	a0,0x5
    800041be:	66650513          	addi	a0,a0,1638 # 80009820 <syscalls+0x148>
    800041c2:	ffffc097          	auipc	ra,0xffffc
    800041c6:	37a080e7          	jalr	890(ra) # 8000053c <panic>

00000000800041ca <iget>:
{
    800041ca:	7179                	addi	sp,sp,-48
    800041cc:	f406                	sd	ra,40(sp)
    800041ce:	f022                	sd	s0,32(sp)
    800041d0:	ec26                	sd	s1,24(sp)
    800041d2:	e84a                	sd	s2,16(sp)
    800041d4:	e44e                	sd	s3,8(sp)
    800041d6:	e052                	sd	s4,0(sp)
    800041d8:	1800                	addi	s0,sp,48
    800041da:	89aa                	mv	s3,a0
    800041dc:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    800041de:	0001d517          	auipc	a0,0x1d
    800041e2:	35a50513          	addi	a0,a0,858 # 80021538 <itable>
    800041e6:	ffffd097          	auipc	ra,0xffffd
    800041ea:	a96080e7          	jalr	-1386(ra) # 80000c7c <acquire>
  empty = 0;
    800041ee:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800041f0:	0001d497          	auipc	s1,0x1d
    800041f4:	36048493          	addi	s1,s1,864 # 80021550 <itable+0x18>
    800041f8:	0001f697          	auipc	a3,0x1f
    800041fc:	de868693          	addi	a3,a3,-536 # 80022fe0 <log>
    80004200:	a039                	j	8000420e <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80004202:	02090b63          	beqz	s2,80004238 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80004206:	08848493          	addi	s1,s1,136
    8000420a:	02d48a63          	beq	s1,a3,8000423e <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    8000420e:	449c                	lw	a5,8(s1)
    80004210:	fef059e3          	blez	a5,80004202 <iget+0x38>
    80004214:	4098                	lw	a4,0(s1)
    80004216:	ff3716e3          	bne	a4,s3,80004202 <iget+0x38>
    8000421a:	40d8                	lw	a4,4(s1)
    8000421c:	ff4713e3          	bne	a4,s4,80004202 <iget+0x38>
      ip->ref++;
    80004220:	2785                	addiw	a5,a5,1
    80004222:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80004224:	0001d517          	auipc	a0,0x1d
    80004228:	31450513          	addi	a0,a0,788 # 80021538 <itable>
    8000422c:	ffffd097          	auipc	ra,0xffffd
    80004230:	b04080e7          	jalr	-1276(ra) # 80000d30 <release>
      return ip;
    80004234:	8926                	mv	s2,s1
    80004236:	a03d                	j	80004264 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80004238:	f7f9                	bnez	a5,80004206 <iget+0x3c>
    8000423a:	8926                	mv	s2,s1
    8000423c:	b7e9                	j	80004206 <iget+0x3c>
  if(empty == 0)
    8000423e:	02090c63          	beqz	s2,80004276 <iget+0xac>
  ip->dev = dev;
    80004242:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80004246:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    8000424a:	4785                	li	a5,1
    8000424c:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80004250:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80004254:	0001d517          	auipc	a0,0x1d
    80004258:	2e450513          	addi	a0,a0,740 # 80021538 <itable>
    8000425c:	ffffd097          	auipc	ra,0xffffd
    80004260:	ad4080e7          	jalr	-1324(ra) # 80000d30 <release>
}
    80004264:	854a                	mv	a0,s2
    80004266:	70a2                	ld	ra,40(sp)
    80004268:	7402                	ld	s0,32(sp)
    8000426a:	64e2                	ld	s1,24(sp)
    8000426c:	6942                	ld	s2,16(sp)
    8000426e:	69a2                	ld	s3,8(sp)
    80004270:	6a02                	ld	s4,0(sp)
    80004272:	6145                	addi	sp,sp,48
    80004274:	8082                	ret
    panic("iget: no inodes");
    80004276:	00005517          	auipc	a0,0x5
    8000427a:	5c250513          	addi	a0,a0,1474 # 80009838 <syscalls+0x160>
    8000427e:	ffffc097          	auipc	ra,0xffffc
    80004282:	2be080e7          	jalr	702(ra) # 8000053c <panic>

0000000080004286 <fsinit>:
fsinit(int dev) {
    80004286:	7179                	addi	sp,sp,-48
    80004288:	f406                	sd	ra,40(sp)
    8000428a:	f022                	sd	s0,32(sp)
    8000428c:	ec26                	sd	s1,24(sp)
    8000428e:	e84a                	sd	s2,16(sp)
    80004290:	e44e                	sd	s3,8(sp)
    80004292:	1800                	addi	s0,sp,48
    80004294:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80004296:	4585                	li	a1,1
    80004298:	00000097          	auipc	ra,0x0
    8000429c:	a50080e7          	jalr	-1456(ra) # 80003ce8 <bread>
    800042a0:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    800042a2:	0001d997          	auipc	s3,0x1d
    800042a6:	27698993          	addi	s3,s3,630 # 80021518 <sb>
    800042aa:	02000613          	li	a2,32
    800042ae:	05850593          	addi	a1,a0,88
    800042b2:	854e                	mv	a0,s3
    800042b4:	ffffd097          	auipc	ra,0xffffd
    800042b8:	b20080e7          	jalr	-1248(ra) # 80000dd4 <memmove>
  brelse(bp);
    800042bc:	8526                	mv	a0,s1
    800042be:	00000097          	auipc	ra,0x0
    800042c2:	b5a080e7          	jalr	-1190(ra) # 80003e18 <brelse>
  if(sb.magic != FSMAGIC)
    800042c6:	0009a703          	lw	a4,0(s3)
    800042ca:	102037b7          	lui	a5,0x10203
    800042ce:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    800042d2:	02f71263          	bne	a4,a5,800042f6 <fsinit+0x70>
  initlog(dev, &sb);
    800042d6:	0001d597          	auipc	a1,0x1d
    800042da:	24258593          	addi	a1,a1,578 # 80021518 <sb>
    800042de:	854a                	mv	a0,s2
    800042e0:	00001097          	auipc	ra,0x1
    800042e4:	b40080e7          	jalr	-1216(ra) # 80004e20 <initlog>
}
    800042e8:	70a2                	ld	ra,40(sp)
    800042ea:	7402                	ld	s0,32(sp)
    800042ec:	64e2                	ld	s1,24(sp)
    800042ee:	6942                	ld	s2,16(sp)
    800042f0:	69a2                	ld	s3,8(sp)
    800042f2:	6145                	addi	sp,sp,48
    800042f4:	8082                	ret
    panic("invalid file system");
    800042f6:	00005517          	auipc	a0,0x5
    800042fa:	55250513          	addi	a0,a0,1362 # 80009848 <syscalls+0x170>
    800042fe:	ffffc097          	auipc	ra,0xffffc
    80004302:	23e080e7          	jalr	574(ra) # 8000053c <panic>

0000000080004306 <iinit>:
{
    80004306:	7179                	addi	sp,sp,-48
    80004308:	f406                	sd	ra,40(sp)
    8000430a:	f022                	sd	s0,32(sp)
    8000430c:	ec26                	sd	s1,24(sp)
    8000430e:	e84a                	sd	s2,16(sp)
    80004310:	e44e                	sd	s3,8(sp)
    80004312:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80004314:	00005597          	auipc	a1,0x5
    80004318:	54c58593          	addi	a1,a1,1356 # 80009860 <syscalls+0x188>
    8000431c:	0001d517          	auipc	a0,0x1d
    80004320:	21c50513          	addi	a0,a0,540 # 80021538 <itable>
    80004324:	ffffd097          	auipc	ra,0xffffd
    80004328:	8c8080e7          	jalr	-1848(ra) # 80000bec <initlock>
  for(i = 0; i < NINODE; i++) {
    8000432c:	0001d497          	auipc	s1,0x1d
    80004330:	23448493          	addi	s1,s1,564 # 80021560 <itable+0x28>
    80004334:	0001f997          	auipc	s3,0x1f
    80004338:	cbc98993          	addi	s3,s3,-836 # 80022ff0 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    8000433c:	00005917          	auipc	s2,0x5
    80004340:	52c90913          	addi	s2,s2,1324 # 80009868 <syscalls+0x190>
    80004344:	85ca                	mv	a1,s2
    80004346:	8526                	mv	a0,s1
    80004348:	00001097          	auipc	ra,0x1
    8000434c:	e3a080e7          	jalr	-454(ra) # 80005182 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80004350:	08848493          	addi	s1,s1,136
    80004354:	ff3498e3          	bne	s1,s3,80004344 <iinit+0x3e>
}
    80004358:	70a2                	ld	ra,40(sp)
    8000435a:	7402                	ld	s0,32(sp)
    8000435c:	64e2                	ld	s1,24(sp)
    8000435e:	6942                	ld	s2,16(sp)
    80004360:	69a2                	ld	s3,8(sp)
    80004362:	6145                	addi	sp,sp,48
    80004364:	8082                	ret

0000000080004366 <ialloc>:
{
    80004366:	715d                	addi	sp,sp,-80
    80004368:	e486                	sd	ra,72(sp)
    8000436a:	e0a2                	sd	s0,64(sp)
    8000436c:	fc26                	sd	s1,56(sp)
    8000436e:	f84a                	sd	s2,48(sp)
    80004370:	f44e                	sd	s3,40(sp)
    80004372:	f052                	sd	s4,32(sp)
    80004374:	ec56                	sd	s5,24(sp)
    80004376:	e85a                	sd	s6,16(sp)
    80004378:	e45e                	sd	s7,8(sp)
    8000437a:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    8000437c:	0001d717          	auipc	a4,0x1d
    80004380:	1a872703          	lw	a4,424(a4) # 80021524 <sb+0xc>
    80004384:	4785                	li	a5,1
    80004386:	04e7fa63          	bgeu	a5,a4,800043da <ialloc+0x74>
    8000438a:	8aaa                	mv	s5,a0
    8000438c:	8bae                	mv	s7,a1
    8000438e:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    80004390:	0001da17          	auipc	s4,0x1d
    80004394:	188a0a13          	addi	s4,s4,392 # 80021518 <sb>
    80004398:	00048b1b          	sext.w	s6,s1
    8000439c:	0044d793          	srli	a5,s1,0x4
    800043a0:	018a2583          	lw	a1,24(s4)
    800043a4:	9dbd                	addw	a1,a1,a5
    800043a6:	8556                	mv	a0,s5
    800043a8:	00000097          	auipc	ra,0x0
    800043ac:	940080e7          	jalr	-1728(ra) # 80003ce8 <bread>
    800043b0:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    800043b2:	05850993          	addi	s3,a0,88
    800043b6:	00f4f793          	andi	a5,s1,15
    800043ba:	079a                	slli	a5,a5,0x6
    800043bc:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    800043be:	00099783          	lh	a5,0(s3)
    800043c2:	c3a1                	beqz	a5,80004402 <ialloc+0x9c>
    brelse(bp);
    800043c4:	00000097          	auipc	ra,0x0
    800043c8:	a54080e7          	jalr	-1452(ra) # 80003e18 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    800043cc:	0485                	addi	s1,s1,1
    800043ce:	00ca2703          	lw	a4,12(s4)
    800043d2:	0004879b          	sext.w	a5,s1
    800043d6:	fce7e1e3          	bltu	a5,a4,80004398 <ialloc+0x32>
  printf("ialloc: no inodes\n");
    800043da:	00005517          	auipc	a0,0x5
    800043de:	49650513          	addi	a0,a0,1174 # 80009870 <syscalls+0x198>
    800043e2:	ffffc097          	auipc	ra,0xffffc
    800043e6:	1a4080e7          	jalr	420(ra) # 80000586 <printf>
  return 0;
    800043ea:	4501                	li	a0,0
}
    800043ec:	60a6                	ld	ra,72(sp)
    800043ee:	6406                	ld	s0,64(sp)
    800043f0:	74e2                	ld	s1,56(sp)
    800043f2:	7942                	ld	s2,48(sp)
    800043f4:	79a2                	ld	s3,40(sp)
    800043f6:	7a02                	ld	s4,32(sp)
    800043f8:	6ae2                	ld	s5,24(sp)
    800043fa:	6b42                	ld	s6,16(sp)
    800043fc:	6ba2                	ld	s7,8(sp)
    800043fe:	6161                	addi	sp,sp,80
    80004400:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80004402:	04000613          	li	a2,64
    80004406:	4581                	li	a1,0
    80004408:	854e                	mv	a0,s3
    8000440a:	ffffd097          	auipc	ra,0xffffd
    8000440e:	96e080e7          	jalr	-1682(ra) # 80000d78 <memset>
      dip->type = type;
    80004412:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80004416:	854a                	mv	a0,s2
    80004418:	00001097          	auipc	ra,0x1
    8000441c:	c84080e7          	jalr	-892(ra) # 8000509c <log_write>
      brelse(bp);
    80004420:	854a                	mv	a0,s2
    80004422:	00000097          	auipc	ra,0x0
    80004426:	9f6080e7          	jalr	-1546(ra) # 80003e18 <brelse>
      return iget(dev, inum);
    8000442a:	85da                	mv	a1,s6
    8000442c:	8556                	mv	a0,s5
    8000442e:	00000097          	auipc	ra,0x0
    80004432:	d9c080e7          	jalr	-612(ra) # 800041ca <iget>
    80004436:	bf5d                	j	800043ec <ialloc+0x86>

0000000080004438 <iupdate>:
{
    80004438:	1101                	addi	sp,sp,-32
    8000443a:	ec06                	sd	ra,24(sp)
    8000443c:	e822                	sd	s0,16(sp)
    8000443e:	e426                	sd	s1,8(sp)
    80004440:	e04a                	sd	s2,0(sp)
    80004442:	1000                	addi	s0,sp,32
    80004444:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80004446:	415c                	lw	a5,4(a0)
    80004448:	0047d79b          	srliw	a5,a5,0x4
    8000444c:	0001d597          	auipc	a1,0x1d
    80004450:	0e45a583          	lw	a1,228(a1) # 80021530 <sb+0x18>
    80004454:	9dbd                	addw	a1,a1,a5
    80004456:	4108                	lw	a0,0(a0)
    80004458:	00000097          	auipc	ra,0x0
    8000445c:	890080e7          	jalr	-1904(ra) # 80003ce8 <bread>
    80004460:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80004462:	05850793          	addi	a5,a0,88
    80004466:	40c8                	lw	a0,4(s1)
    80004468:	893d                	andi	a0,a0,15
    8000446a:	051a                	slli	a0,a0,0x6
    8000446c:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    8000446e:	04449703          	lh	a4,68(s1)
    80004472:	00e51023          	sh	a4,0(a0)
  dip->major = ip->major;
    80004476:	04649703          	lh	a4,70(s1)
    8000447a:	00e51123          	sh	a4,2(a0)
  dip->minor = ip->minor;
    8000447e:	04849703          	lh	a4,72(s1)
    80004482:	00e51223          	sh	a4,4(a0)
  dip->nlink = ip->nlink;
    80004486:	04a49703          	lh	a4,74(s1)
    8000448a:	00e51323          	sh	a4,6(a0)
  dip->size = ip->size;
    8000448e:	44f8                	lw	a4,76(s1)
    80004490:	c518                	sw	a4,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80004492:	03400613          	li	a2,52
    80004496:	05048593          	addi	a1,s1,80
    8000449a:	0531                	addi	a0,a0,12
    8000449c:	ffffd097          	auipc	ra,0xffffd
    800044a0:	938080e7          	jalr	-1736(ra) # 80000dd4 <memmove>
  log_write(bp);
    800044a4:	854a                	mv	a0,s2
    800044a6:	00001097          	auipc	ra,0x1
    800044aa:	bf6080e7          	jalr	-1034(ra) # 8000509c <log_write>
  brelse(bp);
    800044ae:	854a                	mv	a0,s2
    800044b0:	00000097          	auipc	ra,0x0
    800044b4:	968080e7          	jalr	-1688(ra) # 80003e18 <brelse>
}
    800044b8:	60e2                	ld	ra,24(sp)
    800044ba:	6442                	ld	s0,16(sp)
    800044bc:	64a2                	ld	s1,8(sp)
    800044be:	6902                	ld	s2,0(sp)
    800044c0:	6105                	addi	sp,sp,32
    800044c2:	8082                	ret

00000000800044c4 <idup>:
{
    800044c4:	1101                	addi	sp,sp,-32
    800044c6:	ec06                	sd	ra,24(sp)
    800044c8:	e822                	sd	s0,16(sp)
    800044ca:	e426                	sd	s1,8(sp)
    800044cc:	1000                	addi	s0,sp,32
    800044ce:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    800044d0:	0001d517          	auipc	a0,0x1d
    800044d4:	06850513          	addi	a0,a0,104 # 80021538 <itable>
    800044d8:	ffffc097          	auipc	ra,0xffffc
    800044dc:	7a4080e7          	jalr	1956(ra) # 80000c7c <acquire>
  ip->ref++;
    800044e0:	449c                	lw	a5,8(s1)
    800044e2:	2785                	addiw	a5,a5,1
    800044e4:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    800044e6:	0001d517          	auipc	a0,0x1d
    800044ea:	05250513          	addi	a0,a0,82 # 80021538 <itable>
    800044ee:	ffffd097          	auipc	ra,0xffffd
    800044f2:	842080e7          	jalr	-1982(ra) # 80000d30 <release>
}
    800044f6:	8526                	mv	a0,s1
    800044f8:	60e2                	ld	ra,24(sp)
    800044fa:	6442                	ld	s0,16(sp)
    800044fc:	64a2                	ld	s1,8(sp)
    800044fe:	6105                	addi	sp,sp,32
    80004500:	8082                	ret

0000000080004502 <ilock>:
{
    80004502:	1101                	addi	sp,sp,-32
    80004504:	ec06                	sd	ra,24(sp)
    80004506:	e822                	sd	s0,16(sp)
    80004508:	e426                	sd	s1,8(sp)
    8000450a:	e04a                	sd	s2,0(sp)
    8000450c:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    8000450e:	c115                	beqz	a0,80004532 <ilock+0x30>
    80004510:	84aa                	mv	s1,a0
    80004512:	451c                	lw	a5,8(a0)
    80004514:	00f05f63          	blez	a5,80004532 <ilock+0x30>
  acquiresleep(&ip->lock);
    80004518:	0541                	addi	a0,a0,16
    8000451a:	00001097          	auipc	ra,0x1
    8000451e:	ca2080e7          	jalr	-862(ra) # 800051bc <acquiresleep>
  if(ip->valid == 0){
    80004522:	40bc                	lw	a5,64(s1)
    80004524:	cf99                	beqz	a5,80004542 <ilock+0x40>
}
    80004526:	60e2                	ld	ra,24(sp)
    80004528:	6442                	ld	s0,16(sp)
    8000452a:	64a2                	ld	s1,8(sp)
    8000452c:	6902                	ld	s2,0(sp)
    8000452e:	6105                	addi	sp,sp,32
    80004530:	8082                	ret
    panic("ilock");
    80004532:	00005517          	auipc	a0,0x5
    80004536:	35650513          	addi	a0,a0,854 # 80009888 <syscalls+0x1b0>
    8000453a:	ffffc097          	auipc	ra,0xffffc
    8000453e:	002080e7          	jalr	2(ra) # 8000053c <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80004542:	40dc                	lw	a5,4(s1)
    80004544:	0047d79b          	srliw	a5,a5,0x4
    80004548:	0001d597          	auipc	a1,0x1d
    8000454c:	fe85a583          	lw	a1,-24(a1) # 80021530 <sb+0x18>
    80004550:	9dbd                	addw	a1,a1,a5
    80004552:	4088                	lw	a0,0(s1)
    80004554:	fffff097          	auipc	ra,0xfffff
    80004558:	794080e7          	jalr	1940(ra) # 80003ce8 <bread>
    8000455c:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    8000455e:	05850593          	addi	a1,a0,88
    80004562:	40dc                	lw	a5,4(s1)
    80004564:	8bbd                	andi	a5,a5,15
    80004566:	079a                	slli	a5,a5,0x6
    80004568:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    8000456a:	00059783          	lh	a5,0(a1)
    8000456e:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80004572:	00259783          	lh	a5,2(a1)
    80004576:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    8000457a:	00459783          	lh	a5,4(a1)
    8000457e:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80004582:	00659783          	lh	a5,6(a1)
    80004586:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    8000458a:	459c                	lw	a5,8(a1)
    8000458c:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    8000458e:	03400613          	li	a2,52
    80004592:	05b1                	addi	a1,a1,12
    80004594:	05048513          	addi	a0,s1,80
    80004598:	ffffd097          	auipc	ra,0xffffd
    8000459c:	83c080e7          	jalr	-1988(ra) # 80000dd4 <memmove>
    brelse(bp);
    800045a0:	854a                	mv	a0,s2
    800045a2:	00000097          	auipc	ra,0x0
    800045a6:	876080e7          	jalr	-1930(ra) # 80003e18 <brelse>
    ip->valid = 1;
    800045aa:	4785                	li	a5,1
    800045ac:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    800045ae:	04449783          	lh	a5,68(s1)
    800045b2:	fbb5                	bnez	a5,80004526 <ilock+0x24>
      panic("ilock: no type");
    800045b4:	00005517          	auipc	a0,0x5
    800045b8:	2dc50513          	addi	a0,a0,732 # 80009890 <syscalls+0x1b8>
    800045bc:	ffffc097          	auipc	ra,0xffffc
    800045c0:	f80080e7          	jalr	-128(ra) # 8000053c <panic>

00000000800045c4 <iunlock>:
{
    800045c4:	1101                	addi	sp,sp,-32
    800045c6:	ec06                	sd	ra,24(sp)
    800045c8:	e822                	sd	s0,16(sp)
    800045ca:	e426                	sd	s1,8(sp)
    800045cc:	e04a                	sd	s2,0(sp)
    800045ce:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    800045d0:	c905                	beqz	a0,80004600 <iunlock+0x3c>
    800045d2:	84aa                	mv	s1,a0
    800045d4:	01050913          	addi	s2,a0,16
    800045d8:	854a                	mv	a0,s2
    800045da:	00001097          	auipc	ra,0x1
    800045de:	c7c080e7          	jalr	-900(ra) # 80005256 <holdingsleep>
    800045e2:	cd19                	beqz	a0,80004600 <iunlock+0x3c>
    800045e4:	449c                	lw	a5,8(s1)
    800045e6:	00f05d63          	blez	a5,80004600 <iunlock+0x3c>
  releasesleep(&ip->lock);
    800045ea:	854a                	mv	a0,s2
    800045ec:	00001097          	auipc	ra,0x1
    800045f0:	c26080e7          	jalr	-986(ra) # 80005212 <releasesleep>
}
    800045f4:	60e2                	ld	ra,24(sp)
    800045f6:	6442                	ld	s0,16(sp)
    800045f8:	64a2                	ld	s1,8(sp)
    800045fa:	6902                	ld	s2,0(sp)
    800045fc:	6105                	addi	sp,sp,32
    800045fe:	8082                	ret
    panic("iunlock");
    80004600:	00005517          	auipc	a0,0x5
    80004604:	2a050513          	addi	a0,a0,672 # 800098a0 <syscalls+0x1c8>
    80004608:	ffffc097          	auipc	ra,0xffffc
    8000460c:	f34080e7          	jalr	-204(ra) # 8000053c <panic>

0000000080004610 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80004610:	7179                	addi	sp,sp,-48
    80004612:	f406                	sd	ra,40(sp)
    80004614:	f022                	sd	s0,32(sp)
    80004616:	ec26                	sd	s1,24(sp)
    80004618:	e84a                	sd	s2,16(sp)
    8000461a:	e44e                	sd	s3,8(sp)
    8000461c:	e052                	sd	s4,0(sp)
    8000461e:	1800                	addi	s0,sp,48
    80004620:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80004622:	05050493          	addi	s1,a0,80
    80004626:	08050913          	addi	s2,a0,128
    8000462a:	a021                	j	80004632 <itrunc+0x22>
    8000462c:	0491                	addi	s1,s1,4
    8000462e:	01248d63          	beq	s1,s2,80004648 <itrunc+0x38>
    if(ip->addrs[i]){
    80004632:	408c                	lw	a1,0(s1)
    80004634:	dde5                	beqz	a1,8000462c <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80004636:	0009a503          	lw	a0,0(s3)
    8000463a:	00000097          	auipc	ra,0x0
    8000463e:	8f4080e7          	jalr	-1804(ra) # 80003f2e <bfree>
      ip->addrs[i] = 0;
    80004642:	0004a023          	sw	zero,0(s1)
    80004646:	b7dd                	j	8000462c <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80004648:	0809a583          	lw	a1,128(s3)
    8000464c:	e185                	bnez	a1,8000466c <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    8000464e:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80004652:	854e                	mv	a0,s3
    80004654:	00000097          	auipc	ra,0x0
    80004658:	de4080e7          	jalr	-540(ra) # 80004438 <iupdate>
}
    8000465c:	70a2                	ld	ra,40(sp)
    8000465e:	7402                	ld	s0,32(sp)
    80004660:	64e2                	ld	s1,24(sp)
    80004662:	6942                	ld	s2,16(sp)
    80004664:	69a2                	ld	s3,8(sp)
    80004666:	6a02                	ld	s4,0(sp)
    80004668:	6145                	addi	sp,sp,48
    8000466a:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    8000466c:	0009a503          	lw	a0,0(s3)
    80004670:	fffff097          	auipc	ra,0xfffff
    80004674:	678080e7          	jalr	1656(ra) # 80003ce8 <bread>
    80004678:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    8000467a:	05850493          	addi	s1,a0,88
    8000467e:	45850913          	addi	s2,a0,1112
    80004682:	a021                	j	8000468a <itrunc+0x7a>
    80004684:	0491                	addi	s1,s1,4
    80004686:	01248b63          	beq	s1,s2,8000469c <itrunc+0x8c>
      if(a[j])
    8000468a:	408c                	lw	a1,0(s1)
    8000468c:	dde5                	beqz	a1,80004684 <itrunc+0x74>
        bfree(ip->dev, a[j]);
    8000468e:	0009a503          	lw	a0,0(s3)
    80004692:	00000097          	auipc	ra,0x0
    80004696:	89c080e7          	jalr	-1892(ra) # 80003f2e <bfree>
    8000469a:	b7ed                	j	80004684 <itrunc+0x74>
    brelse(bp);
    8000469c:	8552                	mv	a0,s4
    8000469e:	fffff097          	auipc	ra,0xfffff
    800046a2:	77a080e7          	jalr	1914(ra) # 80003e18 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    800046a6:	0809a583          	lw	a1,128(s3)
    800046aa:	0009a503          	lw	a0,0(s3)
    800046ae:	00000097          	auipc	ra,0x0
    800046b2:	880080e7          	jalr	-1920(ra) # 80003f2e <bfree>
    ip->addrs[NDIRECT] = 0;
    800046b6:	0809a023          	sw	zero,128(s3)
    800046ba:	bf51                	j	8000464e <itrunc+0x3e>

00000000800046bc <iput>:
{
    800046bc:	1101                	addi	sp,sp,-32
    800046be:	ec06                	sd	ra,24(sp)
    800046c0:	e822                	sd	s0,16(sp)
    800046c2:	e426                	sd	s1,8(sp)
    800046c4:	e04a                	sd	s2,0(sp)
    800046c6:	1000                	addi	s0,sp,32
    800046c8:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    800046ca:	0001d517          	auipc	a0,0x1d
    800046ce:	e6e50513          	addi	a0,a0,-402 # 80021538 <itable>
    800046d2:	ffffc097          	auipc	ra,0xffffc
    800046d6:	5aa080e7          	jalr	1450(ra) # 80000c7c <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800046da:	4498                	lw	a4,8(s1)
    800046dc:	4785                	li	a5,1
    800046de:	02f70363          	beq	a4,a5,80004704 <iput+0x48>
  ip->ref--;
    800046e2:	449c                	lw	a5,8(s1)
    800046e4:	37fd                	addiw	a5,a5,-1
    800046e6:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    800046e8:	0001d517          	auipc	a0,0x1d
    800046ec:	e5050513          	addi	a0,a0,-432 # 80021538 <itable>
    800046f0:	ffffc097          	auipc	ra,0xffffc
    800046f4:	640080e7          	jalr	1600(ra) # 80000d30 <release>
}
    800046f8:	60e2                	ld	ra,24(sp)
    800046fa:	6442                	ld	s0,16(sp)
    800046fc:	64a2                	ld	s1,8(sp)
    800046fe:	6902                	ld	s2,0(sp)
    80004700:	6105                	addi	sp,sp,32
    80004702:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80004704:	40bc                	lw	a5,64(s1)
    80004706:	dff1                	beqz	a5,800046e2 <iput+0x26>
    80004708:	04a49783          	lh	a5,74(s1)
    8000470c:	fbf9                	bnez	a5,800046e2 <iput+0x26>
    acquiresleep(&ip->lock);
    8000470e:	01048913          	addi	s2,s1,16
    80004712:	854a                	mv	a0,s2
    80004714:	00001097          	auipc	ra,0x1
    80004718:	aa8080e7          	jalr	-1368(ra) # 800051bc <acquiresleep>
    release(&itable.lock);
    8000471c:	0001d517          	auipc	a0,0x1d
    80004720:	e1c50513          	addi	a0,a0,-484 # 80021538 <itable>
    80004724:	ffffc097          	auipc	ra,0xffffc
    80004728:	60c080e7          	jalr	1548(ra) # 80000d30 <release>
    itrunc(ip);
    8000472c:	8526                	mv	a0,s1
    8000472e:	00000097          	auipc	ra,0x0
    80004732:	ee2080e7          	jalr	-286(ra) # 80004610 <itrunc>
    ip->type = 0;
    80004736:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    8000473a:	8526                	mv	a0,s1
    8000473c:	00000097          	auipc	ra,0x0
    80004740:	cfc080e7          	jalr	-772(ra) # 80004438 <iupdate>
    ip->valid = 0;
    80004744:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80004748:	854a                	mv	a0,s2
    8000474a:	00001097          	auipc	ra,0x1
    8000474e:	ac8080e7          	jalr	-1336(ra) # 80005212 <releasesleep>
    acquire(&itable.lock);
    80004752:	0001d517          	auipc	a0,0x1d
    80004756:	de650513          	addi	a0,a0,-538 # 80021538 <itable>
    8000475a:	ffffc097          	auipc	ra,0xffffc
    8000475e:	522080e7          	jalr	1314(ra) # 80000c7c <acquire>
    80004762:	b741                	j	800046e2 <iput+0x26>

0000000080004764 <iunlockput>:
{
    80004764:	1101                	addi	sp,sp,-32
    80004766:	ec06                	sd	ra,24(sp)
    80004768:	e822                	sd	s0,16(sp)
    8000476a:	e426                	sd	s1,8(sp)
    8000476c:	1000                	addi	s0,sp,32
    8000476e:	84aa                	mv	s1,a0
  iunlock(ip);
    80004770:	00000097          	auipc	ra,0x0
    80004774:	e54080e7          	jalr	-428(ra) # 800045c4 <iunlock>
  iput(ip);
    80004778:	8526                	mv	a0,s1
    8000477a:	00000097          	auipc	ra,0x0
    8000477e:	f42080e7          	jalr	-190(ra) # 800046bc <iput>
}
    80004782:	60e2                	ld	ra,24(sp)
    80004784:	6442                	ld	s0,16(sp)
    80004786:	64a2                	ld	s1,8(sp)
    80004788:	6105                	addi	sp,sp,32
    8000478a:	8082                	ret

000000008000478c <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    8000478c:	1141                	addi	sp,sp,-16
    8000478e:	e422                	sd	s0,8(sp)
    80004790:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80004792:	411c                	lw	a5,0(a0)
    80004794:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80004796:	415c                	lw	a5,4(a0)
    80004798:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    8000479a:	04451783          	lh	a5,68(a0)
    8000479e:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    800047a2:	04a51783          	lh	a5,74(a0)
    800047a6:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    800047aa:	04c56783          	lwu	a5,76(a0)
    800047ae:	e99c                	sd	a5,16(a1)
}
    800047b0:	6422                	ld	s0,8(sp)
    800047b2:	0141                	addi	sp,sp,16
    800047b4:	8082                	ret

00000000800047b6 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800047b6:	457c                	lw	a5,76(a0)
    800047b8:	0ed7e963          	bltu	a5,a3,800048aa <readi+0xf4>
{
    800047bc:	7159                	addi	sp,sp,-112
    800047be:	f486                	sd	ra,104(sp)
    800047c0:	f0a2                	sd	s0,96(sp)
    800047c2:	eca6                	sd	s1,88(sp)
    800047c4:	e8ca                	sd	s2,80(sp)
    800047c6:	e4ce                	sd	s3,72(sp)
    800047c8:	e0d2                	sd	s4,64(sp)
    800047ca:	fc56                	sd	s5,56(sp)
    800047cc:	f85a                	sd	s6,48(sp)
    800047ce:	f45e                	sd	s7,40(sp)
    800047d0:	f062                	sd	s8,32(sp)
    800047d2:	ec66                	sd	s9,24(sp)
    800047d4:	e86a                	sd	s10,16(sp)
    800047d6:	e46e                	sd	s11,8(sp)
    800047d8:	1880                	addi	s0,sp,112
    800047da:	8b2a                	mv	s6,a0
    800047dc:	8bae                	mv	s7,a1
    800047de:	8a32                	mv	s4,a2
    800047e0:	84b6                	mv	s1,a3
    800047e2:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    800047e4:	9f35                	addw	a4,a4,a3
    return 0;
    800047e6:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    800047e8:	0ad76063          	bltu	a4,a3,80004888 <readi+0xd2>
  if(off + n > ip->size)
    800047ec:	00e7f463          	bgeu	a5,a4,800047f4 <readi+0x3e>
    n = ip->size - off;
    800047f0:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800047f4:	0a0a8963          	beqz	s5,800048a6 <readi+0xf0>
    800047f8:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    800047fa:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    800047fe:	5c7d                	li	s8,-1
    80004800:	a82d                	j	8000483a <readi+0x84>
    80004802:	020d1d93          	slli	s11,s10,0x20
    80004806:	020ddd93          	srli	s11,s11,0x20
    8000480a:	05890793          	addi	a5,s2,88
    8000480e:	86ee                	mv	a3,s11
    80004810:	963e                	add	a2,a2,a5
    80004812:	85d2                	mv	a1,s4
    80004814:	855e                	mv	a0,s7
    80004816:	ffffe097          	auipc	ra,0xffffe
    8000481a:	156080e7          	jalr	342(ra) # 8000296c <either_copyout>
    8000481e:	05850d63          	beq	a0,s8,80004878 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80004822:	854a                	mv	a0,s2
    80004824:	fffff097          	auipc	ra,0xfffff
    80004828:	5f4080e7          	jalr	1524(ra) # 80003e18 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000482c:	013d09bb          	addw	s3,s10,s3
    80004830:	009d04bb          	addw	s1,s10,s1
    80004834:	9a6e                	add	s4,s4,s11
    80004836:	0559f763          	bgeu	s3,s5,80004884 <readi+0xce>
    uint addr = bmap(ip, off/BSIZE);
    8000483a:	00a4d59b          	srliw	a1,s1,0xa
    8000483e:	855a                	mv	a0,s6
    80004840:	00000097          	auipc	ra,0x0
    80004844:	8a2080e7          	jalr	-1886(ra) # 800040e2 <bmap>
    80004848:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    8000484c:	cd85                	beqz	a1,80004884 <readi+0xce>
    bp = bread(ip->dev, addr);
    8000484e:	000b2503          	lw	a0,0(s6)
    80004852:	fffff097          	auipc	ra,0xfffff
    80004856:	496080e7          	jalr	1174(ra) # 80003ce8 <bread>
    8000485a:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    8000485c:	3ff4f613          	andi	a2,s1,1023
    80004860:	40cc87bb          	subw	a5,s9,a2
    80004864:	413a873b          	subw	a4,s5,s3
    80004868:	8d3e                	mv	s10,a5
    8000486a:	2781                	sext.w	a5,a5
    8000486c:	0007069b          	sext.w	a3,a4
    80004870:	f8f6f9e3          	bgeu	a3,a5,80004802 <readi+0x4c>
    80004874:	8d3a                	mv	s10,a4
    80004876:	b771                	j	80004802 <readi+0x4c>
      brelse(bp);
    80004878:	854a                	mv	a0,s2
    8000487a:	fffff097          	auipc	ra,0xfffff
    8000487e:	59e080e7          	jalr	1438(ra) # 80003e18 <brelse>
      tot = -1;
    80004882:	59fd                	li	s3,-1
  }
  return tot;
    80004884:	0009851b          	sext.w	a0,s3
}
    80004888:	70a6                	ld	ra,104(sp)
    8000488a:	7406                	ld	s0,96(sp)
    8000488c:	64e6                	ld	s1,88(sp)
    8000488e:	6946                	ld	s2,80(sp)
    80004890:	69a6                	ld	s3,72(sp)
    80004892:	6a06                	ld	s4,64(sp)
    80004894:	7ae2                	ld	s5,56(sp)
    80004896:	7b42                	ld	s6,48(sp)
    80004898:	7ba2                	ld	s7,40(sp)
    8000489a:	7c02                	ld	s8,32(sp)
    8000489c:	6ce2                	ld	s9,24(sp)
    8000489e:	6d42                	ld	s10,16(sp)
    800048a0:	6da2                	ld	s11,8(sp)
    800048a2:	6165                	addi	sp,sp,112
    800048a4:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800048a6:	89d6                	mv	s3,s5
    800048a8:	bff1                	j	80004884 <readi+0xce>
    return 0;
    800048aa:	4501                	li	a0,0
}
    800048ac:	8082                	ret

00000000800048ae <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800048ae:	457c                	lw	a5,76(a0)
    800048b0:	10d7e863          	bltu	a5,a3,800049c0 <writei+0x112>
{
    800048b4:	7159                	addi	sp,sp,-112
    800048b6:	f486                	sd	ra,104(sp)
    800048b8:	f0a2                	sd	s0,96(sp)
    800048ba:	eca6                	sd	s1,88(sp)
    800048bc:	e8ca                	sd	s2,80(sp)
    800048be:	e4ce                	sd	s3,72(sp)
    800048c0:	e0d2                	sd	s4,64(sp)
    800048c2:	fc56                	sd	s5,56(sp)
    800048c4:	f85a                	sd	s6,48(sp)
    800048c6:	f45e                	sd	s7,40(sp)
    800048c8:	f062                	sd	s8,32(sp)
    800048ca:	ec66                	sd	s9,24(sp)
    800048cc:	e86a                	sd	s10,16(sp)
    800048ce:	e46e                	sd	s11,8(sp)
    800048d0:	1880                	addi	s0,sp,112
    800048d2:	8aaa                	mv	s5,a0
    800048d4:	8bae                	mv	s7,a1
    800048d6:	8a32                	mv	s4,a2
    800048d8:	8936                	mv	s2,a3
    800048da:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    800048dc:	00e687bb          	addw	a5,a3,a4
    800048e0:	0ed7e263          	bltu	a5,a3,800049c4 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    800048e4:	00043737          	lui	a4,0x43
    800048e8:	0ef76063          	bltu	a4,a5,800049c8 <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800048ec:	0c0b0863          	beqz	s6,800049bc <writei+0x10e>
    800048f0:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    800048f2:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    800048f6:	5c7d                	li	s8,-1
    800048f8:	a091                	j	8000493c <writei+0x8e>
    800048fa:	020d1d93          	slli	s11,s10,0x20
    800048fe:	020ddd93          	srli	s11,s11,0x20
    80004902:	05848793          	addi	a5,s1,88
    80004906:	86ee                	mv	a3,s11
    80004908:	8652                	mv	a2,s4
    8000490a:	85de                	mv	a1,s7
    8000490c:	953e                	add	a0,a0,a5
    8000490e:	ffffe097          	auipc	ra,0xffffe
    80004912:	0b4080e7          	jalr	180(ra) # 800029c2 <either_copyin>
    80004916:	07850263          	beq	a0,s8,8000497a <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    8000491a:	8526                	mv	a0,s1
    8000491c:	00000097          	auipc	ra,0x0
    80004920:	780080e7          	jalr	1920(ra) # 8000509c <log_write>
    brelse(bp);
    80004924:	8526                	mv	a0,s1
    80004926:	fffff097          	auipc	ra,0xfffff
    8000492a:	4f2080e7          	jalr	1266(ra) # 80003e18 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000492e:	013d09bb          	addw	s3,s10,s3
    80004932:	012d093b          	addw	s2,s10,s2
    80004936:	9a6e                	add	s4,s4,s11
    80004938:	0569f663          	bgeu	s3,s6,80004984 <writei+0xd6>
    uint addr = bmap(ip, off/BSIZE);
    8000493c:	00a9559b          	srliw	a1,s2,0xa
    80004940:	8556                	mv	a0,s5
    80004942:	fffff097          	auipc	ra,0xfffff
    80004946:	7a0080e7          	jalr	1952(ra) # 800040e2 <bmap>
    8000494a:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    8000494e:	c99d                	beqz	a1,80004984 <writei+0xd6>
    bp = bread(ip->dev, addr);
    80004950:	000aa503          	lw	a0,0(s5)
    80004954:	fffff097          	auipc	ra,0xfffff
    80004958:	394080e7          	jalr	916(ra) # 80003ce8 <bread>
    8000495c:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    8000495e:	3ff97513          	andi	a0,s2,1023
    80004962:	40ac87bb          	subw	a5,s9,a0
    80004966:	413b073b          	subw	a4,s6,s3
    8000496a:	8d3e                	mv	s10,a5
    8000496c:	2781                	sext.w	a5,a5
    8000496e:	0007069b          	sext.w	a3,a4
    80004972:	f8f6f4e3          	bgeu	a3,a5,800048fa <writei+0x4c>
    80004976:	8d3a                	mv	s10,a4
    80004978:	b749                	j	800048fa <writei+0x4c>
      brelse(bp);
    8000497a:	8526                	mv	a0,s1
    8000497c:	fffff097          	auipc	ra,0xfffff
    80004980:	49c080e7          	jalr	1180(ra) # 80003e18 <brelse>
  }

  if(off > ip->size)
    80004984:	04caa783          	lw	a5,76(s5)
    80004988:	0127f463          	bgeu	a5,s2,80004990 <writei+0xe2>
    ip->size = off;
    8000498c:	052aa623          	sw	s2,76(s5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80004990:	8556                	mv	a0,s5
    80004992:	00000097          	auipc	ra,0x0
    80004996:	aa6080e7          	jalr	-1370(ra) # 80004438 <iupdate>

  return tot;
    8000499a:	0009851b          	sext.w	a0,s3
}
    8000499e:	70a6                	ld	ra,104(sp)
    800049a0:	7406                	ld	s0,96(sp)
    800049a2:	64e6                	ld	s1,88(sp)
    800049a4:	6946                	ld	s2,80(sp)
    800049a6:	69a6                	ld	s3,72(sp)
    800049a8:	6a06                	ld	s4,64(sp)
    800049aa:	7ae2                	ld	s5,56(sp)
    800049ac:	7b42                	ld	s6,48(sp)
    800049ae:	7ba2                	ld	s7,40(sp)
    800049b0:	7c02                	ld	s8,32(sp)
    800049b2:	6ce2                	ld	s9,24(sp)
    800049b4:	6d42                	ld	s10,16(sp)
    800049b6:	6da2                	ld	s11,8(sp)
    800049b8:	6165                	addi	sp,sp,112
    800049ba:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800049bc:	89da                	mv	s3,s6
    800049be:	bfc9                	j	80004990 <writei+0xe2>
    return -1;
    800049c0:	557d                	li	a0,-1
}
    800049c2:	8082                	ret
    return -1;
    800049c4:	557d                	li	a0,-1
    800049c6:	bfe1                	j	8000499e <writei+0xf0>
    return -1;
    800049c8:	557d                	li	a0,-1
    800049ca:	bfd1                	j	8000499e <writei+0xf0>

00000000800049cc <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    800049cc:	1141                	addi	sp,sp,-16
    800049ce:	e406                	sd	ra,8(sp)
    800049d0:	e022                	sd	s0,0(sp)
    800049d2:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    800049d4:	4639                	li	a2,14
    800049d6:	ffffc097          	auipc	ra,0xffffc
    800049da:	472080e7          	jalr	1138(ra) # 80000e48 <strncmp>
}
    800049de:	60a2                	ld	ra,8(sp)
    800049e0:	6402                	ld	s0,0(sp)
    800049e2:	0141                	addi	sp,sp,16
    800049e4:	8082                	ret

00000000800049e6 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    800049e6:	7139                	addi	sp,sp,-64
    800049e8:	fc06                	sd	ra,56(sp)
    800049ea:	f822                	sd	s0,48(sp)
    800049ec:	f426                	sd	s1,40(sp)
    800049ee:	f04a                	sd	s2,32(sp)
    800049f0:	ec4e                	sd	s3,24(sp)
    800049f2:	e852                	sd	s4,16(sp)
    800049f4:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    800049f6:	04451703          	lh	a4,68(a0)
    800049fa:	4785                	li	a5,1
    800049fc:	00f71a63          	bne	a4,a5,80004a10 <dirlookup+0x2a>
    80004a00:	892a                	mv	s2,a0
    80004a02:	89ae                	mv	s3,a1
    80004a04:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80004a06:	457c                	lw	a5,76(a0)
    80004a08:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80004a0a:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80004a0c:	e79d                	bnez	a5,80004a3a <dirlookup+0x54>
    80004a0e:	a8a5                	j	80004a86 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80004a10:	00005517          	auipc	a0,0x5
    80004a14:	e9850513          	addi	a0,a0,-360 # 800098a8 <syscalls+0x1d0>
    80004a18:	ffffc097          	auipc	ra,0xffffc
    80004a1c:	b24080e7          	jalr	-1244(ra) # 8000053c <panic>
      panic("dirlookup read");
    80004a20:	00005517          	auipc	a0,0x5
    80004a24:	ea050513          	addi	a0,a0,-352 # 800098c0 <syscalls+0x1e8>
    80004a28:	ffffc097          	auipc	ra,0xffffc
    80004a2c:	b14080e7          	jalr	-1260(ra) # 8000053c <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80004a30:	24c1                	addiw	s1,s1,16
    80004a32:	04c92783          	lw	a5,76(s2)
    80004a36:	04f4f763          	bgeu	s1,a5,80004a84 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004a3a:	4741                	li	a4,16
    80004a3c:	86a6                	mv	a3,s1
    80004a3e:	fc040613          	addi	a2,s0,-64
    80004a42:	4581                	li	a1,0
    80004a44:	854a                	mv	a0,s2
    80004a46:	00000097          	auipc	ra,0x0
    80004a4a:	d70080e7          	jalr	-656(ra) # 800047b6 <readi>
    80004a4e:	47c1                	li	a5,16
    80004a50:	fcf518e3          	bne	a0,a5,80004a20 <dirlookup+0x3a>
    if(de.inum == 0)
    80004a54:	fc045783          	lhu	a5,-64(s0)
    80004a58:	dfe1                	beqz	a5,80004a30 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80004a5a:	fc240593          	addi	a1,s0,-62
    80004a5e:	854e                	mv	a0,s3
    80004a60:	00000097          	auipc	ra,0x0
    80004a64:	f6c080e7          	jalr	-148(ra) # 800049cc <namecmp>
    80004a68:	f561                	bnez	a0,80004a30 <dirlookup+0x4a>
      if(poff)
    80004a6a:	000a0463          	beqz	s4,80004a72 <dirlookup+0x8c>
        *poff = off;
    80004a6e:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80004a72:	fc045583          	lhu	a1,-64(s0)
    80004a76:	00092503          	lw	a0,0(s2)
    80004a7a:	fffff097          	auipc	ra,0xfffff
    80004a7e:	750080e7          	jalr	1872(ra) # 800041ca <iget>
    80004a82:	a011                	j	80004a86 <dirlookup+0xa0>
  return 0;
    80004a84:	4501                	li	a0,0
}
    80004a86:	70e2                	ld	ra,56(sp)
    80004a88:	7442                	ld	s0,48(sp)
    80004a8a:	74a2                	ld	s1,40(sp)
    80004a8c:	7902                	ld	s2,32(sp)
    80004a8e:	69e2                	ld	s3,24(sp)
    80004a90:	6a42                	ld	s4,16(sp)
    80004a92:	6121                	addi	sp,sp,64
    80004a94:	8082                	ret

0000000080004a96 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80004a96:	711d                	addi	sp,sp,-96
    80004a98:	ec86                	sd	ra,88(sp)
    80004a9a:	e8a2                	sd	s0,80(sp)
    80004a9c:	e4a6                	sd	s1,72(sp)
    80004a9e:	e0ca                	sd	s2,64(sp)
    80004aa0:	fc4e                	sd	s3,56(sp)
    80004aa2:	f852                	sd	s4,48(sp)
    80004aa4:	f456                	sd	s5,40(sp)
    80004aa6:	f05a                	sd	s6,32(sp)
    80004aa8:	ec5e                	sd	s7,24(sp)
    80004aaa:	e862                	sd	s8,16(sp)
    80004aac:	e466                	sd	s9,8(sp)
    80004aae:	1080                	addi	s0,sp,96
    80004ab0:	84aa                	mv	s1,a0
    80004ab2:	8aae                	mv	s5,a1
    80004ab4:	8a32                	mv	s4,a2
  struct inode *ip, *next;

  if(*path == '/')
    80004ab6:	00054703          	lbu	a4,0(a0)
    80004aba:	02f00793          	li	a5,47
    80004abe:	02f70363          	beq	a4,a5,80004ae4 <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80004ac2:	ffffd097          	auipc	ra,0xffffd
    80004ac6:	090080e7          	jalr	144(ra) # 80001b52 <myproc>
    80004aca:	15853503          	ld	a0,344(a0)
    80004ace:	00000097          	auipc	ra,0x0
    80004ad2:	9f6080e7          	jalr	-1546(ra) # 800044c4 <idup>
    80004ad6:	89aa                	mv	s3,a0
  while(*path == '/')
    80004ad8:	02f00913          	li	s2,47
  len = path - s;
    80004adc:	4b01                	li	s6,0
  if(len >= DIRSIZ)
    80004ade:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80004ae0:	4b85                	li	s7,1
    80004ae2:	a865                	j	80004b9a <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    80004ae4:	4585                	li	a1,1
    80004ae6:	4505                	li	a0,1
    80004ae8:	fffff097          	auipc	ra,0xfffff
    80004aec:	6e2080e7          	jalr	1762(ra) # 800041ca <iget>
    80004af0:	89aa                	mv	s3,a0
    80004af2:	b7dd                	j	80004ad8 <namex+0x42>
      iunlockput(ip);
    80004af4:	854e                	mv	a0,s3
    80004af6:	00000097          	auipc	ra,0x0
    80004afa:	c6e080e7          	jalr	-914(ra) # 80004764 <iunlockput>
      return 0;
    80004afe:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80004b00:	854e                	mv	a0,s3
    80004b02:	60e6                	ld	ra,88(sp)
    80004b04:	6446                	ld	s0,80(sp)
    80004b06:	64a6                	ld	s1,72(sp)
    80004b08:	6906                	ld	s2,64(sp)
    80004b0a:	79e2                	ld	s3,56(sp)
    80004b0c:	7a42                	ld	s4,48(sp)
    80004b0e:	7aa2                	ld	s5,40(sp)
    80004b10:	7b02                	ld	s6,32(sp)
    80004b12:	6be2                	ld	s7,24(sp)
    80004b14:	6c42                	ld	s8,16(sp)
    80004b16:	6ca2                	ld	s9,8(sp)
    80004b18:	6125                	addi	sp,sp,96
    80004b1a:	8082                	ret
      iunlock(ip);
    80004b1c:	854e                	mv	a0,s3
    80004b1e:	00000097          	auipc	ra,0x0
    80004b22:	aa6080e7          	jalr	-1370(ra) # 800045c4 <iunlock>
      return ip;
    80004b26:	bfe9                	j	80004b00 <namex+0x6a>
      iunlockput(ip);
    80004b28:	854e                	mv	a0,s3
    80004b2a:	00000097          	auipc	ra,0x0
    80004b2e:	c3a080e7          	jalr	-966(ra) # 80004764 <iunlockput>
      return 0;
    80004b32:	89e6                	mv	s3,s9
    80004b34:	b7f1                	j	80004b00 <namex+0x6a>
  len = path - s;
    80004b36:	40b48633          	sub	a2,s1,a1
    80004b3a:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    80004b3e:	099c5463          	bge	s8,s9,80004bc6 <namex+0x130>
    memmove(name, s, DIRSIZ);
    80004b42:	4639                	li	a2,14
    80004b44:	8552                	mv	a0,s4
    80004b46:	ffffc097          	auipc	ra,0xffffc
    80004b4a:	28e080e7          	jalr	654(ra) # 80000dd4 <memmove>
  while(*path == '/')
    80004b4e:	0004c783          	lbu	a5,0(s1)
    80004b52:	01279763          	bne	a5,s2,80004b60 <namex+0xca>
    path++;
    80004b56:	0485                	addi	s1,s1,1
  while(*path == '/')
    80004b58:	0004c783          	lbu	a5,0(s1)
    80004b5c:	ff278de3          	beq	a5,s2,80004b56 <namex+0xc0>
    ilock(ip);
    80004b60:	854e                	mv	a0,s3
    80004b62:	00000097          	auipc	ra,0x0
    80004b66:	9a0080e7          	jalr	-1632(ra) # 80004502 <ilock>
    if(ip->type != T_DIR){
    80004b6a:	04499783          	lh	a5,68(s3)
    80004b6e:	f97793e3          	bne	a5,s7,80004af4 <namex+0x5e>
    if(nameiparent && *path == '\0'){
    80004b72:	000a8563          	beqz	s5,80004b7c <namex+0xe6>
    80004b76:	0004c783          	lbu	a5,0(s1)
    80004b7a:	d3cd                	beqz	a5,80004b1c <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    80004b7c:	865a                	mv	a2,s6
    80004b7e:	85d2                	mv	a1,s4
    80004b80:	854e                	mv	a0,s3
    80004b82:	00000097          	auipc	ra,0x0
    80004b86:	e64080e7          	jalr	-412(ra) # 800049e6 <dirlookup>
    80004b8a:	8caa                	mv	s9,a0
    80004b8c:	dd51                	beqz	a0,80004b28 <namex+0x92>
    iunlockput(ip);
    80004b8e:	854e                	mv	a0,s3
    80004b90:	00000097          	auipc	ra,0x0
    80004b94:	bd4080e7          	jalr	-1068(ra) # 80004764 <iunlockput>
    ip = next;
    80004b98:	89e6                	mv	s3,s9
  while(*path == '/')
    80004b9a:	0004c783          	lbu	a5,0(s1)
    80004b9e:	05279763          	bne	a5,s2,80004bec <namex+0x156>
    path++;
    80004ba2:	0485                	addi	s1,s1,1
  while(*path == '/')
    80004ba4:	0004c783          	lbu	a5,0(s1)
    80004ba8:	ff278de3          	beq	a5,s2,80004ba2 <namex+0x10c>
  if(*path == 0)
    80004bac:	c79d                	beqz	a5,80004bda <namex+0x144>
    path++;
    80004bae:	85a6                	mv	a1,s1
  len = path - s;
    80004bb0:	8cda                	mv	s9,s6
    80004bb2:	865a                	mv	a2,s6
  while(*path != '/' && *path != 0)
    80004bb4:	01278963          	beq	a5,s2,80004bc6 <namex+0x130>
    80004bb8:	dfbd                	beqz	a5,80004b36 <namex+0xa0>
    path++;
    80004bba:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    80004bbc:	0004c783          	lbu	a5,0(s1)
    80004bc0:	ff279ce3          	bne	a5,s2,80004bb8 <namex+0x122>
    80004bc4:	bf8d                	j	80004b36 <namex+0xa0>
    memmove(name, s, len);
    80004bc6:	2601                	sext.w	a2,a2
    80004bc8:	8552                	mv	a0,s4
    80004bca:	ffffc097          	auipc	ra,0xffffc
    80004bce:	20a080e7          	jalr	522(ra) # 80000dd4 <memmove>
    name[len] = 0;
    80004bd2:	9cd2                	add	s9,s9,s4
    80004bd4:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    80004bd8:	bf9d                	j	80004b4e <namex+0xb8>
  if(nameiparent){
    80004bda:	f20a83e3          	beqz	s5,80004b00 <namex+0x6a>
    iput(ip);
    80004bde:	854e                	mv	a0,s3
    80004be0:	00000097          	auipc	ra,0x0
    80004be4:	adc080e7          	jalr	-1316(ra) # 800046bc <iput>
    return 0;
    80004be8:	4981                	li	s3,0
    80004bea:	bf19                	j	80004b00 <namex+0x6a>
  if(*path == 0)
    80004bec:	d7fd                	beqz	a5,80004bda <namex+0x144>
  while(*path != '/' && *path != 0)
    80004bee:	0004c783          	lbu	a5,0(s1)
    80004bf2:	85a6                	mv	a1,s1
    80004bf4:	b7d1                	j	80004bb8 <namex+0x122>

0000000080004bf6 <dirlink>:
{
    80004bf6:	7139                	addi	sp,sp,-64
    80004bf8:	fc06                	sd	ra,56(sp)
    80004bfa:	f822                	sd	s0,48(sp)
    80004bfc:	f426                	sd	s1,40(sp)
    80004bfe:	f04a                	sd	s2,32(sp)
    80004c00:	ec4e                	sd	s3,24(sp)
    80004c02:	e852                	sd	s4,16(sp)
    80004c04:	0080                	addi	s0,sp,64
    80004c06:	892a                	mv	s2,a0
    80004c08:	8a2e                	mv	s4,a1
    80004c0a:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80004c0c:	4601                	li	a2,0
    80004c0e:	00000097          	auipc	ra,0x0
    80004c12:	dd8080e7          	jalr	-552(ra) # 800049e6 <dirlookup>
    80004c16:	e93d                	bnez	a0,80004c8c <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80004c18:	04c92483          	lw	s1,76(s2)
    80004c1c:	c49d                	beqz	s1,80004c4a <dirlink+0x54>
    80004c1e:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004c20:	4741                	li	a4,16
    80004c22:	86a6                	mv	a3,s1
    80004c24:	fc040613          	addi	a2,s0,-64
    80004c28:	4581                	li	a1,0
    80004c2a:	854a                	mv	a0,s2
    80004c2c:	00000097          	auipc	ra,0x0
    80004c30:	b8a080e7          	jalr	-1142(ra) # 800047b6 <readi>
    80004c34:	47c1                	li	a5,16
    80004c36:	06f51163          	bne	a0,a5,80004c98 <dirlink+0xa2>
    if(de.inum == 0)
    80004c3a:	fc045783          	lhu	a5,-64(s0)
    80004c3e:	c791                	beqz	a5,80004c4a <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80004c40:	24c1                	addiw	s1,s1,16
    80004c42:	04c92783          	lw	a5,76(s2)
    80004c46:	fcf4ede3          	bltu	s1,a5,80004c20 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    80004c4a:	4639                	li	a2,14
    80004c4c:	85d2                	mv	a1,s4
    80004c4e:	fc240513          	addi	a0,s0,-62
    80004c52:	ffffc097          	auipc	ra,0xffffc
    80004c56:	232080e7          	jalr	562(ra) # 80000e84 <strncpy>
  de.inum = inum;
    80004c5a:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004c5e:	4741                	li	a4,16
    80004c60:	86a6                	mv	a3,s1
    80004c62:	fc040613          	addi	a2,s0,-64
    80004c66:	4581                	li	a1,0
    80004c68:	854a                	mv	a0,s2
    80004c6a:	00000097          	auipc	ra,0x0
    80004c6e:	c44080e7          	jalr	-956(ra) # 800048ae <writei>
    80004c72:	1541                	addi	a0,a0,-16
    80004c74:	00a03533          	snez	a0,a0
    80004c78:	40a00533          	neg	a0,a0
}
    80004c7c:	70e2                	ld	ra,56(sp)
    80004c7e:	7442                	ld	s0,48(sp)
    80004c80:	74a2                	ld	s1,40(sp)
    80004c82:	7902                	ld	s2,32(sp)
    80004c84:	69e2                	ld	s3,24(sp)
    80004c86:	6a42                	ld	s4,16(sp)
    80004c88:	6121                	addi	sp,sp,64
    80004c8a:	8082                	ret
    iput(ip);
    80004c8c:	00000097          	auipc	ra,0x0
    80004c90:	a30080e7          	jalr	-1488(ra) # 800046bc <iput>
    return -1;
    80004c94:	557d                	li	a0,-1
    80004c96:	b7dd                	j	80004c7c <dirlink+0x86>
      panic("dirlink read");
    80004c98:	00005517          	auipc	a0,0x5
    80004c9c:	c3850513          	addi	a0,a0,-968 # 800098d0 <syscalls+0x1f8>
    80004ca0:	ffffc097          	auipc	ra,0xffffc
    80004ca4:	89c080e7          	jalr	-1892(ra) # 8000053c <panic>

0000000080004ca8 <namei>:

struct inode*
namei(char *path)
{
    80004ca8:	1101                	addi	sp,sp,-32
    80004caa:	ec06                	sd	ra,24(sp)
    80004cac:	e822                	sd	s0,16(sp)
    80004cae:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80004cb0:	fe040613          	addi	a2,s0,-32
    80004cb4:	4581                	li	a1,0
    80004cb6:	00000097          	auipc	ra,0x0
    80004cba:	de0080e7          	jalr	-544(ra) # 80004a96 <namex>
}
    80004cbe:	60e2                	ld	ra,24(sp)
    80004cc0:	6442                	ld	s0,16(sp)
    80004cc2:	6105                	addi	sp,sp,32
    80004cc4:	8082                	ret

0000000080004cc6 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80004cc6:	1141                	addi	sp,sp,-16
    80004cc8:	e406                	sd	ra,8(sp)
    80004cca:	e022                	sd	s0,0(sp)
    80004ccc:	0800                	addi	s0,sp,16
    80004cce:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80004cd0:	4585                	li	a1,1
    80004cd2:	00000097          	auipc	ra,0x0
    80004cd6:	dc4080e7          	jalr	-572(ra) # 80004a96 <namex>
}
    80004cda:	60a2                	ld	ra,8(sp)
    80004cdc:	6402                	ld	s0,0(sp)
    80004cde:	0141                	addi	sp,sp,16
    80004ce0:	8082                	ret

0000000080004ce2 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80004ce2:	1101                	addi	sp,sp,-32
    80004ce4:	ec06                	sd	ra,24(sp)
    80004ce6:	e822                	sd	s0,16(sp)
    80004ce8:	e426                	sd	s1,8(sp)
    80004cea:	e04a                	sd	s2,0(sp)
    80004cec:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80004cee:	0001e917          	auipc	s2,0x1e
    80004cf2:	2f290913          	addi	s2,s2,754 # 80022fe0 <log>
    80004cf6:	01892583          	lw	a1,24(s2)
    80004cfa:	02892503          	lw	a0,40(s2)
    80004cfe:	fffff097          	auipc	ra,0xfffff
    80004d02:	fea080e7          	jalr	-22(ra) # 80003ce8 <bread>
    80004d06:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80004d08:	02c92683          	lw	a3,44(s2)
    80004d0c:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80004d0e:	02d05763          	blez	a3,80004d3c <write_head+0x5a>
    80004d12:	0001e797          	auipc	a5,0x1e
    80004d16:	2fe78793          	addi	a5,a5,766 # 80023010 <log+0x30>
    80004d1a:	05c50713          	addi	a4,a0,92
    80004d1e:	36fd                	addiw	a3,a3,-1
    80004d20:	1682                	slli	a3,a3,0x20
    80004d22:	9281                	srli	a3,a3,0x20
    80004d24:	068a                	slli	a3,a3,0x2
    80004d26:	0001e617          	auipc	a2,0x1e
    80004d2a:	2ee60613          	addi	a2,a2,750 # 80023014 <log+0x34>
    80004d2e:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    80004d30:	4390                	lw	a2,0(a5)
    80004d32:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80004d34:	0791                	addi	a5,a5,4
    80004d36:	0711                	addi	a4,a4,4
    80004d38:	fed79ce3          	bne	a5,a3,80004d30 <write_head+0x4e>
  }
  bwrite(buf);
    80004d3c:	8526                	mv	a0,s1
    80004d3e:	fffff097          	auipc	ra,0xfffff
    80004d42:	09c080e7          	jalr	156(ra) # 80003dda <bwrite>
  brelse(buf);
    80004d46:	8526                	mv	a0,s1
    80004d48:	fffff097          	auipc	ra,0xfffff
    80004d4c:	0d0080e7          	jalr	208(ra) # 80003e18 <brelse>
}
    80004d50:	60e2                	ld	ra,24(sp)
    80004d52:	6442                	ld	s0,16(sp)
    80004d54:	64a2                	ld	s1,8(sp)
    80004d56:	6902                	ld	s2,0(sp)
    80004d58:	6105                	addi	sp,sp,32
    80004d5a:	8082                	ret

0000000080004d5c <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80004d5c:	0001e797          	auipc	a5,0x1e
    80004d60:	2b07a783          	lw	a5,688(a5) # 8002300c <log+0x2c>
    80004d64:	0af05d63          	blez	a5,80004e1e <install_trans+0xc2>
{
    80004d68:	7139                	addi	sp,sp,-64
    80004d6a:	fc06                	sd	ra,56(sp)
    80004d6c:	f822                	sd	s0,48(sp)
    80004d6e:	f426                	sd	s1,40(sp)
    80004d70:	f04a                	sd	s2,32(sp)
    80004d72:	ec4e                	sd	s3,24(sp)
    80004d74:	e852                	sd	s4,16(sp)
    80004d76:	e456                	sd	s5,8(sp)
    80004d78:	e05a                	sd	s6,0(sp)
    80004d7a:	0080                	addi	s0,sp,64
    80004d7c:	8b2a                	mv	s6,a0
    80004d7e:	0001ea97          	auipc	s5,0x1e
    80004d82:	292a8a93          	addi	s5,s5,658 # 80023010 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80004d86:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80004d88:	0001e997          	auipc	s3,0x1e
    80004d8c:	25898993          	addi	s3,s3,600 # 80022fe0 <log>
    80004d90:	a00d                	j	80004db2 <install_trans+0x56>
    brelse(lbuf);
    80004d92:	854a                	mv	a0,s2
    80004d94:	fffff097          	auipc	ra,0xfffff
    80004d98:	084080e7          	jalr	132(ra) # 80003e18 <brelse>
    brelse(dbuf);
    80004d9c:	8526                	mv	a0,s1
    80004d9e:	fffff097          	auipc	ra,0xfffff
    80004da2:	07a080e7          	jalr	122(ra) # 80003e18 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80004da6:	2a05                	addiw	s4,s4,1
    80004da8:	0a91                	addi	s5,s5,4
    80004daa:	02c9a783          	lw	a5,44(s3)
    80004dae:	04fa5e63          	bge	s4,a5,80004e0a <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80004db2:	0189a583          	lw	a1,24(s3)
    80004db6:	014585bb          	addw	a1,a1,s4
    80004dba:	2585                	addiw	a1,a1,1
    80004dbc:	0289a503          	lw	a0,40(s3)
    80004dc0:	fffff097          	auipc	ra,0xfffff
    80004dc4:	f28080e7          	jalr	-216(ra) # 80003ce8 <bread>
    80004dc8:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80004dca:	000aa583          	lw	a1,0(s5)
    80004dce:	0289a503          	lw	a0,40(s3)
    80004dd2:	fffff097          	auipc	ra,0xfffff
    80004dd6:	f16080e7          	jalr	-234(ra) # 80003ce8 <bread>
    80004dda:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80004ddc:	40000613          	li	a2,1024
    80004de0:	05890593          	addi	a1,s2,88
    80004de4:	05850513          	addi	a0,a0,88
    80004de8:	ffffc097          	auipc	ra,0xffffc
    80004dec:	fec080e7          	jalr	-20(ra) # 80000dd4 <memmove>
    bwrite(dbuf);  // write dst to disk
    80004df0:	8526                	mv	a0,s1
    80004df2:	fffff097          	auipc	ra,0xfffff
    80004df6:	fe8080e7          	jalr	-24(ra) # 80003dda <bwrite>
    if(recovering == 0)
    80004dfa:	f80b1ce3          	bnez	s6,80004d92 <install_trans+0x36>
      bunpin(dbuf);
    80004dfe:	8526                	mv	a0,s1
    80004e00:	fffff097          	auipc	ra,0xfffff
    80004e04:	0f2080e7          	jalr	242(ra) # 80003ef2 <bunpin>
    80004e08:	b769                	j	80004d92 <install_trans+0x36>
}
    80004e0a:	70e2                	ld	ra,56(sp)
    80004e0c:	7442                	ld	s0,48(sp)
    80004e0e:	74a2                	ld	s1,40(sp)
    80004e10:	7902                	ld	s2,32(sp)
    80004e12:	69e2                	ld	s3,24(sp)
    80004e14:	6a42                	ld	s4,16(sp)
    80004e16:	6aa2                	ld	s5,8(sp)
    80004e18:	6b02                	ld	s6,0(sp)
    80004e1a:	6121                	addi	sp,sp,64
    80004e1c:	8082                	ret
    80004e1e:	8082                	ret

0000000080004e20 <initlog>:
{
    80004e20:	7179                	addi	sp,sp,-48
    80004e22:	f406                	sd	ra,40(sp)
    80004e24:	f022                	sd	s0,32(sp)
    80004e26:	ec26                	sd	s1,24(sp)
    80004e28:	e84a                	sd	s2,16(sp)
    80004e2a:	e44e                	sd	s3,8(sp)
    80004e2c:	1800                	addi	s0,sp,48
    80004e2e:	892a                	mv	s2,a0
    80004e30:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80004e32:	0001e497          	auipc	s1,0x1e
    80004e36:	1ae48493          	addi	s1,s1,430 # 80022fe0 <log>
    80004e3a:	00005597          	auipc	a1,0x5
    80004e3e:	aa658593          	addi	a1,a1,-1370 # 800098e0 <syscalls+0x208>
    80004e42:	8526                	mv	a0,s1
    80004e44:	ffffc097          	auipc	ra,0xffffc
    80004e48:	da8080e7          	jalr	-600(ra) # 80000bec <initlock>
  log.start = sb->logstart;
    80004e4c:	0149a583          	lw	a1,20(s3)
    80004e50:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80004e52:	0109a783          	lw	a5,16(s3)
    80004e56:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80004e58:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80004e5c:	854a                	mv	a0,s2
    80004e5e:	fffff097          	auipc	ra,0xfffff
    80004e62:	e8a080e7          	jalr	-374(ra) # 80003ce8 <bread>
  log.lh.n = lh->n;
    80004e66:	4d34                	lw	a3,88(a0)
    80004e68:	d4d4                	sw	a3,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80004e6a:	02d05563          	blez	a3,80004e94 <initlog+0x74>
    80004e6e:	05c50793          	addi	a5,a0,92
    80004e72:	0001e717          	auipc	a4,0x1e
    80004e76:	19e70713          	addi	a4,a4,414 # 80023010 <log+0x30>
    80004e7a:	36fd                	addiw	a3,a3,-1
    80004e7c:	1682                	slli	a3,a3,0x20
    80004e7e:	9281                	srli	a3,a3,0x20
    80004e80:	068a                	slli	a3,a3,0x2
    80004e82:	06050613          	addi	a2,a0,96
    80004e86:	96b2                	add	a3,a3,a2
    log.lh.block[i] = lh->block[i];
    80004e88:	4390                	lw	a2,0(a5)
    80004e8a:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80004e8c:	0791                	addi	a5,a5,4
    80004e8e:	0711                	addi	a4,a4,4
    80004e90:	fed79ce3          	bne	a5,a3,80004e88 <initlog+0x68>
  brelse(buf);
    80004e94:	fffff097          	auipc	ra,0xfffff
    80004e98:	f84080e7          	jalr	-124(ra) # 80003e18 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80004e9c:	4505                	li	a0,1
    80004e9e:	00000097          	auipc	ra,0x0
    80004ea2:	ebe080e7          	jalr	-322(ra) # 80004d5c <install_trans>
  log.lh.n = 0;
    80004ea6:	0001e797          	auipc	a5,0x1e
    80004eaa:	1607a323          	sw	zero,358(a5) # 8002300c <log+0x2c>
  write_head(); // clear the log
    80004eae:	00000097          	auipc	ra,0x0
    80004eb2:	e34080e7          	jalr	-460(ra) # 80004ce2 <write_head>
}
    80004eb6:	70a2                	ld	ra,40(sp)
    80004eb8:	7402                	ld	s0,32(sp)
    80004eba:	64e2                	ld	s1,24(sp)
    80004ebc:	6942                	ld	s2,16(sp)
    80004ebe:	69a2                	ld	s3,8(sp)
    80004ec0:	6145                	addi	sp,sp,48
    80004ec2:	8082                	ret

0000000080004ec4 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80004ec4:	1101                	addi	sp,sp,-32
    80004ec6:	ec06                	sd	ra,24(sp)
    80004ec8:	e822                	sd	s0,16(sp)
    80004eca:	e426                	sd	s1,8(sp)
    80004ecc:	e04a                	sd	s2,0(sp)
    80004ece:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80004ed0:	0001e517          	auipc	a0,0x1e
    80004ed4:	11050513          	addi	a0,a0,272 # 80022fe0 <log>
    80004ed8:	ffffc097          	auipc	ra,0xffffc
    80004edc:	da4080e7          	jalr	-604(ra) # 80000c7c <acquire>
  while(1){
    if(log.committing){
    80004ee0:	0001e497          	auipc	s1,0x1e
    80004ee4:	10048493          	addi	s1,s1,256 # 80022fe0 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80004ee8:	4979                	li	s2,30
    80004eea:	a039                	j	80004ef8 <begin_op+0x34>
      sleep(&log, &log.lock);
    80004eec:	85a6                	mv	a1,s1
    80004eee:	8526                	mv	a0,s1
    80004ef0:	ffffd097          	auipc	ra,0xffffd
    80004ef4:	4ba080e7          	jalr	1210(ra) # 800023aa <sleep>
    if(log.committing){
    80004ef8:	50dc                	lw	a5,36(s1)
    80004efa:	fbed                	bnez	a5,80004eec <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80004efc:	509c                	lw	a5,32(s1)
    80004efe:	0017871b          	addiw	a4,a5,1
    80004f02:	0007069b          	sext.w	a3,a4
    80004f06:	0027179b          	slliw	a5,a4,0x2
    80004f0a:	9fb9                	addw	a5,a5,a4
    80004f0c:	0017979b          	slliw	a5,a5,0x1
    80004f10:	54d8                	lw	a4,44(s1)
    80004f12:	9fb9                	addw	a5,a5,a4
    80004f14:	00f95963          	bge	s2,a5,80004f26 <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80004f18:	85a6                	mv	a1,s1
    80004f1a:	8526                	mv	a0,s1
    80004f1c:	ffffd097          	auipc	ra,0xffffd
    80004f20:	48e080e7          	jalr	1166(ra) # 800023aa <sleep>
    80004f24:	bfd1                	j	80004ef8 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80004f26:	0001e517          	auipc	a0,0x1e
    80004f2a:	0ba50513          	addi	a0,a0,186 # 80022fe0 <log>
    80004f2e:	d114                	sw	a3,32(a0)
      release(&log.lock);
    80004f30:	ffffc097          	auipc	ra,0xffffc
    80004f34:	e00080e7          	jalr	-512(ra) # 80000d30 <release>
      break;
    }
  }
}
    80004f38:	60e2                	ld	ra,24(sp)
    80004f3a:	6442                	ld	s0,16(sp)
    80004f3c:	64a2                	ld	s1,8(sp)
    80004f3e:	6902                	ld	s2,0(sp)
    80004f40:	6105                	addi	sp,sp,32
    80004f42:	8082                	ret

0000000080004f44 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80004f44:	7139                	addi	sp,sp,-64
    80004f46:	fc06                	sd	ra,56(sp)
    80004f48:	f822                	sd	s0,48(sp)
    80004f4a:	f426                	sd	s1,40(sp)
    80004f4c:	f04a                	sd	s2,32(sp)
    80004f4e:	ec4e                	sd	s3,24(sp)
    80004f50:	e852                	sd	s4,16(sp)
    80004f52:	e456                	sd	s5,8(sp)
    80004f54:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80004f56:	0001e497          	auipc	s1,0x1e
    80004f5a:	08a48493          	addi	s1,s1,138 # 80022fe0 <log>
    80004f5e:	8526                	mv	a0,s1
    80004f60:	ffffc097          	auipc	ra,0xffffc
    80004f64:	d1c080e7          	jalr	-740(ra) # 80000c7c <acquire>
  log.outstanding -= 1;
    80004f68:	509c                	lw	a5,32(s1)
    80004f6a:	37fd                	addiw	a5,a5,-1
    80004f6c:	0007891b          	sext.w	s2,a5
    80004f70:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80004f72:	50dc                	lw	a5,36(s1)
    80004f74:	e7b9                	bnez	a5,80004fc2 <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    80004f76:	04091e63          	bnez	s2,80004fd2 <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    80004f7a:	0001e497          	auipc	s1,0x1e
    80004f7e:	06648493          	addi	s1,s1,102 # 80022fe0 <log>
    80004f82:	4785                	li	a5,1
    80004f84:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80004f86:	8526                	mv	a0,s1
    80004f88:	ffffc097          	auipc	ra,0xffffc
    80004f8c:	da8080e7          	jalr	-600(ra) # 80000d30 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80004f90:	54dc                	lw	a5,44(s1)
    80004f92:	06f04763          	bgtz	a5,80005000 <end_op+0xbc>
    acquire(&log.lock);
    80004f96:	0001e497          	auipc	s1,0x1e
    80004f9a:	04a48493          	addi	s1,s1,74 # 80022fe0 <log>
    80004f9e:	8526                	mv	a0,s1
    80004fa0:	ffffc097          	auipc	ra,0xffffc
    80004fa4:	cdc080e7          	jalr	-804(ra) # 80000c7c <acquire>
    log.committing = 0;
    80004fa8:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80004fac:	8526                	mv	a0,s1
    80004fae:	ffffd097          	auipc	ra,0xffffd
    80004fb2:	460080e7          	jalr	1120(ra) # 8000240e <wakeup>
    release(&log.lock);
    80004fb6:	8526                	mv	a0,s1
    80004fb8:	ffffc097          	auipc	ra,0xffffc
    80004fbc:	d78080e7          	jalr	-648(ra) # 80000d30 <release>
}
    80004fc0:	a03d                	j	80004fee <end_op+0xaa>
    panic("log.committing");
    80004fc2:	00005517          	auipc	a0,0x5
    80004fc6:	92650513          	addi	a0,a0,-1754 # 800098e8 <syscalls+0x210>
    80004fca:	ffffb097          	auipc	ra,0xffffb
    80004fce:	572080e7          	jalr	1394(ra) # 8000053c <panic>
    wakeup(&log);
    80004fd2:	0001e497          	auipc	s1,0x1e
    80004fd6:	00e48493          	addi	s1,s1,14 # 80022fe0 <log>
    80004fda:	8526                	mv	a0,s1
    80004fdc:	ffffd097          	auipc	ra,0xffffd
    80004fe0:	432080e7          	jalr	1074(ra) # 8000240e <wakeup>
  release(&log.lock);
    80004fe4:	8526                	mv	a0,s1
    80004fe6:	ffffc097          	auipc	ra,0xffffc
    80004fea:	d4a080e7          	jalr	-694(ra) # 80000d30 <release>
}
    80004fee:	70e2                	ld	ra,56(sp)
    80004ff0:	7442                	ld	s0,48(sp)
    80004ff2:	74a2                	ld	s1,40(sp)
    80004ff4:	7902                	ld	s2,32(sp)
    80004ff6:	69e2                	ld	s3,24(sp)
    80004ff8:	6a42                	ld	s4,16(sp)
    80004ffa:	6aa2                	ld	s5,8(sp)
    80004ffc:	6121                	addi	sp,sp,64
    80004ffe:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    80005000:	0001ea97          	auipc	s5,0x1e
    80005004:	010a8a93          	addi	s5,s5,16 # 80023010 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80005008:	0001ea17          	auipc	s4,0x1e
    8000500c:	fd8a0a13          	addi	s4,s4,-40 # 80022fe0 <log>
    80005010:	018a2583          	lw	a1,24(s4)
    80005014:	012585bb          	addw	a1,a1,s2
    80005018:	2585                	addiw	a1,a1,1
    8000501a:	028a2503          	lw	a0,40(s4)
    8000501e:	fffff097          	auipc	ra,0xfffff
    80005022:	cca080e7          	jalr	-822(ra) # 80003ce8 <bread>
    80005026:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80005028:	000aa583          	lw	a1,0(s5)
    8000502c:	028a2503          	lw	a0,40(s4)
    80005030:	fffff097          	auipc	ra,0xfffff
    80005034:	cb8080e7          	jalr	-840(ra) # 80003ce8 <bread>
    80005038:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    8000503a:	40000613          	li	a2,1024
    8000503e:	05850593          	addi	a1,a0,88
    80005042:	05848513          	addi	a0,s1,88
    80005046:	ffffc097          	auipc	ra,0xffffc
    8000504a:	d8e080e7          	jalr	-626(ra) # 80000dd4 <memmove>
    bwrite(to);  // write the log
    8000504e:	8526                	mv	a0,s1
    80005050:	fffff097          	auipc	ra,0xfffff
    80005054:	d8a080e7          	jalr	-630(ra) # 80003dda <bwrite>
    brelse(from);
    80005058:	854e                	mv	a0,s3
    8000505a:	fffff097          	auipc	ra,0xfffff
    8000505e:	dbe080e7          	jalr	-578(ra) # 80003e18 <brelse>
    brelse(to);
    80005062:	8526                	mv	a0,s1
    80005064:	fffff097          	auipc	ra,0xfffff
    80005068:	db4080e7          	jalr	-588(ra) # 80003e18 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000506c:	2905                	addiw	s2,s2,1
    8000506e:	0a91                	addi	s5,s5,4
    80005070:	02ca2783          	lw	a5,44(s4)
    80005074:	f8f94ee3          	blt	s2,a5,80005010 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80005078:	00000097          	auipc	ra,0x0
    8000507c:	c6a080e7          	jalr	-918(ra) # 80004ce2 <write_head>
    install_trans(0); // Now install writes to home locations
    80005080:	4501                	li	a0,0
    80005082:	00000097          	auipc	ra,0x0
    80005086:	cda080e7          	jalr	-806(ra) # 80004d5c <install_trans>
    log.lh.n = 0;
    8000508a:	0001e797          	auipc	a5,0x1e
    8000508e:	f807a123          	sw	zero,-126(a5) # 8002300c <log+0x2c>
    write_head();    // Erase the transaction from the log
    80005092:	00000097          	auipc	ra,0x0
    80005096:	c50080e7          	jalr	-944(ra) # 80004ce2 <write_head>
    8000509a:	bdf5                	j	80004f96 <end_op+0x52>

000000008000509c <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    8000509c:	1101                	addi	sp,sp,-32
    8000509e:	ec06                	sd	ra,24(sp)
    800050a0:	e822                	sd	s0,16(sp)
    800050a2:	e426                	sd	s1,8(sp)
    800050a4:	e04a                	sd	s2,0(sp)
    800050a6:	1000                	addi	s0,sp,32
    800050a8:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    800050aa:	0001e917          	auipc	s2,0x1e
    800050ae:	f3690913          	addi	s2,s2,-202 # 80022fe0 <log>
    800050b2:	854a                	mv	a0,s2
    800050b4:	ffffc097          	auipc	ra,0xffffc
    800050b8:	bc8080e7          	jalr	-1080(ra) # 80000c7c <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    800050bc:	02c92603          	lw	a2,44(s2)
    800050c0:	47f5                	li	a5,29
    800050c2:	06c7c563          	blt	a5,a2,8000512c <log_write+0x90>
    800050c6:	0001e797          	auipc	a5,0x1e
    800050ca:	f367a783          	lw	a5,-202(a5) # 80022ffc <log+0x1c>
    800050ce:	37fd                	addiw	a5,a5,-1
    800050d0:	04f65e63          	bge	a2,a5,8000512c <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    800050d4:	0001e797          	auipc	a5,0x1e
    800050d8:	f2c7a783          	lw	a5,-212(a5) # 80023000 <log+0x20>
    800050dc:	06f05063          	blez	a5,8000513c <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    800050e0:	4781                	li	a5,0
    800050e2:	06c05563          	blez	a2,8000514c <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    800050e6:	44cc                	lw	a1,12(s1)
    800050e8:	0001e717          	auipc	a4,0x1e
    800050ec:	f2870713          	addi	a4,a4,-216 # 80023010 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    800050f0:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    800050f2:	4314                	lw	a3,0(a4)
    800050f4:	04b68c63          	beq	a3,a1,8000514c <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    800050f8:	2785                	addiw	a5,a5,1
    800050fa:	0711                	addi	a4,a4,4
    800050fc:	fef61be3          	bne	a2,a5,800050f2 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    80005100:	0621                	addi	a2,a2,8
    80005102:	060a                	slli	a2,a2,0x2
    80005104:	0001e797          	auipc	a5,0x1e
    80005108:	edc78793          	addi	a5,a5,-292 # 80022fe0 <log>
    8000510c:	963e                	add	a2,a2,a5
    8000510e:	44dc                	lw	a5,12(s1)
    80005110:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80005112:	8526                	mv	a0,s1
    80005114:	fffff097          	auipc	ra,0xfffff
    80005118:	da2080e7          	jalr	-606(ra) # 80003eb6 <bpin>
    log.lh.n++;
    8000511c:	0001e717          	auipc	a4,0x1e
    80005120:	ec470713          	addi	a4,a4,-316 # 80022fe0 <log>
    80005124:	575c                	lw	a5,44(a4)
    80005126:	2785                	addiw	a5,a5,1
    80005128:	d75c                	sw	a5,44(a4)
    8000512a:	a835                	j	80005166 <log_write+0xca>
    panic("too big a transaction");
    8000512c:	00004517          	auipc	a0,0x4
    80005130:	7cc50513          	addi	a0,a0,1996 # 800098f8 <syscalls+0x220>
    80005134:	ffffb097          	auipc	ra,0xffffb
    80005138:	408080e7          	jalr	1032(ra) # 8000053c <panic>
    panic("log_write outside of trans");
    8000513c:	00004517          	auipc	a0,0x4
    80005140:	7d450513          	addi	a0,a0,2004 # 80009910 <syscalls+0x238>
    80005144:	ffffb097          	auipc	ra,0xffffb
    80005148:	3f8080e7          	jalr	1016(ra) # 8000053c <panic>
  log.lh.block[i] = b->blockno;
    8000514c:	00878713          	addi	a4,a5,8
    80005150:	00271693          	slli	a3,a4,0x2
    80005154:	0001e717          	auipc	a4,0x1e
    80005158:	e8c70713          	addi	a4,a4,-372 # 80022fe0 <log>
    8000515c:	9736                	add	a4,a4,a3
    8000515e:	44d4                	lw	a3,12(s1)
    80005160:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80005162:	faf608e3          	beq	a2,a5,80005112 <log_write+0x76>
  }
  release(&log.lock);
    80005166:	0001e517          	auipc	a0,0x1e
    8000516a:	e7a50513          	addi	a0,a0,-390 # 80022fe0 <log>
    8000516e:	ffffc097          	auipc	ra,0xffffc
    80005172:	bc2080e7          	jalr	-1086(ra) # 80000d30 <release>
}
    80005176:	60e2                	ld	ra,24(sp)
    80005178:	6442                	ld	s0,16(sp)
    8000517a:	64a2                	ld	s1,8(sp)
    8000517c:	6902                	ld	s2,0(sp)
    8000517e:	6105                	addi	sp,sp,32
    80005180:	8082                	ret

0000000080005182 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80005182:	1101                	addi	sp,sp,-32
    80005184:	ec06                	sd	ra,24(sp)
    80005186:	e822                	sd	s0,16(sp)
    80005188:	e426                	sd	s1,8(sp)
    8000518a:	e04a                	sd	s2,0(sp)
    8000518c:	1000                	addi	s0,sp,32
    8000518e:	84aa                	mv	s1,a0
    80005190:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80005192:	00004597          	auipc	a1,0x4
    80005196:	79e58593          	addi	a1,a1,1950 # 80009930 <syscalls+0x258>
    8000519a:	0521                	addi	a0,a0,8
    8000519c:	ffffc097          	auipc	ra,0xffffc
    800051a0:	a50080e7          	jalr	-1456(ra) # 80000bec <initlock>
  lk->name = name;
    800051a4:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    800051a8:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800051ac:	0204a423          	sw	zero,40(s1)
}
    800051b0:	60e2                	ld	ra,24(sp)
    800051b2:	6442                	ld	s0,16(sp)
    800051b4:	64a2                	ld	s1,8(sp)
    800051b6:	6902                	ld	s2,0(sp)
    800051b8:	6105                	addi	sp,sp,32
    800051ba:	8082                	ret

00000000800051bc <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800051bc:	1101                	addi	sp,sp,-32
    800051be:	ec06                	sd	ra,24(sp)
    800051c0:	e822                	sd	s0,16(sp)
    800051c2:	e426                	sd	s1,8(sp)
    800051c4:	e04a                	sd	s2,0(sp)
    800051c6:	1000                	addi	s0,sp,32
    800051c8:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800051ca:	00850913          	addi	s2,a0,8
    800051ce:	854a                	mv	a0,s2
    800051d0:	ffffc097          	auipc	ra,0xffffc
    800051d4:	aac080e7          	jalr	-1364(ra) # 80000c7c <acquire>
  while (lk->locked) {
    800051d8:	409c                	lw	a5,0(s1)
    800051da:	cb89                	beqz	a5,800051ec <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    800051dc:	85ca                	mv	a1,s2
    800051de:	8526                	mv	a0,s1
    800051e0:	ffffd097          	auipc	ra,0xffffd
    800051e4:	1ca080e7          	jalr	458(ra) # 800023aa <sleep>
  while (lk->locked) {
    800051e8:	409c                	lw	a5,0(s1)
    800051ea:	fbed                	bnez	a5,800051dc <acquiresleep+0x20>
  }
  lk->locked = 1;
    800051ec:	4785                	li	a5,1
    800051ee:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    800051f0:	ffffd097          	auipc	ra,0xffffd
    800051f4:	962080e7          	jalr	-1694(ra) # 80001b52 <myproc>
    800051f8:	591c                	lw	a5,48(a0)
    800051fa:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    800051fc:	854a                	mv	a0,s2
    800051fe:	ffffc097          	auipc	ra,0xffffc
    80005202:	b32080e7          	jalr	-1230(ra) # 80000d30 <release>
}
    80005206:	60e2                	ld	ra,24(sp)
    80005208:	6442                	ld	s0,16(sp)
    8000520a:	64a2                	ld	s1,8(sp)
    8000520c:	6902                	ld	s2,0(sp)
    8000520e:	6105                	addi	sp,sp,32
    80005210:	8082                	ret

0000000080005212 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80005212:	1101                	addi	sp,sp,-32
    80005214:	ec06                	sd	ra,24(sp)
    80005216:	e822                	sd	s0,16(sp)
    80005218:	e426                	sd	s1,8(sp)
    8000521a:	e04a                	sd	s2,0(sp)
    8000521c:	1000                	addi	s0,sp,32
    8000521e:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80005220:	00850913          	addi	s2,a0,8
    80005224:	854a                	mv	a0,s2
    80005226:	ffffc097          	auipc	ra,0xffffc
    8000522a:	a56080e7          	jalr	-1450(ra) # 80000c7c <acquire>
  lk->locked = 0;
    8000522e:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80005232:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80005236:	8526                	mv	a0,s1
    80005238:	ffffd097          	auipc	ra,0xffffd
    8000523c:	1d6080e7          	jalr	470(ra) # 8000240e <wakeup>
  release(&lk->lk);
    80005240:	854a                	mv	a0,s2
    80005242:	ffffc097          	auipc	ra,0xffffc
    80005246:	aee080e7          	jalr	-1298(ra) # 80000d30 <release>
}
    8000524a:	60e2                	ld	ra,24(sp)
    8000524c:	6442                	ld	s0,16(sp)
    8000524e:	64a2                	ld	s1,8(sp)
    80005250:	6902                	ld	s2,0(sp)
    80005252:	6105                	addi	sp,sp,32
    80005254:	8082                	ret

0000000080005256 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80005256:	7179                	addi	sp,sp,-48
    80005258:	f406                	sd	ra,40(sp)
    8000525a:	f022                	sd	s0,32(sp)
    8000525c:	ec26                	sd	s1,24(sp)
    8000525e:	e84a                	sd	s2,16(sp)
    80005260:	e44e                	sd	s3,8(sp)
    80005262:	1800                	addi	s0,sp,48
    80005264:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80005266:	00850913          	addi	s2,a0,8
    8000526a:	854a                	mv	a0,s2
    8000526c:	ffffc097          	auipc	ra,0xffffc
    80005270:	a10080e7          	jalr	-1520(ra) # 80000c7c <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80005274:	409c                	lw	a5,0(s1)
    80005276:	ef99                	bnez	a5,80005294 <holdingsleep+0x3e>
    80005278:	4481                	li	s1,0
  release(&lk->lk);
    8000527a:	854a                	mv	a0,s2
    8000527c:	ffffc097          	auipc	ra,0xffffc
    80005280:	ab4080e7          	jalr	-1356(ra) # 80000d30 <release>
  return r;
}
    80005284:	8526                	mv	a0,s1
    80005286:	70a2                	ld	ra,40(sp)
    80005288:	7402                	ld	s0,32(sp)
    8000528a:	64e2                	ld	s1,24(sp)
    8000528c:	6942                	ld	s2,16(sp)
    8000528e:	69a2                	ld	s3,8(sp)
    80005290:	6145                	addi	sp,sp,48
    80005292:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80005294:	0284a983          	lw	s3,40(s1)
    80005298:	ffffd097          	auipc	ra,0xffffd
    8000529c:	8ba080e7          	jalr	-1862(ra) # 80001b52 <myproc>
    800052a0:	5904                	lw	s1,48(a0)
    800052a2:	413484b3          	sub	s1,s1,s3
    800052a6:	0014b493          	seqz	s1,s1
    800052aa:	bfc1                	j	8000527a <holdingsleep+0x24>

00000000800052ac <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    800052ac:	1141                	addi	sp,sp,-16
    800052ae:	e406                	sd	ra,8(sp)
    800052b0:	e022                	sd	s0,0(sp)
    800052b2:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    800052b4:	00004597          	auipc	a1,0x4
    800052b8:	68c58593          	addi	a1,a1,1676 # 80009940 <syscalls+0x268>
    800052bc:	0001e517          	auipc	a0,0x1e
    800052c0:	e6c50513          	addi	a0,a0,-404 # 80023128 <ftable>
    800052c4:	ffffc097          	auipc	ra,0xffffc
    800052c8:	928080e7          	jalr	-1752(ra) # 80000bec <initlock>
}
    800052cc:	60a2                	ld	ra,8(sp)
    800052ce:	6402                	ld	s0,0(sp)
    800052d0:	0141                	addi	sp,sp,16
    800052d2:	8082                	ret

00000000800052d4 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    800052d4:	1101                	addi	sp,sp,-32
    800052d6:	ec06                	sd	ra,24(sp)
    800052d8:	e822                	sd	s0,16(sp)
    800052da:	e426                	sd	s1,8(sp)
    800052dc:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800052de:	0001e517          	auipc	a0,0x1e
    800052e2:	e4a50513          	addi	a0,a0,-438 # 80023128 <ftable>
    800052e6:	ffffc097          	auipc	ra,0xffffc
    800052ea:	996080e7          	jalr	-1642(ra) # 80000c7c <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800052ee:	0001e497          	auipc	s1,0x1e
    800052f2:	e5248493          	addi	s1,s1,-430 # 80023140 <ftable+0x18>
    800052f6:	0001f717          	auipc	a4,0x1f
    800052fa:	dea70713          	addi	a4,a4,-534 # 800240e0 <disk>
    if(f->ref == 0){
    800052fe:	40dc                	lw	a5,4(s1)
    80005300:	cf99                	beqz	a5,8000531e <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80005302:	02848493          	addi	s1,s1,40
    80005306:	fee49ce3          	bne	s1,a4,800052fe <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    8000530a:	0001e517          	auipc	a0,0x1e
    8000530e:	e1e50513          	addi	a0,a0,-482 # 80023128 <ftable>
    80005312:	ffffc097          	auipc	ra,0xffffc
    80005316:	a1e080e7          	jalr	-1506(ra) # 80000d30 <release>
  return 0;
    8000531a:	4481                	li	s1,0
    8000531c:	a819                	j	80005332 <filealloc+0x5e>
      f->ref = 1;
    8000531e:	4785                	li	a5,1
    80005320:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80005322:	0001e517          	auipc	a0,0x1e
    80005326:	e0650513          	addi	a0,a0,-506 # 80023128 <ftable>
    8000532a:	ffffc097          	auipc	ra,0xffffc
    8000532e:	a06080e7          	jalr	-1530(ra) # 80000d30 <release>
}
    80005332:	8526                	mv	a0,s1
    80005334:	60e2                	ld	ra,24(sp)
    80005336:	6442                	ld	s0,16(sp)
    80005338:	64a2                	ld	s1,8(sp)
    8000533a:	6105                	addi	sp,sp,32
    8000533c:	8082                	ret

000000008000533e <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    8000533e:	1101                	addi	sp,sp,-32
    80005340:	ec06                	sd	ra,24(sp)
    80005342:	e822                	sd	s0,16(sp)
    80005344:	e426                	sd	s1,8(sp)
    80005346:	1000                	addi	s0,sp,32
    80005348:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    8000534a:	0001e517          	auipc	a0,0x1e
    8000534e:	dde50513          	addi	a0,a0,-546 # 80023128 <ftable>
    80005352:	ffffc097          	auipc	ra,0xffffc
    80005356:	92a080e7          	jalr	-1750(ra) # 80000c7c <acquire>
  if(f->ref < 1)
    8000535a:	40dc                	lw	a5,4(s1)
    8000535c:	02f05263          	blez	a5,80005380 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80005360:	2785                	addiw	a5,a5,1
    80005362:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80005364:	0001e517          	auipc	a0,0x1e
    80005368:	dc450513          	addi	a0,a0,-572 # 80023128 <ftable>
    8000536c:	ffffc097          	auipc	ra,0xffffc
    80005370:	9c4080e7          	jalr	-1596(ra) # 80000d30 <release>
  return f;
}
    80005374:	8526                	mv	a0,s1
    80005376:	60e2                	ld	ra,24(sp)
    80005378:	6442                	ld	s0,16(sp)
    8000537a:	64a2                	ld	s1,8(sp)
    8000537c:	6105                	addi	sp,sp,32
    8000537e:	8082                	ret
    panic("filedup");
    80005380:	00004517          	auipc	a0,0x4
    80005384:	5c850513          	addi	a0,a0,1480 # 80009948 <syscalls+0x270>
    80005388:	ffffb097          	auipc	ra,0xffffb
    8000538c:	1b4080e7          	jalr	436(ra) # 8000053c <panic>

0000000080005390 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80005390:	7139                	addi	sp,sp,-64
    80005392:	fc06                	sd	ra,56(sp)
    80005394:	f822                	sd	s0,48(sp)
    80005396:	f426                	sd	s1,40(sp)
    80005398:	f04a                	sd	s2,32(sp)
    8000539a:	ec4e                	sd	s3,24(sp)
    8000539c:	e852                	sd	s4,16(sp)
    8000539e:	e456                	sd	s5,8(sp)
    800053a0:	0080                	addi	s0,sp,64
    800053a2:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    800053a4:	0001e517          	auipc	a0,0x1e
    800053a8:	d8450513          	addi	a0,a0,-636 # 80023128 <ftable>
    800053ac:	ffffc097          	auipc	ra,0xffffc
    800053b0:	8d0080e7          	jalr	-1840(ra) # 80000c7c <acquire>
  if(f->ref < 1)
    800053b4:	40dc                	lw	a5,4(s1)
    800053b6:	06f05163          	blez	a5,80005418 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    800053ba:	37fd                	addiw	a5,a5,-1
    800053bc:	0007871b          	sext.w	a4,a5
    800053c0:	c0dc                	sw	a5,4(s1)
    800053c2:	06e04363          	bgtz	a4,80005428 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    800053c6:	0004a903          	lw	s2,0(s1)
    800053ca:	0094ca83          	lbu	s5,9(s1)
    800053ce:	0104ba03          	ld	s4,16(s1)
    800053d2:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    800053d6:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    800053da:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    800053de:	0001e517          	auipc	a0,0x1e
    800053e2:	d4a50513          	addi	a0,a0,-694 # 80023128 <ftable>
    800053e6:	ffffc097          	auipc	ra,0xffffc
    800053ea:	94a080e7          	jalr	-1718(ra) # 80000d30 <release>

  if(ff.type == FD_PIPE){
    800053ee:	4785                	li	a5,1
    800053f0:	04f90d63          	beq	s2,a5,8000544a <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    800053f4:	3979                	addiw	s2,s2,-2
    800053f6:	4785                	li	a5,1
    800053f8:	0527e063          	bltu	a5,s2,80005438 <fileclose+0xa8>
    begin_op();
    800053fc:	00000097          	auipc	ra,0x0
    80005400:	ac8080e7          	jalr	-1336(ra) # 80004ec4 <begin_op>
    iput(ff.ip);
    80005404:	854e                	mv	a0,s3
    80005406:	fffff097          	auipc	ra,0xfffff
    8000540a:	2b6080e7          	jalr	694(ra) # 800046bc <iput>
    end_op();
    8000540e:	00000097          	auipc	ra,0x0
    80005412:	b36080e7          	jalr	-1226(ra) # 80004f44 <end_op>
    80005416:	a00d                	j	80005438 <fileclose+0xa8>
    panic("fileclose");
    80005418:	00004517          	auipc	a0,0x4
    8000541c:	53850513          	addi	a0,a0,1336 # 80009950 <syscalls+0x278>
    80005420:	ffffb097          	auipc	ra,0xffffb
    80005424:	11c080e7          	jalr	284(ra) # 8000053c <panic>
    release(&ftable.lock);
    80005428:	0001e517          	auipc	a0,0x1e
    8000542c:	d0050513          	addi	a0,a0,-768 # 80023128 <ftable>
    80005430:	ffffc097          	auipc	ra,0xffffc
    80005434:	900080e7          	jalr	-1792(ra) # 80000d30 <release>
  }
}
    80005438:	70e2                	ld	ra,56(sp)
    8000543a:	7442                	ld	s0,48(sp)
    8000543c:	74a2                	ld	s1,40(sp)
    8000543e:	7902                	ld	s2,32(sp)
    80005440:	69e2                	ld	s3,24(sp)
    80005442:	6a42                	ld	s4,16(sp)
    80005444:	6aa2                	ld	s5,8(sp)
    80005446:	6121                	addi	sp,sp,64
    80005448:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    8000544a:	85d6                	mv	a1,s5
    8000544c:	8552                	mv	a0,s4
    8000544e:	00000097          	auipc	ra,0x0
    80005452:	34c080e7          	jalr	844(ra) # 8000579a <pipeclose>
    80005456:	b7cd                	j	80005438 <fileclose+0xa8>

0000000080005458 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80005458:	715d                	addi	sp,sp,-80
    8000545a:	e486                	sd	ra,72(sp)
    8000545c:	e0a2                	sd	s0,64(sp)
    8000545e:	fc26                	sd	s1,56(sp)
    80005460:	f84a                	sd	s2,48(sp)
    80005462:	f44e                	sd	s3,40(sp)
    80005464:	0880                	addi	s0,sp,80
    80005466:	84aa                	mv	s1,a0
    80005468:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    8000546a:	ffffc097          	auipc	ra,0xffffc
    8000546e:	6e8080e7          	jalr	1768(ra) # 80001b52 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80005472:	409c                	lw	a5,0(s1)
    80005474:	37f9                	addiw	a5,a5,-2
    80005476:	4705                	li	a4,1
    80005478:	04f76763          	bltu	a4,a5,800054c6 <filestat+0x6e>
    8000547c:	892a                	mv	s2,a0
    ilock(f->ip);
    8000547e:	6c88                	ld	a0,24(s1)
    80005480:	fffff097          	auipc	ra,0xfffff
    80005484:	082080e7          	jalr	130(ra) # 80004502 <ilock>
    stati(f->ip, &st);
    80005488:	fb840593          	addi	a1,s0,-72
    8000548c:	6c88                	ld	a0,24(s1)
    8000548e:	fffff097          	auipc	ra,0xfffff
    80005492:	2fe080e7          	jalr	766(ra) # 8000478c <stati>
    iunlock(f->ip);
    80005496:	6c88                	ld	a0,24(s1)
    80005498:	fffff097          	auipc	ra,0xfffff
    8000549c:	12c080e7          	jalr	300(ra) # 800045c4 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    800054a0:	46e1                	li	a3,24
    800054a2:	fb840613          	addi	a2,s0,-72
    800054a6:	85ce                	mv	a1,s3
    800054a8:	05893503          	ld	a0,88(s2)
    800054ac:	ffffc097          	auipc	ra,0xffffc
    800054b0:	362080e7          	jalr	866(ra) # 8000180e <copyout>
    800054b4:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    800054b8:	60a6                	ld	ra,72(sp)
    800054ba:	6406                	ld	s0,64(sp)
    800054bc:	74e2                	ld	s1,56(sp)
    800054be:	7942                	ld	s2,48(sp)
    800054c0:	79a2                	ld	s3,40(sp)
    800054c2:	6161                	addi	sp,sp,80
    800054c4:	8082                	ret
  return -1;
    800054c6:	557d                	li	a0,-1
    800054c8:	bfc5                	j	800054b8 <filestat+0x60>

00000000800054ca <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    800054ca:	7179                	addi	sp,sp,-48
    800054cc:	f406                	sd	ra,40(sp)
    800054ce:	f022                	sd	s0,32(sp)
    800054d0:	ec26                	sd	s1,24(sp)
    800054d2:	e84a                	sd	s2,16(sp)
    800054d4:	e44e                	sd	s3,8(sp)
    800054d6:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0) 
    800054d8:	00854783          	lbu	a5,8(a0)
    800054dc:	c3d5                	beqz	a5,80005580 <fileread+0xb6>
    800054de:	84aa                	mv	s1,a0
    800054e0:	89ae                	mv	s3,a1
    800054e2:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    800054e4:	411c                	lw	a5,0(a0)
    800054e6:	4705                	li	a4,1
    800054e8:	04e78963          	beq	a5,a4,8000553a <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800054ec:	470d                	li	a4,3
    800054ee:	04e78d63          	beq	a5,a4,80005548 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    800054f2:	4709                	li	a4,2
    800054f4:	06e79e63          	bne	a5,a4,80005570 <fileread+0xa6>
    ilock(f->ip);
    800054f8:	6d08                	ld	a0,24(a0)
    800054fa:	fffff097          	auipc	ra,0xfffff
    800054fe:	008080e7          	jalr	8(ra) # 80004502 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80005502:	874a                	mv	a4,s2
    80005504:	5094                	lw	a3,32(s1)
    80005506:	864e                	mv	a2,s3
    80005508:	4585                	li	a1,1
    8000550a:	6c88                	ld	a0,24(s1)
    8000550c:	fffff097          	auipc	ra,0xfffff
    80005510:	2aa080e7          	jalr	682(ra) # 800047b6 <readi>
    80005514:	892a                	mv	s2,a0
    80005516:	00a05563          	blez	a0,80005520 <fileread+0x56>
      f->off += r;
    8000551a:	509c                	lw	a5,32(s1)
    8000551c:	9fa9                	addw	a5,a5,a0
    8000551e:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80005520:	6c88                	ld	a0,24(s1)
    80005522:	fffff097          	auipc	ra,0xfffff
    80005526:	0a2080e7          	jalr	162(ra) # 800045c4 <iunlock>
  } else {
    panic("fileread");
  }
  return r;
}
    8000552a:	854a                	mv	a0,s2
    8000552c:	70a2                	ld	ra,40(sp)
    8000552e:	7402                	ld	s0,32(sp)
    80005530:	64e2                	ld	s1,24(sp)
    80005532:	6942                	ld	s2,16(sp)
    80005534:	69a2                	ld	s3,8(sp)
    80005536:	6145                	addi	sp,sp,48
    80005538:	8082                	ret
    r = piperead(f->pipe, addr, n);
    8000553a:	6908                	ld	a0,16(a0)
    8000553c:	00000097          	auipc	ra,0x0
    80005540:	3c6080e7          	jalr	966(ra) # 80005902 <piperead>
    80005544:	892a                	mv	s2,a0
    80005546:	b7d5                	j	8000552a <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80005548:	02451783          	lh	a5,36(a0)
    8000554c:	03079693          	slli	a3,a5,0x30
    80005550:	92c1                	srli	a3,a3,0x30
    80005552:	4725                	li	a4,9
    80005554:	02d76863          	bltu	a4,a3,80005584 <fileread+0xba>
    80005558:	0792                	slli	a5,a5,0x4
    8000555a:	0001e717          	auipc	a4,0x1e
    8000555e:	b2e70713          	addi	a4,a4,-1234 # 80023088 <devsw>
    80005562:	97ba                	add	a5,a5,a4
    80005564:	639c                	ld	a5,0(a5)
    80005566:	c38d                	beqz	a5,80005588 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80005568:	4505                	li	a0,1
    8000556a:	9782                	jalr	a5
    8000556c:	892a                	mv	s2,a0
    8000556e:	bf75                	j	8000552a <fileread+0x60>
    panic("fileread");
    80005570:	00004517          	auipc	a0,0x4
    80005574:	3f050513          	addi	a0,a0,1008 # 80009960 <syscalls+0x288>
    80005578:	ffffb097          	auipc	ra,0xffffb
    8000557c:	fc4080e7          	jalr	-60(ra) # 8000053c <panic>
    return -1;
    80005580:	597d                	li	s2,-1
    80005582:	b765                	j	8000552a <fileread+0x60>
      return -1;
    80005584:	597d                	li	s2,-1
    80005586:	b755                	j	8000552a <fileread+0x60>
    80005588:	597d                	li	s2,-1
    8000558a:	b745                	j	8000552a <fileread+0x60>

000000008000558c <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    8000558c:	715d                	addi	sp,sp,-80
    8000558e:	e486                	sd	ra,72(sp)
    80005590:	e0a2                	sd	s0,64(sp)
    80005592:	fc26                	sd	s1,56(sp)
    80005594:	f84a                	sd	s2,48(sp)
    80005596:	f44e                	sd	s3,40(sp)
    80005598:	f052                	sd	s4,32(sp)
    8000559a:	ec56                	sd	s5,24(sp)
    8000559c:	e85a                	sd	s6,16(sp)
    8000559e:	e45e                	sd	s7,8(sp)
    800055a0:	e062                	sd	s8,0(sp)
    800055a2:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    800055a4:	00954783          	lbu	a5,9(a0)
    800055a8:	10078663          	beqz	a5,800056b4 <filewrite+0x128>
    800055ac:	892a                	mv	s2,a0
    800055ae:	8aae                	mv	s5,a1
    800055b0:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    800055b2:	411c                	lw	a5,0(a0)
    800055b4:	4705                	li	a4,1
    800055b6:	02e78263          	beq	a5,a4,800055da <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800055ba:	470d                	li	a4,3
    800055bc:	02e78663          	beq	a5,a4,800055e8 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    800055c0:	4709                	li	a4,2
    800055c2:	0ee79163          	bne	a5,a4,800056a4 <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    800055c6:	0ac05d63          	blez	a2,80005680 <filewrite+0xf4>
    int i = 0;
    800055ca:	4981                	li	s3,0
    800055cc:	6b05                	lui	s6,0x1
    800055ce:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    800055d2:	6b85                	lui	s7,0x1
    800055d4:	c00b8b9b          	addiw	s7,s7,-1024
    800055d8:	a861                	j	80005670 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    800055da:	6908                	ld	a0,16(a0)
    800055dc:	00000097          	auipc	ra,0x0
    800055e0:	22e080e7          	jalr	558(ra) # 8000580a <pipewrite>
    800055e4:	8a2a                	mv	s4,a0
    800055e6:	a045                	j	80005686 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    800055e8:	02451783          	lh	a5,36(a0)
    800055ec:	03079693          	slli	a3,a5,0x30
    800055f0:	92c1                	srli	a3,a3,0x30
    800055f2:	4725                	li	a4,9
    800055f4:	0cd76263          	bltu	a4,a3,800056b8 <filewrite+0x12c>
    800055f8:	0792                	slli	a5,a5,0x4
    800055fa:	0001e717          	auipc	a4,0x1e
    800055fe:	a8e70713          	addi	a4,a4,-1394 # 80023088 <devsw>
    80005602:	97ba                	add	a5,a5,a4
    80005604:	679c                	ld	a5,8(a5)
    80005606:	cbdd                	beqz	a5,800056bc <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    80005608:	4505                	li	a0,1
    8000560a:	9782                	jalr	a5
    8000560c:	8a2a                	mv	s4,a0
    8000560e:	a8a5                	j	80005686 <filewrite+0xfa>
    80005610:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80005614:	00000097          	auipc	ra,0x0
    80005618:	8b0080e7          	jalr	-1872(ra) # 80004ec4 <begin_op>
      ilock(f->ip);
    8000561c:	01893503          	ld	a0,24(s2)
    80005620:	fffff097          	auipc	ra,0xfffff
    80005624:	ee2080e7          	jalr	-286(ra) # 80004502 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80005628:	8762                	mv	a4,s8
    8000562a:	02092683          	lw	a3,32(s2)
    8000562e:	01598633          	add	a2,s3,s5
    80005632:	4585                	li	a1,1
    80005634:	01893503          	ld	a0,24(s2)
    80005638:	fffff097          	auipc	ra,0xfffff
    8000563c:	276080e7          	jalr	630(ra) # 800048ae <writei>
    80005640:	84aa                	mv	s1,a0
    80005642:	00a05763          	blez	a0,80005650 <filewrite+0xc4>
        f->off += r;
    80005646:	02092783          	lw	a5,32(s2)
    8000564a:	9fa9                	addw	a5,a5,a0
    8000564c:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80005650:	01893503          	ld	a0,24(s2)
    80005654:	fffff097          	auipc	ra,0xfffff
    80005658:	f70080e7          	jalr	-144(ra) # 800045c4 <iunlock>
      end_op();
    8000565c:	00000097          	auipc	ra,0x0
    80005660:	8e8080e7          	jalr	-1816(ra) # 80004f44 <end_op>

      if(r != n1){
    80005664:	009c1f63          	bne	s8,s1,80005682 <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    80005668:	013489bb          	addw	s3,s1,s3
    while(i < n){
    8000566c:	0149db63          	bge	s3,s4,80005682 <filewrite+0xf6>
      int n1 = n - i;
    80005670:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    80005674:	84be                	mv	s1,a5
    80005676:	2781                	sext.w	a5,a5
    80005678:	f8fb5ce3          	bge	s6,a5,80005610 <filewrite+0x84>
    8000567c:	84de                	mv	s1,s7
    8000567e:	bf49                	j	80005610 <filewrite+0x84>
    int i = 0;
    80005680:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80005682:	013a1f63          	bne	s4,s3,800056a0 <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80005686:	8552                	mv	a0,s4
    80005688:	60a6                	ld	ra,72(sp)
    8000568a:	6406                	ld	s0,64(sp)
    8000568c:	74e2                	ld	s1,56(sp)
    8000568e:	7942                	ld	s2,48(sp)
    80005690:	79a2                	ld	s3,40(sp)
    80005692:	7a02                	ld	s4,32(sp)
    80005694:	6ae2                	ld	s5,24(sp)
    80005696:	6b42                	ld	s6,16(sp)
    80005698:	6ba2                	ld	s7,8(sp)
    8000569a:	6c02                	ld	s8,0(sp)
    8000569c:	6161                	addi	sp,sp,80
    8000569e:	8082                	ret
    ret = (i == n ? n : -1);
    800056a0:	5a7d                	li	s4,-1
    800056a2:	b7d5                	j	80005686 <filewrite+0xfa>
    panic("filewrite");
    800056a4:	00004517          	auipc	a0,0x4
    800056a8:	2cc50513          	addi	a0,a0,716 # 80009970 <syscalls+0x298>
    800056ac:	ffffb097          	auipc	ra,0xffffb
    800056b0:	e90080e7          	jalr	-368(ra) # 8000053c <panic>
    return -1;
    800056b4:	5a7d                	li	s4,-1
    800056b6:	bfc1                	j	80005686 <filewrite+0xfa>
      return -1;
    800056b8:	5a7d                	li	s4,-1
    800056ba:	b7f1                	j	80005686 <filewrite+0xfa>
    800056bc:	5a7d                	li	s4,-1
    800056be:	b7e1                	j	80005686 <filewrite+0xfa>

00000000800056c0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    800056c0:	7179                	addi	sp,sp,-48
    800056c2:	f406                	sd	ra,40(sp)
    800056c4:	f022                	sd	s0,32(sp)
    800056c6:	ec26                	sd	s1,24(sp)
    800056c8:	e84a                	sd	s2,16(sp)
    800056ca:	e44e                	sd	s3,8(sp)
    800056cc:	e052                	sd	s4,0(sp)
    800056ce:	1800                	addi	s0,sp,48
    800056d0:	84aa                	mv	s1,a0
    800056d2:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    800056d4:	0005b023          	sd	zero,0(a1)
    800056d8:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    800056dc:	00000097          	auipc	ra,0x0
    800056e0:	bf8080e7          	jalr	-1032(ra) # 800052d4 <filealloc>
    800056e4:	e088                	sd	a0,0(s1)
    800056e6:	c551                	beqz	a0,80005772 <pipealloc+0xb2>
    800056e8:	00000097          	auipc	ra,0x0
    800056ec:	bec080e7          	jalr	-1044(ra) # 800052d4 <filealloc>
    800056f0:	00aa3023          	sd	a0,0(s4)
    800056f4:	c92d                	beqz	a0,80005766 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800056f6:	ffffb097          	auipc	ra,0xffffb
    800056fa:	496080e7          	jalr	1174(ra) # 80000b8c <kalloc>
    800056fe:	892a                	mv	s2,a0
    80005700:	c125                	beqz	a0,80005760 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80005702:	4985                	li	s3,1
    80005704:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80005708:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    8000570c:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80005710:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80005714:	00004597          	auipc	a1,0x4
    80005718:	26c58593          	addi	a1,a1,620 # 80009980 <syscalls+0x2a8>
    8000571c:	ffffb097          	auipc	ra,0xffffb
    80005720:	4d0080e7          	jalr	1232(ra) # 80000bec <initlock>
  (*f0)->type = FD_PIPE;
    80005724:	609c                	ld	a5,0(s1)
    80005726:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    8000572a:	609c                	ld	a5,0(s1)
    8000572c:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80005730:	609c                	ld	a5,0(s1)
    80005732:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80005736:	609c                	ld	a5,0(s1)
    80005738:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    8000573c:	000a3783          	ld	a5,0(s4)
    80005740:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80005744:	000a3783          	ld	a5,0(s4)
    80005748:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    8000574c:	000a3783          	ld	a5,0(s4)
    80005750:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80005754:	000a3783          	ld	a5,0(s4)
    80005758:	0127b823          	sd	s2,16(a5)
  return 0;
    8000575c:	4501                	li	a0,0
    8000575e:	a025                	j	80005786 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80005760:	6088                	ld	a0,0(s1)
    80005762:	e501                	bnez	a0,8000576a <pipealloc+0xaa>
    80005764:	a039                	j	80005772 <pipealloc+0xb2>
    80005766:	6088                	ld	a0,0(s1)
    80005768:	c51d                	beqz	a0,80005796 <pipealloc+0xd6>
    fileclose(*f0);
    8000576a:	00000097          	auipc	ra,0x0
    8000576e:	c26080e7          	jalr	-986(ra) # 80005390 <fileclose>
  if(*f1)
    80005772:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80005776:	557d                	li	a0,-1
  if(*f1)
    80005778:	c799                	beqz	a5,80005786 <pipealloc+0xc6>
    fileclose(*f1);
    8000577a:	853e                	mv	a0,a5
    8000577c:	00000097          	auipc	ra,0x0
    80005780:	c14080e7          	jalr	-1004(ra) # 80005390 <fileclose>
  return -1;
    80005784:	557d                	li	a0,-1
}
    80005786:	70a2                	ld	ra,40(sp)
    80005788:	7402                	ld	s0,32(sp)
    8000578a:	64e2                	ld	s1,24(sp)
    8000578c:	6942                	ld	s2,16(sp)
    8000578e:	69a2                	ld	s3,8(sp)
    80005790:	6a02                	ld	s4,0(sp)
    80005792:	6145                	addi	sp,sp,48
    80005794:	8082                	ret
  return -1;
    80005796:	557d                	li	a0,-1
    80005798:	b7fd                	j	80005786 <pipealloc+0xc6>

000000008000579a <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    8000579a:	1101                	addi	sp,sp,-32
    8000579c:	ec06                	sd	ra,24(sp)
    8000579e:	e822                	sd	s0,16(sp)
    800057a0:	e426                	sd	s1,8(sp)
    800057a2:	e04a                	sd	s2,0(sp)
    800057a4:	1000                	addi	s0,sp,32
    800057a6:	84aa                	mv	s1,a0
    800057a8:	892e                	mv	s2,a1
  acquire(&pi->lock);
    800057aa:	ffffb097          	auipc	ra,0xffffb
    800057ae:	4d2080e7          	jalr	1234(ra) # 80000c7c <acquire>
  if(writable){
    800057b2:	02090d63          	beqz	s2,800057ec <pipeclose+0x52>
    pi->writeopen = 0;
    800057b6:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    800057ba:	21848513          	addi	a0,s1,536
    800057be:	ffffd097          	auipc	ra,0xffffd
    800057c2:	c50080e7          	jalr	-944(ra) # 8000240e <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    800057c6:	2204b783          	ld	a5,544(s1)
    800057ca:	eb95                	bnez	a5,800057fe <pipeclose+0x64>
    release(&pi->lock);
    800057cc:	8526                	mv	a0,s1
    800057ce:	ffffb097          	auipc	ra,0xffffb
    800057d2:	562080e7          	jalr	1378(ra) # 80000d30 <release>
    kfree((char*)pi);
    800057d6:	8526                	mv	a0,s1
    800057d8:	ffffb097          	auipc	ra,0xffffb
    800057dc:	2b8080e7          	jalr	696(ra) # 80000a90 <kfree>
  } else
    release(&pi->lock);
}
    800057e0:	60e2                	ld	ra,24(sp)
    800057e2:	6442                	ld	s0,16(sp)
    800057e4:	64a2                	ld	s1,8(sp)
    800057e6:	6902                	ld	s2,0(sp)
    800057e8:	6105                	addi	sp,sp,32
    800057ea:	8082                	ret
    pi->readopen = 0;
    800057ec:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    800057f0:	21c48513          	addi	a0,s1,540
    800057f4:	ffffd097          	auipc	ra,0xffffd
    800057f8:	c1a080e7          	jalr	-998(ra) # 8000240e <wakeup>
    800057fc:	b7e9                	j	800057c6 <pipeclose+0x2c>
    release(&pi->lock);
    800057fe:	8526                	mv	a0,s1
    80005800:	ffffb097          	auipc	ra,0xffffb
    80005804:	530080e7          	jalr	1328(ra) # 80000d30 <release>
}
    80005808:	bfe1                	j	800057e0 <pipeclose+0x46>

000000008000580a <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    8000580a:	711d                	addi	sp,sp,-96
    8000580c:	ec86                	sd	ra,88(sp)
    8000580e:	e8a2                	sd	s0,80(sp)
    80005810:	e4a6                	sd	s1,72(sp)
    80005812:	e0ca                	sd	s2,64(sp)
    80005814:	fc4e                	sd	s3,56(sp)
    80005816:	f852                	sd	s4,48(sp)
    80005818:	f456                	sd	s5,40(sp)
    8000581a:	f05a                	sd	s6,32(sp)
    8000581c:	ec5e                	sd	s7,24(sp)
    8000581e:	e862                	sd	s8,16(sp)
    80005820:	1080                	addi	s0,sp,96
    80005822:	84aa                	mv	s1,a0
    80005824:	8aae                	mv	s5,a1
    80005826:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80005828:	ffffc097          	auipc	ra,0xffffc
    8000582c:	32a080e7          	jalr	810(ra) # 80001b52 <myproc>
    80005830:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80005832:	8526                	mv	a0,s1
    80005834:	ffffb097          	auipc	ra,0xffffb
    80005838:	448080e7          	jalr	1096(ra) # 80000c7c <acquire>
  while(i < n){
    8000583c:	0b405663          	blez	s4,800058e8 <pipewrite+0xde>
  int i = 0;
    80005840:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80005842:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80005844:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80005848:	21c48b93          	addi	s7,s1,540
    8000584c:	a089                	j	8000588e <pipewrite+0x84>
      release(&pi->lock);
    8000584e:	8526                	mv	a0,s1
    80005850:	ffffb097          	auipc	ra,0xffffb
    80005854:	4e0080e7          	jalr	1248(ra) # 80000d30 <release>
      return -1;
    80005858:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    8000585a:	854a                	mv	a0,s2
    8000585c:	60e6                	ld	ra,88(sp)
    8000585e:	6446                	ld	s0,80(sp)
    80005860:	64a6                	ld	s1,72(sp)
    80005862:	6906                	ld	s2,64(sp)
    80005864:	79e2                	ld	s3,56(sp)
    80005866:	7a42                	ld	s4,48(sp)
    80005868:	7aa2                	ld	s5,40(sp)
    8000586a:	7b02                	ld	s6,32(sp)
    8000586c:	6be2                	ld	s7,24(sp)
    8000586e:	6c42                	ld	s8,16(sp)
    80005870:	6125                	addi	sp,sp,96
    80005872:	8082                	ret
      wakeup(&pi->nread);
    80005874:	8562                	mv	a0,s8
    80005876:	ffffd097          	auipc	ra,0xffffd
    8000587a:	b98080e7          	jalr	-1128(ra) # 8000240e <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    8000587e:	85a6                	mv	a1,s1
    80005880:	855e                	mv	a0,s7
    80005882:	ffffd097          	auipc	ra,0xffffd
    80005886:	b28080e7          	jalr	-1240(ra) # 800023aa <sleep>
  while(i < n){
    8000588a:	07495063          	bge	s2,s4,800058ea <pipewrite+0xe0>
    if(pi->readopen == 0 || killed(pr)){
    8000588e:	2204a783          	lw	a5,544(s1)
    80005892:	dfd5                	beqz	a5,8000584e <pipewrite+0x44>
    80005894:	854e                	mv	a0,s3
    80005896:	ffffd097          	auipc	ra,0xffffd
    8000589a:	dd2080e7          	jalr	-558(ra) # 80002668 <killed>
    8000589e:	f945                	bnez	a0,8000584e <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    800058a0:	2184a783          	lw	a5,536(s1)
    800058a4:	21c4a703          	lw	a4,540(s1)
    800058a8:	2007879b          	addiw	a5,a5,512
    800058ac:	fcf704e3          	beq	a4,a5,80005874 <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800058b0:	4685                	li	a3,1
    800058b2:	01590633          	add	a2,s2,s5
    800058b6:	faf40593          	addi	a1,s0,-81
    800058ba:	0589b503          	ld	a0,88(s3)
    800058be:	ffffc097          	auipc	ra,0xffffc
    800058c2:	fdc080e7          	jalr	-36(ra) # 8000189a <copyin>
    800058c6:	03650263          	beq	a0,s6,800058ea <pipewrite+0xe0>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    800058ca:	21c4a783          	lw	a5,540(s1)
    800058ce:	0017871b          	addiw	a4,a5,1
    800058d2:	20e4ae23          	sw	a4,540(s1)
    800058d6:	1ff7f793          	andi	a5,a5,511
    800058da:	97a6                	add	a5,a5,s1
    800058dc:	faf44703          	lbu	a4,-81(s0)
    800058e0:	00e78c23          	sb	a4,24(a5)
      i++;
    800058e4:	2905                	addiw	s2,s2,1
    800058e6:	b755                	j	8000588a <pipewrite+0x80>
  int i = 0;
    800058e8:	4901                	li	s2,0
  wakeup(&pi->nread);
    800058ea:	21848513          	addi	a0,s1,536
    800058ee:	ffffd097          	auipc	ra,0xffffd
    800058f2:	b20080e7          	jalr	-1248(ra) # 8000240e <wakeup>
  release(&pi->lock);
    800058f6:	8526                	mv	a0,s1
    800058f8:	ffffb097          	auipc	ra,0xffffb
    800058fc:	438080e7          	jalr	1080(ra) # 80000d30 <release>
  return i;
    80005900:	bfa9                	j	8000585a <pipewrite+0x50>

0000000080005902 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80005902:	715d                	addi	sp,sp,-80
    80005904:	e486                	sd	ra,72(sp)
    80005906:	e0a2                	sd	s0,64(sp)
    80005908:	fc26                	sd	s1,56(sp)
    8000590a:	f84a                	sd	s2,48(sp)
    8000590c:	f44e                	sd	s3,40(sp)
    8000590e:	f052                	sd	s4,32(sp)
    80005910:	ec56                	sd	s5,24(sp)
    80005912:	e85a                	sd	s6,16(sp)
    80005914:	0880                	addi	s0,sp,80
    80005916:	84aa                	mv	s1,a0
    80005918:	892e                	mv	s2,a1
    8000591a:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    8000591c:	ffffc097          	auipc	ra,0xffffc
    80005920:	236080e7          	jalr	566(ra) # 80001b52 <myproc>
    80005924:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80005926:	8526                	mv	a0,s1
    80005928:	ffffb097          	auipc	ra,0xffffb
    8000592c:	354080e7          	jalr	852(ra) # 80000c7c <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80005930:	2184a703          	lw	a4,536(s1)
    80005934:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80005938:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000593c:	02f71763          	bne	a4,a5,8000596a <piperead+0x68>
    80005940:	2244a783          	lw	a5,548(s1)
    80005944:	c39d                	beqz	a5,8000596a <piperead+0x68>
    if(killed(pr)){
    80005946:	8552                	mv	a0,s4
    80005948:	ffffd097          	auipc	ra,0xffffd
    8000594c:	d20080e7          	jalr	-736(ra) # 80002668 <killed>
    80005950:	e941                	bnez	a0,800059e0 <piperead+0xde>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80005952:	85a6                	mv	a1,s1
    80005954:	854e                	mv	a0,s3
    80005956:	ffffd097          	auipc	ra,0xffffd
    8000595a:	a54080e7          	jalr	-1452(ra) # 800023aa <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000595e:	2184a703          	lw	a4,536(s1)
    80005962:	21c4a783          	lw	a5,540(s1)
    80005966:	fcf70de3          	beq	a4,a5,80005940 <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000596a:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000596c:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000596e:	05505363          	blez	s5,800059b4 <piperead+0xb2>
    if(pi->nread == pi->nwrite)
    80005972:	2184a783          	lw	a5,536(s1)
    80005976:	21c4a703          	lw	a4,540(s1)
    8000597a:	02f70d63          	beq	a4,a5,800059b4 <piperead+0xb2>
    ch = pi->data[pi->nread++ % PIPESIZE];
    8000597e:	0017871b          	addiw	a4,a5,1
    80005982:	20e4ac23          	sw	a4,536(s1)
    80005986:	1ff7f793          	andi	a5,a5,511
    8000598a:	97a6                	add	a5,a5,s1
    8000598c:	0187c783          	lbu	a5,24(a5)
    80005990:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80005994:	4685                	li	a3,1
    80005996:	fbf40613          	addi	a2,s0,-65
    8000599a:	85ca                	mv	a1,s2
    8000599c:	058a3503          	ld	a0,88(s4)
    800059a0:	ffffc097          	auipc	ra,0xffffc
    800059a4:	e6e080e7          	jalr	-402(ra) # 8000180e <copyout>
    800059a8:	01650663          	beq	a0,s6,800059b4 <piperead+0xb2>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800059ac:	2985                	addiw	s3,s3,1
    800059ae:	0905                	addi	s2,s2,1
    800059b0:	fd3a91e3          	bne	s5,s3,80005972 <piperead+0x70>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    800059b4:	21c48513          	addi	a0,s1,540
    800059b8:	ffffd097          	auipc	ra,0xffffd
    800059bc:	a56080e7          	jalr	-1450(ra) # 8000240e <wakeup>
  release(&pi->lock);
    800059c0:	8526                	mv	a0,s1
    800059c2:	ffffb097          	auipc	ra,0xffffb
    800059c6:	36e080e7          	jalr	878(ra) # 80000d30 <release>
  return i;
}
    800059ca:	854e                	mv	a0,s3
    800059cc:	60a6                	ld	ra,72(sp)
    800059ce:	6406                	ld	s0,64(sp)
    800059d0:	74e2                	ld	s1,56(sp)
    800059d2:	7942                	ld	s2,48(sp)
    800059d4:	79a2                	ld	s3,40(sp)
    800059d6:	7a02                	ld	s4,32(sp)
    800059d8:	6ae2                	ld	s5,24(sp)
    800059da:	6b42                	ld	s6,16(sp)
    800059dc:	6161                	addi	sp,sp,80
    800059de:	8082                	ret
      release(&pi->lock);
    800059e0:	8526                	mv	a0,s1
    800059e2:	ffffb097          	auipc	ra,0xffffb
    800059e6:	34e080e7          	jalr	846(ra) # 80000d30 <release>
      return -1;
    800059ea:	59fd                	li	s3,-1
    800059ec:	bff9                	j	800059ca <piperead+0xc8>

00000000800059ee <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    800059ee:	1141                	addi	sp,sp,-16
    800059f0:	e422                	sd	s0,8(sp)
    800059f2:	0800                	addi	s0,sp,16
    800059f4:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    800059f6:	8905                	andi	a0,a0,1
    800059f8:	c111                	beqz	a0,800059fc <flags2perm+0xe>
      perm = PTE_X;
    800059fa:	4521                	li	a0,8
    if(flags & 0x2)
    800059fc:	8b89                	andi	a5,a5,2
    800059fe:	c399                	beqz	a5,80005a04 <flags2perm+0x16>
      perm |= PTE_W;
    80005a00:	00456513          	ori	a0,a0,4
    return perm;
}
    80005a04:	6422                	ld	s0,8(sp)
    80005a06:	0141                	addi	sp,sp,16
    80005a08:	8082                	ret

0000000080005a0a <exec>:

int
exec(char *path, char **argv)
{
    80005a0a:	de010113          	addi	sp,sp,-544
    80005a0e:	20113c23          	sd	ra,536(sp)
    80005a12:	20813823          	sd	s0,528(sp)
    80005a16:	20913423          	sd	s1,520(sp)
    80005a1a:	21213023          	sd	s2,512(sp)
    80005a1e:	ffce                	sd	s3,504(sp)
    80005a20:	fbd2                	sd	s4,496(sp)
    80005a22:	f7d6                	sd	s5,488(sp)
    80005a24:	f3da                	sd	s6,480(sp)
    80005a26:	efde                	sd	s7,472(sp)
    80005a28:	ebe2                	sd	s8,464(sp)
    80005a2a:	e7e6                	sd	s9,456(sp)
    80005a2c:	e3ea                	sd	s10,448(sp)
    80005a2e:	ff6e                	sd	s11,440(sp)
    80005a30:	1400                	addi	s0,sp,544
    80005a32:	892a                	mv	s2,a0
    80005a34:	dea43423          	sd	a0,-536(s0)
    80005a38:	deb43823          	sd	a1,-528(s0)

  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80005a3c:	ffffc097          	auipc	ra,0xffffc
    80005a40:	116080e7          	jalr	278(ra) # 80001b52 <myproc>
    80005a44:	84aa                	mv	s1,a0

  begin_op();
    80005a46:	fffff097          	auipc	ra,0xfffff
    80005a4a:	47e080e7          	jalr	1150(ra) # 80004ec4 <begin_op>

  if((ip = namei(path)) == 0){
    80005a4e:	854a                	mv	a0,s2
    80005a50:	fffff097          	auipc	ra,0xfffff
    80005a54:	258080e7          	jalr	600(ra) # 80004ca8 <namei>
    80005a58:	c93d                	beqz	a0,80005ace <exec+0xc4>
    80005a5a:	8aaa                	mv	s5,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80005a5c:	fffff097          	auipc	ra,0xfffff
    80005a60:	aa6080e7          	jalr	-1370(ra) # 80004502 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80005a64:	04000713          	li	a4,64
    80005a68:	4681                	li	a3,0
    80005a6a:	e5040613          	addi	a2,s0,-432
    80005a6e:	4581                	li	a1,0
    80005a70:	8556                	mv	a0,s5
    80005a72:	fffff097          	auipc	ra,0xfffff
    80005a76:	d44080e7          	jalr	-700(ra) # 800047b6 <readi>
    80005a7a:	04000793          	li	a5,64
    80005a7e:	00f51a63          	bne	a0,a5,80005a92 <exec+0x88>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    80005a82:	e5042703          	lw	a4,-432(s0)
    80005a86:	464c47b7          	lui	a5,0x464c4
    80005a8a:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80005a8e:	04f70663          	beq	a4,a5,80005ada <exec+0xd0>
  
 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80005a92:	8556                	mv	a0,s5
    80005a94:	fffff097          	auipc	ra,0xfffff
    80005a98:	cd0080e7          	jalr	-816(ra) # 80004764 <iunlockput>
    end_op();
    80005a9c:	fffff097          	auipc	ra,0xfffff
    80005aa0:	4a8080e7          	jalr	1192(ra) # 80004f44 <end_op>
  }
  return -1;
    80005aa4:	557d                	li	a0,-1
}
    80005aa6:	21813083          	ld	ra,536(sp)
    80005aaa:	21013403          	ld	s0,528(sp)
    80005aae:	20813483          	ld	s1,520(sp)
    80005ab2:	20013903          	ld	s2,512(sp)
    80005ab6:	79fe                	ld	s3,504(sp)
    80005ab8:	7a5e                	ld	s4,496(sp)
    80005aba:	7abe                	ld	s5,488(sp)
    80005abc:	7b1e                	ld	s6,480(sp)
    80005abe:	6bfe                	ld	s7,472(sp)
    80005ac0:	6c5e                	ld	s8,464(sp)
    80005ac2:	6cbe                	ld	s9,456(sp)
    80005ac4:	6d1e                	ld	s10,448(sp)
    80005ac6:	7dfa                	ld	s11,440(sp)
    80005ac8:	22010113          	addi	sp,sp,544
    80005acc:	8082                	ret
    end_op();
    80005ace:	fffff097          	auipc	ra,0xfffff
    80005ad2:	476080e7          	jalr	1142(ra) # 80004f44 <end_op>
    return -1;
    80005ad6:	557d                	li	a0,-1
    80005ad8:	b7f9                	j	80005aa6 <exec+0x9c>
  if((pagetable = proc_pagetable(p)) == 0)
    80005ada:	8526                	mv	a0,s1
    80005adc:	ffffc097          	auipc	ra,0xffffc
    80005ae0:	13a080e7          	jalr	314(ra) # 80001c16 <proc_pagetable>
    80005ae4:	8b2a                	mv	s6,a0
    80005ae6:	d555                	beqz	a0,80005a92 <exec+0x88>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80005ae8:	e7042783          	lw	a5,-400(s0)
    80005aec:	e8845703          	lhu	a4,-376(s0)
    80005af0:	c735                	beqz	a4,80005b5c <exec+0x152>
  uint64 argc, sz = PGSIZE*3, sp, ustack[MAXARG], stackbase;
    80005af2:	690d                	lui	s2,0x3
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80005af4:	e0043423          	sd	zero,-504(s0)
    if(ph.vaddr % PGSIZE != 0)
    80005af8:	6a05                	lui	s4,0x1
    80005afa:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    80005afe:	dee43023          	sd	a4,-544(s0)
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    80005b02:	6d85                	lui	s11,0x1
    80005b04:	7d7d                	lui	s10,0xfffff
    80005b06:	a41d                	j	80005d2c <exec+0x322>
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    80005b08:	00004517          	auipc	a0,0x4
    80005b0c:	e8050513          	addi	a0,a0,-384 # 80009988 <syscalls+0x2b0>
    80005b10:	ffffb097          	auipc	ra,0xffffb
    80005b14:	a2c080e7          	jalr	-1492(ra) # 8000053c <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80005b18:	874a                	mv	a4,s2
    80005b1a:	009c86bb          	addw	a3,s9,s1
    80005b1e:	4581                	li	a1,0
    80005b20:	8556                	mv	a0,s5
    80005b22:	fffff097          	auipc	ra,0xfffff
    80005b26:	c94080e7          	jalr	-876(ra) # 800047b6 <readi>
    80005b2a:	2501                	sext.w	a0,a0
    80005b2c:	1aa91163          	bne	s2,a0,80005cce <exec+0x2c4>
  for(i = 0; i < sz; i += PGSIZE){
    80005b30:	009d84bb          	addw	s1,s11,s1
    80005b34:	013d09bb          	addw	s3,s10,s3
    80005b38:	1d74fa63          	bgeu	s1,s7,80005d0c <exec+0x302>
    pa = walkaddr(pagetable, va + i);
    80005b3c:	02049593          	slli	a1,s1,0x20
    80005b40:	9181                	srli	a1,a1,0x20
    80005b42:	95e2                	add	a1,a1,s8
    80005b44:	855a                	mv	a0,s6
    80005b46:	ffffb097          	auipc	ra,0xffffb
    80005b4a:	5bc080e7          	jalr	1468(ra) # 80001102 <walkaddr>
    80005b4e:	862a                	mv	a2,a0
    if(pa == 0)
    80005b50:	dd45                	beqz	a0,80005b08 <exec+0xfe>
      n = PGSIZE;
    80005b52:	8952                	mv	s2,s4
    if(sz - i < PGSIZE)
    80005b54:	fd49f2e3          	bgeu	s3,s4,80005b18 <exec+0x10e>
      n = sz - i;
    80005b58:	894e                	mv	s2,s3
    80005b5a:	bf7d                	j	80005b18 <exec+0x10e>
  uint64 argc, sz = PGSIZE*3, sp, ustack[MAXARG], stackbase;
    80005b5c:	690d                	lui	s2,0x3
  iunlockput(ip);
    80005b5e:	8556                	mv	a0,s5
    80005b60:	fffff097          	auipc	ra,0xfffff
    80005b64:	c04080e7          	jalr	-1020(ra) # 80004764 <iunlockput>
  end_op();
    80005b68:	fffff097          	auipc	ra,0xfffff
    80005b6c:	3dc080e7          	jalr	988(ra) # 80004f44 <end_op>
  p = myproc();
    80005b70:	ffffc097          	auipc	ra,0xffffc
    80005b74:	fe2080e7          	jalr	-30(ra) # 80001b52 <myproc>
    80005b78:	8baa                	mv	s7,a0
  uint64 oldsz = p->sz;
    80005b7a:	05053c83          	ld	s9,80(a0)
  sz = PGROUNDUP(sz); 
    80005b7e:	6785                	lui	a5,0x1
    80005b80:	17fd                	addi	a5,a5,-1
    80005b82:	993e                	add	s2,s2,a5
    80005b84:	77fd                	lui	a5,0xfffff
    80005b86:	00f977b3          	and	a5,s2,a5
    80005b8a:	def43c23          	sd	a5,-520(s0)
  if((sz1 = uvmalloc(pagetable, stack_sz, USERTOP, PTE_W)) == 0) 
    80005b8e:	4691                	li	a3,4
    80005b90:	000a0637          	lui	a2,0xa0
    80005b94:	0009f5b7          	lui	a1,0x9f
    80005b98:	855a                	mv	a0,s6
    80005b9a:	ffffc097          	auipc	ra,0xffffc
    80005b9e:	91c080e7          	jalr	-1764(ra) # 800014b6 <uvmalloc>
    80005ba2:	892a                	mv	s2,a0
    80005ba4:	14050c63          	beqz	a0,80005cfc <exec+0x2f2>
  stackbase = sp - PGSIZE;
    80005ba8:	7c7d                	lui	s8,0xfffff
    80005baa:	9c2a                	add	s8,s8,a0
  for(argc = 0; argv[argc]; argc++) {
    80005bac:	df043783          	ld	a5,-528(s0)
    80005bb0:	6388                	ld	a0,0(a5)
    80005bb2:	c525                	beqz	a0,80005c1a <exec+0x210>
    80005bb4:	e9040993          	addi	s3,s0,-368
    80005bb8:	f9040a93          	addi	s5,s0,-112
    80005bbc:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    80005bbe:	ffffb097          	auipc	ra,0xffffb
    80005bc2:	336080e7          	jalr	822(ra) # 80000ef4 <strlen>
    80005bc6:	2505                	addiw	a0,a0,1
    80005bc8:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80005bcc:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    80005bd0:	13896863          	bltu	s2,s8,80005d00 <exec+0x2f6>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80005bd4:	df043d03          	ld	s10,-528(s0)
    80005bd8:	000d3a03          	ld	s4,0(s10) # fffffffffffff000 <end+0xffffffff7ffdade0>
    80005bdc:	8552                	mv	a0,s4
    80005bde:	ffffb097          	auipc	ra,0xffffb
    80005be2:	316080e7          	jalr	790(ra) # 80000ef4 <strlen>
    80005be6:	0015069b          	addiw	a3,a0,1
    80005bea:	8652                	mv	a2,s4
    80005bec:	85ca                	mv	a1,s2
    80005bee:	855a                	mv	a0,s6
    80005bf0:	ffffc097          	auipc	ra,0xffffc
    80005bf4:	c1e080e7          	jalr	-994(ra) # 8000180e <copyout>
    80005bf8:	10054663          	bltz	a0,80005d04 <exec+0x2fa>
    ustack[argc] = sp;
    80005bfc:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80005c00:	0485                	addi	s1,s1,1
    80005c02:	008d0793          	addi	a5,s10,8
    80005c06:	def43823          	sd	a5,-528(s0)
    80005c0a:	008d3503          	ld	a0,8(s10)
    80005c0e:	c519                	beqz	a0,80005c1c <exec+0x212>
    if(argc >= MAXARG)
    80005c10:	09a1                	addi	s3,s3,8
    80005c12:	fb3a96e3          	bne	s5,s3,80005bbe <exec+0x1b4>
  ip = 0;
    80005c16:	4a81                	li	s5,0
    80005c18:	a85d                	j	80005cce <exec+0x2c4>
  for(argc = 0; argv[argc]; argc++) {
    80005c1a:	4481                	li	s1,0
  ustack[argc] = 0;
    80005c1c:	00349793          	slli	a5,s1,0x3
    80005c20:	f9040713          	addi	a4,s0,-112
    80005c24:	97ba                	add	a5,a5,a4
    80005c26:	f007b023          	sd	zero,-256(a5) # ffffffffffffef00 <end+0xffffffff7ffdace0>
  sp -= (argc+1) * sizeof(uint64);
    80005c2a:	00148693          	addi	a3,s1,1
    80005c2e:	068e                	slli	a3,a3,0x3
    80005c30:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80005c34:	ff097913          	andi	s2,s2,-16
  ip = 0;
    80005c38:	4a81                	li	s5,0
  if(sp < stackbase)
    80005c3a:	09896a63          	bltu	s2,s8,80005cce <exec+0x2c4>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80005c3e:	e9040613          	addi	a2,s0,-368
    80005c42:	85ca                	mv	a1,s2
    80005c44:	855a                	mv	a0,s6
    80005c46:	ffffc097          	auipc	ra,0xffffc
    80005c4a:	bc8080e7          	jalr	-1080(ra) # 8000180e <copyout>
    80005c4e:	0a054d63          	bltz	a0,80005d08 <exec+0x2fe>
  p->trapframe->a1 = sp;
    80005c52:	060bb783          	ld	a5,96(s7) # 1060 <_entry-0x7fffefa0>
    80005c56:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80005c5a:	de843783          	ld	a5,-536(s0)
    80005c5e:	0007c703          	lbu	a4,0(a5)
    80005c62:	cf11                	beqz	a4,80005c7e <exec+0x274>
    80005c64:	0785                	addi	a5,a5,1
    if(*s == '/')
    80005c66:	02f00693          	li	a3,47
    80005c6a:	a029                	j	80005c74 <exec+0x26a>
  for(last=s=path; *s; s++)
    80005c6c:	0785                	addi	a5,a5,1
    80005c6e:	fff7c703          	lbu	a4,-1(a5)
    80005c72:	c711                	beqz	a4,80005c7e <exec+0x274>
    if(*s == '/')
    80005c74:	fed71ce3          	bne	a4,a3,80005c6c <exec+0x262>
      last = s+1;
    80005c78:	def43423          	sd	a5,-536(s0)
    80005c7c:	bfc5                	j	80005c6c <exec+0x262>
  safestrcpy(p->name, last, sizeof(p->name));
    80005c7e:	4641                	li	a2,16
    80005c80:	de843583          	ld	a1,-536(s0)
    80005c84:	160b8513          	addi	a0,s7,352
    80005c88:	ffffb097          	auipc	ra,0xffffb
    80005c8c:	23a080e7          	jalr	570(ra) # 80000ec2 <safestrcpy>
  oldpagetable = p->pagetable;
    80005c90:	058bb503          	ld	a0,88(s7)
  p->pagetable = pagetable;
    80005c94:	056bbc23          	sd	s6,88(s7)
  p->sz = sz;
    80005c98:	df843783          	ld	a5,-520(s0)
    80005c9c:	04fbb823          	sd	a5,80(s7)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80005ca0:	060bb783          	ld	a5,96(s7)
    80005ca4:	e6843703          	ld	a4,-408(s0)
    80005ca8:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80005caa:	060bb783          	ld	a5,96(s7)
    80005cae:	0327b823          	sd	s2,48(a5)
  p->stack_sz = stack_sz;   // update this as the stack grows
    80005cb2:	0009f7b7          	lui	a5,0x9f
    80005cb6:	04fbb423          	sd	a5,72(s7)
  proc_freepagetable(oldpagetable, oldsz);
    80005cba:	85e6                	mv	a1,s9
    80005cbc:	ffffc097          	auipc	ra,0xffffc
    80005cc0:	ff6080e7          	jalr	-10(ra) # 80001cb2 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80005cc4:	0004851b          	sext.w	a0,s1
    80005cc8:	bbf9                	j	80005aa6 <exec+0x9c>
    80005cca:	df243c23          	sd	s2,-520(s0)
    proc_freepagetable(pagetable, sz);
    80005cce:	df843583          	ld	a1,-520(s0)
    80005cd2:	855a                	mv	a0,s6
    80005cd4:	ffffc097          	auipc	ra,0xffffc
    80005cd8:	fde080e7          	jalr	-34(ra) # 80001cb2 <proc_freepagetable>
  if(ip){
    80005cdc:	da0a9be3          	bnez	s5,80005a92 <exec+0x88>
  return -1;
    80005ce0:	557d                	li	a0,-1
    80005ce2:	b3d1                	j	80005aa6 <exec+0x9c>
    80005ce4:	df243c23          	sd	s2,-520(s0)
    80005ce8:	b7dd                	j	80005cce <exec+0x2c4>
    80005cea:	df243c23          	sd	s2,-520(s0)
    80005cee:	b7c5                	j	80005cce <exec+0x2c4>
    80005cf0:	df243c23          	sd	s2,-520(s0)
    80005cf4:	bfe9                	j	80005cce <exec+0x2c4>
    80005cf6:	df243c23          	sd	s2,-520(s0)
    80005cfa:	bfd1                	j	80005cce <exec+0x2c4>
  ip = 0;
    80005cfc:	4a81                	li	s5,0
    80005cfe:	bfc1                	j	80005cce <exec+0x2c4>
    80005d00:	4a81                	li	s5,0
    80005d02:	b7f1                	j	80005cce <exec+0x2c4>
    80005d04:	4a81                	li	s5,0
    80005d06:	b7e1                	j	80005cce <exec+0x2c4>
    80005d08:	4a81                	li	s5,0
    80005d0a:	b7d1                	j	80005cce <exec+0x2c4>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0) 
    80005d0c:	df843903          	ld	s2,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80005d10:	e0843783          	ld	a5,-504(s0)
    80005d14:	0017869b          	addiw	a3,a5,1
    80005d18:	e0d43423          	sd	a3,-504(s0)
    80005d1c:	e0043783          	ld	a5,-512(s0)
    80005d20:	0387879b          	addiw	a5,a5,56
    80005d24:	e8845703          	lhu	a4,-376(s0)
    80005d28:	e2e6dbe3          	bge	a3,a4,80005b5e <exec+0x154>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80005d2c:	2781                	sext.w	a5,a5
    80005d2e:	e0f43023          	sd	a5,-512(s0)
    80005d32:	03800713          	li	a4,56
    80005d36:	86be                	mv	a3,a5
    80005d38:	e1840613          	addi	a2,s0,-488
    80005d3c:	4581                	li	a1,0
    80005d3e:	8556                	mv	a0,s5
    80005d40:	fffff097          	auipc	ra,0xfffff
    80005d44:	a76080e7          	jalr	-1418(ra) # 800047b6 <readi>
    80005d48:	03800793          	li	a5,56
    80005d4c:	f6f51fe3          	bne	a0,a5,80005cca <exec+0x2c0>
    if(ph.type != ELF_PROG_LOAD)
    80005d50:	e1842783          	lw	a5,-488(s0)
    80005d54:	4705                	li	a4,1
    80005d56:	fae79de3          	bne	a5,a4,80005d10 <exec+0x306>
    if(ph.memsz < ph.filesz)
    80005d5a:	e4043483          	ld	s1,-448(s0)
    80005d5e:	e3843783          	ld	a5,-456(s0)
    80005d62:	f8f4e1e3          	bltu	s1,a5,80005ce4 <exec+0x2da>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80005d66:	e2843783          	ld	a5,-472(s0)
    80005d6a:	94be                	add	s1,s1,a5
    80005d6c:	f6f4efe3          	bltu	s1,a5,80005cea <exec+0x2e0>
    if(ph.vaddr % PGSIZE != 0)
    80005d70:	de043703          	ld	a4,-544(s0)
    80005d74:	8ff9                	and	a5,a5,a4
    80005d76:	ffad                	bnez	a5,80005cf0 <exec+0x2e6>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0) 
    80005d78:	e1c42503          	lw	a0,-484(s0)
    80005d7c:	00000097          	auipc	ra,0x0
    80005d80:	c72080e7          	jalr	-910(ra) # 800059ee <flags2perm>
    80005d84:	86aa                	mv	a3,a0
    80005d86:	8626                	mv	a2,s1
    80005d88:	85ca                	mv	a1,s2
    80005d8a:	855a                	mv	a0,s6
    80005d8c:	ffffb097          	auipc	ra,0xffffb
    80005d90:	72a080e7          	jalr	1834(ra) # 800014b6 <uvmalloc>
    80005d94:	dea43c23          	sd	a0,-520(s0)
    80005d98:	dd39                	beqz	a0,80005cf6 <exec+0x2ec>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0) 
    80005d9a:	e2843c03          	ld	s8,-472(s0)
    80005d9e:	e2042c83          	lw	s9,-480(s0)
    80005da2:	e3842b83          	lw	s7,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80005da6:	f60b83e3          	beqz	s7,80005d0c <exec+0x302>
    80005daa:	89de                	mv	s3,s7
    80005dac:	4481                	li	s1,0
    80005dae:	b379                	j	80005b3c <exec+0x132>

0000000080005db0 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80005db0:	7179                	addi	sp,sp,-48
    80005db2:	f406                	sd	ra,40(sp)
    80005db4:	f022                	sd	s0,32(sp)
    80005db6:	ec26                	sd	s1,24(sp)
    80005db8:	e84a                	sd	s2,16(sp)
    80005dba:	1800                	addi	s0,sp,48
    80005dbc:	892e                	mv	s2,a1
    80005dbe:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80005dc0:	fdc40593          	addi	a1,s0,-36
    80005dc4:	ffffe097          	auipc	ra,0xffffe
    80005dc8:	a08080e7          	jalr	-1528(ra) # 800037cc <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80005dcc:	fdc42703          	lw	a4,-36(s0)
    80005dd0:	47bd                	li	a5,15
    80005dd2:	02e7eb63          	bltu	a5,a4,80005e08 <argfd+0x58>
    80005dd6:	ffffc097          	auipc	ra,0xffffc
    80005dda:	d7c080e7          	jalr	-644(ra) # 80001b52 <myproc>
    80005dde:	fdc42703          	lw	a4,-36(s0)
    80005de2:	01a70793          	addi	a5,a4,26
    80005de6:	078e                	slli	a5,a5,0x3
    80005de8:	953e                	add	a0,a0,a5
    80005dea:	651c                	ld	a5,8(a0)
    80005dec:	c385                	beqz	a5,80005e0c <argfd+0x5c>
    return -1;
  if(pfd)
    80005dee:	00090463          	beqz	s2,80005df6 <argfd+0x46>
    *pfd = fd;
    80005df2:	00e92023          	sw	a4,0(s2) # 3000 <_entry-0x7fffd000>
  if(pf)
    *pf = f;
  return 0;
    80005df6:	4501                	li	a0,0
  if(pf)
    80005df8:	c091                	beqz	s1,80005dfc <argfd+0x4c>
    *pf = f;
    80005dfa:	e09c                	sd	a5,0(s1)
}
    80005dfc:	70a2                	ld	ra,40(sp)
    80005dfe:	7402                	ld	s0,32(sp)
    80005e00:	64e2                	ld	s1,24(sp)
    80005e02:	6942                	ld	s2,16(sp)
    80005e04:	6145                	addi	sp,sp,48
    80005e06:	8082                	ret
    return -1;
    80005e08:	557d                	li	a0,-1
    80005e0a:	bfcd                	j	80005dfc <argfd+0x4c>
    80005e0c:	557d                	li	a0,-1
    80005e0e:	b7fd                	j	80005dfc <argfd+0x4c>

0000000080005e10 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80005e10:	1101                	addi	sp,sp,-32
    80005e12:	ec06                	sd	ra,24(sp)
    80005e14:	e822                	sd	s0,16(sp)
    80005e16:	e426                	sd	s1,8(sp)
    80005e18:	1000                	addi	s0,sp,32
    80005e1a:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80005e1c:	ffffc097          	auipc	ra,0xffffc
    80005e20:	d36080e7          	jalr	-714(ra) # 80001b52 <myproc>
    80005e24:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80005e26:	0d850793          	addi	a5,a0,216
    80005e2a:	4501                	li	a0,0
    80005e2c:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80005e2e:	6398                	ld	a4,0(a5)
    80005e30:	cb19                	beqz	a4,80005e46 <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80005e32:	2505                	addiw	a0,a0,1
    80005e34:	07a1                	addi	a5,a5,8
    80005e36:	fed51ce3          	bne	a0,a3,80005e2e <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80005e3a:	557d                	li	a0,-1
}
    80005e3c:	60e2                	ld	ra,24(sp)
    80005e3e:	6442                	ld	s0,16(sp)
    80005e40:	64a2                	ld	s1,8(sp)
    80005e42:	6105                	addi	sp,sp,32
    80005e44:	8082                	ret
      p->ofile[fd] = f;
    80005e46:	01a50793          	addi	a5,a0,26
    80005e4a:	078e                	slli	a5,a5,0x3
    80005e4c:	963e                	add	a2,a2,a5
    80005e4e:	e604                	sd	s1,8(a2)
      return fd;
    80005e50:	b7f5                	j	80005e3c <fdalloc+0x2c>

0000000080005e52 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80005e52:	715d                	addi	sp,sp,-80
    80005e54:	e486                	sd	ra,72(sp)
    80005e56:	e0a2                	sd	s0,64(sp)
    80005e58:	fc26                	sd	s1,56(sp)
    80005e5a:	f84a                	sd	s2,48(sp)
    80005e5c:	f44e                	sd	s3,40(sp)
    80005e5e:	f052                	sd	s4,32(sp)
    80005e60:	ec56                	sd	s5,24(sp)
    80005e62:	e85a                	sd	s6,16(sp)
    80005e64:	0880                	addi	s0,sp,80
    80005e66:	8b2e                	mv	s6,a1
    80005e68:	89b2                	mv	s3,a2
    80005e6a:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80005e6c:	fb040593          	addi	a1,s0,-80
    80005e70:	fffff097          	auipc	ra,0xfffff
    80005e74:	e56080e7          	jalr	-426(ra) # 80004cc6 <nameiparent>
    80005e78:	84aa                	mv	s1,a0
    80005e7a:	14050f63          	beqz	a0,80005fd8 <create+0x186>
    return 0;

  ilock(dp);
    80005e7e:	ffffe097          	auipc	ra,0xffffe
    80005e82:	684080e7          	jalr	1668(ra) # 80004502 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80005e86:	4601                	li	a2,0
    80005e88:	fb040593          	addi	a1,s0,-80
    80005e8c:	8526                	mv	a0,s1
    80005e8e:	fffff097          	auipc	ra,0xfffff
    80005e92:	b58080e7          	jalr	-1192(ra) # 800049e6 <dirlookup>
    80005e96:	8aaa                	mv	s5,a0
    80005e98:	c931                	beqz	a0,80005eec <create+0x9a>
    iunlockput(dp);
    80005e9a:	8526                	mv	a0,s1
    80005e9c:	fffff097          	auipc	ra,0xfffff
    80005ea0:	8c8080e7          	jalr	-1848(ra) # 80004764 <iunlockput>
    ilock(ip);
    80005ea4:	8556                	mv	a0,s5
    80005ea6:	ffffe097          	auipc	ra,0xffffe
    80005eaa:	65c080e7          	jalr	1628(ra) # 80004502 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80005eae:	000b059b          	sext.w	a1,s6
    80005eb2:	4789                	li	a5,2
    80005eb4:	02f59563          	bne	a1,a5,80005ede <create+0x8c>
    80005eb8:	044ad783          	lhu	a5,68(s5)
    80005ebc:	37f9                	addiw	a5,a5,-2
    80005ebe:	17c2                	slli	a5,a5,0x30
    80005ec0:	93c1                	srli	a5,a5,0x30
    80005ec2:	4705                	li	a4,1
    80005ec4:	00f76d63          	bltu	a4,a5,80005ede <create+0x8c>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80005ec8:	8556                	mv	a0,s5
    80005eca:	60a6                	ld	ra,72(sp)
    80005ecc:	6406                	ld	s0,64(sp)
    80005ece:	74e2                	ld	s1,56(sp)
    80005ed0:	7942                	ld	s2,48(sp)
    80005ed2:	79a2                	ld	s3,40(sp)
    80005ed4:	7a02                	ld	s4,32(sp)
    80005ed6:	6ae2                	ld	s5,24(sp)
    80005ed8:	6b42                	ld	s6,16(sp)
    80005eda:	6161                	addi	sp,sp,80
    80005edc:	8082                	ret
    iunlockput(ip);
    80005ede:	8556                	mv	a0,s5
    80005ee0:	fffff097          	auipc	ra,0xfffff
    80005ee4:	884080e7          	jalr	-1916(ra) # 80004764 <iunlockput>
    return 0;
    80005ee8:	4a81                	li	s5,0
    80005eea:	bff9                	j	80005ec8 <create+0x76>
  if((ip = ialloc(dp->dev, type)) == 0){
    80005eec:	85da                	mv	a1,s6
    80005eee:	4088                	lw	a0,0(s1)
    80005ef0:	ffffe097          	auipc	ra,0xffffe
    80005ef4:	476080e7          	jalr	1142(ra) # 80004366 <ialloc>
    80005ef8:	8a2a                	mv	s4,a0
    80005efa:	c539                	beqz	a0,80005f48 <create+0xf6>
  ilock(ip);
    80005efc:	ffffe097          	auipc	ra,0xffffe
    80005f00:	606080e7          	jalr	1542(ra) # 80004502 <ilock>
  ip->major = major;
    80005f04:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    80005f08:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    80005f0c:	4905                	li	s2,1
    80005f0e:	052a1523          	sh	s2,74(s4)
  iupdate(ip);
    80005f12:	8552                	mv	a0,s4
    80005f14:	ffffe097          	auipc	ra,0xffffe
    80005f18:	524080e7          	jalr	1316(ra) # 80004438 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80005f1c:	000b059b          	sext.w	a1,s6
    80005f20:	03258b63          	beq	a1,s2,80005f56 <create+0x104>
  if(dirlink(dp, name, ip->inum) < 0)
    80005f24:	004a2603          	lw	a2,4(s4)
    80005f28:	fb040593          	addi	a1,s0,-80
    80005f2c:	8526                	mv	a0,s1
    80005f2e:	fffff097          	auipc	ra,0xfffff
    80005f32:	cc8080e7          	jalr	-824(ra) # 80004bf6 <dirlink>
    80005f36:	06054f63          	bltz	a0,80005fb4 <create+0x162>
  iunlockput(dp);
    80005f3a:	8526                	mv	a0,s1
    80005f3c:	fffff097          	auipc	ra,0xfffff
    80005f40:	828080e7          	jalr	-2008(ra) # 80004764 <iunlockput>
  return ip;
    80005f44:	8ad2                	mv	s5,s4
    80005f46:	b749                	j	80005ec8 <create+0x76>
    iunlockput(dp);
    80005f48:	8526                	mv	a0,s1
    80005f4a:	fffff097          	auipc	ra,0xfffff
    80005f4e:	81a080e7          	jalr	-2022(ra) # 80004764 <iunlockput>
    return 0;
    80005f52:	8ad2                	mv	s5,s4
    80005f54:	bf95                	j	80005ec8 <create+0x76>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80005f56:	004a2603          	lw	a2,4(s4)
    80005f5a:	00004597          	auipc	a1,0x4
    80005f5e:	a4e58593          	addi	a1,a1,-1458 # 800099a8 <syscalls+0x2d0>
    80005f62:	8552                	mv	a0,s4
    80005f64:	fffff097          	auipc	ra,0xfffff
    80005f68:	c92080e7          	jalr	-878(ra) # 80004bf6 <dirlink>
    80005f6c:	04054463          	bltz	a0,80005fb4 <create+0x162>
    80005f70:	40d0                	lw	a2,4(s1)
    80005f72:	00004597          	auipc	a1,0x4
    80005f76:	a3e58593          	addi	a1,a1,-1474 # 800099b0 <syscalls+0x2d8>
    80005f7a:	8552                	mv	a0,s4
    80005f7c:	fffff097          	auipc	ra,0xfffff
    80005f80:	c7a080e7          	jalr	-902(ra) # 80004bf6 <dirlink>
    80005f84:	02054863          	bltz	a0,80005fb4 <create+0x162>
  if(dirlink(dp, name, ip->inum) < 0)
    80005f88:	004a2603          	lw	a2,4(s4)
    80005f8c:	fb040593          	addi	a1,s0,-80
    80005f90:	8526                	mv	a0,s1
    80005f92:	fffff097          	auipc	ra,0xfffff
    80005f96:	c64080e7          	jalr	-924(ra) # 80004bf6 <dirlink>
    80005f9a:	00054d63          	bltz	a0,80005fb4 <create+0x162>
    dp->nlink++;  // for ".."
    80005f9e:	04a4d783          	lhu	a5,74(s1)
    80005fa2:	2785                	addiw	a5,a5,1
    80005fa4:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80005fa8:	8526                	mv	a0,s1
    80005faa:	ffffe097          	auipc	ra,0xffffe
    80005fae:	48e080e7          	jalr	1166(ra) # 80004438 <iupdate>
    80005fb2:	b761                	j	80005f3a <create+0xe8>
  ip->nlink = 0;
    80005fb4:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    80005fb8:	8552                	mv	a0,s4
    80005fba:	ffffe097          	auipc	ra,0xffffe
    80005fbe:	47e080e7          	jalr	1150(ra) # 80004438 <iupdate>
  iunlockput(ip);
    80005fc2:	8552                	mv	a0,s4
    80005fc4:	ffffe097          	auipc	ra,0xffffe
    80005fc8:	7a0080e7          	jalr	1952(ra) # 80004764 <iunlockput>
  iunlockput(dp);
    80005fcc:	8526                	mv	a0,s1
    80005fce:	ffffe097          	auipc	ra,0xffffe
    80005fd2:	796080e7          	jalr	1942(ra) # 80004764 <iunlockput>
  return 0;
    80005fd6:	bdcd                	j	80005ec8 <create+0x76>
    return 0;
    80005fd8:	8aaa                	mv	s5,a0
    80005fda:	b5fd                	j	80005ec8 <create+0x76>

0000000080005fdc <sys_dup>:
{
    80005fdc:	7179                	addi	sp,sp,-48
    80005fde:	f406                	sd	ra,40(sp)
    80005fe0:	f022                	sd	s0,32(sp)
    80005fe2:	ec26                	sd	s1,24(sp)
    80005fe4:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80005fe6:	fd840613          	addi	a2,s0,-40
    80005fea:	4581                	li	a1,0
    80005fec:	4501                	li	a0,0
    80005fee:	00000097          	auipc	ra,0x0
    80005ff2:	dc2080e7          	jalr	-574(ra) # 80005db0 <argfd>
    return -1;
    80005ff6:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80005ff8:	02054363          	bltz	a0,8000601e <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    80005ffc:	fd843503          	ld	a0,-40(s0)
    80006000:	00000097          	auipc	ra,0x0
    80006004:	e10080e7          	jalr	-496(ra) # 80005e10 <fdalloc>
    80006008:	84aa                	mv	s1,a0
    return -1;
    8000600a:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    8000600c:	00054963          	bltz	a0,8000601e <sys_dup+0x42>
  filedup(f);
    80006010:	fd843503          	ld	a0,-40(s0)
    80006014:	fffff097          	auipc	ra,0xfffff
    80006018:	32a080e7          	jalr	810(ra) # 8000533e <filedup>
  return fd;
    8000601c:	87a6                	mv	a5,s1
}
    8000601e:	853e                	mv	a0,a5
    80006020:	70a2                	ld	ra,40(sp)
    80006022:	7402                	ld	s0,32(sp)
    80006024:	64e2                	ld	s1,24(sp)
    80006026:	6145                	addi	sp,sp,48
    80006028:	8082                	ret

000000008000602a <sys_read>:
{
    8000602a:	7179                	addi	sp,sp,-48
    8000602c:	f406                	sd	ra,40(sp)
    8000602e:	f022                	sd	s0,32(sp)
    80006030:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80006032:	fd840593          	addi	a1,s0,-40
    80006036:	4505                	li	a0,1
    80006038:	ffffd097          	auipc	ra,0xffffd
    8000603c:	7b4080e7          	jalr	1972(ra) # 800037ec <argaddr>
  argint(2, &n);
    80006040:	fe440593          	addi	a1,s0,-28
    80006044:	4509                	li	a0,2
    80006046:	ffffd097          	auipc	ra,0xffffd
    8000604a:	786080e7          	jalr	1926(ra) # 800037cc <argint>
  if(argfd(0, 0, &f) < 0)
    8000604e:	fe840613          	addi	a2,s0,-24
    80006052:	4581                	li	a1,0
    80006054:	4501                	li	a0,0
    80006056:	00000097          	auipc	ra,0x0
    8000605a:	d5a080e7          	jalr	-678(ra) # 80005db0 <argfd>
    8000605e:	87aa                	mv	a5,a0
    return -1;
    80006060:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80006062:	0007cc63          	bltz	a5,8000607a <sys_read+0x50>
  return fileread(f, p, n);
    80006066:	fe442603          	lw	a2,-28(s0)
    8000606a:	fd843583          	ld	a1,-40(s0)
    8000606e:	fe843503          	ld	a0,-24(s0)
    80006072:	fffff097          	auipc	ra,0xfffff
    80006076:	458080e7          	jalr	1112(ra) # 800054ca <fileread>
}
    8000607a:	70a2                	ld	ra,40(sp)
    8000607c:	7402                	ld	s0,32(sp)
    8000607e:	6145                	addi	sp,sp,48
    80006080:	8082                	ret

0000000080006082 <sys_write>:
{
    80006082:	7179                	addi	sp,sp,-48
    80006084:	f406                	sd	ra,40(sp)
    80006086:	f022                	sd	s0,32(sp)
    80006088:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    8000608a:	fd840593          	addi	a1,s0,-40
    8000608e:	4505                	li	a0,1
    80006090:	ffffd097          	auipc	ra,0xffffd
    80006094:	75c080e7          	jalr	1884(ra) # 800037ec <argaddr>
  argint(2, &n);
    80006098:	fe440593          	addi	a1,s0,-28
    8000609c:	4509                	li	a0,2
    8000609e:	ffffd097          	auipc	ra,0xffffd
    800060a2:	72e080e7          	jalr	1838(ra) # 800037cc <argint>
  if(argfd(0, 0, &f) < 0)
    800060a6:	fe840613          	addi	a2,s0,-24
    800060aa:	4581                	li	a1,0
    800060ac:	4501                	li	a0,0
    800060ae:	00000097          	auipc	ra,0x0
    800060b2:	d02080e7          	jalr	-766(ra) # 80005db0 <argfd>
    800060b6:	87aa                	mv	a5,a0
    return -1;
    800060b8:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800060ba:	0007cc63          	bltz	a5,800060d2 <sys_write+0x50>
  return filewrite(f, p, n);
    800060be:	fe442603          	lw	a2,-28(s0)
    800060c2:	fd843583          	ld	a1,-40(s0)
    800060c6:	fe843503          	ld	a0,-24(s0)
    800060ca:	fffff097          	auipc	ra,0xfffff
    800060ce:	4c2080e7          	jalr	1218(ra) # 8000558c <filewrite>
}
    800060d2:	70a2                	ld	ra,40(sp)
    800060d4:	7402                	ld	s0,32(sp)
    800060d6:	6145                	addi	sp,sp,48
    800060d8:	8082                	ret

00000000800060da <sys_close>:
{
    800060da:	1101                	addi	sp,sp,-32
    800060dc:	ec06                	sd	ra,24(sp)
    800060de:	e822                	sd	s0,16(sp)
    800060e0:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800060e2:	fe040613          	addi	a2,s0,-32
    800060e6:	fec40593          	addi	a1,s0,-20
    800060ea:	4501                	li	a0,0
    800060ec:	00000097          	auipc	ra,0x0
    800060f0:	cc4080e7          	jalr	-828(ra) # 80005db0 <argfd>
    return -1;
    800060f4:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800060f6:	02054463          	bltz	a0,8000611e <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    800060fa:	ffffc097          	auipc	ra,0xffffc
    800060fe:	a58080e7          	jalr	-1448(ra) # 80001b52 <myproc>
    80006102:	fec42783          	lw	a5,-20(s0)
    80006106:	07e9                	addi	a5,a5,26
    80006108:	078e                	slli	a5,a5,0x3
    8000610a:	97aa                	add	a5,a5,a0
    8000610c:	0007b423          	sd	zero,8(a5) # 9f008 <_entry-0x7ff60ff8>
  fileclose(f);
    80006110:	fe043503          	ld	a0,-32(s0)
    80006114:	fffff097          	auipc	ra,0xfffff
    80006118:	27c080e7          	jalr	636(ra) # 80005390 <fileclose>
  return 0;
    8000611c:	4781                	li	a5,0
}
    8000611e:	853e                	mv	a0,a5
    80006120:	60e2                	ld	ra,24(sp)
    80006122:	6442                	ld	s0,16(sp)
    80006124:	6105                	addi	sp,sp,32
    80006126:	8082                	ret

0000000080006128 <sys_fstat>:
{
    80006128:	1101                	addi	sp,sp,-32
    8000612a:	ec06                	sd	ra,24(sp)
    8000612c:	e822                	sd	s0,16(sp)
    8000612e:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    80006130:	fe040593          	addi	a1,s0,-32
    80006134:	4505                	li	a0,1
    80006136:	ffffd097          	auipc	ra,0xffffd
    8000613a:	6b6080e7          	jalr	1718(ra) # 800037ec <argaddr>
  if(argfd(0, 0, &f) < 0)
    8000613e:	fe840613          	addi	a2,s0,-24
    80006142:	4581                	li	a1,0
    80006144:	4501                	li	a0,0
    80006146:	00000097          	auipc	ra,0x0
    8000614a:	c6a080e7          	jalr	-918(ra) # 80005db0 <argfd>
    8000614e:	87aa                	mv	a5,a0
    return -1;
    80006150:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80006152:	0007ca63          	bltz	a5,80006166 <sys_fstat+0x3e>
  return filestat(f, st);
    80006156:	fe043583          	ld	a1,-32(s0)
    8000615a:	fe843503          	ld	a0,-24(s0)
    8000615e:	fffff097          	auipc	ra,0xfffff
    80006162:	2fa080e7          	jalr	762(ra) # 80005458 <filestat>
}
    80006166:	60e2                	ld	ra,24(sp)
    80006168:	6442                	ld	s0,16(sp)
    8000616a:	6105                	addi	sp,sp,32
    8000616c:	8082                	ret

000000008000616e <sys_link>:
{
    8000616e:	7169                	addi	sp,sp,-304
    80006170:	f606                	sd	ra,296(sp)
    80006172:	f222                	sd	s0,288(sp)
    80006174:	ee26                	sd	s1,280(sp)
    80006176:	ea4a                	sd	s2,272(sp)
    80006178:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000617a:	08000613          	li	a2,128
    8000617e:	ed040593          	addi	a1,s0,-304
    80006182:	4501                	li	a0,0
    80006184:	ffffd097          	auipc	ra,0xffffd
    80006188:	688080e7          	jalr	1672(ra) # 8000380c <argstr>
    return -1;
    8000618c:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000618e:	10054e63          	bltz	a0,800062aa <sys_link+0x13c>
    80006192:	08000613          	li	a2,128
    80006196:	f5040593          	addi	a1,s0,-176
    8000619a:	4505                	li	a0,1
    8000619c:	ffffd097          	auipc	ra,0xffffd
    800061a0:	670080e7          	jalr	1648(ra) # 8000380c <argstr>
    return -1;
    800061a4:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800061a6:	10054263          	bltz	a0,800062aa <sys_link+0x13c>
  begin_op();
    800061aa:	fffff097          	auipc	ra,0xfffff
    800061ae:	d1a080e7          	jalr	-742(ra) # 80004ec4 <begin_op>
  if((ip = namei(old)) == 0){
    800061b2:	ed040513          	addi	a0,s0,-304
    800061b6:	fffff097          	auipc	ra,0xfffff
    800061ba:	af2080e7          	jalr	-1294(ra) # 80004ca8 <namei>
    800061be:	84aa                	mv	s1,a0
    800061c0:	c551                	beqz	a0,8000624c <sys_link+0xde>
  ilock(ip);
    800061c2:	ffffe097          	auipc	ra,0xffffe
    800061c6:	340080e7          	jalr	832(ra) # 80004502 <ilock>
  if(ip->type == T_DIR){
    800061ca:	04449703          	lh	a4,68(s1)
    800061ce:	4785                	li	a5,1
    800061d0:	08f70463          	beq	a4,a5,80006258 <sys_link+0xea>
  ip->nlink++;
    800061d4:	04a4d783          	lhu	a5,74(s1)
    800061d8:	2785                	addiw	a5,a5,1
    800061da:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800061de:	8526                	mv	a0,s1
    800061e0:	ffffe097          	auipc	ra,0xffffe
    800061e4:	258080e7          	jalr	600(ra) # 80004438 <iupdate>
  iunlock(ip);
    800061e8:	8526                	mv	a0,s1
    800061ea:	ffffe097          	auipc	ra,0xffffe
    800061ee:	3da080e7          	jalr	986(ra) # 800045c4 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    800061f2:	fd040593          	addi	a1,s0,-48
    800061f6:	f5040513          	addi	a0,s0,-176
    800061fa:	fffff097          	auipc	ra,0xfffff
    800061fe:	acc080e7          	jalr	-1332(ra) # 80004cc6 <nameiparent>
    80006202:	892a                	mv	s2,a0
    80006204:	c935                	beqz	a0,80006278 <sys_link+0x10a>
  ilock(dp);
    80006206:	ffffe097          	auipc	ra,0xffffe
    8000620a:	2fc080e7          	jalr	764(ra) # 80004502 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    8000620e:	00092703          	lw	a4,0(s2)
    80006212:	409c                	lw	a5,0(s1)
    80006214:	04f71d63          	bne	a4,a5,8000626e <sys_link+0x100>
    80006218:	40d0                	lw	a2,4(s1)
    8000621a:	fd040593          	addi	a1,s0,-48
    8000621e:	854a                	mv	a0,s2
    80006220:	fffff097          	auipc	ra,0xfffff
    80006224:	9d6080e7          	jalr	-1578(ra) # 80004bf6 <dirlink>
    80006228:	04054363          	bltz	a0,8000626e <sys_link+0x100>
  iunlockput(dp);
    8000622c:	854a                	mv	a0,s2
    8000622e:	ffffe097          	auipc	ra,0xffffe
    80006232:	536080e7          	jalr	1334(ra) # 80004764 <iunlockput>
  iput(ip);
    80006236:	8526                	mv	a0,s1
    80006238:	ffffe097          	auipc	ra,0xffffe
    8000623c:	484080e7          	jalr	1156(ra) # 800046bc <iput>
  end_op();
    80006240:	fffff097          	auipc	ra,0xfffff
    80006244:	d04080e7          	jalr	-764(ra) # 80004f44 <end_op>
  return 0;
    80006248:	4781                	li	a5,0
    8000624a:	a085                	j	800062aa <sys_link+0x13c>
    end_op();
    8000624c:	fffff097          	auipc	ra,0xfffff
    80006250:	cf8080e7          	jalr	-776(ra) # 80004f44 <end_op>
    return -1;
    80006254:	57fd                	li	a5,-1
    80006256:	a891                	j	800062aa <sys_link+0x13c>
    iunlockput(ip);
    80006258:	8526                	mv	a0,s1
    8000625a:	ffffe097          	auipc	ra,0xffffe
    8000625e:	50a080e7          	jalr	1290(ra) # 80004764 <iunlockput>
    end_op();
    80006262:	fffff097          	auipc	ra,0xfffff
    80006266:	ce2080e7          	jalr	-798(ra) # 80004f44 <end_op>
    return -1;
    8000626a:	57fd                	li	a5,-1
    8000626c:	a83d                	j	800062aa <sys_link+0x13c>
    iunlockput(dp);
    8000626e:	854a                	mv	a0,s2
    80006270:	ffffe097          	auipc	ra,0xffffe
    80006274:	4f4080e7          	jalr	1268(ra) # 80004764 <iunlockput>
  ilock(ip);
    80006278:	8526                	mv	a0,s1
    8000627a:	ffffe097          	auipc	ra,0xffffe
    8000627e:	288080e7          	jalr	648(ra) # 80004502 <ilock>
  ip->nlink--;
    80006282:	04a4d783          	lhu	a5,74(s1)
    80006286:	37fd                	addiw	a5,a5,-1
    80006288:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    8000628c:	8526                	mv	a0,s1
    8000628e:	ffffe097          	auipc	ra,0xffffe
    80006292:	1aa080e7          	jalr	426(ra) # 80004438 <iupdate>
  iunlockput(ip);
    80006296:	8526                	mv	a0,s1
    80006298:	ffffe097          	auipc	ra,0xffffe
    8000629c:	4cc080e7          	jalr	1228(ra) # 80004764 <iunlockput>
  end_op();
    800062a0:	fffff097          	auipc	ra,0xfffff
    800062a4:	ca4080e7          	jalr	-860(ra) # 80004f44 <end_op>
  return -1;
    800062a8:	57fd                	li	a5,-1
}
    800062aa:	853e                	mv	a0,a5
    800062ac:	70b2                	ld	ra,296(sp)
    800062ae:	7412                	ld	s0,288(sp)
    800062b0:	64f2                	ld	s1,280(sp)
    800062b2:	6952                	ld	s2,272(sp)
    800062b4:	6155                	addi	sp,sp,304
    800062b6:	8082                	ret

00000000800062b8 <sys_unlink>:
{
    800062b8:	7151                	addi	sp,sp,-240
    800062ba:	f586                	sd	ra,232(sp)
    800062bc:	f1a2                	sd	s0,224(sp)
    800062be:	eda6                	sd	s1,216(sp)
    800062c0:	e9ca                	sd	s2,208(sp)
    800062c2:	e5ce                	sd	s3,200(sp)
    800062c4:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    800062c6:	08000613          	li	a2,128
    800062ca:	f3040593          	addi	a1,s0,-208
    800062ce:	4501                	li	a0,0
    800062d0:	ffffd097          	auipc	ra,0xffffd
    800062d4:	53c080e7          	jalr	1340(ra) # 8000380c <argstr>
    800062d8:	18054163          	bltz	a0,8000645a <sys_unlink+0x1a2>
  begin_op();
    800062dc:	fffff097          	auipc	ra,0xfffff
    800062e0:	be8080e7          	jalr	-1048(ra) # 80004ec4 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800062e4:	fb040593          	addi	a1,s0,-80
    800062e8:	f3040513          	addi	a0,s0,-208
    800062ec:	fffff097          	auipc	ra,0xfffff
    800062f0:	9da080e7          	jalr	-1574(ra) # 80004cc6 <nameiparent>
    800062f4:	84aa                	mv	s1,a0
    800062f6:	c979                	beqz	a0,800063cc <sys_unlink+0x114>
  ilock(dp);
    800062f8:	ffffe097          	auipc	ra,0xffffe
    800062fc:	20a080e7          	jalr	522(ra) # 80004502 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80006300:	00003597          	auipc	a1,0x3
    80006304:	6a858593          	addi	a1,a1,1704 # 800099a8 <syscalls+0x2d0>
    80006308:	fb040513          	addi	a0,s0,-80
    8000630c:	ffffe097          	auipc	ra,0xffffe
    80006310:	6c0080e7          	jalr	1728(ra) # 800049cc <namecmp>
    80006314:	14050a63          	beqz	a0,80006468 <sys_unlink+0x1b0>
    80006318:	00003597          	auipc	a1,0x3
    8000631c:	69858593          	addi	a1,a1,1688 # 800099b0 <syscalls+0x2d8>
    80006320:	fb040513          	addi	a0,s0,-80
    80006324:	ffffe097          	auipc	ra,0xffffe
    80006328:	6a8080e7          	jalr	1704(ra) # 800049cc <namecmp>
    8000632c:	12050e63          	beqz	a0,80006468 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80006330:	f2c40613          	addi	a2,s0,-212
    80006334:	fb040593          	addi	a1,s0,-80
    80006338:	8526                	mv	a0,s1
    8000633a:	ffffe097          	auipc	ra,0xffffe
    8000633e:	6ac080e7          	jalr	1708(ra) # 800049e6 <dirlookup>
    80006342:	892a                	mv	s2,a0
    80006344:	12050263          	beqz	a0,80006468 <sys_unlink+0x1b0>
  ilock(ip);
    80006348:	ffffe097          	auipc	ra,0xffffe
    8000634c:	1ba080e7          	jalr	442(ra) # 80004502 <ilock>
  if(ip->nlink < 1)
    80006350:	04a91783          	lh	a5,74(s2)
    80006354:	08f05263          	blez	a5,800063d8 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80006358:	04491703          	lh	a4,68(s2)
    8000635c:	4785                	li	a5,1
    8000635e:	08f70563          	beq	a4,a5,800063e8 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80006362:	4641                	li	a2,16
    80006364:	4581                	li	a1,0
    80006366:	fc040513          	addi	a0,s0,-64
    8000636a:	ffffb097          	auipc	ra,0xffffb
    8000636e:	a0e080e7          	jalr	-1522(ra) # 80000d78 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80006372:	4741                	li	a4,16
    80006374:	f2c42683          	lw	a3,-212(s0)
    80006378:	fc040613          	addi	a2,s0,-64
    8000637c:	4581                	li	a1,0
    8000637e:	8526                	mv	a0,s1
    80006380:	ffffe097          	auipc	ra,0xffffe
    80006384:	52e080e7          	jalr	1326(ra) # 800048ae <writei>
    80006388:	47c1                	li	a5,16
    8000638a:	0af51563          	bne	a0,a5,80006434 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    8000638e:	04491703          	lh	a4,68(s2)
    80006392:	4785                	li	a5,1
    80006394:	0af70863          	beq	a4,a5,80006444 <sys_unlink+0x18c>
  iunlockput(dp);
    80006398:	8526                	mv	a0,s1
    8000639a:	ffffe097          	auipc	ra,0xffffe
    8000639e:	3ca080e7          	jalr	970(ra) # 80004764 <iunlockput>
  ip->nlink--;
    800063a2:	04a95783          	lhu	a5,74(s2)
    800063a6:	37fd                	addiw	a5,a5,-1
    800063a8:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    800063ac:	854a                	mv	a0,s2
    800063ae:	ffffe097          	auipc	ra,0xffffe
    800063b2:	08a080e7          	jalr	138(ra) # 80004438 <iupdate>
  iunlockput(ip);
    800063b6:	854a                	mv	a0,s2
    800063b8:	ffffe097          	auipc	ra,0xffffe
    800063bc:	3ac080e7          	jalr	940(ra) # 80004764 <iunlockput>
  end_op();
    800063c0:	fffff097          	auipc	ra,0xfffff
    800063c4:	b84080e7          	jalr	-1148(ra) # 80004f44 <end_op>
  return 0;
    800063c8:	4501                	li	a0,0
    800063ca:	a84d                	j	8000647c <sys_unlink+0x1c4>
    end_op();
    800063cc:	fffff097          	auipc	ra,0xfffff
    800063d0:	b78080e7          	jalr	-1160(ra) # 80004f44 <end_op>
    return -1;
    800063d4:	557d                	li	a0,-1
    800063d6:	a05d                	j	8000647c <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    800063d8:	00003517          	auipc	a0,0x3
    800063dc:	5e050513          	addi	a0,a0,1504 # 800099b8 <syscalls+0x2e0>
    800063e0:	ffffa097          	auipc	ra,0xffffa
    800063e4:	15c080e7          	jalr	348(ra) # 8000053c <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800063e8:	04c92703          	lw	a4,76(s2)
    800063ec:	02000793          	li	a5,32
    800063f0:	f6e7f9e3          	bgeu	a5,a4,80006362 <sys_unlink+0xaa>
    800063f4:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800063f8:	4741                	li	a4,16
    800063fa:	86ce                	mv	a3,s3
    800063fc:	f1840613          	addi	a2,s0,-232
    80006400:	4581                	li	a1,0
    80006402:	854a                	mv	a0,s2
    80006404:	ffffe097          	auipc	ra,0xffffe
    80006408:	3b2080e7          	jalr	946(ra) # 800047b6 <readi>
    8000640c:	47c1                	li	a5,16
    8000640e:	00f51b63          	bne	a0,a5,80006424 <sys_unlink+0x16c>
    if(de.inum != 0)
    80006412:	f1845783          	lhu	a5,-232(s0)
    80006416:	e7a1                	bnez	a5,8000645e <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80006418:	29c1                	addiw	s3,s3,16
    8000641a:	04c92783          	lw	a5,76(s2)
    8000641e:	fcf9ede3          	bltu	s3,a5,800063f8 <sys_unlink+0x140>
    80006422:	b781                	j	80006362 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80006424:	00003517          	auipc	a0,0x3
    80006428:	5ac50513          	addi	a0,a0,1452 # 800099d0 <syscalls+0x2f8>
    8000642c:	ffffa097          	auipc	ra,0xffffa
    80006430:	110080e7          	jalr	272(ra) # 8000053c <panic>
    panic("unlink: writei");
    80006434:	00003517          	auipc	a0,0x3
    80006438:	5b450513          	addi	a0,a0,1460 # 800099e8 <syscalls+0x310>
    8000643c:	ffffa097          	auipc	ra,0xffffa
    80006440:	100080e7          	jalr	256(ra) # 8000053c <panic>
    dp->nlink--;
    80006444:	04a4d783          	lhu	a5,74(s1)
    80006448:	37fd                	addiw	a5,a5,-1
    8000644a:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    8000644e:	8526                	mv	a0,s1
    80006450:	ffffe097          	auipc	ra,0xffffe
    80006454:	fe8080e7          	jalr	-24(ra) # 80004438 <iupdate>
    80006458:	b781                	j	80006398 <sys_unlink+0xe0>
    return -1;
    8000645a:	557d                	li	a0,-1
    8000645c:	a005                	j	8000647c <sys_unlink+0x1c4>
    iunlockput(ip);
    8000645e:	854a                	mv	a0,s2
    80006460:	ffffe097          	auipc	ra,0xffffe
    80006464:	304080e7          	jalr	772(ra) # 80004764 <iunlockput>
  iunlockput(dp);
    80006468:	8526                	mv	a0,s1
    8000646a:	ffffe097          	auipc	ra,0xffffe
    8000646e:	2fa080e7          	jalr	762(ra) # 80004764 <iunlockput>
  end_op();
    80006472:	fffff097          	auipc	ra,0xfffff
    80006476:	ad2080e7          	jalr	-1326(ra) # 80004f44 <end_op>
  return -1;
    8000647a:	557d                	li	a0,-1
}
    8000647c:	70ae                	ld	ra,232(sp)
    8000647e:	740e                	ld	s0,224(sp)
    80006480:	64ee                	ld	s1,216(sp)
    80006482:	694e                	ld	s2,208(sp)
    80006484:	69ae                	ld	s3,200(sp)
    80006486:	616d                	addi	sp,sp,240
    80006488:	8082                	ret

000000008000648a <sys_open>:

uint64
sys_open(void)
{
    8000648a:	7131                	addi	sp,sp,-192
    8000648c:	fd06                	sd	ra,184(sp)
    8000648e:	f922                	sd	s0,176(sp)
    80006490:	f526                	sd	s1,168(sp)
    80006492:	f14a                	sd	s2,160(sp)
    80006494:	ed4e                	sd	s3,152(sp)
    80006496:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80006498:	f4c40593          	addi	a1,s0,-180
    8000649c:	4505                	li	a0,1
    8000649e:	ffffd097          	auipc	ra,0xffffd
    800064a2:	32e080e7          	jalr	814(ra) # 800037cc <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    800064a6:	08000613          	li	a2,128
    800064aa:	f5040593          	addi	a1,s0,-176
    800064ae:	4501                	li	a0,0
    800064b0:	ffffd097          	auipc	ra,0xffffd
    800064b4:	35c080e7          	jalr	860(ra) # 8000380c <argstr>
    800064b8:	87aa                	mv	a5,a0
    return -1;
    800064ba:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    800064bc:	0a07c963          	bltz	a5,8000656e <sys_open+0xe4>

  begin_op();
    800064c0:	fffff097          	auipc	ra,0xfffff
    800064c4:	a04080e7          	jalr	-1532(ra) # 80004ec4 <begin_op>

  if(omode & O_CREATE){
    800064c8:	f4c42783          	lw	a5,-180(s0)
    800064cc:	2007f793          	andi	a5,a5,512
    800064d0:	cfc5                	beqz	a5,80006588 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    800064d2:	4681                	li	a3,0
    800064d4:	4601                	li	a2,0
    800064d6:	4589                	li	a1,2
    800064d8:	f5040513          	addi	a0,s0,-176
    800064dc:	00000097          	auipc	ra,0x0
    800064e0:	976080e7          	jalr	-1674(ra) # 80005e52 <create>
    800064e4:	84aa                	mv	s1,a0
    if(ip == 0){
    800064e6:	c959                	beqz	a0,8000657c <sys_open+0xf2>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    800064e8:	04449703          	lh	a4,68(s1)
    800064ec:	478d                	li	a5,3
    800064ee:	00f71763          	bne	a4,a5,800064fc <sys_open+0x72>
    800064f2:	0464d703          	lhu	a4,70(s1)
    800064f6:	47a5                	li	a5,9
    800064f8:	0ce7ed63          	bltu	a5,a4,800065d2 <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    800064fc:	fffff097          	auipc	ra,0xfffff
    80006500:	dd8080e7          	jalr	-552(ra) # 800052d4 <filealloc>
    80006504:	89aa                	mv	s3,a0
    80006506:	10050363          	beqz	a0,8000660c <sys_open+0x182>
    8000650a:	00000097          	auipc	ra,0x0
    8000650e:	906080e7          	jalr	-1786(ra) # 80005e10 <fdalloc>
    80006512:	892a                	mv	s2,a0
    80006514:	0e054763          	bltz	a0,80006602 <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80006518:	04449703          	lh	a4,68(s1)
    8000651c:	478d                	li	a5,3
    8000651e:	0cf70563          	beq	a4,a5,800065e8 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80006522:	4789                	li	a5,2
    80006524:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80006528:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    8000652c:	0099bc23          	sd	s1,24(s3)
  f->readable = !(omode & O_WRONLY);
    80006530:	f4c42783          	lw	a5,-180(s0)
    80006534:	0017c713          	xori	a4,a5,1
    80006538:	8b05                	andi	a4,a4,1
    8000653a:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000653e:	0037f713          	andi	a4,a5,3
    80006542:	00e03733          	snez	a4,a4
    80006546:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    8000654a:	4007f793          	andi	a5,a5,1024
    8000654e:	c791                	beqz	a5,8000655a <sys_open+0xd0>
    80006550:	04449703          	lh	a4,68(s1)
    80006554:	4789                	li	a5,2
    80006556:	0af70063          	beq	a4,a5,800065f6 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    8000655a:	8526                	mv	a0,s1
    8000655c:	ffffe097          	auipc	ra,0xffffe
    80006560:	068080e7          	jalr	104(ra) # 800045c4 <iunlock>
  end_op();
    80006564:	fffff097          	auipc	ra,0xfffff
    80006568:	9e0080e7          	jalr	-1568(ra) # 80004f44 <end_op>

  return fd;
    8000656c:	854a                	mv	a0,s2
}
    8000656e:	70ea                	ld	ra,184(sp)
    80006570:	744a                	ld	s0,176(sp)
    80006572:	74aa                	ld	s1,168(sp)
    80006574:	790a                	ld	s2,160(sp)
    80006576:	69ea                	ld	s3,152(sp)
    80006578:	6129                	addi	sp,sp,192
    8000657a:	8082                	ret
      end_op();
    8000657c:	fffff097          	auipc	ra,0xfffff
    80006580:	9c8080e7          	jalr	-1592(ra) # 80004f44 <end_op>
      return -1;
    80006584:	557d                	li	a0,-1
    80006586:	b7e5                	j	8000656e <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80006588:	f5040513          	addi	a0,s0,-176
    8000658c:	ffffe097          	auipc	ra,0xffffe
    80006590:	71c080e7          	jalr	1820(ra) # 80004ca8 <namei>
    80006594:	84aa                	mv	s1,a0
    80006596:	c905                	beqz	a0,800065c6 <sys_open+0x13c>
    ilock(ip);
    80006598:	ffffe097          	auipc	ra,0xffffe
    8000659c:	f6a080e7          	jalr	-150(ra) # 80004502 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    800065a0:	04449703          	lh	a4,68(s1)
    800065a4:	4785                	li	a5,1
    800065a6:	f4f711e3          	bne	a4,a5,800064e8 <sys_open+0x5e>
    800065aa:	f4c42783          	lw	a5,-180(s0)
    800065ae:	d7b9                	beqz	a5,800064fc <sys_open+0x72>
      iunlockput(ip);
    800065b0:	8526                	mv	a0,s1
    800065b2:	ffffe097          	auipc	ra,0xffffe
    800065b6:	1b2080e7          	jalr	434(ra) # 80004764 <iunlockput>
      end_op();
    800065ba:	fffff097          	auipc	ra,0xfffff
    800065be:	98a080e7          	jalr	-1654(ra) # 80004f44 <end_op>
      return -1;
    800065c2:	557d                	li	a0,-1
    800065c4:	b76d                	j	8000656e <sys_open+0xe4>
      end_op();
    800065c6:	fffff097          	auipc	ra,0xfffff
    800065ca:	97e080e7          	jalr	-1666(ra) # 80004f44 <end_op>
      return -1;
    800065ce:	557d                	li	a0,-1
    800065d0:	bf79                	j	8000656e <sys_open+0xe4>
    iunlockput(ip);
    800065d2:	8526                	mv	a0,s1
    800065d4:	ffffe097          	auipc	ra,0xffffe
    800065d8:	190080e7          	jalr	400(ra) # 80004764 <iunlockput>
    end_op();
    800065dc:	fffff097          	auipc	ra,0xfffff
    800065e0:	968080e7          	jalr	-1688(ra) # 80004f44 <end_op>
    return -1;
    800065e4:	557d                	li	a0,-1
    800065e6:	b761                	j	8000656e <sys_open+0xe4>
    f->type = FD_DEVICE;
    800065e8:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    800065ec:	04649783          	lh	a5,70(s1)
    800065f0:	02f99223          	sh	a5,36(s3)
    800065f4:	bf25                	j	8000652c <sys_open+0xa2>
    itrunc(ip);
    800065f6:	8526                	mv	a0,s1
    800065f8:	ffffe097          	auipc	ra,0xffffe
    800065fc:	018080e7          	jalr	24(ra) # 80004610 <itrunc>
    80006600:	bfa9                	j	8000655a <sys_open+0xd0>
      fileclose(f);
    80006602:	854e                	mv	a0,s3
    80006604:	fffff097          	auipc	ra,0xfffff
    80006608:	d8c080e7          	jalr	-628(ra) # 80005390 <fileclose>
    iunlockput(ip);
    8000660c:	8526                	mv	a0,s1
    8000660e:	ffffe097          	auipc	ra,0xffffe
    80006612:	156080e7          	jalr	342(ra) # 80004764 <iunlockput>
    end_op();
    80006616:	fffff097          	auipc	ra,0xfffff
    8000661a:	92e080e7          	jalr	-1746(ra) # 80004f44 <end_op>
    return -1;
    8000661e:	557d                	li	a0,-1
    80006620:	b7b9                	j	8000656e <sys_open+0xe4>

0000000080006622 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80006622:	7175                	addi	sp,sp,-144
    80006624:	e506                	sd	ra,136(sp)
    80006626:	e122                	sd	s0,128(sp)
    80006628:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    8000662a:	fffff097          	auipc	ra,0xfffff
    8000662e:	89a080e7          	jalr	-1894(ra) # 80004ec4 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80006632:	08000613          	li	a2,128
    80006636:	f7040593          	addi	a1,s0,-144
    8000663a:	4501                	li	a0,0
    8000663c:	ffffd097          	auipc	ra,0xffffd
    80006640:	1d0080e7          	jalr	464(ra) # 8000380c <argstr>
    80006644:	02054963          	bltz	a0,80006676 <sys_mkdir+0x54>
    80006648:	4681                	li	a3,0
    8000664a:	4601                	li	a2,0
    8000664c:	4585                	li	a1,1
    8000664e:	f7040513          	addi	a0,s0,-144
    80006652:	00000097          	auipc	ra,0x0
    80006656:	800080e7          	jalr	-2048(ra) # 80005e52 <create>
    8000665a:	cd11                	beqz	a0,80006676 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    8000665c:	ffffe097          	auipc	ra,0xffffe
    80006660:	108080e7          	jalr	264(ra) # 80004764 <iunlockput>
  end_op();
    80006664:	fffff097          	auipc	ra,0xfffff
    80006668:	8e0080e7          	jalr	-1824(ra) # 80004f44 <end_op>
  return 0;
    8000666c:	4501                	li	a0,0
}
    8000666e:	60aa                	ld	ra,136(sp)
    80006670:	640a                	ld	s0,128(sp)
    80006672:	6149                	addi	sp,sp,144
    80006674:	8082                	ret
    end_op();
    80006676:	fffff097          	auipc	ra,0xfffff
    8000667a:	8ce080e7          	jalr	-1842(ra) # 80004f44 <end_op>
    return -1;
    8000667e:	557d                	li	a0,-1
    80006680:	b7fd                	j	8000666e <sys_mkdir+0x4c>

0000000080006682 <sys_mknod>:

uint64
sys_mknod(void)
{
    80006682:	7135                	addi	sp,sp,-160
    80006684:	ed06                	sd	ra,152(sp)
    80006686:	e922                	sd	s0,144(sp)
    80006688:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    8000668a:	fffff097          	auipc	ra,0xfffff
    8000668e:	83a080e7          	jalr	-1990(ra) # 80004ec4 <begin_op>
  argint(1, &major);
    80006692:	f6c40593          	addi	a1,s0,-148
    80006696:	4505                	li	a0,1
    80006698:	ffffd097          	auipc	ra,0xffffd
    8000669c:	134080e7          	jalr	308(ra) # 800037cc <argint>
  argint(2, &minor);
    800066a0:	f6840593          	addi	a1,s0,-152
    800066a4:	4509                	li	a0,2
    800066a6:	ffffd097          	auipc	ra,0xffffd
    800066aa:	126080e7          	jalr	294(ra) # 800037cc <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    800066ae:	08000613          	li	a2,128
    800066b2:	f7040593          	addi	a1,s0,-144
    800066b6:	4501                	li	a0,0
    800066b8:	ffffd097          	auipc	ra,0xffffd
    800066bc:	154080e7          	jalr	340(ra) # 8000380c <argstr>
    800066c0:	02054b63          	bltz	a0,800066f6 <sys_mknod+0x74>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    800066c4:	f6841683          	lh	a3,-152(s0)
    800066c8:	f6c41603          	lh	a2,-148(s0)
    800066cc:	458d                	li	a1,3
    800066ce:	f7040513          	addi	a0,s0,-144
    800066d2:	fffff097          	auipc	ra,0xfffff
    800066d6:	780080e7          	jalr	1920(ra) # 80005e52 <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    800066da:	cd11                	beqz	a0,800066f6 <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    800066dc:	ffffe097          	auipc	ra,0xffffe
    800066e0:	088080e7          	jalr	136(ra) # 80004764 <iunlockput>
  end_op();
    800066e4:	fffff097          	auipc	ra,0xfffff
    800066e8:	860080e7          	jalr	-1952(ra) # 80004f44 <end_op>
  return 0;
    800066ec:	4501                	li	a0,0
}
    800066ee:	60ea                	ld	ra,152(sp)
    800066f0:	644a                	ld	s0,144(sp)
    800066f2:	610d                	addi	sp,sp,160
    800066f4:	8082                	ret
    end_op();
    800066f6:	fffff097          	auipc	ra,0xfffff
    800066fa:	84e080e7          	jalr	-1970(ra) # 80004f44 <end_op>
    return -1;
    800066fe:	557d                	li	a0,-1
    80006700:	b7fd                	j	800066ee <sys_mknod+0x6c>

0000000080006702 <sys_chdir>:

uint64
sys_chdir(void)
{
    80006702:	7135                	addi	sp,sp,-160
    80006704:	ed06                	sd	ra,152(sp)
    80006706:	e922                	sd	s0,144(sp)
    80006708:	e526                	sd	s1,136(sp)
    8000670a:	e14a                	sd	s2,128(sp)
    8000670c:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    8000670e:	ffffb097          	auipc	ra,0xffffb
    80006712:	444080e7          	jalr	1092(ra) # 80001b52 <myproc>
    80006716:	892a                	mv	s2,a0
  
  begin_op();
    80006718:	ffffe097          	auipc	ra,0xffffe
    8000671c:	7ac080e7          	jalr	1964(ra) # 80004ec4 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80006720:	08000613          	li	a2,128
    80006724:	f6040593          	addi	a1,s0,-160
    80006728:	4501                	li	a0,0
    8000672a:	ffffd097          	auipc	ra,0xffffd
    8000672e:	0e2080e7          	jalr	226(ra) # 8000380c <argstr>
    80006732:	04054b63          	bltz	a0,80006788 <sys_chdir+0x86>
    80006736:	f6040513          	addi	a0,s0,-160
    8000673a:	ffffe097          	auipc	ra,0xffffe
    8000673e:	56e080e7          	jalr	1390(ra) # 80004ca8 <namei>
    80006742:	84aa                	mv	s1,a0
    80006744:	c131                	beqz	a0,80006788 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80006746:	ffffe097          	auipc	ra,0xffffe
    8000674a:	dbc080e7          	jalr	-580(ra) # 80004502 <ilock>
  if(ip->type != T_DIR){
    8000674e:	04449703          	lh	a4,68(s1)
    80006752:	4785                	li	a5,1
    80006754:	04f71063          	bne	a4,a5,80006794 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80006758:	8526                	mv	a0,s1
    8000675a:	ffffe097          	auipc	ra,0xffffe
    8000675e:	e6a080e7          	jalr	-406(ra) # 800045c4 <iunlock>
  iput(p->cwd);
    80006762:	15893503          	ld	a0,344(s2)
    80006766:	ffffe097          	auipc	ra,0xffffe
    8000676a:	f56080e7          	jalr	-170(ra) # 800046bc <iput>
  end_op();
    8000676e:	ffffe097          	auipc	ra,0xffffe
    80006772:	7d6080e7          	jalr	2006(ra) # 80004f44 <end_op>
  p->cwd = ip;
    80006776:	14993c23          	sd	s1,344(s2)
  return 0;
    8000677a:	4501                	li	a0,0
}
    8000677c:	60ea                	ld	ra,152(sp)
    8000677e:	644a                	ld	s0,144(sp)
    80006780:	64aa                	ld	s1,136(sp)
    80006782:	690a                	ld	s2,128(sp)
    80006784:	610d                	addi	sp,sp,160
    80006786:	8082                	ret
    end_op();
    80006788:	ffffe097          	auipc	ra,0xffffe
    8000678c:	7bc080e7          	jalr	1980(ra) # 80004f44 <end_op>
    return -1;
    80006790:	557d                	li	a0,-1
    80006792:	b7ed                	j	8000677c <sys_chdir+0x7a>
    iunlockput(ip);
    80006794:	8526                	mv	a0,s1
    80006796:	ffffe097          	auipc	ra,0xffffe
    8000679a:	fce080e7          	jalr	-50(ra) # 80004764 <iunlockput>
    end_op();
    8000679e:	ffffe097          	auipc	ra,0xffffe
    800067a2:	7a6080e7          	jalr	1958(ra) # 80004f44 <end_op>
    return -1;
    800067a6:	557d                	li	a0,-1
    800067a8:	bfd1                	j	8000677c <sys_chdir+0x7a>

00000000800067aa <sys_exec>:

uint64
sys_exec(void)
{
    800067aa:	7145                	addi	sp,sp,-464
    800067ac:	e786                	sd	ra,456(sp)
    800067ae:	e3a2                	sd	s0,448(sp)
    800067b0:	ff26                	sd	s1,440(sp)
    800067b2:	fb4a                	sd	s2,432(sp)
    800067b4:	f74e                	sd	s3,424(sp)
    800067b6:	f352                	sd	s4,416(sp)
    800067b8:	ef56                	sd	s5,408(sp)
    800067ba:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    800067bc:	e3840593          	addi	a1,s0,-456
    800067c0:	4505                	li	a0,1
    800067c2:	ffffd097          	auipc	ra,0xffffd
    800067c6:	02a080e7          	jalr	42(ra) # 800037ec <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    800067ca:	08000613          	li	a2,128
    800067ce:	f4040593          	addi	a1,s0,-192
    800067d2:	4501                	li	a0,0
    800067d4:	ffffd097          	auipc	ra,0xffffd
    800067d8:	038080e7          	jalr	56(ra) # 8000380c <argstr>
    800067dc:	87aa                	mv	a5,a0
    return -1;
    800067de:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    800067e0:	0c07c263          	bltz	a5,800068a4 <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    800067e4:	10000613          	li	a2,256
    800067e8:	4581                	li	a1,0
    800067ea:	e4040513          	addi	a0,s0,-448
    800067ee:	ffffa097          	auipc	ra,0xffffa
    800067f2:	58a080e7          	jalr	1418(ra) # 80000d78 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    800067f6:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    800067fa:	89a6                	mv	s3,s1
    800067fc:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    800067fe:	02000a13          	li	s4,32
    80006802:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80006806:	00391793          	slli	a5,s2,0x3
    8000680a:	e3040593          	addi	a1,s0,-464
    8000680e:	e3843503          	ld	a0,-456(s0)
    80006812:	953e                	add	a0,a0,a5
    80006814:	ffffd097          	auipc	ra,0xffffd
    80006818:	ec6080e7          	jalr	-314(ra) # 800036da <fetchaddr>
    8000681c:	02054a63          	bltz	a0,80006850 <sys_exec+0xa6>
      goto bad;
    }
    if(uarg == 0){
    80006820:	e3043783          	ld	a5,-464(s0)
    80006824:	c3b9                	beqz	a5,8000686a <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80006826:	ffffa097          	auipc	ra,0xffffa
    8000682a:	366080e7          	jalr	870(ra) # 80000b8c <kalloc>
    8000682e:	85aa                	mv	a1,a0
    80006830:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80006834:	cd11                	beqz	a0,80006850 <sys_exec+0xa6>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80006836:	6605                	lui	a2,0x1
    80006838:	e3043503          	ld	a0,-464(s0)
    8000683c:	ffffd097          	auipc	ra,0xffffd
    80006840:	f3c080e7          	jalr	-196(ra) # 80003778 <fetchstr>
    80006844:	00054663          	bltz	a0,80006850 <sys_exec+0xa6>
    if(i >= NELEM(argv)){
    80006848:	0905                	addi	s2,s2,1
    8000684a:	09a1                	addi	s3,s3,8
    8000684c:	fb491be3          	bne	s2,s4,80006802 <sys_exec+0x58>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80006850:	10048913          	addi	s2,s1,256
    80006854:	6088                	ld	a0,0(s1)
    80006856:	c531                	beqz	a0,800068a2 <sys_exec+0xf8>
    kfree(argv[i]);
    80006858:	ffffa097          	auipc	ra,0xffffa
    8000685c:	238080e7          	jalr	568(ra) # 80000a90 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80006860:	04a1                	addi	s1,s1,8
    80006862:	ff2499e3          	bne	s1,s2,80006854 <sys_exec+0xaa>
  return -1;
    80006866:	557d                	li	a0,-1
    80006868:	a835                	j	800068a4 <sys_exec+0xfa>
      argv[i] = 0;
    8000686a:	0a8e                	slli	s5,s5,0x3
    8000686c:	fc040793          	addi	a5,s0,-64
    80006870:	9abe                	add	s5,s5,a5
    80006872:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    80006876:	e4040593          	addi	a1,s0,-448
    8000687a:	f4040513          	addi	a0,s0,-192
    8000687e:	fffff097          	auipc	ra,0xfffff
    80006882:	18c080e7          	jalr	396(ra) # 80005a0a <exec>
    80006886:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80006888:	10048993          	addi	s3,s1,256
    8000688c:	6088                	ld	a0,0(s1)
    8000688e:	c901                	beqz	a0,8000689e <sys_exec+0xf4>
    kfree(argv[i]);
    80006890:	ffffa097          	auipc	ra,0xffffa
    80006894:	200080e7          	jalr	512(ra) # 80000a90 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80006898:	04a1                	addi	s1,s1,8
    8000689a:	ff3499e3          	bne	s1,s3,8000688c <sys_exec+0xe2>
  return ret;
    8000689e:	854a                	mv	a0,s2
    800068a0:	a011                	j	800068a4 <sys_exec+0xfa>
  return -1;
    800068a2:	557d                	li	a0,-1
}
    800068a4:	60be                	ld	ra,456(sp)
    800068a6:	641e                	ld	s0,448(sp)
    800068a8:	74fa                	ld	s1,440(sp)
    800068aa:	795a                	ld	s2,432(sp)
    800068ac:	79ba                	ld	s3,424(sp)
    800068ae:	7a1a                	ld	s4,416(sp)
    800068b0:	6afa                	ld	s5,408(sp)
    800068b2:	6179                	addi	sp,sp,464
    800068b4:	8082                	ret

00000000800068b6 <sys_pipe>:

uint64
sys_pipe(void)
{
    800068b6:	7139                	addi	sp,sp,-64
    800068b8:	fc06                	sd	ra,56(sp)
    800068ba:	f822                	sd	s0,48(sp)
    800068bc:	f426                	sd	s1,40(sp)
    800068be:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    800068c0:	ffffb097          	auipc	ra,0xffffb
    800068c4:	292080e7          	jalr	658(ra) # 80001b52 <myproc>
    800068c8:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    800068ca:	fd840593          	addi	a1,s0,-40
    800068ce:	4501                	li	a0,0
    800068d0:	ffffd097          	auipc	ra,0xffffd
    800068d4:	f1c080e7          	jalr	-228(ra) # 800037ec <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    800068d8:	fc840593          	addi	a1,s0,-56
    800068dc:	fd040513          	addi	a0,s0,-48
    800068e0:	fffff097          	auipc	ra,0xfffff
    800068e4:	de0080e7          	jalr	-544(ra) # 800056c0 <pipealloc>
    return -1;
    800068e8:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    800068ea:	0c054463          	bltz	a0,800069b2 <sys_pipe+0xfc>
  fd0 = -1;
    800068ee:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800068f2:	fd043503          	ld	a0,-48(s0)
    800068f6:	fffff097          	auipc	ra,0xfffff
    800068fa:	51a080e7          	jalr	1306(ra) # 80005e10 <fdalloc>
    800068fe:	fca42223          	sw	a0,-60(s0)
    80006902:	08054b63          	bltz	a0,80006998 <sys_pipe+0xe2>
    80006906:	fc843503          	ld	a0,-56(s0)
    8000690a:	fffff097          	auipc	ra,0xfffff
    8000690e:	506080e7          	jalr	1286(ra) # 80005e10 <fdalloc>
    80006912:	fca42023          	sw	a0,-64(s0)
    80006916:	06054863          	bltz	a0,80006986 <sys_pipe+0xd0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000691a:	4691                	li	a3,4
    8000691c:	fc440613          	addi	a2,s0,-60
    80006920:	fd843583          	ld	a1,-40(s0)
    80006924:	6ca8                	ld	a0,88(s1)
    80006926:	ffffb097          	auipc	ra,0xffffb
    8000692a:	ee8080e7          	jalr	-280(ra) # 8000180e <copyout>
    8000692e:	02054063          	bltz	a0,8000694e <sys_pipe+0x98>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80006932:	4691                	li	a3,4
    80006934:	fc040613          	addi	a2,s0,-64
    80006938:	fd843583          	ld	a1,-40(s0)
    8000693c:	0591                	addi	a1,a1,4
    8000693e:	6ca8                	ld	a0,88(s1)
    80006940:	ffffb097          	auipc	ra,0xffffb
    80006944:	ece080e7          	jalr	-306(ra) # 8000180e <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80006948:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000694a:	06055463          	bgez	a0,800069b2 <sys_pipe+0xfc>
    p->ofile[fd0] = 0;
    8000694e:	fc442783          	lw	a5,-60(s0)
    80006952:	07e9                	addi	a5,a5,26
    80006954:	078e                	slli	a5,a5,0x3
    80006956:	97a6                	add	a5,a5,s1
    80006958:	0007b423          	sd	zero,8(a5)
    p->ofile[fd1] = 0;
    8000695c:	fc042503          	lw	a0,-64(s0)
    80006960:	0569                	addi	a0,a0,26
    80006962:	050e                	slli	a0,a0,0x3
    80006964:	94aa                	add	s1,s1,a0
    80006966:	0004b423          	sd	zero,8(s1)
    fileclose(rf);
    8000696a:	fd043503          	ld	a0,-48(s0)
    8000696e:	fffff097          	auipc	ra,0xfffff
    80006972:	a22080e7          	jalr	-1502(ra) # 80005390 <fileclose>
    fileclose(wf);
    80006976:	fc843503          	ld	a0,-56(s0)
    8000697a:	fffff097          	auipc	ra,0xfffff
    8000697e:	a16080e7          	jalr	-1514(ra) # 80005390 <fileclose>
    return -1;
    80006982:	57fd                	li	a5,-1
    80006984:	a03d                	j	800069b2 <sys_pipe+0xfc>
    if(fd0 >= 0)
    80006986:	fc442783          	lw	a5,-60(s0)
    8000698a:	0007c763          	bltz	a5,80006998 <sys_pipe+0xe2>
      p->ofile[fd0] = 0;
    8000698e:	07e9                	addi	a5,a5,26
    80006990:	078e                	slli	a5,a5,0x3
    80006992:	94be                	add	s1,s1,a5
    80006994:	0004b423          	sd	zero,8(s1)
    fileclose(rf);
    80006998:	fd043503          	ld	a0,-48(s0)
    8000699c:	fffff097          	auipc	ra,0xfffff
    800069a0:	9f4080e7          	jalr	-1548(ra) # 80005390 <fileclose>
    fileclose(wf);
    800069a4:	fc843503          	ld	a0,-56(s0)
    800069a8:	fffff097          	auipc	ra,0xfffff
    800069ac:	9e8080e7          	jalr	-1560(ra) # 80005390 <fileclose>
    return -1;
    800069b0:	57fd                	li	a5,-1
}
    800069b2:	853e                	mv	a0,a5
    800069b4:	70e2                	ld	ra,56(sp)
    800069b6:	7442                	ld	s0,48(sp)
    800069b8:	74a2                	ld	s1,40(sp)
    800069ba:	6121                	addi	sp,sp,64
    800069bc:	8082                	ret
	...

00000000800069c0 <kernelvec>:
    800069c0:	7111                	addi	sp,sp,-256
    800069c2:	e006                	sd	ra,0(sp)
    800069c4:	e40a                	sd	sp,8(sp)
    800069c6:	e80e                	sd	gp,16(sp)
    800069c8:	ec12                	sd	tp,24(sp)
    800069ca:	f016                	sd	t0,32(sp)
    800069cc:	f41a                	sd	t1,40(sp)
    800069ce:	f81e                	sd	t2,48(sp)
    800069d0:	fc22                	sd	s0,56(sp)
    800069d2:	e0a6                	sd	s1,64(sp)
    800069d4:	e4aa                	sd	a0,72(sp)
    800069d6:	e8ae                	sd	a1,80(sp)
    800069d8:	ecb2                	sd	a2,88(sp)
    800069da:	f0b6                	sd	a3,96(sp)
    800069dc:	f4ba                	sd	a4,104(sp)
    800069de:	f8be                	sd	a5,112(sp)
    800069e0:	fcc2                	sd	a6,120(sp)
    800069e2:	e146                	sd	a7,128(sp)
    800069e4:	e54a                	sd	s2,136(sp)
    800069e6:	e94e                	sd	s3,144(sp)
    800069e8:	ed52                	sd	s4,152(sp)
    800069ea:	f156                	sd	s5,160(sp)
    800069ec:	f55a                	sd	s6,168(sp)
    800069ee:	f95e                	sd	s7,176(sp)
    800069f0:	fd62                	sd	s8,184(sp)
    800069f2:	e1e6                	sd	s9,192(sp)
    800069f4:	e5ea                	sd	s10,200(sp)
    800069f6:	e9ee                	sd	s11,208(sp)
    800069f8:	edf2                	sd	t3,216(sp)
    800069fa:	f1f6                	sd	t4,224(sp)
    800069fc:	f5fa                	sd	t5,232(sp)
    800069fe:	f9fe                	sd	t6,240(sp)
    80006a00:	ba7fc0ef          	jal	ra,800035a6 <kerneltrap>
    80006a04:	6082                	ld	ra,0(sp)
    80006a06:	6122                	ld	sp,8(sp)
    80006a08:	61c2                	ld	gp,16(sp)
    80006a0a:	7282                	ld	t0,32(sp)
    80006a0c:	7322                	ld	t1,40(sp)
    80006a0e:	73c2                	ld	t2,48(sp)
    80006a10:	7462                	ld	s0,56(sp)
    80006a12:	6486                	ld	s1,64(sp)
    80006a14:	6526                	ld	a0,72(sp)
    80006a16:	65c6                	ld	a1,80(sp)
    80006a18:	6666                	ld	a2,88(sp)
    80006a1a:	7686                	ld	a3,96(sp)
    80006a1c:	7726                	ld	a4,104(sp)
    80006a1e:	77c6                	ld	a5,112(sp)
    80006a20:	7866                	ld	a6,120(sp)
    80006a22:	688a                	ld	a7,128(sp)
    80006a24:	692a                	ld	s2,136(sp)
    80006a26:	69ca                	ld	s3,144(sp)
    80006a28:	6a6a                	ld	s4,152(sp)
    80006a2a:	7a8a                	ld	s5,160(sp)
    80006a2c:	7b2a                	ld	s6,168(sp)
    80006a2e:	7bca                	ld	s7,176(sp)
    80006a30:	7c6a                	ld	s8,184(sp)
    80006a32:	6c8e                	ld	s9,192(sp)
    80006a34:	6d2e                	ld	s10,200(sp)
    80006a36:	6dce                	ld	s11,208(sp)
    80006a38:	6e6e                	ld	t3,216(sp)
    80006a3a:	7e8e                	ld	t4,224(sp)
    80006a3c:	7f2e                	ld	t5,232(sp)
    80006a3e:	7fce                	ld	t6,240(sp)
    80006a40:	6111                	addi	sp,sp,256
    80006a42:	10200073          	sret
    80006a46:	00000013          	nop
    80006a4a:	00000013          	nop
    80006a4e:	0001                	nop

0000000080006a50 <timervec>:
    80006a50:	34051573          	csrrw	a0,mscratch,a0
    80006a54:	e10c                	sd	a1,0(a0)
    80006a56:	e510                	sd	a2,8(a0)
    80006a58:	e914                	sd	a3,16(a0)
    80006a5a:	6d0c                	ld	a1,24(a0)
    80006a5c:	7110                	ld	a2,32(a0)
    80006a5e:	6194                	ld	a3,0(a1)
    80006a60:	96b2                	add	a3,a3,a2
    80006a62:	e194                	sd	a3,0(a1)
    80006a64:	4589                	li	a1,2
    80006a66:	14459073          	csrw	sip,a1
    80006a6a:	6914                	ld	a3,16(a0)
    80006a6c:	6510                	ld	a2,8(a0)
    80006a6e:	610c                	ld	a1,0(a0)
    80006a70:	34051573          	csrrw	a0,mscratch,a0
    80006a74:	30200073          	mret
	...

0000000080006a7a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80006a7a:	1141                	addi	sp,sp,-16
    80006a7c:	e422                	sd	s0,8(sp)
    80006a7e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80006a80:	0c0007b7          	lui	a5,0xc000
    80006a84:	4705                	li	a4,1
    80006a86:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80006a88:	c3d8                	sw	a4,4(a5)
}
    80006a8a:	6422                	ld	s0,8(sp)
    80006a8c:	0141                	addi	sp,sp,16
    80006a8e:	8082                	ret

0000000080006a90 <plicinithart>:

void
plicinithart(void)
{
    80006a90:	1141                	addi	sp,sp,-16
    80006a92:	e406                	sd	ra,8(sp)
    80006a94:	e022                	sd	s0,0(sp)
    80006a96:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80006a98:	ffffb097          	auipc	ra,0xffffb
    80006a9c:	08e080e7          	jalr	142(ra) # 80001b26 <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80006aa0:	0085171b          	slliw	a4,a0,0x8
    80006aa4:	0c0027b7          	lui	a5,0xc002
    80006aa8:	97ba                	add	a5,a5,a4
    80006aaa:	40200713          	li	a4,1026
    80006aae:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80006ab2:	00d5151b          	slliw	a0,a0,0xd
    80006ab6:	0c2017b7          	lui	a5,0xc201
    80006aba:	953e                	add	a0,a0,a5
    80006abc:	00052023          	sw	zero,0(a0)
}
    80006ac0:	60a2                	ld	ra,8(sp)
    80006ac2:	6402                	ld	s0,0(sp)
    80006ac4:	0141                	addi	sp,sp,16
    80006ac6:	8082                	ret

0000000080006ac8 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80006ac8:	1141                	addi	sp,sp,-16
    80006aca:	e406                	sd	ra,8(sp)
    80006acc:	e022                	sd	s0,0(sp)
    80006ace:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80006ad0:	ffffb097          	auipc	ra,0xffffb
    80006ad4:	056080e7          	jalr	86(ra) # 80001b26 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80006ad8:	00d5179b          	slliw	a5,a0,0xd
    80006adc:	0c201537          	lui	a0,0xc201
    80006ae0:	953e                	add	a0,a0,a5
  return irq;
}
    80006ae2:	4148                	lw	a0,4(a0)
    80006ae4:	60a2                	ld	ra,8(sp)
    80006ae6:	6402                	ld	s0,0(sp)
    80006ae8:	0141                	addi	sp,sp,16
    80006aea:	8082                	ret

0000000080006aec <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80006aec:	1101                	addi	sp,sp,-32
    80006aee:	ec06                	sd	ra,24(sp)
    80006af0:	e822                	sd	s0,16(sp)
    80006af2:	e426                	sd	s1,8(sp)
    80006af4:	1000                	addi	s0,sp,32
    80006af6:	84aa                	mv	s1,a0
  int hart = cpuid();
    80006af8:	ffffb097          	auipc	ra,0xffffb
    80006afc:	02e080e7          	jalr	46(ra) # 80001b26 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80006b00:	00d5151b          	slliw	a0,a0,0xd
    80006b04:	0c2017b7          	lui	a5,0xc201
    80006b08:	97aa                	add	a5,a5,a0
    80006b0a:	c3c4                	sw	s1,4(a5)
}
    80006b0c:	60e2                	ld	ra,24(sp)
    80006b0e:	6442                	ld	s0,16(sp)
    80006b10:	64a2                	ld	s1,8(sp)
    80006b12:	6105                	addi	sp,sp,32
    80006b14:	8082                	ret

0000000080006b16 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80006b16:	1141                	addi	sp,sp,-16
    80006b18:	e406                	sd	ra,8(sp)
    80006b1a:	e022                	sd	s0,0(sp)
    80006b1c:	0800                	addi	s0,sp,16
  if(i >= NUM)
    80006b1e:	479d                	li	a5,7
    80006b20:	04a7cc63          	blt	a5,a0,80006b78 <free_desc+0x62>
    panic("free_desc 1");
  if(disk.free[i])
    80006b24:	0001d797          	auipc	a5,0x1d
    80006b28:	5bc78793          	addi	a5,a5,1468 # 800240e0 <disk>
    80006b2c:	97aa                	add	a5,a5,a0
    80006b2e:	0187c783          	lbu	a5,24(a5)
    80006b32:	ebb9                	bnez	a5,80006b88 <free_desc+0x72>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80006b34:	00451613          	slli	a2,a0,0x4
    80006b38:	0001d797          	auipc	a5,0x1d
    80006b3c:	5a878793          	addi	a5,a5,1448 # 800240e0 <disk>
    80006b40:	6394                	ld	a3,0(a5)
    80006b42:	96b2                	add	a3,a3,a2
    80006b44:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    80006b48:	6398                	ld	a4,0(a5)
    80006b4a:	9732                	add	a4,a4,a2
    80006b4c:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    80006b50:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80006b54:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80006b58:	953e                	add	a0,a0,a5
    80006b5a:	4785                	li	a5,1
    80006b5c:	00f50c23          	sb	a5,24(a0) # c201018 <_entry-0x73dfefe8>
  wakeup(&disk.free[0]);
    80006b60:	0001d517          	auipc	a0,0x1d
    80006b64:	59850513          	addi	a0,a0,1432 # 800240f8 <disk+0x18>
    80006b68:	ffffc097          	auipc	ra,0xffffc
    80006b6c:	8a6080e7          	jalr	-1882(ra) # 8000240e <wakeup>
}
    80006b70:	60a2                	ld	ra,8(sp)
    80006b72:	6402                	ld	s0,0(sp)
    80006b74:	0141                	addi	sp,sp,16
    80006b76:	8082                	ret
    panic("free_desc 1");
    80006b78:	00003517          	auipc	a0,0x3
    80006b7c:	e8050513          	addi	a0,a0,-384 # 800099f8 <syscalls+0x320>
    80006b80:	ffffa097          	auipc	ra,0xffffa
    80006b84:	9bc080e7          	jalr	-1604(ra) # 8000053c <panic>
    panic("free_desc 2");
    80006b88:	00003517          	auipc	a0,0x3
    80006b8c:	e8050513          	addi	a0,a0,-384 # 80009a08 <syscalls+0x330>
    80006b90:	ffffa097          	auipc	ra,0xffffa
    80006b94:	9ac080e7          	jalr	-1620(ra) # 8000053c <panic>

0000000080006b98 <virtio_disk_init>:
{
    80006b98:	1101                	addi	sp,sp,-32
    80006b9a:	ec06                	sd	ra,24(sp)
    80006b9c:	e822                	sd	s0,16(sp)
    80006b9e:	e426                	sd	s1,8(sp)
    80006ba0:	e04a                	sd	s2,0(sp)
    80006ba2:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80006ba4:	00003597          	auipc	a1,0x3
    80006ba8:	e7458593          	addi	a1,a1,-396 # 80009a18 <syscalls+0x340>
    80006bac:	0001d517          	auipc	a0,0x1d
    80006bb0:	65c50513          	addi	a0,a0,1628 # 80024208 <disk+0x128>
    80006bb4:	ffffa097          	auipc	ra,0xffffa
    80006bb8:	038080e7          	jalr	56(ra) # 80000bec <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80006bbc:	100017b7          	lui	a5,0x10001
    80006bc0:	4398                	lw	a4,0(a5)
    80006bc2:	2701                	sext.w	a4,a4
    80006bc4:	747277b7          	lui	a5,0x74727
    80006bc8:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80006bcc:	14f71c63          	bne	a4,a5,80006d24 <virtio_disk_init+0x18c>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80006bd0:	100017b7          	lui	a5,0x10001
    80006bd4:	43dc                	lw	a5,4(a5)
    80006bd6:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80006bd8:	4709                	li	a4,2
    80006bda:	14e79563          	bne	a5,a4,80006d24 <virtio_disk_init+0x18c>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80006bde:	100017b7          	lui	a5,0x10001
    80006be2:	479c                	lw	a5,8(a5)
    80006be4:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80006be6:	12e79f63          	bne	a5,a4,80006d24 <virtio_disk_init+0x18c>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80006bea:	100017b7          	lui	a5,0x10001
    80006bee:	47d8                	lw	a4,12(a5)
    80006bf0:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80006bf2:	554d47b7          	lui	a5,0x554d4
    80006bf6:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80006bfa:	12f71563          	bne	a4,a5,80006d24 <virtio_disk_init+0x18c>
  *R(VIRTIO_MMIO_STATUS) = status;
    80006bfe:	100017b7          	lui	a5,0x10001
    80006c02:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80006c06:	4705                	li	a4,1
    80006c08:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80006c0a:	470d                	li	a4,3
    80006c0c:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80006c0e:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80006c10:	c7ffe737          	lui	a4,0xc7ffe
    80006c14:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fda53f>
    80006c18:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80006c1a:	2701                	sext.w	a4,a4
    80006c1c:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80006c1e:	472d                	li	a4,11
    80006c20:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    80006c22:	5bbc                	lw	a5,112(a5)
    80006c24:	0007891b          	sext.w	s2,a5
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80006c28:	8ba1                	andi	a5,a5,8
    80006c2a:	10078563          	beqz	a5,80006d34 <virtio_disk_init+0x19c>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80006c2e:	100017b7          	lui	a5,0x10001
    80006c32:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80006c36:	43fc                	lw	a5,68(a5)
    80006c38:	2781                	sext.w	a5,a5
    80006c3a:	10079563          	bnez	a5,80006d44 <virtio_disk_init+0x1ac>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80006c3e:	100017b7          	lui	a5,0x10001
    80006c42:	5bdc                	lw	a5,52(a5)
    80006c44:	2781                	sext.w	a5,a5
  if(max == 0)
    80006c46:	10078763          	beqz	a5,80006d54 <virtio_disk_init+0x1bc>
  if(max < NUM)
    80006c4a:	471d                	li	a4,7
    80006c4c:	10f77c63          	bgeu	a4,a5,80006d64 <virtio_disk_init+0x1cc>
  disk.desc = kalloc();
    80006c50:	ffffa097          	auipc	ra,0xffffa
    80006c54:	f3c080e7          	jalr	-196(ra) # 80000b8c <kalloc>
    80006c58:	0001d497          	auipc	s1,0x1d
    80006c5c:	48848493          	addi	s1,s1,1160 # 800240e0 <disk>
    80006c60:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80006c62:	ffffa097          	auipc	ra,0xffffa
    80006c66:	f2a080e7          	jalr	-214(ra) # 80000b8c <kalloc>
    80006c6a:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    80006c6c:	ffffa097          	auipc	ra,0xffffa
    80006c70:	f20080e7          	jalr	-224(ra) # 80000b8c <kalloc>
    80006c74:	87aa                	mv	a5,a0
    80006c76:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    80006c78:	6088                	ld	a0,0(s1)
    80006c7a:	cd6d                	beqz	a0,80006d74 <virtio_disk_init+0x1dc>
    80006c7c:	0001d717          	auipc	a4,0x1d
    80006c80:	46c73703          	ld	a4,1132(a4) # 800240e8 <disk+0x8>
    80006c84:	cb65                	beqz	a4,80006d74 <virtio_disk_init+0x1dc>
    80006c86:	c7fd                	beqz	a5,80006d74 <virtio_disk_init+0x1dc>
  memset(disk.desc, 0, PGSIZE);
    80006c88:	6605                	lui	a2,0x1
    80006c8a:	4581                	li	a1,0
    80006c8c:	ffffa097          	auipc	ra,0xffffa
    80006c90:	0ec080e7          	jalr	236(ra) # 80000d78 <memset>
  memset(disk.avail, 0, PGSIZE);
    80006c94:	0001d497          	auipc	s1,0x1d
    80006c98:	44c48493          	addi	s1,s1,1100 # 800240e0 <disk>
    80006c9c:	6605                	lui	a2,0x1
    80006c9e:	4581                	li	a1,0
    80006ca0:	6488                	ld	a0,8(s1)
    80006ca2:	ffffa097          	auipc	ra,0xffffa
    80006ca6:	0d6080e7          	jalr	214(ra) # 80000d78 <memset>
  memset(disk.used, 0, PGSIZE);
    80006caa:	6605                	lui	a2,0x1
    80006cac:	4581                	li	a1,0
    80006cae:	6888                	ld	a0,16(s1)
    80006cb0:	ffffa097          	auipc	ra,0xffffa
    80006cb4:	0c8080e7          	jalr	200(ra) # 80000d78 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80006cb8:	100017b7          	lui	a5,0x10001
    80006cbc:	4721                	li	a4,8
    80006cbe:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    80006cc0:	4098                	lw	a4,0(s1)
    80006cc2:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80006cc6:	40d8                	lw	a4,4(s1)
    80006cc8:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    80006ccc:	6498                	ld	a4,8(s1)
    80006cce:	0007069b          	sext.w	a3,a4
    80006cd2:	08d7a823          	sw	a3,144(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80006cd6:	9701                	srai	a4,a4,0x20
    80006cd8:	08e7aa23          	sw	a4,148(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    80006cdc:	6898                	ld	a4,16(s1)
    80006cde:	0007069b          	sext.w	a3,a4
    80006ce2:	0ad7a023          	sw	a3,160(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80006ce6:	9701                	srai	a4,a4,0x20
    80006ce8:	0ae7a223          	sw	a4,164(a5)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80006cec:	4705                	li	a4,1
    80006cee:	c3f8                	sw	a4,68(a5)
    disk.free[i] = 1;
    80006cf0:	00e48c23          	sb	a4,24(s1)
    80006cf4:	00e48ca3          	sb	a4,25(s1)
    80006cf8:	00e48d23          	sb	a4,26(s1)
    80006cfc:	00e48da3          	sb	a4,27(s1)
    80006d00:	00e48e23          	sb	a4,28(s1)
    80006d04:	00e48ea3          	sb	a4,29(s1)
    80006d08:	00e48f23          	sb	a4,30(s1)
    80006d0c:	00e48fa3          	sb	a4,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80006d10:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80006d14:	0727a823          	sw	s2,112(a5)
}
    80006d18:	60e2                	ld	ra,24(sp)
    80006d1a:	6442                	ld	s0,16(sp)
    80006d1c:	64a2                	ld	s1,8(sp)
    80006d1e:	6902                	ld	s2,0(sp)
    80006d20:	6105                	addi	sp,sp,32
    80006d22:	8082                	ret
    panic("could not find virtio disk");
    80006d24:	00003517          	auipc	a0,0x3
    80006d28:	d0450513          	addi	a0,a0,-764 # 80009a28 <syscalls+0x350>
    80006d2c:	ffffa097          	auipc	ra,0xffffa
    80006d30:	810080e7          	jalr	-2032(ra) # 8000053c <panic>
    panic("virtio disk FEATURES_OK unset");
    80006d34:	00003517          	auipc	a0,0x3
    80006d38:	d1450513          	addi	a0,a0,-748 # 80009a48 <syscalls+0x370>
    80006d3c:	ffffa097          	auipc	ra,0xffffa
    80006d40:	800080e7          	jalr	-2048(ra) # 8000053c <panic>
    panic("virtio disk should not be ready");
    80006d44:	00003517          	auipc	a0,0x3
    80006d48:	d2450513          	addi	a0,a0,-732 # 80009a68 <syscalls+0x390>
    80006d4c:	ffff9097          	auipc	ra,0xffff9
    80006d50:	7f0080e7          	jalr	2032(ra) # 8000053c <panic>
    panic("virtio disk has no queue 0");
    80006d54:	00003517          	auipc	a0,0x3
    80006d58:	d3450513          	addi	a0,a0,-716 # 80009a88 <syscalls+0x3b0>
    80006d5c:	ffff9097          	auipc	ra,0xffff9
    80006d60:	7e0080e7          	jalr	2016(ra) # 8000053c <panic>
    panic("virtio disk max queue too short");
    80006d64:	00003517          	auipc	a0,0x3
    80006d68:	d4450513          	addi	a0,a0,-700 # 80009aa8 <syscalls+0x3d0>
    80006d6c:	ffff9097          	auipc	ra,0xffff9
    80006d70:	7d0080e7          	jalr	2000(ra) # 8000053c <panic>
    panic("virtio disk kalloc");
    80006d74:	00003517          	auipc	a0,0x3
    80006d78:	d5450513          	addi	a0,a0,-684 # 80009ac8 <syscalls+0x3f0>
    80006d7c:	ffff9097          	auipc	ra,0xffff9
    80006d80:	7c0080e7          	jalr	1984(ra) # 8000053c <panic>

0000000080006d84 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80006d84:	7119                	addi	sp,sp,-128
    80006d86:	fc86                	sd	ra,120(sp)
    80006d88:	f8a2                	sd	s0,112(sp)
    80006d8a:	f4a6                	sd	s1,104(sp)
    80006d8c:	f0ca                	sd	s2,96(sp)
    80006d8e:	ecce                	sd	s3,88(sp)
    80006d90:	e8d2                	sd	s4,80(sp)
    80006d92:	e4d6                	sd	s5,72(sp)
    80006d94:	e0da                	sd	s6,64(sp)
    80006d96:	fc5e                	sd	s7,56(sp)
    80006d98:	f862                	sd	s8,48(sp)
    80006d9a:	f466                	sd	s9,40(sp)
    80006d9c:	f06a                	sd	s10,32(sp)
    80006d9e:	ec6e                	sd	s11,24(sp)
    80006da0:	0100                	addi	s0,sp,128
    80006da2:	8aaa                	mv	s5,a0
    80006da4:	8c2e                	mv	s8,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80006da6:	00c52d03          	lw	s10,12(a0)
    80006daa:	001d1d1b          	slliw	s10,s10,0x1
    80006dae:	1d02                	slli	s10,s10,0x20
    80006db0:	020d5d13          	srli	s10,s10,0x20

  acquire(&disk.vdisk_lock);
    80006db4:	0001d517          	auipc	a0,0x1d
    80006db8:	45450513          	addi	a0,a0,1108 # 80024208 <disk+0x128>
    80006dbc:	ffffa097          	auipc	ra,0xffffa
    80006dc0:	ec0080e7          	jalr	-320(ra) # 80000c7c <acquire>
  for(int i = 0; i < 3; i++){
    80006dc4:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80006dc6:	44a1                	li	s1,8
      disk.free[i] = 0;
    80006dc8:	0001db97          	auipc	s7,0x1d
    80006dcc:	318b8b93          	addi	s7,s7,792 # 800240e0 <disk>
  for(int i = 0; i < 3; i++){
    80006dd0:	4b0d                	li	s6,3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80006dd2:	0001dc97          	auipc	s9,0x1d
    80006dd6:	436c8c93          	addi	s9,s9,1078 # 80024208 <disk+0x128>
    80006dda:	a08d                	j	80006e3c <virtio_disk_rw+0xb8>
      disk.free[i] = 0;
    80006ddc:	00fb8733          	add	a4,s7,a5
    80006de0:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80006de4:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80006de6:	0207c563          	bltz	a5,80006e10 <virtio_disk_rw+0x8c>
  for(int i = 0; i < 3; i++){
    80006dea:	2905                	addiw	s2,s2,1
    80006dec:	0611                	addi	a2,a2,4
    80006dee:	05690c63          	beq	s2,s6,80006e46 <virtio_disk_rw+0xc2>
    idx[i] = alloc_desc();
    80006df2:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80006df4:	0001d717          	auipc	a4,0x1d
    80006df8:	2ec70713          	addi	a4,a4,748 # 800240e0 <disk>
    80006dfc:	87ce                	mv	a5,s3
    if(disk.free[i]){
    80006dfe:	01874683          	lbu	a3,24(a4)
    80006e02:	fee9                	bnez	a3,80006ddc <virtio_disk_rw+0x58>
  for(int i = 0; i < NUM; i++){
    80006e04:	2785                	addiw	a5,a5,1
    80006e06:	0705                	addi	a4,a4,1
    80006e08:	fe979be3          	bne	a5,s1,80006dfe <virtio_disk_rw+0x7a>
    idx[i] = alloc_desc();
    80006e0c:	57fd                	li	a5,-1
    80006e0e:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    80006e10:	01205d63          	blez	s2,80006e2a <virtio_disk_rw+0xa6>
    80006e14:	8dce                	mv	s11,s3
        free_desc(idx[j]);
    80006e16:	000a2503          	lw	a0,0(s4)
    80006e1a:	00000097          	auipc	ra,0x0
    80006e1e:	cfc080e7          	jalr	-772(ra) # 80006b16 <free_desc>
      for(int j = 0; j < i; j++)
    80006e22:	2d85                	addiw	s11,s11,1
    80006e24:	0a11                	addi	s4,s4,4
    80006e26:	ffb918e3          	bne	s2,s11,80006e16 <virtio_disk_rw+0x92>
    sleep(&disk.free[0], &disk.vdisk_lock);
    80006e2a:	85e6                	mv	a1,s9
    80006e2c:	0001d517          	auipc	a0,0x1d
    80006e30:	2cc50513          	addi	a0,a0,716 # 800240f8 <disk+0x18>
    80006e34:	ffffb097          	auipc	ra,0xffffb
    80006e38:	576080e7          	jalr	1398(ra) # 800023aa <sleep>
  for(int i = 0; i < 3; i++){
    80006e3c:	f8040a13          	addi	s4,s0,-128
{
    80006e40:	8652                	mv	a2,s4
  for(int i = 0; i < 3; i++){
    80006e42:	894e                	mv	s2,s3
    80006e44:	b77d                	j	80006df2 <virtio_disk_rw+0x6e>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80006e46:	f8042583          	lw	a1,-128(s0)
    80006e4a:	00a58793          	addi	a5,a1,10
    80006e4e:	0792                	slli	a5,a5,0x4

  if(write)
    80006e50:	0001d617          	auipc	a2,0x1d
    80006e54:	29060613          	addi	a2,a2,656 # 800240e0 <disk>
    80006e58:	00f60733          	add	a4,a2,a5
    80006e5c:	018036b3          	snez	a3,s8
    80006e60:	c714                	sw	a3,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80006e62:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    80006e66:	01a73823          	sd	s10,16(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80006e6a:	f6078693          	addi	a3,a5,-160
    80006e6e:	6218                	ld	a4,0(a2)
    80006e70:	9736                	add	a4,a4,a3
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80006e72:	00878513          	addi	a0,a5,8
    80006e76:	9532                	add	a0,a0,a2
  disk.desc[idx[0]].addr = (uint64) buf0;
    80006e78:	e308                	sd	a0,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80006e7a:	6208                	ld	a0,0(a2)
    80006e7c:	96aa                	add	a3,a3,a0
    80006e7e:	4741                	li	a4,16
    80006e80:	c698                	sw	a4,8(a3)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80006e82:	4705                	li	a4,1
    80006e84:	00e69623          	sh	a4,12(a3)
  disk.desc[idx[0]].next = idx[1];
    80006e88:	f8442703          	lw	a4,-124(s0)
    80006e8c:	00e69723          	sh	a4,14(a3)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80006e90:	0712                	slli	a4,a4,0x4
    80006e92:	953a                	add	a0,a0,a4
    80006e94:	058a8693          	addi	a3,s5,88
    80006e98:	e114                	sd	a3,0(a0)
  disk.desc[idx[1]].len = BSIZE;
    80006e9a:	6208                	ld	a0,0(a2)
    80006e9c:	972a                	add	a4,a4,a0
    80006e9e:	40000693          	li	a3,1024
    80006ea2:	c714                	sw	a3,8(a4)
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80006ea4:	001c3c13          	seqz	s8,s8
    80006ea8:	0c06                	slli	s8,s8,0x1
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80006eaa:	001c6c13          	ori	s8,s8,1
    80006eae:	01871623          	sh	s8,12(a4)
  disk.desc[idx[1]].next = idx[2];
    80006eb2:	f8842603          	lw	a2,-120(s0)
    80006eb6:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80006eba:	0001d697          	auipc	a3,0x1d
    80006ebe:	22668693          	addi	a3,a3,550 # 800240e0 <disk>
    80006ec2:	00258713          	addi	a4,a1,2
    80006ec6:	0712                	slli	a4,a4,0x4
    80006ec8:	9736                	add	a4,a4,a3
    80006eca:	587d                	li	a6,-1
    80006ecc:	01070823          	sb	a6,16(a4)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80006ed0:	0612                	slli	a2,a2,0x4
    80006ed2:	9532                	add	a0,a0,a2
    80006ed4:	f9078793          	addi	a5,a5,-112
    80006ed8:	97b6                	add	a5,a5,a3
    80006eda:	e11c                	sd	a5,0(a0)
  disk.desc[idx[2]].len = 1;
    80006edc:	629c                	ld	a5,0(a3)
    80006ede:	97b2                	add	a5,a5,a2
    80006ee0:	4605                	li	a2,1
    80006ee2:	c790                	sw	a2,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80006ee4:	4509                	li	a0,2
    80006ee6:	00a79623          	sh	a0,12(a5)
  disk.desc[idx[2]].next = 0;
    80006eea:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80006eee:	00caa223          	sw	a2,4(s5)
  disk.info[idx[0]].b = b;
    80006ef2:	01573423          	sd	s5,8(a4)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80006ef6:	6698                	ld	a4,8(a3)
    80006ef8:	00275783          	lhu	a5,2(a4)
    80006efc:	8b9d                	andi	a5,a5,7
    80006efe:	0786                	slli	a5,a5,0x1
    80006f00:	97ba                	add	a5,a5,a4
    80006f02:	00b79223          	sh	a1,4(a5)

  __sync_synchronize();
    80006f06:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80006f0a:	6698                	ld	a4,8(a3)
    80006f0c:	00275783          	lhu	a5,2(a4)
    80006f10:	2785                	addiw	a5,a5,1
    80006f12:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80006f16:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80006f1a:	100017b7          	lui	a5,0x10001
    80006f1e:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80006f22:	004aa783          	lw	a5,4(s5)
    80006f26:	02c79163          	bne	a5,a2,80006f48 <virtio_disk_rw+0x1c4>
    sleep(b, &disk.vdisk_lock);
    80006f2a:	0001d917          	auipc	s2,0x1d
    80006f2e:	2de90913          	addi	s2,s2,734 # 80024208 <disk+0x128>
  while(b->disk == 1) {
    80006f32:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    80006f34:	85ca                	mv	a1,s2
    80006f36:	8556                	mv	a0,s5
    80006f38:	ffffb097          	auipc	ra,0xffffb
    80006f3c:	472080e7          	jalr	1138(ra) # 800023aa <sleep>
  while(b->disk == 1) {
    80006f40:	004aa783          	lw	a5,4(s5)
    80006f44:	fe9788e3          	beq	a5,s1,80006f34 <virtio_disk_rw+0x1b0>
  }

  disk.info[idx[0]].b = 0;
    80006f48:	f8042903          	lw	s2,-128(s0)
    80006f4c:	00290793          	addi	a5,s2,2
    80006f50:	00479713          	slli	a4,a5,0x4
    80006f54:	0001d797          	auipc	a5,0x1d
    80006f58:	18c78793          	addi	a5,a5,396 # 800240e0 <disk>
    80006f5c:	97ba                	add	a5,a5,a4
    80006f5e:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    80006f62:	0001d997          	auipc	s3,0x1d
    80006f66:	17e98993          	addi	s3,s3,382 # 800240e0 <disk>
    80006f6a:	00491713          	slli	a4,s2,0x4
    80006f6e:	0009b783          	ld	a5,0(s3)
    80006f72:	97ba                	add	a5,a5,a4
    80006f74:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80006f78:	854a                	mv	a0,s2
    80006f7a:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80006f7e:	00000097          	auipc	ra,0x0
    80006f82:	b98080e7          	jalr	-1128(ra) # 80006b16 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80006f86:	8885                	andi	s1,s1,1
    80006f88:	f0ed                	bnez	s1,80006f6a <virtio_disk_rw+0x1e6>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80006f8a:	0001d517          	auipc	a0,0x1d
    80006f8e:	27e50513          	addi	a0,a0,638 # 80024208 <disk+0x128>
    80006f92:	ffffa097          	auipc	ra,0xffffa
    80006f96:	d9e080e7          	jalr	-610(ra) # 80000d30 <release>
}
    80006f9a:	70e6                	ld	ra,120(sp)
    80006f9c:	7446                	ld	s0,112(sp)
    80006f9e:	74a6                	ld	s1,104(sp)
    80006fa0:	7906                	ld	s2,96(sp)
    80006fa2:	69e6                	ld	s3,88(sp)
    80006fa4:	6a46                	ld	s4,80(sp)
    80006fa6:	6aa6                	ld	s5,72(sp)
    80006fa8:	6b06                	ld	s6,64(sp)
    80006faa:	7be2                	ld	s7,56(sp)
    80006fac:	7c42                	ld	s8,48(sp)
    80006fae:	7ca2                	ld	s9,40(sp)
    80006fb0:	7d02                	ld	s10,32(sp)
    80006fb2:	6de2                	ld	s11,24(sp)
    80006fb4:	6109                	addi	sp,sp,128
    80006fb6:	8082                	ret

0000000080006fb8 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80006fb8:	1101                	addi	sp,sp,-32
    80006fba:	ec06                	sd	ra,24(sp)
    80006fbc:	e822                	sd	s0,16(sp)
    80006fbe:	e426                	sd	s1,8(sp)
    80006fc0:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80006fc2:	0001d497          	auipc	s1,0x1d
    80006fc6:	11e48493          	addi	s1,s1,286 # 800240e0 <disk>
    80006fca:	0001d517          	auipc	a0,0x1d
    80006fce:	23e50513          	addi	a0,a0,574 # 80024208 <disk+0x128>
    80006fd2:	ffffa097          	auipc	ra,0xffffa
    80006fd6:	caa080e7          	jalr	-854(ra) # 80000c7c <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80006fda:	10001737          	lui	a4,0x10001
    80006fde:	533c                	lw	a5,96(a4)
    80006fe0:	8b8d                	andi	a5,a5,3
    80006fe2:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80006fe4:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80006fe8:	689c                	ld	a5,16(s1)
    80006fea:	0204d703          	lhu	a4,32(s1)
    80006fee:	0027d783          	lhu	a5,2(a5)
    80006ff2:	04f70863          	beq	a4,a5,80007042 <virtio_disk_intr+0x8a>
    __sync_synchronize();
    80006ff6:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80006ffa:	6898                	ld	a4,16(s1)
    80006ffc:	0204d783          	lhu	a5,32(s1)
    80007000:	8b9d                	andi	a5,a5,7
    80007002:	078e                	slli	a5,a5,0x3
    80007004:	97ba                	add	a5,a5,a4
    80007006:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80007008:	00278713          	addi	a4,a5,2
    8000700c:	0712                	slli	a4,a4,0x4
    8000700e:	9726                	add	a4,a4,s1
    80007010:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80007014:	e721                	bnez	a4,8000705c <virtio_disk_intr+0xa4>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80007016:	0789                	addi	a5,a5,2
    80007018:	0792                	slli	a5,a5,0x4
    8000701a:	97a6                	add	a5,a5,s1
    8000701c:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    8000701e:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80007022:	ffffb097          	auipc	ra,0xffffb
    80007026:	3ec080e7          	jalr	1004(ra) # 8000240e <wakeup>

    disk.used_idx += 1;
    8000702a:	0204d783          	lhu	a5,32(s1)
    8000702e:	2785                	addiw	a5,a5,1
    80007030:	17c2                	slli	a5,a5,0x30
    80007032:	93c1                	srli	a5,a5,0x30
    80007034:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80007038:	6898                	ld	a4,16(s1)
    8000703a:	00275703          	lhu	a4,2(a4)
    8000703e:	faf71ce3          	bne	a4,a5,80006ff6 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80007042:	0001d517          	auipc	a0,0x1d
    80007046:	1c650513          	addi	a0,a0,454 # 80024208 <disk+0x128>
    8000704a:	ffffa097          	auipc	ra,0xffffa
    8000704e:	ce6080e7          	jalr	-794(ra) # 80000d30 <release>
}
    80007052:	60e2                	ld	ra,24(sp)
    80007054:	6442                	ld	s0,16(sp)
    80007056:	64a2                	ld	s1,8(sp)
    80007058:	6105                	addi	sp,sp,32
    8000705a:	8082                	ret
      panic("virtio_disk_intr status");
    8000705c:	00003517          	auipc	a0,0x3
    80007060:	a8450513          	addi	a0,a0,-1404 # 80009ae0 <syscalls+0x408>
    80007064:	ffff9097          	auipc	ra,0xffff9
    80007068:	4d8080e7          	jalr	1240(ra) # 8000053c <panic>
	...

0000000080008000 <_trampoline>:
    80008000:	14051073          	csrw	sscratch,a0
    80008004:	02000537          	lui	a0,0x2000
    80008008:	357d                	addiw	a0,a0,-1
    8000800a:	0536                	slli	a0,a0,0xd
    8000800c:	02153423          	sd	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    80008010:	02253823          	sd	sp,48(a0)
    80008014:	02353c23          	sd	gp,56(a0)
    80008018:	04453023          	sd	tp,64(a0)
    8000801c:	04553423          	sd	t0,72(a0)
    80008020:	04653823          	sd	t1,80(a0)
    80008024:	04753c23          	sd	t2,88(a0)
    80008028:	f120                	sd	s0,96(a0)
    8000802a:	f524                	sd	s1,104(a0)
    8000802c:	fd2c                	sd	a1,120(a0)
    8000802e:	e150                	sd	a2,128(a0)
    80008030:	e554                	sd	a3,136(a0)
    80008032:	e958                	sd	a4,144(a0)
    80008034:	ed5c                	sd	a5,152(a0)
    80008036:	0b053023          	sd	a6,160(a0)
    8000803a:	0b153423          	sd	a7,168(a0)
    8000803e:	0b253823          	sd	s2,176(a0)
    80008042:	0b353c23          	sd	s3,184(a0)
    80008046:	0d453023          	sd	s4,192(a0)
    8000804a:	0d553423          	sd	s5,200(a0)
    8000804e:	0d653823          	sd	s6,208(a0)
    80008052:	0d753c23          	sd	s7,216(a0)
    80008056:	0f853023          	sd	s8,224(a0)
    8000805a:	0f953423          	sd	s9,232(a0)
    8000805e:	0fa53823          	sd	s10,240(a0)
    80008062:	0fb53c23          	sd	s11,248(a0)
    80008066:	11c53023          	sd	t3,256(a0)
    8000806a:	11d53423          	sd	t4,264(a0)
    8000806e:	11e53823          	sd	t5,272(a0)
    80008072:	11f53c23          	sd	t6,280(a0)
    80008076:	140022f3          	csrr	t0,sscratch
    8000807a:	06553823          	sd	t0,112(a0)
    8000807e:	00853103          	ld	sp,8(a0)
    80008082:	02053203          	ld	tp,32(a0)
    80008086:	01053283          	ld	t0,16(a0)
    8000808a:	00053303          	ld	t1,0(a0)
    8000808e:	12000073          	sfence.vma
    80008092:	18031073          	csrw	satp,t1
    80008096:	12000073          	sfence.vma
    8000809a:	8282                	jr	t0

000000008000809c <userret>:
    8000809c:	12000073          	sfence.vma
    800080a0:	18051073          	csrw	satp,a0
    800080a4:	12000073          	sfence.vma
    800080a8:	02000537          	lui	a0,0x2000
    800080ac:	357d                	addiw	a0,a0,-1
    800080ae:	0536                	slli	a0,a0,0xd
    800080b0:	02853083          	ld	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    800080b4:	03053103          	ld	sp,48(a0)
    800080b8:	03853183          	ld	gp,56(a0)
    800080bc:	04053203          	ld	tp,64(a0)
    800080c0:	04853283          	ld	t0,72(a0)
    800080c4:	05053303          	ld	t1,80(a0)
    800080c8:	05853383          	ld	t2,88(a0)
    800080cc:	7120                	ld	s0,96(a0)
    800080ce:	7524                	ld	s1,104(a0)
    800080d0:	7d2c                	ld	a1,120(a0)
    800080d2:	6150                	ld	a2,128(a0)
    800080d4:	6554                	ld	a3,136(a0)
    800080d6:	6958                	ld	a4,144(a0)
    800080d8:	6d5c                	ld	a5,152(a0)
    800080da:	0a053803          	ld	a6,160(a0)
    800080de:	0a853883          	ld	a7,168(a0)
    800080e2:	0b053903          	ld	s2,176(a0)
    800080e6:	0b853983          	ld	s3,184(a0)
    800080ea:	0c053a03          	ld	s4,192(a0)
    800080ee:	0c853a83          	ld	s5,200(a0)
    800080f2:	0d053b03          	ld	s6,208(a0)
    800080f6:	0d853b83          	ld	s7,216(a0)
    800080fa:	0e053c03          	ld	s8,224(a0)
    800080fe:	0e853c83          	ld	s9,232(a0)
    80008102:	0f053d03          	ld	s10,240(a0)
    80008106:	0f853d83          	ld	s11,248(a0)
    8000810a:	10053e03          	ld	t3,256(a0)
    8000810e:	10853e83          	ld	t4,264(a0)
    80008112:	11053f03          	ld	t5,272(a0)
    80008116:	11853f83          	ld	t6,280(a0)
    8000811a:	7928                	ld	a0,112(a0)
    8000811c:	10200073          	sret
	...
