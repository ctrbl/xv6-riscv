
user/_heap:     file format elf64-littleriscv


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
    3006:	1000                	addi	s0,sp,32
  uint64 sz = (uint64) sbrk(0); // end of heap
    3008:	4501                	li	a0,0
    300a:	00000097          	auipc	ra,0x0
    300e:	450080e7          	jalr	1104(ra) # 345a <sbrk>
    3012:	fea43423          	sd	a0,-24(s0)
  uint64 stackpage = (160 - 1) * 4096; // start of stack
  uint64 heap = stackpage - (4096*5); // start of heap

  // ensure they actually placed stack high...
  assert((uint64) &sz > stackpage);
    3016:	fe840713          	addi	a4,s0,-24
    301a:	0009f7b7          	lui	a5,0x9f
    301e:	04e7e863          	bltu	a5,a4,306e <main+0x6e>
    3022:	465d                	li	a2,23
    3024:	00001597          	auipc	a1,0x1
    3028:	8fc58593          	addi	a1,a1,-1796 # 3920 <malloc+0xf0>
    302c:	00001517          	auipc	a0,0x1
    3030:	90450513          	addi	a0,a0,-1788 # 3930 <malloc+0x100>
    3034:	00000097          	auipc	ra,0x0
    3038:	73e080e7          	jalr	1854(ra) # 3772 <printf>
    303c:	00001597          	auipc	a1,0x1
    3040:	8fc58593          	addi	a1,a1,-1796 # 3938 <malloc+0x108>
    3044:	00001517          	auipc	a0,0x1
    3048:	91450513          	addi	a0,a0,-1772 # 3958 <malloc+0x128>
    304c:	00000097          	auipc	ra,0x0
    3050:	726080e7          	jalr	1830(ra) # 3772 <printf>
    3054:	00001517          	auipc	a0,0x1
    3058:	91c50513          	addi	a0,a0,-1764 # 3970 <malloc+0x140>
    305c:	00000097          	auipc	ra,0x0
    3060:	716080e7          	jalr	1814(ra) # 3772 <printf>
    3064:	4501                	li	a0,0
    3066:	00000097          	auipc	ra,0x0
    306a:	364080e7          	jalr	868(ra) # 33ca <exit>

  // full use of heap possible
  assert((uint64) sbrk(heap - sz) != -1);
    306e:	0009a7b7          	lui	a5,0x9a
    3072:	40a7853b          	subw	a0,a5,a0
    3076:	00000097          	auipc	ra,0x0
    307a:	3e4080e7          	jalr	996(ra) # 345a <sbrk>
    307e:	57fd                	li	a5,-1
    3080:	00f50f63          	beq	a0,a5,309e <main+0x9e>
  printf("TEST PASSED\n");
    3084:	00001517          	auipc	a0,0x1
    3088:	91c50513          	addi	a0,a0,-1764 # 39a0 <malloc+0x170>
    308c:	00000097          	auipc	ra,0x0
    3090:	6e6080e7          	jalr	1766(ra) # 3772 <printf>
  exit(0);
    3094:	4501                	li	a0,0
    3096:	00000097          	auipc	ra,0x0
    309a:	334080e7          	jalr	820(ra) # 33ca <exit>
  assert((uint64) sbrk(heap - sz) != -1);
    309e:	4669                	li	a2,26
    30a0:	00001597          	auipc	a1,0x1
    30a4:	88058593          	addi	a1,a1,-1920 # 3920 <malloc+0xf0>
    30a8:	00001517          	auipc	a0,0x1
    30ac:	88850513          	addi	a0,a0,-1912 # 3930 <malloc+0x100>
    30b0:	00000097          	auipc	ra,0x0
    30b4:	6c2080e7          	jalr	1730(ra) # 3772 <printf>
    30b8:	00001597          	auipc	a1,0x1
    30bc:	8c858593          	addi	a1,a1,-1848 # 3980 <malloc+0x150>
    30c0:	00001517          	auipc	a0,0x1
    30c4:	89850513          	addi	a0,a0,-1896 # 3958 <malloc+0x128>
    30c8:	00000097          	auipc	ra,0x0
    30cc:	6aa080e7          	jalr	1706(ra) # 3772 <printf>
    30d0:	00001517          	auipc	a0,0x1
    30d4:	8a050513          	addi	a0,a0,-1888 # 3970 <malloc+0x140>
    30d8:	00000097          	auipc	ra,0x0
    30dc:	69a080e7          	jalr	1690(ra) # 3772 <printf>
    30e0:	4501                	li	a0,0
    30e2:	00000097          	auipc	ra,0x0
    30e6:	2e8080e7          	jalr	744(ra) # 33ca <exit>

00000000000030ea <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    30ea:	1141                	addi	sp,sp,-16
    30ec:	e406                	sd	ra,8(sp)
    30ee:	e022                	sd	s0,0(sp)
    30f0:	0800                	addi	s0,sp,16
  extern int main();
  main();
    30f2:	00000097          	auipc	ra,0x0
    30f6:	f0e080e7          	jalr	-242(ra) # 3000 <main>
  exit(0);
    30fa:	4501                	li	a0,0
    30fc:	00000097          	auipc	ra,0x0
    3100:	2ce080e7          	jalr	718(ra) # 33ca <exit>

0000000000003104 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3104:	1141                	addi	sp,sp,-16
    3106:	e422                	sd	s0,8(sp)
    3108:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    310a:	87aa                	mv	a5,a0
    310c:	0585                	addi	a1,a1,1
    310e:	0785                	addi	a5,a5,1
    3110:	fff5c703          	lbu	a4,-1(a1)
    3114:	fee78fa3          	sb	a4,-1(a5) # 99fff <base+0x95fef>
    3118:	fb75                	bnez	a4,310c <strcpy+0x8>
    ;
  return os;
}
    311a:	6422                	ld	s0,8(sp)
    311c:	0141                	addi	sp,sp,16
    311e:	8082                	ret

0000000000003120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3120:	1141                	addi	sp,sp,-16
    3122:	e422                	sd	s0,8(sp)
    3124:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    3126:	00054783          	lbu	a5,0(a0)
    312a:	cb91                	beqz	a5,313e <strcmp+0x1e>
    312c:	0005c703          	lbu	a4,0(a1)
    3130:	00f71763          	bne	a4,a5,313e <strcmp+0x1e>
    p++, q++;
    3134:	0505                	addi	a0,a0,1
    3136:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    3138:	00054783          	lbu	a5,0(a0)
    313c:	fbe5                	bnez	a5,312c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    313e:	0005c503          	lbu	a0,0(a1)
}
    3142:	40a7853b          	subw	a0,a5,a0
    3146:	6422                	ld	s0,8(sp)
    3148:	0141                	addi	sp,sp,16
    314a:	8082                	ret

000000000000314c <strlen>:

uint
strlen(const char *s)
{
    314c:	1141                	addi	sp,sp,-16
    314e:	e422                	sd	s0,8(sp)
    3150:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    3152:	00054783          	lbu	a5,0(a0)
    3156:	cf91                	beqz	a5,3172 <strlen+0x26>
    3158:	0505                	addi	a0,a0,1
    315a:	87aa                	mv	a5,a0
    315c:	4685                	li	a3,1
    315e:	9e89                	subw	a3,a3,a0
    3160:	00f6853b          	addw	a0,a3,a5
    3164:	0785                	addi	a5,a5,1
    3166:	fff7c703          	lbu	a4,-1(a5)
    316a:	fb7d                	bnez	a4,3160 <strlen+0x14>
    ;
  return n;
}
    316c:	6422                	ld	s0,8(sp)
    316e:	0141                	addi	sp,sp,16
    3170:	8082                	ret
  for(n = 0; s[n]; n++)
    3172:	4501                	li	a0,0
    3174:	bfe5                	j	316c <strlen+0x20>

0000000000003176 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3176:	1141                	addi	sp,sp,-16
    3178:	e422                	sd	s0,8(sp)
    317a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    317c:	ca19                	beqz	a2,3192 <memset+0x1c>
    317e:	87aa                	mv	a5,a0
    3180:	1602                	slli	a2,a2,0x20
    3182:	9201                	srli	a2,a2,0x20
    3184:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    3188:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    318c:	0785                	addi	a5,a5,1
    318e:	fee79de3          	bne	a5,a4,3188 <memset+0x12>
  }
  return dst;
}
    3192:	6422                	ld	s0,8(sp)
    3194:	0141                	addi	sp,sp,16
    3196:	8082                	ret

0000000000003198 <strchr>:

char*
strchr(const char *s, char c)
{
    3198:	1141                	addi	sp,sp,-16
    319a:	e422                	sd	s0,8(sp)
    319c:	0800                	addi	s0,sp,16
  for(; *s; s++)
    319e:	00054783          	lbu	a5,0(a0)
    31a2:	cb99                	beqz	a5,31b8 <strchr+0x20>
    if(*s == c)
    31a4:	00f58763          	beq	a1,a5,31b2 <strchr+0x1a>
  for(; *s; s++)
    31a8:	0505                	addi	a0,a0,1
    31aa:	00054783          	lbu	a5,0(a0)
    31ae:	fbfd                	bnez	a5,31a4 <strchr+0xc>
      return (char*)s;
  return 0;
    31b0:	4501                	li	a0,0
}
    31b2:	6422                	ld	s0,8(sp)
    31b4:	0141                	addi	sp,sp,16
    31b6:	8082                	ret
  return 0;
    31b8:	4501                	li	a0,0
    31ba:	bfe5                	j	31b2 <strchr+0x1a>

00000000000031bc <gets>:

char*
gets(char *buf, int max)
{
    31bc:	711d                	addi	sp,sp,-96
    31be:	ec86                	sd	ra,88(sp)
    31c0:	e8a2                	sd	s0,80(sp)
    31c2:	e4a6                	sd	s1,72(sp)
    31c4:	e0ca                	sd	s2,64(sp)
    31c6:	fc4e                	sd	s3,56(sp)
    31c8:	f852                	sd	s4,48(sp)
    31ca:	f456                	sd	s5,40(sp)
    31cc:	f05a                	sd	s6,32(sp)
    31ce:	ec5e                	sd	s7,24(sp)
    31d0:	1080                	addi	s0,sp,96
    31d2:	8baa                	mv	s7,a0
    31d4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    31d6:	892a                	mv	s2,a0
    31d8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    31da:	4aa9                	li	s5,10
    31dc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    31de:	89a6                	mv	s3,s1
    31e0:	2485                	addiw	s1,s1,1
    31e2:	0344d863          	bge	s1,s4,3212 <gets+0x56>
    cc = read(0, &c, 1);
    31e6:	4605                	li	a2,1
    31e8:	faf40593          	addi	a1,s0,-81
    31ec:	4501                	li	a0,0
    31ee:	00000097          	auipc	ra,0x0
    31f2:	1fc080e7          	jalr	508(ra) # 33ea <read>
    if(cc < 1)
    31f6:	00a05e63          	blez	a0,3212 <gets+0x56>
    buf[i++] = c;
    31fa:	faf44783          	lbu	a5,-81(s0)
    31fe:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3202:	01578763          	beq	a5,s5,3210 <gets+0x54>
    3206:	0905                	addi	s2,s2,1
    3208:	fd679be3          	bne	a5,s6,31de <gets+0x22>
  for(i=0; i+1 < max; ){
    320c:	89a6                	mv	s3,s1
    320e:	a011                	j	3212 <gets+0x56>
    3210:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3212:	99de                	add	s3,s3,s7
    3214:	00098023          	sb	zero,0(s3)
  return buf;
}
    3218:	855e                	mv	a0,s7
    321a:	60e6                	ld	ra,88(sp)
    321c:	6446                	ld	s0,80(sp)
    321e:	64a6                	ld	s1,72(sp)
    3220:	6906                	ld	s2,64(sp)
    3222:	79e2                	ld	s3,56(sp)
    3224:	7a42                	ld	s4,48(sp)
    3226:	7aa2                	ld	s5,40(sp)
    3228:	7b02                	ld	s6,32(sp)
    322a:	6be2                	ld	s7,24(sp)
    322c:	6125                	addi	sp,sp,96
    322e:	8082                	ret

0000000000003230 <stat>:

int
stat(const char *n, struct stat *st)
{
    3230:	1101                	addi	sp,sp,-32
    3232:	ec06                	sd	ra,24(sp)
    3234:	e822                	sd	s0,16(sp)
    3236:	e426                	sd	s1,8(sp)
    3238:	e04a                	sd	s2,0(sp)
    323a:	1000                	addi	s0,sp,32
    323c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    323e:	4581                	li	a1,0
    3240:	00000097          	auipc	ra,0x0
    3244:	1d2080e7          	jalr	466(ra) # 3412 <open>
  if(fd < 0)
    3248:	02054563          	bltz	a0,3272 <stat+0x42>
    324c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    324e:	85ca                	mv	a1,s2
    3250:	00000097          	auipc	ra,0x0
    3254:	1da080e7          	jalr	474(ra) # 342a <fstat>
    3258:	892a                	mv	s2,a0
  close(fd);
    325a:	8526                	mv	a0,s1
    325c:	00000097          	auipc	ra,0x0
    3260:	19e080e7          	jalr	414(ra) # 33fa <close>
  return r;
}
    3264:	854a                	mv	a0,s2
    3266:	60e2                	ld	ra,24(sp)
    3268:	6442                	ld	s0,16(sp)
    326a:	64a2                	ld	s1,8(sp)
    326c:	6902                	ld	s2,0(sp)
    326e:	6105                	addi	sp,sp,32
    3270:	8082                	ret
    return -1;
    3272:	597d                	li	s2,-1
    3274:	bfc5                	j	3264 <stat+0x34>

0000000000003276 <atoi>:

int
atoi(const char *s)
{
    3276:	1141                	addi	sp,sp,-16
    3278:	e422                	sd	s0,8(sp)
    327a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    327c:	00054603          	lbu	a2,0(a0)
    3280:	fd06079b          	addiw	a5,a2,-48
    3284:	0ff7f793          	andi	a5,a5,255
    3288:	4725                	li	a4,9
    328a:	02f76963          	bltu	a4,a5,32bc <atoi+0x46>
    328e:	86aa                	mv	a3,a0
  n = 0;
    3290:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    3292:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    3294:	0685                	addi	a3,a3,1
    3296:	0025179b          	slliw	a5,a0,0x2
    329a:	9fa9                	addw	a5,a5,a0
    329c:	0017979b          	slliw	a5,a5,0x1
    32a0:	9fb1                	addw	a5,a5,a2
    32a2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    32a6:	0006c603          	lbu	a2,0(a3)
    32aa:	fd06071b          	addiw	a4,a2,-48
    32ae:	0ff77713          	andi	a4,a4,255
    32b2:	fee5f1e3          	bgeu	a1,a4,3294 <atoi+0x1e>
  return n;
}
    32b6:	6422                	ld	s0,8(sp)
    32b8:	0141                	addi	sp,sp,16
    32ba:	8082                	ret
  n = 0;
    32bc:	4501                	li	a0,0
    32be:	bfe5                	j	32b6 <atoi+0x40>

00000000000032c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    32c0:	1141                	addi	sp,sp,-16
    32c2:	e422                	sd	s0,8(sp)
    32c4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    32c6:	02b57463          	bgeu	a0,a1,32ee <memmove+0x2e>
    while(n-- > 0)
    32ca:	00c05f63          	blez	a2,32e8 <memmove+0x28>
    32ce:	1602                	slli	a2,a2,0x20
    32d0:	9201                	srli	a2,a2,0x20
    32d2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    32d6:	872a                	mv	a4,a0
      *dst++ = *src++;
    32d8:	0585                	addi	a1,a1,1
    32da:	0705                	addi	a4,a4,1
    32dc:	fff5c683          	lbu	a3,-1(a1)
    32e0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    32e4:	fee79ae3          	bne	a5,a4,32d8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    32e8:	6422                	ld	s0,8(sp)
    32ea:	0141                	addi	sp,sp,16
    32ec:	8082                	ret
    dst += n;
    32ee:	00c50733          	add	a4,a0,a2
    src += n;
    32f2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    32f4:	fec05ae3          	blez	a2,32e8 <memmove+0x28>
    32f8:	fff6079b          	addiw	a5,a2,-1
    32fc:	1782                	slli	a5,a5,0x20
    32fe:	9381                	srli	a5,a5,0x20
    3300:	fff7c793          	not	a5,a5
    3304:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3306:	15fd                	addi	a1,a1,-1
    3308:	177d                	addi	a4,a4,-1
    330a:	0005c683          	lbu	a3,0(a1)
    330e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3312:	fee79ae3          	bne	a5,a4,3306 <memmove+0x46>
    3316:	bfc9                	j	32e8 <memmove+0x28>

0000000000003318 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    3318:	1141                	addi	sp,sp,-16
    331a:	e422                	sd	s0,8(sp)
    331c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    331e:	ca05                	beqz	a2,334e <memcmp+0x36>
    3320:	fff6069b          	addiw	a3,a2,-1
    3324:	1682                	slli	a3,a3,0x20
    3326:	9281                	srli	a3,a3,0x20
    3328:	0685                	addi	a3,a3,1
    332a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    332c:	00054783          	lbu	a5,0(a0)
    3330:	0005c703          	lbu	a4,0(a1)
    3334:	00e79863          	bne	a5,a4,3344 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    3338:	0505                	addi	a0,a0,1
    p2++;
    333a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    333c:	fed518e3          	bne	a0,a3,332c <memcmp+0x14>
  }
  return 0;
    3340:	4501                	li	a0,0
    3342:	a019                	j	3348 <memcmp+0x30>
      return *p1 - *p2;
    3344:	40e7853b          	subw	a0,a5,a4
}
    3348:	6422                	ld	s0,8(sp)
    334a:	0141                	addi	sp,sp,16
    334c:	8082                	ret
  return 0;
    334e:	4501                	li	a0,0
    3350:	bfe5                	j	3348 <memcmp+0x30>

0000000000003352 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    3352:	1141                	addi	sp,sp,-16
    3354:	e406                	sd	ra,8(sp)
    3356:	e022                	sd	s0,0(sp)
    3358:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    335a:	00000097          	auipc	ra,0x0
    335e:	f66080e7          	jalr	-154(ra) # 32c0 <memmove>
}
    3362:	60a2                	ld	ra,8(sp)
    3364:	6402                	ld	s0,0(sp)
    3366:	0141                	addi	sp,sp,16
    3368:	8082                	ret

000000000000336a <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    336a:	1141                	addi	sp,sp,-16
    336c:	e422                	sd	s0,8(sp)
    336e:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    3370:	00052023          	sw	zero,0(a0)
}  
    3374:	6422                	ld	s0,8(sp)
    3376:	0141                	addi	sp,sp,16
    3378:	8082                	ret

000000000000337a <lock>:

void lock(struct spinlock * lk) 
{    
    337a:	1141                	addi	sp,sp,-16
    337c:	e422                	sd	s0,8(sp)
    337e:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    3380:	4705                	li	a4,1
    3382:	87ba                	mv	a5,a4
    3384:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    3388:	2781                	sext.w	a5,a5
    338a:	ffe5                	bnez	a5,3382 <lock+0x8>
}  
    338c:	6422                	ld	s0,8(sp)
    338e:	0141                	addi	sp,sp,16
    3390:	8082                	ret

0000000000003392 <unlock>:

void unlock(struct spinlock * lk) 
{   
    3392:	1141                	addi	sp,sp,-16
    3394:	e422                	sd	s0,8(sp)
    3396:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    3398:	0f50000f          	fence	iorw,ow
    339c:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    33a0:	6422                	ld	s0,8(sp)
    33a2:	0141                	addi	sp,sp,16
    33a4:	8082                	ret

00000000000033a6 <isDigit>:

unsigned int isDigit(char *c) {
    33a6:	1141                	addi	sp,sp,-16
    33a8:	e422                	sd	s0,8(sp)
    33aa:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    33ac:	00054503          	lbu	a0,0(a0)
    33b0:	fd05051b          	addiw	a0,a0,-48
    33b4:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    33b8:	00a53513          	sltiu	a0,a0,10
    33bc:	6422                	ld	s0,8(sp)
    33be:	0141                	addi	sp,sp,16
    33c0:	8082                	ret

00000000000033c2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    33c2:	4885                	li	a7,1
 ecall
    33c4:	00000073          	ecall
 ret
    33c8:	8082                	ret

00000000000033ca <exit>:
.global exit
exit:
 li a7, SYS_exit
    33ca:	4889                	li	a7,2
 ecall
    33cc:	00000073          	ecall
 ret
    33d0:	8082                	ret

00000000000033d2 <wait>:
.global wait
wait:
 li a7, SYS_wait
    33d2:	488d                	li	a7,3
 ecall
    33d4:	00000073          	ecall
 ret
    33d8:	8082                	ret

00000000000033da <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    33da:	48e1                	li	a7,24
 ecall
    33dc:	00000073          	ecall
 ret
    33e0:	8082                	ret

00000000000033e2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    33e2:	4891                	li	a7,4
 ecall
    33e4:	00000073          	ecall
 ret
    33e8:	8082                	ret

00000000000033ea <read>:
.global read
read:
 li a7, SYS_read
    33ea:	4895                	li	a7,5
 ecall
    33ec:	00000073          	ecall
 ret
    33f0:	8082                	ret

00000000000033f2 <write>:
.global write
write:
 li a7, SYS_write
    33f2:	48c1                	li	a7,16
 ecall
    33f4:	00000073          	ecall
 ret
    33f8:	8082                	ret

00000000000033fa <close>:
.global close
close:
 li a7, SYS_close
    33fa:	48d5                	li	a7,21
 ecall
    33fc:	00000073          	ecall
 ret
    3400:	8082                	ret

0000000000003402 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3402:	4899                	li	a7,6
 ecall
    3404:	00000073          	ecall
 ret
    3408:	8082                	ret

000000000000340a <exec>:
.global exec
exec:
 li a7, SYS_exec
    340a:	489d                	li	a7,7
 ecall
    340c:	00000073          	ecall
 ret
    3410:	8082                	ret

0000000000003412 <open>:
.global open
open:
 li a7, SYS_open
    3412:	48bd                	li	a7,15
 ecall
    3414:	00000073          	ecall
 ret
    3418:	8082                	ret

000000000000341a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    341a:	48c5                	li	a7,17
 ecall
    341c:	00000073          	ecall
 ret
    3420:	8082                	ret

0000000000003422 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3422:	48c9                	li	a7,18
 ecall
    3424:	00000073          	ecall
 ret
    3428:	8082                	ret

000000000000342a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    342a:	48a1                	li	a7,8
 ecall
    342c:	00000073          	ecall
 ret
    3430:	8082                	ret

0000000000003432 <link>:
.global link
link:
 li a7, SYS_link
    3432:	48cd                	li	a7,19
 ecall
    3434:	00000073          	ecall
 ret
    3438:	8082                	ret

000000000000343a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    343a:	48d1                	li	a7,20
 ecall
    343c:	00000073          	ecall
 ret
    3440:	8082                	ret

0000000000003442 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3442:	48a5                	li	a7,9
 ecall
    3444:	00000073          	ecall
 ret
    3448:	8082                	ret

000000000000344a <dup>:
.global dup
dup:
 li a7, SYS_dup
    344a:	48a9                	li	a7,10
 ecall
    344c:	00000073          	ecall
 ret
    3450:	8082                	ret

0000000000003452 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    3452:	48ad                	li	a7,11
 ecall
    3454:	00000073          	ecall
 ret
    3458:	8082                	ret

000000000000345a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    345a:	48b1                	li	a7,12
 ecall
    345c:	00000073          	ecall
 ret
    3460:	8082                	ret

0000000000003462 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    3462:	48b5                	li	a7,13
 ecall
    3464:	00000073          	ecall
 ret
    3468:	8082                	ret

000000000000346a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    346a:	48b9                	li	a7,14
 ecall
    346c:	00000073          	ecall
 ret
    3470:	8082                	ret

0000000000003472 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    3472:	48d9                	li	a7,22
 ecall
    3474:	00000073          	ecall
 ret
    3478:	8082                	ret

000000000000347a <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    347a:	48dd                	li	a7,23
 ecall
    347c:	00000073          	ecall
 ret
    3480:	8082                	ret

0000000000003482 <ps>:
.global ps
ps:
 li a7, SYS_ps
    3482:	48e5                	li	a7,25
 ecall
    3484:	00000073          	ecall
 ret
    3488:	8082                	ret

000000000000348a <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    348a:	48e9                	li	a7,26
 ecall
    348c:	00000073          	ecall
 ret
    3490:	8082                	ret

0000000000003492 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    3492:	48ed                	li	a7,27
 ecall
    3494:	00000073          	ecall
 ret
    3498:	8082                	ret

000000000000349a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    349a:	1101                	addi	sp,sp,-32
    349c:	ec06                	sd	ra,24(sp)
    349e:	e822                	sd	s0,16(sp)
    34a0:	1000                	addi	s0,sp,32
    34a2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    34a6:	4605                	li	a2,1
    34a8:	fef40593          	addi	a1,s0,-17
    34ac:	00000097          	auipc	ra,0x0
    34b0:	f46080e7          	jalr	-186(ra) # 33f2 <write>
}
    34b4:	60e2                	ld	ra,24(sp)
    34b6:	6442                	ld	s0,16(sp)
    34b8:	6105                	addi	sp,sp,32
    34ba:	8082                	ret

00000000000034bc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    34bc:	7139                	addi	sp,sp,-64
    34be:	fc06                	sd	ra,56(sp)
    34c0:	f822                	sd	s0,48(sp)
    34c2:	f426                	sd	s1,40(sp)
    34c4:	f04a                	sd	s2,32(sp)
    34c6:	ec4e                	sd	s3,24(sp)
    34c8:	0080                	addi	s0,sp,64
    34ca:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    34cc:	c299                	beqz	a3,34d2 <printint+0x16>
    34ce:	0805c863          	bltz	a1,355e <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    34d2:	2581                	sext.w	a1,a1
  neg = 0;
    34d4:	4881                	li	a7,0
    34d6:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    34da:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    34dc:	2601                	sext.w	a2,a2
    34de:	00000517          	auipc	a0,0x0
    34e2:	4da50513          	addi	a0,a0,1242 # 39b8 <digits>
    34e6:	883a                	mv	a6,a4
    34e8:	2705                	addiw	a4,a4,1
    34ea:	02c5f7bb          	remuw	a5,a1,a2
    34ee:	1782                	slli	a5,a5,0x20
    34f0:	9381                	srli	a5,a5,0x20
    34f2:	97aa                	add	a5,a5,a0
    34f4:	0007c783          	lbu	a5,0(a5)
    34f8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    34fc:	0005879b          	sext.w	a5,a1
    3500:	02c5d5bb          	divuw	a1,a1,a2
    3504:	0685                	addi	a3,a3,1
    3506:	fec7f0e3          	bgeu	a5,a2,34e6 <printint+0x2a>
  if(neg)
    350a:	00088b63          	beqz	a7,3520 <printint+0x64>
    buf[i++] = '-';
    350e:	fd040793          	addi	a5,s0,-48
    3512:	973e                	add	a4,a4,a5
    3514:	02d00793          	li	a5,45
    3518:	fef70823          	sb	a5,-16(a4)
    351c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    3520:	02e05863          	blez	a4,3550 <printint+0x94>
    3524:	fc040793          	addi	a5,s0,-64
    3528:	00e78933          	add	s2,a5,a4
    352c:	fff78993          	addi	s3,a5,-1
    3530:	99ba                	add	s3,s3,a4
    3532:	377d                	addiw	a4,a4,-1
    3534:	1702                	slli	a4,a4,0x20
    3536:	9301                	srli	a4,a4,0x20
    3538:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    353c:	fff94583          	lbu	a1,-1(s2)
    3540:	8526                	mv	a0,s1
    3542:	00000097          	auipc	ra,0x0
    3546:	f58080e7          	jalr	-168(ra) # 349a <putc>
  while(--i >= 0)
    354a:	197d                	addi	s2,s2,-1
    354c:	ff3918e3          	bne	s2,s3,353c <printint+0x80>
}
    3550:	70e2                	ld	ra,56(sp)
    3552:	7442                	ld	s0,48(sp)
    3554:	74a2                	ld	s1,40(sp)
    3556:	7902                	ld	s2,32(sp)
    3558:	69e2                	ld	s3,24(sp)
    355a:	6121                	addi	sp,sp,64
    355c:	8082                	ret
    x = -xx;
    355e:	40b005bb          	negw	a1,a1
    neg = 1;
    3562:	4885                	li	a7,1
    x = -xx;
    3564:	bf8d                	j	34d6 <printint+0x1a>

0000000000003566 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    3566:	7119                	addi	sp,sp,-128
    3568:	fc86                	sd	ra,120(sp)
    356a:	f8a2                	sd	s0,112(sp)
    356c:	f4a6                	sd	s1,104(sp)
    356e:	f0ca                	sd	s2,96(sp)
    3570:	ecce                	sd	s3,88(sp)
    3572:	e8d2                	sd	s4,80(sp)
    3574:	e4d6                	sd	s5,72(sp)
    3576:	e0da                	sd	s6,64(sp)
    3578:	fc5e                	sd	s7,56(sp)
    357a:	f862                	sd	s8,48(sp)
    357c:	f466                	sd	s9,40(sp)
    357e:	f06a                	sd	s10,32(sp)
    3580:	ec6e                	sd	s11,24(sp)
    3582:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    3584:	0005c903          	lbu	s2,0(a1)
    3588:	18090f63          	beqz	s2,3726 <vprintf+0x1c0>
    358c:	8aaa                	mv	s5,a0
    358e:	8b32                	mv	s6,a2
    3590:	00158493          	addi	s1,a1,1
  state = 0;
    3594:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3596:	02500a13          	li	s4,37
      if(c == 'd'){
    359a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    359e:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    35a2:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    35a6:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    35aa:	00000b97          	auipc	s7,0x0
    35ae:	40eb8b93          	addi	s7,s7,1038 # 39b8 <digits>
    35b2:	a839                	j	35d0 <vprintf+0x6a>
        putc(fd, c);
    35b4:	85ca                	mv	a1,s2
    35b6:	8556                	mv	a0,s5
    35b8:	00000097          	auipc	ra,0x0
    35bc:	ee2080e7          	jalr	-286(ra) # 349a <putc>
    35c0:	a019                	j	35c6 <vprintf+0x60>
    } else if(state == '%'){
    35c2:	01498f63          	beq	s3,s4,35e0 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    35c6:	0485                	addi	s1,s1,1
    35c8:	fff4c903          	lbu	s2,-1(s1)
    35cc:	14090d63          	beqz	s2,3726 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    35d0:	0009079b          	sext.w	a5,s2
    if(state == 0){
    35d4:	fe0997e3          	bnez	s3,35c2 <vprintf+0x5c>
      if(c == '%'){
    35d8:	fd479ee3          	bne	a5,s4,35b4 <vprintf+0x4e>
        state = '%';
    35dc:	89be                	mv	s3,a5
    35de:	b7e5                	j	35c6 <vprintf+0x60>
      if(c == 'd'){
    35e0:	05878063          	beq	a5,s8,3620 <vprintf+0xba>
      } else if(c == 'l') {
    35e4:	05978c63          	beq	a5,s9,363c <vprintf+0xd6>
      } else if(c == 'x') {
    35e8:	07a78863          	beq	a5,s10,3658 <vprintf+0xf2>
      } else if(c == 'p') {
    35ec:	09b78463          	beq	a5,s11,3674 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    35f0:	07300713          	li	a4,115
    35f4:	0ce78663          	beq	a5,a4,36c0 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    35f8:	06300713          	li	a4,99
    35fc:	0ee78e63          	beq	a5,a4,36f8 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    3600:	11478863          	beq	a5,s4,3710 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3604:	85d2                	mv	a1,s4
    3606:	8556                	mv	a0,s5
    3608:	00000097          	auipc	ra,0x0
    360c:	e92080e7          	jalr	-366(ra) # 349a <putc>
        putc(fd, c);
    3610:	85ca                	mv	a1,s2
    3612:	8556                	mv	a0,s5
    3614:	00000097          	auipc	ra,0x0
    3618:	e86080e7          	jalr	-378(ra) # 349a <putc>
      }
      state = 0;
    361c:	4981                	li	s3,0
    361e:	b765                	j	35c6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    3620:	008b0913          	addi	s2,s6,8
    3624:	4685                	li	a3,1
    3626:	4629                	li	a2,10
    3628:	000b2583          	lw	a1,0(s6)
    362c:	8556                	mv	a0,s5
    362e:	00000097          	auipc	ra,0x0
    3632:	e8e080e7          	jalr	-370(ra) # 34bc <printint>
    3636:	8b4a                	mv	s6,s2
      state = 0;
    3638:	4981                	li	s3,0
    363a:	b771                	j	35c6 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    363c:	008b0913          	addi	s2,s6,8
    3640:	4681                	li	a3,0
    3642:	4629                	li	a2,10
    3644:	000b2583          	lw	a1,0(s6)
    3648:	8556                	mv	a0,s5
    364a:	00000097          	auipc	ra,0x0
    364e:	e72080e7          	jalr	-398(ra) # 34bc <printint>
    3652:	8b4a                	mv	s6,s2
      state = 0;
    3654:	4981                	li	s3,0
    3656:	bf85                	j	35c6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    3658:	008b0913          	addi	s2,s6,8
    365c:	4681                	li	a3,0
    365e:	4641                	li	a2,16
    3660:	000b2583          	lw	a1,0(s6)
    3664:	8556                	mv	a0,s5
    3666:	00000097          	auipc	ra,0x0
    366a:	e56080e7          	jalr	-426(ra) # 34bc <printint>
    366e:	8b4a                	mv	s6,s2
      state = 0;
    3670:	4981                	li	s3,0
    3672:	bf91                	j	35c6 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    3674:	008b0793          	addi	a5,s6,8
    3678:	f8f43423          	sd	a5,-120(s0)
    367c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    3680:	03000593          	li	a1,48
    3684:	8556                	mv	a0,s5
    3686:	00000097          	auipc	ra,0x0
    368a:	e14080e7          	jalr	-492(ra) # 349a <putc>
  putc(fd, 'x');
    368e:	85ea                	mv	a1,s10
    3690:	8556                	mv	a0,s5
    3692:	00000097          	auipc	ra,0x0
    3696:	e08080e7          	jalr	-504(ra) # 349a <putc>
    369a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    369c:	03c9d793          	srli	a5,s3,0x3c
    36a0:	97de                	add	a5,a5,s7
    36a2:	0007c583          	lbu	a1,0(a5)
    36a6:	8556                	mv	a0,s5
    36a8:	00000097          	auipc	ra,0x0
    36ac:	df2080e7          	jalr	-526(ra) # 349a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    36b0:	0992                	slli	s3,s3,0x4
    36b2:	397d                	addiw	s2,s2,-1
    36b4:	fe0914e3          	bnez	s2,369c <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    36b8:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    36bc:	4981                	li	s3,0
    36be:	b721                	j	35c6 <vprintf+0x60>
        s = va_arg(ap, char*);
    36c0:	008b0993          	addi	s3,s6,8
    36c4:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    36c8:	02090163          	beqz	s2,36ea <vprintf+0x184>
        while(*s != 0){
    36cc:	00094583          	lbu	a1,0(s2)
    36d0:	c9a1                	beqz	a1,3720 <vprintf+0x1ba>
          putc(fd, *s);
    36d2:	8556                	mv	a0,s5
    36d4:	00000097          	auipc	ra,0x0
    36d8:	dc6080e7          	jalr	-570(ra) # 349a <putc>
          s++;
    36dc:	0905                	addi	s2,s2,1
        while(*s != 0){
    36de:	00094583          	lbu	a1,0(s2)
    36e2:	f9e5                	bnez	a1,36d2 <vprintf+0x16c>
        s = va_arg(ap, char*);
    36e4:	8b4e                	mv	s6,s3
      state = 0;
    36e6:	4981                	li	s3,0
    36e8:	bdf9                	j	35c6 <vprintf+0x60>
          s = "(null)";
    36ea:	00000917          	auipc	s2,0x0
    36ee:	2c690913          	addi	s2,s2,710 # 39b0 <malloc+0x180>
        while(*s != 0){
    36f2:	02800593          	li	a1,40
    36f6:	bff1                	j	36d2 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    36f8:	008b0913          	addi	s2,s6,8
    36fc:	000b4583          	lbu	a1,0(s6)
    3700:	8556                	mv	a0,s5
    3702:	00000097          	auipc	ra,0x0
    3706:	d98080e7          	jalr	-616(ra) # 349a <putc>
    370a:	8b4a                	mv	s6,s2
      state = 0;
    370c:	4981                	li	s3,0
    370e:	bd65                	j	35c6 <vprintf+0x60>
        putc(fd, c);
    3710:	85d2                	mv	a1,s4
    3712:	8556                	mv	a0,s5
    3714:	00000097          	auipc	ra,0x0
    3718:	d86080e7          	jalr	-634(ra) # 349a <putc>
      state = 0;
    371c:	4981                	li	s3,0
    371e:	b565                	j	35c6 <vprintf+0x60>
        s = va_arg(ap, char*);
    3720:	8b4e                	mv	s6,s3
      state = 0;
    3722:	4981                	li	s3,0
    3724:	b54d                	j	35c6 <vprintf+0x60>
    }
  }
}
    3726:	70e6                	ld	ra,120(sp)
    3728:	7446                	ld	s0,112(sp)
    372a:	74a6                	ld	s1,104(sp)
    372c:	7906                	ld	s2,96(sp)
    372e:	69e6                	ld	s3,88(sp)
    3730:	6a46                	ld	s4,80(sp)
    3732:	6aa6                	ld	s5,72(sp)
    3734:	6b06                	ld	s6,64(sp)
    3736:	7be2                	ld	s7,56(sp)
    3738:	7c42                	ld	s8,48(sp)
    373a:	7ca2                	ld	s9,40(sp)
    373c:	7d02                	ld	s10,32(sp)
    373e:	6de2                	ld	s11,24(sp)
    3740:	6109                	addi	sp,sp,128
    3742:	8082                	ret

0000000000003744 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    3744:	715d                	addi	sp,sp,-80
    3746:	ec06                	sd	ra,24(sp)
    3748:	e822                	sd	s0,16(sp)
    374a:	1000                	addi	s0,sp,32
    374c:	e010                	sd	a2,0(s0)
    374e:	e414                	sd	a3,8(s0)
    3750:	e818                	sd	a4,16(s0)
    3752:	ec1c                	sd	a5,24(s0)
    3754:	03043023          	sd	a6,32(s0)
    3758:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    375c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    3760:	8622                	mv	a2,s0
    3762:	00000097          	auipc	ra,0x0
    3766:	e04080e7          	jalr	-508(ra) # 3566 <vprintf>
}
    376a:	60e2                	ld	ra,24(sp)
    376c:	6442                	ld	s0,16(sp)
    376e:	6161                	addi	sp,sp,80
    3770:	8082                	ret

0000000000003772 <printf>:

void
printf(const char *fmt, ...)
{
    3772:	711d                	addi	sp,sp,-96
    3774:	ec06                	sd	ra,24(sp)
    3776:	e822                	sd	s0,16(sp)
    3778:	1000                	addi	s0,sp,32
    377a:	e40c                	sd	a1,8(s0)
    377c:	e810                	sd	a2,16(s0)
    377e:	ec14                	sd	a3,24(s0)
    3780:	f018                	sd	a4,32(s0)
    3782:	f41c                	sd	a5,40(s0)
    3784:	03043823          	sd	a6,48(s0)
    3788:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    378c:	00840613          	addi	a2,s0,8
    3790:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    3794:	85aa                	mv	a1,a0
    3796:	4505                	li	a0,1
    3798:	00000097          	auipc	ra,0x0
    379c:	dce080e7          	jalr	-562(ra) # 3566 <vprintf>
}
    37a0:	60e2                	ld	ra,24(sp)
    37a2:	6442                	ld	s0,16(sp)
    37a4:	6125                	addi	sp,sp,96
    37a6:	8082                	ret

00000000000037a8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    37a8:	1141                	addi	sp,sp,-16
    37aa:	e422                	sd	s0,8(sp)
    37ac:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    37ae:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    37b2:	00001797          	auipc	a5,0x1
    37b6:	84e7b783          	ld	a5,-1970(a5) # 4000 <freep>
    37ba:	a805                	j	37ea <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    37bc:	4618                	lw	a4,8(a2)
    37be:	9db9                	addw	a1,a1,a4
    37c0:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    37c4:	6398                	ld	a4,0(a5)
    37c6:	6318                	ld	a4,0(a4)
    37c8:	fee53823          	sd	a4,-16(a0)
    37cc:	a091                	j	3810 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    37ce:	ff852703          	lw	a4,-8(a0)
    37d2:	9e39                	addw	a2,a2,a4
    37d4:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    37d6:	ff053703          	ld	a4,-16(a0)
    37da:	e398                	sd	a4,0(a5)
    37dc:	a099                	j	3822 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    37de:	6398                	ld	a4,0(a5)
    37e0:	00e7e463          	bltu	a5,a4,37e8 <free+0x40>
    37e4:	00e6ea63          	bltu	a3,a4,37f8 <free+0x50>
{
    37e8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    37ea:	fed7fae3          	bgeu	a5,a3,37de <free+0x36>
    37ee:	6398                	ld	a4,0(a5)
    37f0:	00e6e463          	bltu	a3,a4,37f8 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    37f4:	fee7eae3          	bltu	a5,a4,37e8 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    37f8:	ff852583          	lw	a1,-8(a0)
    37fc:	6390                	ld	a2,0(a5)
    37fe:	02059713          	slli	a4,a1,0x20
    3802:	9301                	srli	a4,a4,0x20
    3804:	0712                	slli	a4,a4,0x4
    3806:	9736                	add	a4,a4,a3
    3808:	fae60ae3          	beq	a2,a4,37bc <free+0x14>
    bp->s.ptr = p->s.ptr;
    380c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    3810:	4790                	lw	a2,8(a5)
    3812:	02061713          	slli	a4,a2,0x20
    3816:	9301                	srli	a4,a4,0x20
    3818:	0712                	slli	a4,a4,0x4
    381a:	973e                	add	a4,a4,a5
    381c:	fae689e3          	beq	a3,a4,37ce <free+0x26>
  } else
    p->s.ptr = bp;
    3820:	e394                	sd	a3,0(a5)
  freep = p;
    3822:	00000717          	auipc	a4,0x0
    3826:	7cf73f23          	sd	a5,2014(a4) # 4000 <freep>
}
    382a:	6422                	ld	s0,8(sp)
    382c:	0141                	addi	sp,sp,16
    382e:	8082                	ret

0000000000003830 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3830:	7139                	addi	sp,sp,-64
    3832:	fc06                	sd	ra,56(sp)
    3834:	f822                	sd	s0,48(sp)
    3836:	f426                	sd	s1,40(sp)
    3838:	f04a                	sd	s2,32(sp)
    383a:	ec4e                	sd	s3,24(sp)
    383c:	e852                	sd	s4,16(sp)
    383e:	e456                	sd	s5,8(sp)
    3840:	e05a                	sd	s6,0(sp)
    3842:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3844:	02051493          	slli	s1,a0,0x20
    3848:	9081                	srli	s1,s1,0x20
    384a:	04bd                	addi	s1,s1,15
    384c:	8091                	srli	s1,s1,0x4
    384e:	0014899b          	addiw	s3,s1,1
    3852:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    3854:	00000517          	auipc	a0,0x0
    3858:	7ac53503          	ld	a0,1964(a0) # 4000 <freep>
    385c:	c515                	beqz	a0,3888 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    385e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3860:	4798                	lw	a4,8(a5)
    3862:	02977f63          	bgeu	a4,s1,38a0 <malloc+0x70>
    3866:	8a4e                	mv	s4,s3
    3868:	0009871b          	sext.w	a4,s3
    386c:	6685                	lui	a3,0x1
    386e:	00d77363          	bgeu	a4,a3,3874 <malloc+0x44>
    3872:	6a05                	lui	s4,0x1
    3874:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    3878:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    387c:	00000917          	auipc	s2,0x0
    3880:	78490913          	addi	s2,s2,1924 # 4000 <freep>
  if(p == (char*)-1)
    3884:	5afd                	li	s5,-1
    3886:	a88d                	j	38f8 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    3888:	00000797          	auipc	a5,0x0
    388c:	78878793          	addi	a5,a5,1928 # 4010 <base>
    3890:	00000717          	auipc	a4,0x0
    3894:	76f73823          	sd	a5,1904(a4) # 4000 <freep>
    3898:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    389a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    389e:	b7e1                	j	3866 <malloc+0x36>
      if(p->s.size == nunits)
    38a0:	02e48b63          	beq	s1,a4,38d6 <malloc+0xa6>
        p->s.size -= nunits;
    38a4:	4137073b          	subw	a4,a4,s3
    38a8:	c798                	sw	a4,8(a5)
        p += p->s.size;
    38aa:	1702                	slli	a4,a4,0x20
    38ac:	9301                	srli	a4,a4,0x20
    38ae:	0712                	slli	a4,a4,0x4
    38b0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    38b2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    38b6:	00000717          	auipc	a4,0x0
    38ba:	74a73523          	sd	a0,1866(a4) # 4000 <freep>
      return (void*)(p + 1);
    38be:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    38c2:	70e2                	ld	ra,56(sp)
    38c4:	7442                	ld	s0,48(sp)
    38c6:	74a2                	ld	s1,40(sp)
    38c8:	7902                	ld	s2,32(sp)
    38ca:	69e2                	ld	s3,24(sp)
    38cc:	6a42                	ld	s4,16(sp)
    38ce:	6aa2                	ld	s5,8(sp)
    38d0:	6b02                	ld	s6,0(sp)
    38d2:	6121                	addi	sp,sp,64
    38d4:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    38d6:	6398                	ld	a4,0(a5)
    38d8:	e118                	sd	a4,0(a0)
    38da:	bff1                	j	38b6 <malloc+0x86>
  hp->s.size = nu;
    38dc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    38e0:	0541                	addi	a0,a0,16
    38e2:	00000097          	auipc	ra,0x0
    38e6:	ec6080e7          	jalr	-314(ra) # 37a8 <free>
  return freep;
    38ea:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    38ee:	d971                	beqz	a0,38c2 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    38f0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    38f2:	4798                	lw	a4,8(a5)
    38f4:	fa9776e3          	bgeu	a4,s1,38a0 <malloc+0x70>
    if(p == freep)
    38f8:	00093703          	ld	a4,0(s2)
    38fc:	853e                	mv	a0,a5
    38fe:	fef719e3          	bne	a4,a5,38f0 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3902:	8552                	mv	a0,s4
    3904:	00000097          	auipc	ra,0x0
    3908:	b56080e7          	jalr	-1194(ra) # 345a <sbrk>
  if(p == (char*)-1)
    390c:	fd5518e3          	bne	a0,s5,38dc <malloc+0xac>
        return 0;
    3910:	4501                	li	a0,0
    3912:	bf45                	j	38c2 <malloc+0x92>
