
user/_heap2:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <main>:
  exit(0); \
}

int
main(int argc, char *argv[])
{
    3000:	1101                	addi	sp,sp,-32
    3002:	ec06                	sd	ra,24(sp)
    3004:	e822                	sd	s0,16(sp)
    3006:	e426                	sd	s1,8(sp)
    3008:	1000                	addi	s0,sp,32
  uint64 sz = (uint64) sbrk(0); // end opf heap
    300a:	4501                	li	a0,0
    300c:	00000097          	auipc	ra,0x0
    3010:	4ba080e7          	jalr	1210(ra) # 34c6 <sbrk>
  uint64 stackpage = (160 - 1) * 4096; // address where stack starts
  uint64 heap = stackpage - 4096*5; // address where guardpage starts

  assert((uint64) sbrk(heap - sz) != -1); // should allocate dynamic memory from the end of heap till the guardpage
    3014:	0005049b          	sext.w	s1,a0
    3018:	0009a7b7          	lui	a5,0x9a
    301c:	40a7853b          	subw	a0,a5,a0
    3020:	00000097          	auipc	ra,0x0
    3024:	4a6080e7          	jalr	1190(ra) # 34c6 <sbrk>
    3028:	57fd                	li	a5,-1
    302a:	06f50d63          	beq	a0,a5,30a4 <main+0xa4>
  assert((uint64) sbrk(-1*(heap - sz)) != -1); // equivalent to sbrk(0) since sz should be equal to guardpage
    302e:	fff66537          	lui	a0,0xfff66
    3032:	9d25                	addw	a0,a0,s1
    3034:	00000097          	auipc	ra,0x0
    3038:	492080e7          	jalr	1170(ra) # 34c6 <sbrk>
    303c:	57fd                	li	a5,-1
    303e:	0af50963          	beq	a0,a5,30f0 <main+0xf0>
  assert((uint64) sbrk(heap - sz + 1) == -1); // cannot allocate inside the guardpage
    3042:	0009a537          	lui	a0,0x9a
    3046:	2505                	addiw	a0,a0,1
    3048:	9d05                	subw	a0,a0,s1
    304a:	00000097          	auipc	ra,0x0
    304e:	47c080e7          	jalr	1148(ra) # 34c6 <sbrk>
    3052:	57fd                	li	a5,-1
    3054:	0ef50463          	beq	a0,a5,313c <main+0x13c>
    3058:	4661                	li	a2,24
    305a:	00001597          	auipc	a1,0x1
    305e:	92658593          	addi	a1,a1,-1754 # 3980 <malloc+0xe4>
    3062:	00001517          	auipc	a0,0x1
    3066:	92e50513          	addi	a0,a0,-1746 # 3990 <malloc+0xf4>
    306a:	00000097          	auipc	ra,0x0
    306e:	774080e7          	jalr	1908(ra) # 37de <printf>
    3072:	00001597          	auipc	a1,0x1
    3076:	99658593          	addi	a1,a1,-1642 # 3a08 <malloc+0x16c>
    307a:	00001517          	auipc	a0,0x1
    307e:	93e50513          	addi	a0,a0,-1730 # 39b8 <malloc+0x11c>
    3082:	00000097          	auipc	ra,0x0
    3086:	75c080e7          	jalr	1884(ra) # 37de <printf>
    308a:	00001517          	auipc	a0,0x1
    308e:	94650513          	addi	a0,a0,-1722 # 39d0 <malloc+0x134>
    3092:	00000097          	auipc	ra,0x0
    3096:	74c080e7          	jalr	1868(ra) # 37de <printf>
    309a:	4501                	li	a0,0
    309c:	00000097          	auipc	ra,0x0
    30a0:	39a080e7          	jalr	922(ra) # 3436 <exit>
  assert((uint64) sbrk(heap - sz) != -1); // should allocate dynamic memory from the end of heap till the guardpage
    30a4:	4659                	li	a2,22
    30a6:	00001597          	auipc	a1,0x1
    30aa:	8da58593          	addi	a1,a1,-1830 # 3980 <malloc+0xe4>
    30ae:	00001517          	auipc	a0,0x1
    30b2:	8e250513          	addi	a0,a0,-1822 # 3990 <malloc+0xf4>
    30b6:	00000097          	auipc	ra,0x0
    30ba:	728080e7          	jalr	1832(ra) # 37de <printf>
    30be:	00001597          	auipc	a1,0x1
    30c2:	8da58593          	addi	a1,a1,-1830 # 3998 <malloc+0xfc>
    30c6:	00001517          	auipc	a0,0x1
    30ca:	8f250513          	addi	a0,a0,-1806 # 39b8 <malloc+0x11c>
    30ce:	00000097          	auipc	ra,0x0
    30d2:	710080e7          	jalr	1808(ra) # 37de <printf>
    30d6:	00001517          	auipc	a0,0x1
    30da:	8fa50513          	addi	a0,a0,-1798 # 39d0 <malloc+0x134>
    30de:	00000097          	auipc	ra,0x0
    30e2:	700080e7          	jalr	1792(ra) # 37de <printf>
    30e6:	4501                	li	a0,0
    30e8:	00000097          	auipc	ra,0x0
    30ec:	34e080e7          	jalr	846(ra) # 3436 <exit>
  assert((uint64) sbrk(-1*(heap - sz)) != -1); // equivalent to sbrk(0) since sz should be equal to guardpage
    30f0:	465d                	li	a2,23
    30f2:	00001597          	auipc	a1,0x1
    30f6:	88e58593          	addi	a1,a1,-1906 # 3980 <malloc+0xe4>
    30fa:	00001517          	auipc	a0,0x1
    30fe:	89650513          	addi	a0,a0,-1898 # 3990 <malloc+0xf4>
    3102:	00000097          	auipc	ra,0x0
    3106:	6dc080e7          	jalr	1756(ra) # 37de <printf>
    310a:	00001597          	auipc	a1,0x1
    310e:	8d658593          	addi	a1,a1,-1834 # 39e0 <malloc+0x144>
    3112:	00001517          	auipc	a0,0x1
    3116:	8a650513          	addi	a0,a0,-1882 # 39b8 <malloc+0x11c>
    311a:	00000097          	auipc	ra,0x0
    311e:	6c4080e7          	jalr	1732(ra) # 37de <printf>
    3122:	00001517          	auipc	a0,0x1
    3126:	8ae50513          	addi	a0,a0,-1874 # 39d0 <malloc+0x134>
    312a:	00000097          	auipc	ra,0x0
    312e:	6b4080e7          	jalr	1716(ra) # 37de <printf>
    3132:	4501                	li	a0,0
    3134:	00000097          	auipc	ra,0x0
    3138:	302080e7          	jalr	770(ra) # 3436 <exit>
  printf("TEST PASSED\n");
    313c:	00001517          	auipc	a0,0x1
    3140:	8f450513          	addi	a0,a0,-1804 # 3a30 <malloc+0x194>
    3144:	00000097          	auipc	ra,0x0
    3148:	69a080e7          	jalr	1690(ra) # 37de <printf>
  exit(0);
    314c:	4501                	li	a0,0
    314e:	00000097          	auipc	ra,0x0
    3152:	2e8080e7          	jalr	744(ra) # 3436 <exit>

0000000000003156 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    3156:	1141                	addi	sp,sp,-16
    3158:	e406                	sd	ra,8(sp)
    315a:	e022                	sd	s0,0(sp)
    315c:	0800                	addi	s0,sp,16
  extern int main();
  main();
    315e:	00000097          	auipc	ra,0x0
    3162:	ea2080e7          	jalr	-350(ra) # 3000 <main>
  exit(0);
    3166:	4501                	li	a0,0
    3168:	00000097          	auipc	ra,0x0
    316c:	2ce080e7          	jalr	718(ra) # 3436 <exit>

0000000000003170 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3170:	1141                	addi	sp,sp,-16
    3172:	e422                	sd	s0,8(sp)
    3174:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3176:	87aa                	mv	a5,a0
    3178:	0585                	addi	a1,a1,1
    317a:	0785                	addi	a5,a5,1
    317c:	fff5c703          	lbu	a4,-1(a1)
    3180:	fee78fa3          	sb	a4,-1(a5) # 99fff <base+0x95fef>
    3184:	fb75                	bnez	a4,3178 <strcpy+0x8>
    ;
  return os;
}
    3186:	6422                	ld	s0,8(sp)
    3188:	0141                	addi	sp,sp,16
    318a:	8082                	ret

000000000000318c <strcmp>:

int
strcmp(const char *p, const char *q)
{
    318c:	1141                	addi	sp,sp,-16
    318e:	e422                	sd	s0,8(sp)
    3190:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    3192:	00054783          	lbu	a5,0(a0)
    3196:	cb91                	beqz	a5,31aa <strcmp+0x1e>
    3198:	0005c703          	lbu	a4,0(a1)
    319c:	00f71763          	bne	a4,a5,31aa <strcmp+0x1e>
    p++, q++;
    31a0:	0505                	addi	a0,a0,1
    31a2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    31a4:	00054783          	lbu	a5,0(a0)
    31a8:	fbe5                	bnez	a5,3198 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    31aa:	0005c503          	lbu	a0,0(a1)
}
    31ae:	40a7853b          	subw	a0,a5,a0
    31b2:	6422                	ld	s0,8(sp)
    31b4:	0141                	addi	sp,sp,16
    31b6:	8082                	ret

00000000000031b8 <strlen>:

uint
strlen(const char *s)
{
    31b8:	1141                	addi	sp,sp,-16
    31ba:	e422                	sd	s0,8(sp)
    31bc:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    31be:	00054783          	lbu	a5,0(a0)
    31c2:	cf91                	beqz	a5,31de <strlen+0x26>
    31c4:	0505                	addi	a0,a0,1
    31c6:	87aa                	mv	a5,a0
    31c8:	4685                	li	a3,1
    31ca:	9e89                	subw	a3,a3,a0
    31cc:	00f6853b          	addw	a0,a3,a5
    31d0:	0785                	addi	a5,a5,1
    31d2:	fff7c703          	lbu	a4,-1(a5)
    31d6:	fb7d                	bnez	a4,31cc <strlen+0x14>
    ;
  return n;
}
    31d8:	6422                	ld	s0,8(sp)
    31da:	0141                	addi	sp,sp,16
    31dc:	8082                	ret
  for(n = 0; s[n]; n++)
    31de:	4501                	li	a0,0
    31e0:	bfe5                	j	31d8 <strlen+0x20>

00000000000031e2 <memset>:

void*
memset(void *dst, int c, uint n)
{
    31e2:	1141                	addi	sp,sp,-16
    31e4:	e422                	sd	s0,8(sp)
    31e6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    31e8:	ca19                	beqz	a2,31fe <memset+0x1c>
    31ea:	87aa                	mv	a5,a0
    31ec:	1602                	slli	a2,a2,0x20
    31ee:	9201                	srli	a2,a2,0x20
    31f0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    31f4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    31f8:	0785                	addi	a5,a5,1
    31fa:	fee79de3          	bne	a5,a4,31f4 <memset+0x12>
  }
  return dst;
}
    31fe:	6422                	ld	s0,8(sp)
    3200:	0141                	addi	sp,sp,16
    3202:	8082                	ret

0000000000003204 <strchr>:

char*
strchr(const char *s, char c)
{
    3204:	1141                	addi	sp,sp,-16
    3206:	e422                	sd	s0,8(sp)
    3208:	0800                	addi	s0,sp,16
  for(; *s; s++)
    320a:	00054783          	lbu	a5,0(a0)
    320e:	cb99                	beqz	a5,3224 <strchr+0x20>
    if(*s == c)
    3210:	00f58763          	beq	a1,a5,321e <strchr+0x1a>
  for(; *s; s++)
    3214:	0505                	addi	a0,a0,1
    3216:	00054783          	lbu	a5,0(a0)
    321a:	fbfd                	bnez	a5,3210 <strchr+0xc>
      return (char*)s;
  return 0;
    321c:	4501                	li	a0,0
}
    321e:	6422                	ld	s0,8(sp)
    3220:	0141                	addi	sp,sp,16
    3222:	8082                	ret
  return 0;
    3224:	4501                	li	a0,0
    3226:	bfe5                	j	321e <strchr+0x1a>

0000000000003228 <gets>:

char*
gets(char *buf, int max)
{
    3228:	711d                	addi	sp,sp,-96
    322a:	ec86                	sd	ra,88(sp)
    322c:	e8a2                	sd	s0,80(sp)
    322e:	e4a6                	sd	s1,72(sp)
    3230:	e0ca                	sd	s2,64(sp)
    3232:	fc4e                	sd	s3,56(sp)
    3234:	f852                	sd	s4,48(sp)
    3236:	f456                	sd	s5,40(sp)
    3238:	f05a                	sd	s6,32(sp)
    323a:	ec5e                	sd	s7,24(sp)
    323c:	1080                	addi	s0,sp,96
    323e:	8baa                	mv	s7,a0
    3240:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3242:	892a                	mv	s2,a0
    3244:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3246:	4aa9                	li	s5,10
    3248:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    324a:	89a6                	mv	s3,s1
    324c:	2485                	addiw	s1,s1,1
    324e:	0344d863          	bge	s1,s4,327e <gets+0x56>
    cc = read(0, &c, 1);
    3252:	4605                	li	a2,1
    3254:	faf40593          	addi	a1,s0,-81
    3258:	4501                	li	a0,0
    325a:	00000097          	auipc	ra,0x0
    325e:	1fc080e7          	jalr	508(ra) # 3456 <read>
    if(cc < 1)
    3262:	00a05e63          	blez	a0,327e <gets+0x56>
    buf[i++] = c;
    3266:	faf44783          	lbu	a5,-81(s0)
    326a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    326e:	01578763          	beq	a5,s5,327c <gets+0x54>
    3272:	0905                	addi	s2,s2,1
    3274:	fd679be3          	bne	a5,s6,324a <gets+0x22>
  for(i=0; i+1 < max; ){
    3278:	89a6                	mv	s3,s1
    327a:	a011                	j	327e <gets+0x56>
    327c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    327e:	99de                	add	s3,s3,s7
    3280:	00098023          	sb	zero,0(s3)
  return buf;
}
    3284:	855e                	mv	a0,s7
    3286:	60e6                	ld	ra,88(sp)
    3288:	6446                	ld	s0,80(sp)
    328a:	64a6                	ld	s1,72(sp)
    328c:	6906                	ld	s2,64(sp)
    328e:	79e2                	ld	s3,56(sp)
    3290:	7a42                	ld	s4,48(sp)
    3292:	7aa2                	ld	s5,40(sp)
    3294:	7b02                	ld	s6,32(sp)
    3296:	6be2                	ld	s7,24(sp)
    3298:	6125                	addi	sp,sp,96
    329a:	8082                	ret

000000000000329c <stat>:

int
stat(const char *n, struct stat *st)
{
    329c:	1101                	addi	sp,sp,-32
    329e:	ec06                	sd	ra,24(sp)
    32a0:	e822                	sd	s0,16(sp)
    32a2:	e426                	sd	s1,8(sp)
    32a4:	e04a                	sd	s2,0(sp)
    32a6:	1000                	addi	s0,sp,32
    32a8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    32aa:	4581                	li	a1,0
    32ac:	00000097          	auipc	ra,0x0
    32b0:	1d2080e7          	jalr	466(ra) # 347e <open>
  if(fd < 0)
    32b4:	02054563          	bltz	a0,32de <stat+0x42>
    32b8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    32ba:	85ca                	mv	a1,s2
    32bc:	00000097          	auipc	ra,0x0
    32c0:	1da080e7          	jalr	474(ra) # 3496 <fstat>
    32c4:	892a                	mv	s2,a0
  close(fd);
    32c6:	8526                	mv	a0,s1
    32c8:	00000097          	auipc	ra,0x0
    32cc:	19e080e7          	jalr	414(ra) # 3466 <close>
  return r;
}
    32d0:	854a                	mv	a0,s2
    32d2:	60e2                	ld	ra,24(sp)
    32d4:	6442                	ld	s0,16(sp)
    32d6:	64a2                	ld	s1,8(sp)
    32d8:	6902                	ld	s2,0(sp)
    32da:	6105                	addi	sp,sp,32
    32dc:	8082                	ret
    return -1;
    32de:	597d                	li	s2,-1
    32e0:	bfc5                	j	32d0 <stat+0x34>

00000000000032e2 <atoi>:

int
atoi(const char *s)
{
    32e2:	1141                	addi	sp,sp,-16
    32e4:	e422                	sd	s0,8(sp)
    32e6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    32e8:	00054603          	lbu	a2,0(a0)
    32ec:	fd06079b          	addiw	a5,a2,-48
    32f0:	0ff7f793          	andi	a5,a5,255
    32f4:	4725                	li	a4,9
    32f6:	02f76963          	bltu	a4,a5,3328 <atoi+0x46>
    32fa:	86aa                	mv	a3,a0
  n = 0;
    32fc:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    32fe:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    3300:	0685                	addi	a3,a3,1
    3302:	0025179b          	slliw	a5,a0,0x2
    3306:	9fa9                	addw	a5,a5,a0
    3308:	0017979b          	slliw	a5,a5,0x1
    330c:	9fb1                	addw	a5,a5,a2
    330e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    3312:	0006c603          	lbu	a2,0(a3)
    3316:	fd06071b          	addiw	a4,a2,-48
    331a:	0ff77713          	andi	a4,a4,255
    331e:	fee5f1e3          	bgeu	a1,a4,3300 <atoi+0x1e>
  return n;
}
    3322:	6422                	ld	s0,8(sp)
    3324:	0141                	addi	sp,sp,16
    3326:	8082                	ret
  n = 0;
    3328:	4501                	li	a0,0
    332a:	bfe5                	j	3322 <atoi+0x40>

000000000000332c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    332c:	1141                	addi	sp,sp,-16
    332e:	e422                	sd	s0,8(sp)
    3330:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    3332:	02b57463          	bgeu	a0,a1,335a <memmove+0x2e>
    while(n-- > 0)
    3336:	00c05f63          	blez	a2,3354 <memmove+0x28>
    333a:	1602                	slli	a2,a2,0x20
    333c:	9201                	srli	a2,a2,0x20
    333e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    3342:	872a                	mv	a4,a0
      *dst++ = *src++;
    3344:	0585                	addi	a1,a1,1
    3346:	0705                	addi	a4,a4,1
    3348:	fff5c683          	lbu	a3,-1(a1)
    334c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3350:	fee79ae3          	bne	a5,a4,3344 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    3354:	6422                	ld	s0,8(sp)
    3356:	0141                	addi	sp,sp,16
    3358:	8082                	ret
    dst += n;
    335a:	00c50733          	add	a4,a0,a2
    src += n;
    335e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    3360:	fec05ae3          	blez	a2,3354 <memmove+0x28>
    3364:	fff6079b          	addiw	a5,a2,-1
    3368:	1782                	slli	a5,a5,0x20
    336a:	9381                	srli	a5,a5,0x20
    336c:	fff7c793          	not	a5,a5
    3370:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3372:	15fd                	addi	a1,a1,-1
    3374:	177d                	addi	a4,a4,-1
    3376:	0005c683          	lbu	a3,0(a1)
    337a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    337e:	fee79ae3          	bne	a5,a4,3372 <memmove+0x46>
    3382:	bfc9                	j	3354 <memmove+0x28>

0000000000003384 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    3384:	1141                	addi	sp,sp,-16
    3386:	e422                	sd	s0,8(sp)
    3388:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    338a:	ca05                	beqz	a2,33ba <memcmp+0x36>
    338c:	fff6069b          	addiw	a3,a2,-1
    3390:	1682                	slli	a3,a3,0x20
    3392:	9281                	srli	a3,a3,0x20
    3394:	0685                	addi	a3,a3,1
    3396:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    3398:	00054783          	lbu	a5,0(a0)
    339c:	0005c703          	lbu	a4,0(a1)
    33a0:	00e79863          	bne	a5,a4,33b0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    33a4:	0505                	addi	a0,a0,1
    p2++;
    33a6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    33a8:	fed518e3          	bne	a0,a3,3398 <memcmp+0x14>
  }
  return 0;
    33ac:	4501                	li	a0,0
    33ae:	a019                	j	33b4 <memcmp+0x30>
      return *p1 - *p2;
    33b0:	40e7853b          	subw	a0,a5,a4
}
    33b4:	6422                	ld	s0,8(sp)
    33b6:	0141                	addi	sp,sp,16
    33b8:	8082                	ret
  return 0;
    33ba:	4501                	li	a0,0
    33bc:	bfe5                	j	33b4 <memcmp+0x30>

00000000000033be <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    33be:	1141                	addi	sp,sp,-16
    33c0:	e406                	sd	ra,8(sp)
    33c2:	e022                	sd	s0,0(sp)
    33c4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    33c6:	00000097          	auipc	ra,0x0
    33ca:	f66080e7          	jalr	-154(ra) # 332c <memmove>
}
    33ce:	60a2                	ld	ra,8(sp)
    33d0:	6402                	ld	s0,0(sp)
    33d2:	0141                	addi	sp,sp,16
    33d4:	8082                	ret

00000000000033d6 <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    33d6:	1141                	addi	sp,sp,-16
    33d8:	e422                	sd	s0,8(sp)
    33da:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    33dc:	00052023          	sw	zero,0(a0)
}  
    33e0:	6422                	ld	s0,8(sp)
    33e2:	0141                	addi	sp,sp,16
    33e4:	8082                	ret

00000000000033e6 <lock>:

void lock(struct spinlock * lk) 
{    
    33e6:	1141                	addi	sp,sp,-16
    33e8:	e422                	sd	s0,8(sp)
    33ea:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    33ec:	4705                	li	a4,1
    33ee:	87ba                	mv	a5,a4
    33f0:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    33f4:	2781                	sext.w	a5,a5
    33f6:	ffe5                	bnez	a5,33ee <lock+0x8>
}  
    33f8:	6422                	ld	s0,8(sp)
    33fa:	0141                	addi	sp,sp,16
    33fc:	8082                	ret

00000000000033fe <unlock>:

void unlock(struct spinlock * lk) 
{   
    33fe:	1141                	addi	sp,sp,-16
    3400:	e422                	sd	s0,8(sp)
    3402:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    3404:	0f50000f          	fence	iorw,ow
    3408:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    340c:	6422                	ld	s0,8(sp)
    340e:	0141                	addi	sp,sp,16
    3410:	8082                	ret

0000000000003412 <isDigit>:

unsigned int isDigit(char *c) {
    3412:	1141                	addi	sp,sp,-16
    3414:	e422                	sd	s0,8(sp)
    3416:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    3418:	00054503          	lbu	a0,0(a0)
    341c:	fd05051b          	addiw	a0,a0,-48
    3420:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    3424:	00a53513          	sltiu	a0,a0,10
    3428:	6422                	ld	s0,8(sp)
    342a:	0141                	addi	sp,sp,16
    342c:	8082                	ret

000000000000342e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    342e:	4885                	li	a7,1
 ecall
    3430:	00000073          	ecall
 ret
    3434:	8082                	ret

0000000000003436 <exit>:
.global exit
exit:
 li a7, SYS_exit
    3436:	4889                	li	a7,2
 ecall
    3438:	00000073          	ecall
 ret
    343c:	8082                	ret

000000000000343e <wait>:
.global wait
wait:
 li a7, SYS_wait
    343e:	488d                	li	a7,3
 ecall
    3440:	00000073          	ecall
 ret
    3444:	8082                	ret

0000000000003446 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    3446:	48e1                	li	a7,24
 ecall
    3448:	00000073          	ecall
 ret
    344c:	8082                	ret

000000000000344e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    344e:	4891                	li	a7,4
 ecall
    3450:	00000073          	ecall
 ret
    3454:	8082                	ret

0000000000003456 <read>:
.global read
read:
 li a7, SYS_read
    3456:	4895                	li	a7,5
 ecall
    3458:	00000073          	ecall
 ret
    345c:	8082                	ret

000000000000345e <write>:
.global write
write:
 li a7, SYS_write
    345e:	48c1                	li	a7,16
 ecall
    3460:	00000073          	ecall
 ret
    3464:	8082                	ret

0000000000003466 <close>:
.global close
close:
 li a7, SYS_close
    3466:	48d5                	li	a7,21
 ecall
    3468:	00000073          	ecall
 ret
    346c:	8082                	ret

000000000000346e <kill>:
.global kill
kill:
 li a7, SYS_kill
    346e:	4899                	li	a7,6
 ecall
    3470:	00000073          	ecall
 ret
    3474:	8082                	ret

0000000000003476 <exec>:
.global exec
exec:
 li a7, SYS_exec
    3476:	489d                	li	a7,7
 ecall
    3478:	00000073          	ecall
 ret
    347c:	8082                	ret

000000000000347e <open>:
.global open
open:
 li a7, SYS_open
    347e:	48bd                	li	a7,15
 ecall
    3480:	00000073          	ecall
 ret
    3484:	8082                	ret

0000000000003486 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    3486:	48c5                	li	a7,17
 ecall
    3488:	00000073          	ecall
 ret
    348c:	8082                	ret

000000000000348e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    348e:	48c9                	li	a7,18
 ecall
    3490:	00000073          	ecall
 ret
    3494:	8082                	ret

0000000000003496 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    3496:	48a1                	li	a7,8
 ecall
    3498:	00000073          	ecall
 ret
    349c:	8082                	ret

000000000000349e <link>:
.global link
link:
 li a7, SYS_link
    349e:	48cd                	li	a7,19
 ecall
    34a0:	00000073          	ecall
 ret
    34a4:	8082                	ret

00000000000034a6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    34a6:	48d1                	li	a7,20
 ecall
    34a8:	00000073          	ecall
 ret
    34ac:	8082                	ret

00000000000034ae <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    34ae:	48a5                	li	a7,9
 ecall
    34b0:	00000073          	ecall
 ret
    34b4:	8082                	ret

00000000000034b6 <dup>:
.global dup
dup:
 li a7, SYS_dup
    34b6:	48a9                	li	a7,10
 ecall
    34b8:	00000073          	ecall
 ret
    34bc:	8082                	ret

00000000000034be <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    34be:	48ad                	li	a7,11
 ecall
    34c0:	00000073          	ecall
 ret
    34c4:	8082                	ret

00000000000034c6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    34c6:	48b1                	li	a7,12
 ecall
    34c8:	00000073          	ecall
 ret
    34cc:	8082                	ret

00000000000034ce <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    34ce:	48b5                	li	a7,13
 ecall
    34d0:	00000073          	ecall
 ret
    34d4:	8082                	ret

00000000000034d6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    34d6:	48b9                	li	a7,14
 ecall
    34d8:	00000073          	ecall
 ret
    34dc:	8082                	ret

00000000000034de <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    34de:	48d9                	li	a7,22
 ecall
    34e0:	00000073          	ecall
 ret
    34e4:	8082                	ret

00000000000034e6 <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    34e6:	48dd                	li	a7,23
 ecall
    34e8:	00000073          	ecall
 ret
    34ec:	8082                	ret

00000000000034ee <ps>:
.global ps
ps:
 li a7, SYS_ps
    34ee:	48e5                	li	a7,25
 ecall
    34f0:	00000073          	ecall
 ret
    34f4:	8082                	ret

00000000000034f6 <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    34f6:	48e9                	li	a7,26
 ecall
    34f8:	00000073          	ecall
 ret
    34fc:	8082                	ret

00000000000034fe <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    34fe:	48ed                	li	a7,27
 ecall
    3500:	00000073          	ecall
 ret
    3504:	8082                	ret

0000000000003506 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    3506:	1101                	addi	sp,sp,-32
    3508:	ec06                	sd	ra,24(sp)
    350a:	e822                	sd	s0,16(sp)
    350c:	1000                	addi	s0,sp,32
    350e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    3512:	4605                	li	a2,1
    3514:	fef40593          	addi	a1,s0,-17
    3518:	00000097          	auipc	ra,0x0
    351c:	f46080e7          	jalr	-186(ra) # 345e <write>
}
    3520:	60e2                	ld	ra,24(sp)
    3522:	6442                	ld	s0,16(sp)
    3524:	6105                	addi	sp,sp,32
    3526:	8082                	ret

0000000000003528 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3528:	7139                	addi	sp,sp,-64
    352a:	fc06                	sd	ra,56(sp)
    352c:	f822                	sd	s0,48(sp)
    352e:	f426                	sd	s1,40(sp)
    3530:	f04a                	sd	s2,32(sp)
    3532:	ec4e                	sd	s3,24(sp)
    3534:	0080                	addi	s0,sp,64
    3536:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3538:	c299                	beqz	a3,353e <printint+0x16>
    353a:	0805c863          	bltz	a1,35ca <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    353e:	2581                	sext.w	a1,a1
  neg = 0;
    3540:	4881                	li	a7,0
    3542:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    3546:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    3548:	2601                	sext.w	a2,a2
    354a:	00000517          	auipc	a0,0x0
    354e:	4fe50513          	addi	a0,a0,1278 # 3a48 <digits>
    3552:	883a                	mv	a6,a4
    3554:	2705                	addiw	a4,a4,1
    3556:	02c5f7bb          	remuw	a5,a1,a2
    355a:	1782                	slli	a5,a5,0x20
    355c:	9381                	srli	a5,a5,0x20
    355e:	97aa                	add	a5,a5,a0
    3560:	0007c783          	lbu	a5,0(a5)
    3564:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    3568:	0005879b          	sext.w	a5,a1
    356c:	02c5d5bb          	divuw	a1,a1,a2
    3570:	0685                	addi	a3,a3,1
    3572:	fec7f0e3          	bgeu	a5,a2,3552 <printint+0x2a>
  if(neg)
    3576:	00088b63          	beqz	a7,358c <printint+0x64>
    buf[i++] = '-';
    357a:	fd040793          	addi	a5,s0,-48
    357e:	973e                	add	a4,a4,a5
    3580:	02d00793          	li	a5,45
    3584:	fef70823          	sb	a5,-16(a4)
    3588:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    358c:	02e05863          	blez	a4,35bc <printint+0x94>
    3590:	fc040793          	addi	a5,s0,-64
    3594:	00e78933          	add	s2,a5,a4
    3598:	fff78993          	addi	s3,a5,-1
    359c:	99ba                	add	s3,s3,a4
    359e:	377d                	addiw	a4,a4,-1
    35a0:	1702                	slli	a4,a4,0x20
    35a2:	9301                	srli	a4,a4,0x20
    35a4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    35a8:	fff94583          	lbu	a1,-1(s2)
    35ac:	8526                	mv	a0,s1
    35ae:	00000097          	auipc	ra,0x0
    35b2:	f58080e7          	jalr	-168(ra) # 3506 <putc>
  while(--i >= 0)
    35b6:	197d                	addi	s2,s2,-1
    35b8:	ff3918e3          	bne	s2,s3,35a8 <printint+0x80>
}
    35bc:	70e2                	ld	ra,56(sp)
    35be:	7442                	ld	s0,48(sp)
    35c0:	74a2                	ld	s1,40(sp)
    35c2:	7902                	ld	s2,32(sp)
    35c4:	69e2                	ld	s3,24(sp)
    35c6:	6121                	addi	sp,sp,64
    35c8:	8082                	ret
    x = -xx;
    35ca:	40b005bb          	negw	a1,a1
    neg = 1;
    35ce:	4885                	li	a7,1
    x = -xx;
    35d0:	bf8d                	j	3542 <printint+0x1a>

00000000000035d2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    35d2:	7119                	addi	sp,sp,-128
    35d4:	fc86                	sd	ra,120(sp)
    35d6:	f8a2                	sd	s0,112(sp)
    35d8:	f4a6                	sd	s1,104(sp)
    35da:	f0ca                	sd	s2,96(sp)
    35dc:	ecce                	sd	s3,88(sp)
    35de:	e8d2                	sd	s4,80(sp)
    35e0:	e4d6                	sd	s5,72(sp)
    35e2:	e0da                	sd	s6,64(sp)
    35e4:	fc5e                	sd	s7,56(sp)
    35e6:	f862                	sd	s8,48(sp)
    35e8:	f466                	sd	s9,40(sp)
    35ea:	f06a                	sd	s10,32(sp)
    35ec:	ec6e                	sd	s11,24(sp)
    35ee:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    35f0:	0005c903          	lbu	s2,0(a1)
    35f4:	18090f63          	beqz	s2,3792 <vprintf+0x1c0>
    35f8:	8aaa                	mv	s5,a0
    35fa:	8b32                	mv	s6,a2
    35fc:	00158493          	addi	s1,a1,1
  state = 0;
    3600:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3602:	02500a13          	li	s4,37
      if(c == 'd'){
    3606:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    360a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    360e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    3612:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3616:	00000b97          	auipc	s7,0x0
    361a:	432b8b93          	addi	s7,s7,1074 # 3a48 <digits>
    361e:	a839                	j	363c <vprintf+0x6a>
        putc(fd, c);
    3620:	85ca                	mv	a1,s2
    3622:	8556                	mv	a0,s5
    3624:	00000097          	auipc	ra,0x0
    3628:	ee2080e7          	jalr	-286(ra) # 3506 <putc>
    362c:	a019                	j	3632 <vprintf+0x60>
    } else if(state == '%'){
    362e:	01498f63          	beq	s3,s4,364c <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    3632:	0485                	addi	s1,s1,1
    3634:	fff4c903          	lbu	s2,-1(s1)
    3638:	14090d63          	beqz	s2,3792 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    363c:	0009079b          	sext.w	a5,s2
    if(state == 0){
    3640:	fe0997e3          	bnez	s3,362e <vprintf+0x5c>
      if(c == '%'){
    3644:	fd479ee3          	bne	a5,s4,3620 <vprintf+0x4e>
        state = '%';
    3648:	89be                	mv	s3,a5
    364a:	b7e5                	j	3632 <vprintf+0x60>
      if(c == 'd'){
    364c:	05878063          	beq	a5,s8,368c <vprintf+0xba>
      } else if(c == 'l') {
    3650:	05978c63          	beq	a5,s9,36a8 <vprintf+0xd6>
      } else if(c == 'x') {
    3654:	07a78863          	beq	a5,s10,36c4 <vprintf+0xf2>
      } else if(c == 'p') {
    3658:	09b78463          	beq	a5,s11,36e0 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    365c:	07300713          	li	a4,115
    3660:	0ce78663          	beq	a5,a4,372c <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3664:	06300713          	li	a4,99
    3668:	0ee78e63          	beq	a5,a4,3764 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    366c:	11478863          	beq	a5,s4,377c <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3670:	85d2                	mv	a1,s4
    3672:	8556                	mv	a0,s5
    3674:	00000097          	auipc	ra,0x0
    3678:	e92080e7          	jalr	-366(ra) # 3506 <putc>
        putc(fd, c);
    367c:	85ca                	mv	a1,s2
    367e:	8556                	mv	a0,s5
    3680:	00000097          	auipc	ra,0x0
    3684:	e86080e7          	jalr	-378(ra) # 3506 <putc>
      }
      state = 0;
    3688:	4981                	li	s3,0
    368a:	b765                	j	3632 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    368c:	008b0913          	addi	s2,s6,8
    3690:	4685                	li	a3,1
    3692:	4629                	li	a2,10
    3694:	000b2583          	lw	a1,0(s6)
    3698:	8556                	mv	a0,s5
    369a:	00000097          	auipc	ra,0x0
    369e:	e8e080e7          	jalr	-370(ra) # 3528 <printint>
    36a2:	8b4a                	mv	s6,s2
      state = 0;
    36a4:	4981                	li	s3,0
    36a6:	b771                	j	3632 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    36a8:	008b0913          	addi	s2,s6,8
    36ac:	4681                	li	a3,0
    36ae:	4629                	li	a2,10
    36b0:	000b2583          	lw	a1,0(s6)
    36b4:	8556                	mv	a0,s5
    36b6:	00000097          	auipc	ra,0x0
    36ba:	e72080e7          	jalr	-398(ra) # 3528 <printint>
    36be:	8b4a                	mv	s6,s2
      state = 0;
    36c0:	4981                	li	s3,0
    36c2:	bf85                	j	3632 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    36c4:	008b0913          	addi	s2,s6,8
    36c8:	4681                	li	a3,0
    36ca:	4641                	li	a2,16
    36cc:	000b2583          	lw	a1,0(s6)
    36d0:	8556                	mv	a0,s5
    36d2:	00000097          	auipc	ra,0x0
    36d6:	e56080e7          	jalr	-426(ra) # 3528 <printint>
    36da:	8b4a                	mv	s6,s2
      state = 0;
    36dc:	4981                	li	s3,0
    36de:	bf91                	j	3632 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    36e0:	008b0793          	addi	a5,s6,8
    36e4:	f8f43423          	sd	a5,-120(s0)
    36e8:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    36ec:	03000593          	li	a1,48
    36f0:	8556                	mv	a0,s5
    36f2:	00000097          	auipc	ra,0x0
    36f6:	e14080e7          	jalr	-492(ra) # 3506 <putc>
  putc(fd, 'x');
    36fa:	85ea                	mv	a1,s10
    36fc:	8556                	mv	a0,s5
    36fe:	00000097          	auipc	ra,0x0
    3702:	e08080e7          	jalr	-504(ra) # 3506 <putc>
    3706:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3708:	03c9d793          	srli	a5,s3,0x3c
    370c:	97de                	add	a5,a5,s7
    370e:	0007c583          	lbu	a1,0(a5)
    3712:	8556                	mv	a0,s5
    3714:	00000097          	auipc	ra,0x0
    3718:	df2080e7          	jalr	-526(ra) # 3506 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    371c:	0992                	slli	s3,s3,0x4
    371e:	397d                	addiw	s2,s2,-1
    3720:	fe0914e3          	bnez	s2,3708 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    3724:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    3728:	4981                	li	s3,0
    372a:	b721                	j	3632 <vprintf+0x60>
        s = va_arg(ap, char*);
    372c:	008b0993          	addi	s3,s6,8
    3730:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    3734:	02090163          	beqz	s2,3756 <vprintf+0x184>
        while(*s != 0){
    3738:	00094583          	lbu	a1,0(s2)
    373c:	c9a1                	beqz	a1,378c <vprintf+0x1ba>
          putc(fd, *s);
    373e:	8556                	mv	a0,s5
    3740:	00000097          	auipc	ra,0x0
    3744:	dc6080e7          	jalr	-570(ra) # 3506 <putc>
          s++;
    3748:	0905                	addi	s2,s2,1
        while(*s != 0){
    374a:	00094583          	lbu	a1,0(s2)
    374e:	f9e5                	bnez	a1,373e <vprintf+0x16c>
        s = va_arg(ap, char*);
    3750:	8b4e                	mv	s6,s3
      state = 0;
    3752:	4981                	li	s3,0
    3754:	bdf9                	j	3632 <vprintf+0x60>
          s = "(null)";
    3756:	00000917          	auipc	s2,0x0
    375a:	2ea90913          	addi	s2,s2,746 # 3a40 <malloc+0x1a4>
        while(*s != 0){
    375e:	02800593          	li	a1,40
    3762:	bff1                	j	373e <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    3764:	008b0913          	addi	s2,s6,8
    3768:	000b4583          	lbu	a1,0(s6)
    376c:	8556                	mv	a0,s5
    376e:	00000097          	auipc	ra,0x0
    3772:	d98080e7          	jalr	-616(ra) # 3506 <putc>
    3776:	8b4a                	mv	s6,s2
      state = 0;
    3778:	4981                	li	s3,0
    377a:	bd65                	j	3632 <vprintf+0x60>
        putc(fd, c);
    377c:	85d2                	mv	a1,s4
    377e:	8556                	mv	a0,s5
    3780:	00000097          	auipc	ra,0x0
    3784:	d86080e7          	jalr	-634(ra) # 3506 <putc>
      state = 0;
    3788:	4981                	li	s3,0
    378a:	b565                	j	3632 <vprintf+0x60>
        s = va_arg(ap, char*);
    378c:	8b4e                	mv	s6,s3
      state = 0;
    378e:	4981                	li	s3,0
    3790:	b54d                	j	3632 <vprintf+0x60>
    }
  }
}
    3792:	70e6                	ld	ra,120(sp)
    3794:	7446                	ld	s0,112(sp)
    3796:	74a6                	ld	s1,104(sp)
    3798:	7906                	ld	s2,96(sp)
    379a:	69e6                	ld	s3,88(sp)
    379c:	6a46                	ld	s4,80(sp)
    379e:	6aa6                	ld	s5,72(sp)
    37a0:	6b06                	ld	s6,64(sp)
    37a2:	7be2                	ld	s7,56(sp)
    37a4:	7c42                	ld	s8,48(sp)
    37a6:	7ca2                	ld	s9,40(sp)
    37a8:	7d02                	ld	s10,32(sp)
    37aa:	6de2                	ld	s11,24(sp)
    37ac:	6109                	addi	sp,sp,128
    37ae:	8082                	ret

00000000000037b0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    37b0:	715d                	addi	sp,sp,-80
    37b2:	ec06                	sd	ra,24(sp)
    37b4:	e822                	sd	s0,16(sp)
    37b6:	1000                	addi	s0,sp,32
    37b8:	e010                	sd	a2,0(s0)
    37ba:	e414                	sd	a3,8(s0)
    37bc:	e818                	sd	a4,16(s0)
    37be:	ec1c                	sd	a5,24(s0)
    37c0:	03043023          	sd	a6,32(s0)
    37c4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    37c8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    37cc:	8622                	mv	a2,s0
    37ce:	00000097          	auipc	ra,0x0
    37d2:	e04080e7          	jalr	-508(ra) # 35d2 <vprintf>
}
    37d6:	60e2                	ld	ra,24(sp)
    37d8:	6442                	ld	s0,16(sp)
    37da:	6161                	addi	sp,sp,80
    37dc:	8082                	ret

00000000000037de <printf>:

void
printf(const char *fmt, ...)
{
    37de:	711d                	addi	sp,sp,-96
    37e0:	ec06                	sd	ra,24(sp)
    37e2:	e822                	sd	s0,16(sp)
    37e4:	1000                	addi	s0,sp,32
    37e6:	e40c                	sd	a1,8(s0)
    37e8:	e810                	sd	a2,16(s0)
    37ea:	ec14                	sd	a3,24(s0)
    37ec:	f018                	sd	a4,32(s0)
    37ee:	f41c                	sd	a5,40(s0)
    37f0:	03043823          	sd	a6,48(s0)
    37f4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    37f8:	00840613          	addi	a2,s0,8
    37fc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    3800:	85aa                	mv	a1,a0
    3802:	4505                	li	a0,1
    3804:	00000097          	auipc	ra,0x0
    3808:	dce080e7          	jalr	-562(ra) # 35d2 <vprintf>
}
    380c:	60e2                	ld	ra,24(sp)
    380e:	6442                	ld	s0,16(sp)
    3810:	6125                	addi	sp,sp,96
    3812:	8082                	ret

0000000000003814 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3814:	1141                	addi	sp,sp,-16
    3816:	e422                	sd	s0,8(sp)
    3818:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    381a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    381e:	00000797          	auipc	a5,0x0
    3822:	7e27b783          	ld	a5,2018(a5) # 4000 <freep>
    3826:	a805                	j	3856 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3828:	4618                	lw	a4,8(a2)
    382a:	9db9                	addw	a1,a1,a4
    382c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    3830:	6398                	ld	a4,0(a5)
    3832:	6318                	ld	a4,0(a4)
    3834:	fee53823          	sd	a4,-16(a0)
    3838:	a091                	j	387c <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    383a:	ff852703          	lw	a4,-8(a0)
    383e:	9e39                	addw	a2,a2,a4
    3840:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    3842:	ff053703          	ld	a4,-16(a0)
    3846:	e398                	sd	a4,0(a5)
    3848:	a099                	j	388e <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    384a:	6398                	ld	a4,0(a5)
    384c:	00e7e463          	bltu	a5,a4,3854 <free+0x40>
    3850:	00e6ea63          	bltu	a3,a4,3864 <free+0x50>
{
    3854:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3856:	fed7fae3          	bgeu	a5,a3,384a <free+0x36>
    385a:	6398                	ld	a4,0(a5)
    385c:	00e6e463          	bltu	a3,a4,3864 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3860:	fee7eae3          	bltu	a5,a4,3854 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    3864:	ff852583          	lw	a1,-8(a0)
    3868:	6390                	ld	a2,0(a5)
    386a:	02059713          	slli	a4,a1,0x20
    386e:	9301                	srli	a4,a4,0x20
    3870:	0712                	slli	a4,a4,0x4
    3872:	9736                	add	a4,a4,a3
    3874:	fae60ae3          	beq	a2,a4,3828 <free+0x14>
    bp->s.ptr = p->s.ptr;
    3878:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    387c:	4790                	lw	a2,8(a5)
    387e:	02061713          	slli	a4,a2,0x20
    3882:	9301                	srli	a4,a4,0x20
    3884:	0712                	slli	a4,a4,0x4
    3886:	973e                	add	a4,a4,a5
    3888:	fae689e3          	beq	a3,a4,383a <free+0x26>
  } else
    p->s.ptr = bp;
    388c:	e394                	sd	a3,0(a5)
  freep = p;
    388e:	00000717          	auipc	a4,0x0
    3892:	76f73923          	sd	a5,1906(a4) # 4000 <freep>
}
    3896:	6422                	ld	s0,8(sp)
    3898:	0141                	addi	sp,sp,16
    389a:	8082                	ret

000000000000389c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    389c:	7139                	addi	sp,sp,-64
    389e:	fc06                	sd	ra,56(sp)
    38a0:	f822                	sd	s0,48(sp)
    38a2:	f426                	sd	s1,40(sp)
    38a4:	f04a                	sd	s2,32(sp)
    38a6:	ec4e                	sd	s3,24(sp)
    38a8:	e852                	sd	s4,16(sp)
    38aa:	e456                	sd	s5,8(sp)
    38ac:	e05a                	sd	s6,0(sp)
    38ae:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    38b0:	02051493          	slli	s1,a0,0x20
    38b4:	9081                	srli	s1,s1,0x20
    38b6:	04bd                	addi	s1,s1,15
    38b8:	8091                	srli	s1,s1,0x4
    38ba:	0014899b          	addiw	s3,s1,1
    38be:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    38c0:	00000517          	auipc	a0,0x0
    38c4:	74053503          	ld	a0,1856(a0) # 4000 <freep>
    38c8:	c515                	beqz	a0,38f4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    38ca:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    38cc:	4798                	lw	a4,8(a5)
    38ce:	02977f63          	bgeu	a4,s1,390c <malloc+0x70>
    38d2:	8a4e                	mv	s4,s3
    38d4:	0009871b          	sext.w	a4,s3
    38d8:	6685                	lui	a3,0x1
    38da:	00d77363          	bgeu	a4,a3,38e0 <malloc+0x44>
    38de:	6a05                	lui	s4,0x1
    38e0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    38e4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    38e8:	00000917          	auipc	s2,0x0
    38ec:	71890913          	addi	s2,s2,1816 # 4000 <freep>
  if(p == (char*)-1)
    38f0:	5afd                	li	s5,-1
    38f2:	a88d                	j	3964 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    38f4:	00000797          	auipc	a5,0x0
    38f8:	71c78793          	addi	a5,a5,1820 # 4010 <base>
    38fc:	00000717          	auipc	a4,0x0
    3900:	70f73223          	sd	a5,1796(a4) # 4000 <freep>
    3904:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    3906:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    390a:	b7e1                	j	38d2 <malloc+0x36>
      if(p->s.size == nunits)
    390c:	02e48b63          	beq	s1,a4,3942 <malloc+0xa6>
        p->s.size -= nunits;
    3910:	4137073b          	subw	a4,a4,s3
    3914:	c798                	sw	a4,8(a5)
        p += p->s.size;
    3916:	1702                	slli	a4,a4,0x20
    3918:	9301                	srli	a4,a4,0x20
    391a:	0712                	slli	a4,a4,0x4
    391c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    391e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    3922:	00000717          	auipc	a4,0x0
    3926:	6ca73f23          	sd	a0,1758(a4) # 4000 <freep>
      return (void*)(p + 1);
    392a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    392e:	70e2                	ld	ra,56(sp)
    3930:	7442                	ld	s0,48(sp)
    3932:	74a2                	ld	s1,40(sp)
    3934:	7902                	ld	s2,32(sp)
    3936:	69e2                	ld	s3,24(sp)
    3938:	6a42                	ld	s4,16(sp)
    393a:	6aa2                	ld	s5,8(sp)
    393c:	6b02                	ld	s6,0(sp)
    393e:	6121                	addi	sp,sp,64
    3940:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3942:	6398                	ld	a4,0(a5)
    3944:	e118                	sd	a4,0(a0)
    3946:	bff1                	j	3922 <malloc+0x86>
  hp->s.size = nu;
    3948:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    394c:	0541                	addi	a0,a0,16
    394e:	00000097          	auipc	ra,0x0
    3952:	ec6080e7          	jalr	-314(ra) # 3814 <free>
  return freep;
    3956:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    395a:	d971                	beqz	a0,392e <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    395c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    395e:	4798                	lw	a4,8(a5)
    3960:	fa9776e3          	bgeu	a4,s1,390c <malloc+0x70>
    if(p == freep)
    3964:	00093703          	ld	a4,0(s2)
    3968:	853e                	mv	a0,a5
    396a:	fef719e3          	bne	a4,a5,395c <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    396e:	8552                	mv	a0,s4
    3970:	00000097          	auipc	ra,0x0
    3974:	b56080e7          	jalr	-1194(ra) # 34c6 <sbrk>
  if(p == (char*)-1)
    3978:	fd5518e3          	bne	a0,s5,3948 <malloc+0xac>
        return 0;
    397c:	4501                	li	a0,0
    397e:	bf45                	j	392e <malloc+0x92>
