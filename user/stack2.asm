
user/_stack2:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <foo>:
  exit(0); \
}

void
foo(void *mainlocal) 
{
    3000:	1101                	addi	sp,sp,-32
    3002:	ec06                	sd	ra,24(sp)
    3004:	e822                	sd	s0,16(sp)
    3006:	1000                	addi	s0,sp,32
  int local;
  // local should be allocated at a lower address since the stack grows down
  assert((uint64) &local < (uint64) mainlocal);
    3008:	fec40793          	addi	a5,s0,-20
    300c:	00a7f663          	bgeu	a5,a0,3018 <foo+0x18>
}
    3010:	60e2                	ld	ra,24(sp)
    3012:	6442                	ld	s0,16(sp)
    3014:	6105                	addi	sp,sp,32
    3016:	8082                	ret
  assert((uint64) &local < (uint64) mainlocal);
    3018:	4651                	li	a2,20
    301a:	00001597          	auipc	a1,0x1
    301e:	90658593          	addi	a1,a1,-1786 # 3920 <malloc+0xec>
    3022:	00001517          	auipc	a0,0x1
    3026:	90e50513          	addi	a0,a0,-1778 # 3930 <malloc+0xfc>
    302a:	00000097          	auipc	ra,0x0
    302e:	74c080e7          	jalr	1868(ra) # 3776 <printf>
    3032:	00001597          	auipc	a1,0x1
    3036:	90658593          	addi	a1,a1,-1786 # 3938 <malloc+0x104>
    303a:	00001517          	auipc	a0,0x1
    303e:	92650513          	addi	a0,a0,-1754 # 3960 <malloc+0x12c>
    3042:	00000097          	auipc	ra,0x0
    3046:	734080e7          	jalr	1844(ra) # 3776 <printf>
    304a:	00001517          	auipc	a0,0x1
    304e:	92e50513          	addi	a0,a0,-1746 # 3978 <malloc+0x144>
    3052:	00000097          	auipc	ra,0x0
    3056:	724080e7          	jalr	1828(ra) # 3776 <printf>
    305a:	4501                	li	a0,0
    305c:	00000097          	auipc	ra,0x0
    3060:	372080e7          	jalr	882(ra) # 33ce <exit>

0000000000003064 <main>:

int
main(int argc, char *argv[])
{
    3064:	1101                	addi	sp,sp,-32
    3066:	ec06                	sd	ra,24(sp)
    3068:	e822                	sd	s0,16(sp)
    306a:	1000                	addi	s0,sp,32
  int local;
  assert((uint64)&local > 639*1024);
    306c:	fec40713          	addi	a4,s0,-20
    3070:	000a07b7          	lui	a5,0xa0
    3074:	c0078793          	addi	a5,a5,-1024 # 9fc00 <base+0x9bbf0>
    3078:	04e7e863          	bltu	a5,a4,30c8 <main+0x64>
    307c:	466d                	li	a2,27
    307e:	00001597          	auipc	a1,0x1
    3082:	8a258593          	addi	a1,a1,-1886 # 3920 <malloc+0xec>
    3086:	00001517          	auipc	a0,0x1
    308a:	8aa50513          	addi	a0,a0,-1878 # 3930 <malloc+0xfc>
    308e:	00000097          	auipc	ra,0x0
    3092:	6e8080e7          	jalr	1768(ra) # 3776 <printf>
    3096:	00001597          	auipc	a1,0x1
    309a:	8f258593          	addi	a1,a1,-1806 # 3988 <malloc+0x154>
    309e:	00001517          	auipc	a0,0x1
    30a2:	8c250513          	addi	a0,a0,-1854 # 3960 <malloc+0x12c>
    30a6:	00000097          	auipc	ra,0x0
    30aa:	6d0080e7          	jalr	1744(ra) # 3776 <printf>
    30ae:	00001517          	auipc	a0,0x1
    30b2:	8ca50513          	addi	a0,a0,-1846 # 3978 <malloc+0x144>
    30b6:	00000097          	auipc	ra,0x0
    30ba:	6c0080e7          	jalr	1728(ra) # 3776 <printf>
    30be:	4501                	li	a0,0
    30c0:	00000097          	auipc	ra,0x0
    30c4:	30e080e7          	jalr	782(ra) # 33ce <exit>
  foo((void*) &local);
    30c8:	fec40513          	addi	a0,s0,-20
    30cc:	00000097          	auipc	ra,0x0
    30d0:	f34080e7          	jalr	-204(ra) # 3000 <foo>
  printf("TEST PASSED\n");
    30d4:	00001517          	auipc	a0,0x1
    30d8:	8d450513          	addi	a0,a0,-1836 # 39a8 <malloc+0x174>
    30dc:	00000097          	auipc	ra,0x0
    30e0:	69a080e7          	jalr	1690(ra) # 3776 <printf>
  exit(0);
    30e4:	4501                	li	a0,0
    30e6:	00000097          	auipc	ra,0x0
    30ea:	2e8080e7          	jalr	744(ra) # 33ce <exit>

00000000000030ee <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    30ee:	1141                	addi	sp,sp,-16
    30f0:	e406                	sd	ra,8(sp)
    30f2:	e022                	sd	s0,0(sp)
    30f4:	0800                	addi	s0,sp,16
  extern int main();
  main();
    30f6:	00000097          	auipc	ra,0x0
    30fa:	f6e080e7          	jalr	-146(ra) # 3064 <main>
  exit(0);
    30fe:	4501                	li	a0,0
    3100:	00000097          	auipc	ra,0x0
    3104:	2ce080e7          	jalr	718(ra) # 33ce <exit>

0000000000003108 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3108:	1141                	addi	sp,sp,-16
    310a:	e422                	sd	s0,8(sp)
    310c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    310e:	87aa                	mv	a5,a0
    3110:	0585                	addi	a1,a1,1
    3112:	0785                	addi	a5,a5,1
    3114:	fff5c703          	lbu	a4,-1(a1)
    3118:	fee78fa3          	sb	a4,-1(a5)
    311c:	fb75                	bnez	a4,3110 <strcpy+0x8>
    ;
  return os;
}
    311e:	6422                	ld	s0,8(sp)
    3120:	0141                	addi	sp,sp,16
    3122:	8082                	ret

0000000000003124 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3124:	1141                	addi	sp,sp,-16
    3126:	e422                	sd	s0,8(sp)
    3128:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    312a:	00054783          	lbu	a5,0(a0)
    312e:	cb91                	beqz	a5,3142 <strcmp+0x1e>
    3130:	0005c703          	lbu	a4,0(a1)
    3134:	00f71763          	bne	a4,a5,3142 <strcmp+0x1e>
    p++, q++;
    3138:	0505                	addi	a0,a0,1
    313a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    313c:	00054783          	lbu	a5,0(a0)
    3140:	fbe5                	bnez	a5,3130 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    3142:	0005c503          	lbu	a0,0(a1)
}
    3146:	40a7853b          	subw	a0,a5,a0
    314a:	6422                	ld	s0,8(sp)
    314c:	0141                	addi	sp,sp,16
    314e:	8082                	ret

0000000000003150 <strlen>:

uint
strlen(const char *s)
{
    3150:	1141                	addi	sp,sp,-16
    3152:	e422                	sd	s0,8(sp)
    3154:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    3156:	00054783          	lbu	a5,0(a0)
    315a:	cf91                	beqz	a5,3176 <strlen+0x26>
    315c:	0505                	addi	a0,a0,1
    315e:	87aa                	mv	a5,a0
    3160:	4685                	li	a3,1
    3162:	9e89                	subw	a3,a3,a0
    3164:	00f6853b          	addw	a0,a3,a5
    3168:	0785                	addi	a5,a5,1
    316a:	fff7c703          	lbu	a4,-1(a5)
    316e:	fb7d                	bnez	a4,3164 <strlen+0x14>
    ;
  return n;
}
    3170:	6422                	ld	s0,8(sp)
    3172:	0141                	addi	sp,sp,16
    3174:	8082                	ret
  for(n = 0; s[n]; n++)
    3176:	4501                	li	a0,0
    3178:	bfe5                	j	3170 <strlen+0x20>

000000000000317a <memset>:

void*
memset(void *dst, int c, uint n)
{
    317a:	1141                	addi	sp,sp,-16
    317c:	e422                	sd	s0,8(sp)
    317e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    3180:	ca19                	beqz	a2,3196 <memset+0x1c>
    3182:	87aa                	mv	a5,a0
    3184:	1602                	slli	a2,a2,0x20
    3186:	9201                	srli	a2,a2,0x20
    3188:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    318c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    3190:	0785                	addi	a5,a5,1
    3192:	fee79de3          	bne	a5,a4,318c <memset+0x12>
  }
  return dst;
}
    3196:	6422                	ld	s0,8(sp)
    3198:	0141                	addi	sp,sp,16
    319a:	8082                	ret

000000000000319c <strchr>:

char*
strchr(const char *s, char c)
{
    319c:	1141                	addi	sp,sp,-16
    319e:	e422                	sd	s0,8(sp)
    31a0:	0800                	addi	s0,sp,16
  for(; *s; s++)
    31a2:	00054783          	lbu	a5,0(a0)
    31a6:	cb99                	beqz	a5,31bc <strchr+0x20>
    if(*s == c)
    31a8:	00f58763          	beq	a1,a5,31b6 <strchr+0x1a>
  for(; *s; s++)
    31ac:	0505                	addi	a0,a0,1
    31ae:	00054783          	lbu	a5,0(a0)
    31b2:	fbfd                	bnez	a5,31a8 <strchr+0xc>
      return (char*)s;
  return 0;
    31b4:	4501                	li	a0,0
}
    31b6:	6422                	ld	s0,8(sp)
    31b8:	0141                	addi	sp,sp,16
    31ba:	8082                	ret
  return 0;
    31bc:	4501                	li	a0,0
    31be:	bfe5                	j	31b6 <strchr+0x1a>

00000000000031c0 <gets>:

char*
gets(char *buf, int max)
{
    31c0:	711d                	addi	sp,sp,-96
    31c2:	ec86                	sd	ra,88(sp)
    31c4:	e8a2                	sd	s0,80(sp)
    31c6:	e4a6                	sd	s1,72(sp)
    31c8:	e0ca                	sd	s2,64(sp)
    31ca:	fc4e                	sd	s3,56(sp)
    31cc:	f852                	sd	s4,48(sp)
    31ce:	f456                	sd	s5,40(sp)
    31d0:	f05a                	sd	s6,32(sp)
    31d2:	ec5e                	sd	s7,24(sp)
    31d4:	1080                	addi	s0,sp,96
    31d6:	8baa                	mv	s7,a0
    31d8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    31da:	892a                	mv	s2,a0
    31dc:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    31de:	4aa9                	li	s5,10
    31e0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    31e2:	89a6                	mv	s3,s1
    31e4:	2485                	addiw	s1,s1,1
    31e6:	0344d863          	bge	s1,s4,3216 <gets+0x56>
    cc = read(0, &c, 1);
    31ea:	4605                	li	a2,1
    31ec:	faf40593          	addi	a1,s0,-81
    31f0:	4501                	li	a0,0
    31f2:	00000097          	auipc	ra,0x0
    31f6:	1fc080e7          	jalr	508(ra) # 33ee <read>
    if(cc < 1)
    31fa:	00a05e63          	blez	a0,3216 <gets+0x56>
    buf[i++] = c;
    31fe:	faf44783          	lbu	a5,-81(s0)
    3202:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3206:	01578763          	beq	a5,s5,3214 <gets+0x54>
    320a:	0905                	addi	s2,s2,1
    320c:	fd679be3          	bne	a5,s6,31e2 <gets+0x22>
  for(i=0; i+1 < max; ){
    3210:	89a6                	mv	s3,s1
    3212:	a011                	j	3216 <gets+0x56>
    3214:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3216:	99de                	add	s3,s3,s7
    3218:	00098023          	sb	zero,0(s3)
  return buf;
}
    321c:	855e                	mv	a0,s7
    321e:	60e6                	ld	ra,88(sp)
    3220:	6446                	ld	s0,80(sp)
    3222:	64a6                	ld	s1,72(sp)
    3224:	6906                	ld	s2,64(sp)
    3226:	79e2                	ld	s3,56(sp)
    3228:	7a42                	ld	s4,48(sp)
    322a:	7aa2                	ld	s5,40(sp)
    322c:	7b02                	ld	s6,32(sp)
    322e:	6be2                	ld	s7,24(sp)
    3230:	6125                	addi	sp,sp,96
    3232:	8082                	ret

0000000000003234 <stat>:

int
stat(const char *n, struct stat *st)
{
    3234:	1101                	addi	sp,sp,-32
    3236:	ec06                	sd	ra,24(sp)
    3238:	e822                	sd	s0,16(sp)
    323a:	e426                	sd	s1,8(sp)
    323c:	e04a                	sd	s2,0(sp)
    323e:	1000                	addi	s0,sp,32
    3240:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3242:	4581                	li	a1,0
    3244:	00000097          	auipc	ra,0x0
    3248:	1d2080e7          	jalr	466(ra) # 3416 <open>
  if(fd < 0)
    324c:	02054563          	bltz	a0,3276 <stat+0x42>
    3250:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    3252:	85ca                	mv	a1,s2
    3254:	00000097          	auipc	ra,0x0
    3258:	1da080e7          	jalr	474(ra) # 342e <fstat>
    325c:	892a                	mv	s2,a0
  close(fd);
    325e:	8526                	mv	a0,s1
    3260:	00000097          	auipc	ra,0x0
    3264:	19e080e7          	jalr	414(ra) # 33fe <close>
  return r;
}
    3268:	854a                	mv	a0,s2
    326a:	60e2                	ld	ra,24(sp)
    326c:	6442                	ld	s0,16(sp)
    326e:	64a2                	ld	s1,8(sp)
    3270:	6902                	ld	s2,0(sp)
    3272:	6105                	addi	sp,sp,32
    3274:	8082                	ret
    return -1;
    3276:	597d                	li	s2,-1
    3278:	bfc5                	j	3268 <stat+0x34>

000000000000327a <atoi>:

int
atoi(const char *s)
{
    327a:	1141                	addi	sp,sp,-16
    327c:	e422                	sd	s0,8(sp)
    327e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3280:	00054603          	lbu	a2,0(a0)
    3284:	fd06079b          	addiw	a5,a2,-48
    3288:	0ff7f793          	andi	a5,a5,255
    328c:	4725                	li	a4,9
    328e:	02f76963          	bltu	a4,a5,32c0 <atoi+0x46>
    3292:	86aa                	mv	a3,a0
  n = 0;
    3294:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    3296:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    3298:	0685                	addi	a3,a3,1
    329a:	0025179b          	slliw	a5,a0,0x2
    329e:	9fa9                	addw	a5,a5,a0
    32a0:	0017979b          	slliw	a5,a5,0x1
    32a4:	9fb1                	addw	a5,a5,a2
    32a6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    32aa:	0006c603          	lbu	a2,0(a3)
    32ae:	fd06071b          	addiw	a4,a2,-48
    32b2:	0ff77713          	andi	a4,a4,255
    32b6:	fee5f1e3          	bgeu	a1,a4,3298 <atoi+0x1e>
  return n;
}
    32ba:	6422                	ld	s0,8(sp)
    32bc:	0141                	addi	sp,sp,16
    32be:	8082                	ret
  n = 0;
    32c0:	4501                	li	a0,0
    32c2:	bfe5                	j	32ba <atoi+0x40>

00000000000032c4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    32c4:	1141                	addi	sp,sp,-16
    32c6:	e422                	sd	s0,8(sp)
    32c8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    32ca:	02b57463          	bgeu	a0,a1,32f2 <memmove+0x2e>
    while(n-- > 0)
    32ce:	00c05f63          	blez	a2,32ec <memmove+0x28>
    32d2:	1602                	slli	a2,a2,0x20
    32d4:	9201                	srli	a2,a2,0x20
    32d6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    32da:	872a                	mv	a4,a0
      *dst++ = *src++;
    32dc:	0585                	addi	a1,a1,1
    32de:	0705                	addi	a4,a4,1
    32e0:	fff5c683          	lbu	a3,-1(a1)
    32e4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    32e8:	fee79ae3          	bne	a5,a4,32dc <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    32ec:	6422                	ld	s0,8(sp)
    32ee:	0141                	addi	sp,sp,16
    32f0:	8082                	ret
    dst += n;
    32f2:	00c50733          	add	a4,a0,a2
    src += n;
    32f6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    32f8:	fec05ae3          	blez	a2,32ec <memmove+0x28>
    32fc:	fff6079b          	addiw	a5,a2,-1
    3300:	1782                	slli	a5,a5,0x20
    3302:	9381                	srli	a5,a5,0x20
    3304:	fff7c793          	not	a5,a5
    3308:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    330a:	15fd                	addi	a1,a1,-1
    330c:	177d                	addi	a4,a4,-1
    330e:	0005c683          	lbu	a3,0(a1)
    3312:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3316:	fee79ae3          	bne	a5,a4,330a <memmove+0x46>
    331a:	bfc9                	j	32ec <memmove+0x28>

000000000000331c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    331c:	1141                	addi	sp,sp,-16
    331e:	e422                	sd	s0,8(sp)
    3320:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    3322:	ca05                	beqz	a2,3352 <memcmp+0x36>
    3324:	fff6069b          	addiw	a3,a2,-1
    3328:	1682                	slli	a3,a3,0x20
    332a:	9281                	srli	a3,a3,0x20
    332c:	0685                	addi	a3,a3,1
    332e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    3330:	00054783          	lbu	a5,0(a0)
    3334:	0005c703          	lbu	a4,0(a1)
    3338:	00e79863          	bne	a5,a4,3348 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    333c:	0505                	addi	a0,a0,1
    p2++;
    333e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    3340:	fed518e3          	bne	a0,a3,3330 <memcmp+0x14>
  }
  return 0;
    3344:	4501                	li	a0,0
    3346:	a019                	j	334c <memcmp+0x30>
      return *p1 - *p2;
    3348:	40e7853b          	subw	a0,a5,a4
}
    334c:	6422                	ld	s0,8(sp)
    334e:	0141                	addi	sp,sp,16
    3350:	8082                	ret
  return 0;
    3352:	4501                	li	a0,0
    3354:	bfe5                	j	334c <memcmp+0x30>

0000000000003356 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    3356:	1141                	addi	sp,sp,-16
    3358:	e406                	sd	ra,8(sp)
    335a:	e022                	sd	s0,0(sp)
    335c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    335e:	00000097          	auipc	ra,0x0
    3362:	f66080e7          	jalr	-154(ra) # 32c4 <memmove>
}
    3366:	60a2                	ld	ra,8(sp)
    3368:	6402                	ld	s0,0(sp)
    336a:	0141                	addi	sp,sp,16
    336c:	8082                	ret

000000000000336e <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    336e:	1141                	addi	sp,sp,-16
    3370:	e422                	sd	s0,8(sp)
    3372:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    3374:	00052023          	sw	zero,0(a0)
}  
    3378:	6422                	ld	s0,8(sp)
    337a:	0141                	addi	sp,sp,16
    337c:	8082                	ret

000000000000337e <lock>:

void lock(struct spinlock * lk) 
{    
    337e:	1141                	addi	sp,sp,-16
    3380:	e422                	sd	s0,8(sp)
    3382:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    3384:	4705                	li	a4,1
    3386:	87ba                	mv	a5,a4
    3388:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    338c:	2781                	sext.w	a5,a5
    338e:	ffe5                	bnez	a5,3386 <lock+0x8>
}  
    3390:	6422                	ld	s0,8(sp)
    3392:	0141                	addi	sp,sp,16
    3394:	8082                	ret

0000000000003396 <unlock>:

void unlock(struct spinlock * lk) 
{   
    3396:	1141                	addi	sp,sp,-16
    3398:	e422                	sd	s0,8(sp)
    339a:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    339c:	0f50000f          	fence	iorw,ow
    33a0:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    33a4:	6422                	ld	s0,8(sp)
    33a6:	0141                	addi	sp,sp,16
    33a8:	8082                	ret

00000000000033aa <isDigit>:

unsigned int isDigit(char *c) {
    33aa:	1141                	addi	sp,sp,-16
    33ac:	e422                	sd	s0,8(sp)
    33ae:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    33b0:	00054503          	lbu	a0,0(a0)
    33b4:	fd05051b          	addiw	a0,a0,-48
    33b8:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    33bc:	00a53513          	sltiu	a0,a0,10
    33c0:	6422                	ld	s0,8(sp)
    33c2:	0141                	addi	sp,sp,16
    33c4:	8082                	ret

00000000000033c6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    33c6:	4885                	li	a7,1
 ecall
    33c8:	00000073          	ecall
 ret
    33cc:	8082                	ret

00000000000033ce <exit>:
.global exit
exit:
 li a7, SYS_exit
    33ce:	4889                	li	a7,2
 ecall
    33d0:	00000073          	ecall
 ret
    33d4:	8082                	ret

00000000000033d6 <wait>:
.global wait
wait:
 li a7, SYS_wait
    33d6:	488d                	li	a7,3
 ecall
    33d8:	00000073          	ecall
 ret
    33dc:	8082                	ret

00000000000033de <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    33de:	48e1                	li	a7,24
 ecall
    33e0:	00000073          	ecall
 ret
    33e4:	8082                	ret

00000000000033e6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    33e6:	4891                	li	a7,4
 ecall
    33e8:	00000073          	ecall
 ret
    33ec:	8082                	ret

00000000000033ee <read>:
.global read
read:
 li a7, SYS_read
    33ee:	4895                	li	a7,5
 ecall
    33f0:	00000073          	ecall
 ret
    33f4:	8082                	ret

00000000000033f6 <write>:
.global write
write:
 li a7, SYS_write
    33f6:	48c1                	li	a7,16
 ecall
    33f8:	00000073          	ecall
 ret
    33fc:	8082                	ret

00000000000033fe <close>:
.global close
close:
 li a7, SYS_close
    33fe:	48d5                	li	a7,21
 ecall
    3400:	00000073          	ecall
 ret
    3404:	8082                	ret

0000000000003406 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3406:	4899                	li	a7,6
 ecall
    3408:	00000073          	ecall
 ret
    340c:	8082                	ret

000000000000340e <exec>:
.global exec
exec:
 li a7, SYS_exec
    340e:	489d                	li	a7,7
 ecall
    3410:	00000073          	ecall
 ret
    3414:	8082                	ret

0000000000003416 <open>:
.global open
open:
 li a7, SYS_open
    3416:	48bd                	li	a7,15
 ecall
    3418:	00000073          	ecall
 ret
    341c:	8082                	ret

000000000000341e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    341e:	48c5                	li	a7,17
 ecall
    3420:	00000073          	ecall
 ret
    3424:	8082                	ret

0000000000003426 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3426:	48c9                	li	a7,18
 ecall
    3428:	00000073          	ecall
 ret
    342c:	8082                	ret

000000000000342e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    342e:	48a1                	li	a7,8
 ecall
    3430:	00000073          	ecall
 ret
    3434:	8082                	ret

0000000000003436 <link>:
.global link
link:
 li a7, SYS_link
    3436:	48cd                	li	a7,19
 ecall
    3438:	00000073          	ecall
 ret
    343c:	8082                	ret

000000000000343e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    343e:	48d1                	li	a7,20
 ecall
    3440:	00000073          	ecall
 ret
    3444:	8082                	ret

0000000000003446 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3446:	48a5                	li	a7,9
 ecall
    3448:	00000073          	ecall
 ret
    344c:	8082                	ret

000000000000344e <dup>:
.global dup
dup:
 li a7, SYS_dup
    344e:	48a9                	li	a7,10
 ecall
    3450:	00000073          	ecall
 ret
    3454:	8082                	ret

0000000000003456 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    3456:	48ad                	li	a7,11
 ecall
    3458:	00000073          	ecall
 ret
    345c:	8082                	ret

000000000000345e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    345e:	48b1                	li	a7,12
 ecall
    3460:	00000073          	ecall
 ret
    3464:	8082                	ret

0000000000003466 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    3466:	48b5                	li	a7,13
 ecall
    3468:	00000073          	ecall
 ret
    346c:	8082                	ret

000000000000346e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    346e:	48b9                	li	a7,14
 ecall
    3470:	00000073          	ecall
 ret
    3474:	8082                	ret

0000000000003476 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    3476:	48d9                	li	a7,22
 ecall
    3478:	00000073          	ecall
 ret
    347c:	8082                	ret

000000000000347e <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    347e:	48dd                	li	a7,23
 ecall
    3480:	00000073          	ecall
 ret
    3484:	8082                	ret

0000000000003486 <ps>:
.global ps
ps:
 li a7, SYS_ps
    3486:	48e5                	li	a7,25
 ecall
    3488:	00000073          	ecall
 ret
    348c:	8082                	ret

000000000000348e <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    348e:	48e9                	li	a7,26
 ecall
    3490:	00000073          	ecall
 ret
    3494:	8082                	ret

0000000000003496 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    3496:	48ed                	li	a7,27
 ecall
    3498:	00000073          	ecall
 ret
    349c:	8082                	ret

000000000000349e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    349e:	1101                	addi	sp,sp,-32
    34a0:	ec06                	sd	ra,24(sp)
    34a2:	e822                	sd	s0,16(sp)
    34a4:	1000                	addi	s0,sp,32
    34a6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    34aa:	4605                	li	a2,1
    34ac:	fef40593          	addi	a1,s0,-17
    34b0:	00000097          	auipc	ra,0x0
    34b4:	f46080e7          	jalr	-186(ra) # 33f6 <write>
}
    34b8:	60e2                	ld	ra,24(sp)
    34ba:	6442                	ld	s0,16(sp)
    34bc:	6105                	addi	sp,sp,32
    34be:	8082                	ret

00000000000034c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    34c0:	7139                	addi	sp,sp,-64
    34c2:	fc06                	sd	ra,56(sp)
    34c4:	f822                	sd	s0,48(sp)
    34c6:	f426                	sd	s1,40(sp)
    34c8:	f04a                	sd	s2,32(sp)
    34ca:	ec4e                	sd	s3,24(sp)
    34cc:	0080                	addi	s0,sp,64
    34ce:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    34d0:	c299                	beqz	a3,34d6 <printint+0x16>
    34d2:	0805c863          	bltz	a1,3562 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    34d6:	2581                	sext.w	a1,a1
  neg = 0;
    34d8:	4881                	li	a7,0
    34da:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    34de:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    34e0:	2601                	sext.w	a2,a2
    34e2:	00000517          	auipc	a0,0x0
    34e6:	4de50513          	addi	a0,a0,1246 # 39c0 <digits>
    34ea:	883a                	mv	a6,a4
    34ec:	2705                	addiw	a4,a4,1
    34ee:	02c5f7bb          	remuw	a5,a1,a2
    34f2:	1782                	slli	a5,a5,0x20
    34f4:	9381                	srli	a5,a5,0x20
    34f6:	97aa                	add	a5,a5,a0
    34f8:	0007c783          	lbu	a5,0(a5)
    34fc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    3500:	0005879b          	sext.w	a5,a1
    3504:	02c5d5bb          	divuw	a1,a1,a2
    3508:	0685                	addi	a3,a3,1
    350a:	fec7f0e3          	bgeu	a5,a2,34ea <printint+0x2a>
  if(neg)
    350e:	00088b63          	beqz	a7,3524 <printint+0x64>
    buf[i++] = '-';
    3512:	fd040793          	addi	a5,s0,-48
    3516:	973e                	add	a4,a4,a5
    3518:	02d00793          	li	a5,45
    351c:	fef70823          	sb	a5,-16(a4)
    3520:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    3524:	02e05863          	blez	a4,3554 <printint+0x94>
    3528:	fc040793          	addi	a5,s0,-64
    352c:	00e78933          	add	s2,a5,a4
    3530:	fff78993          	addi	s3,a5,-1
    3534:	99ba                	add	s3,s3,a4
    3536:	377d                	addiw	a4,a4,-1
    3538:	1702                	slli	a4,a4,0x20
    353a:	9301                	srli	a4,a4,0x20
    353c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    3540:	fff94583          	lbu	a1,-1(s2)
    3544:	8526                	mv	a0,s1
    3546:	00000097          	auipc	ra,0x0
    354a:	f58080e7          	jalr	-168(ra) # 349e <putc>
  while(--i >= 0)
    354e:	197d                	addi	s2,s2,-1
    3550:	ff3918e3          	bne	s2,s3,3540 <printint+0x80>
}
    3554:	70e2                	ld	ra,56(sp)
    3556:	7442                	ld	s0,48(sp)
    3558:	74a2                	ld	s1,40(sp)
    355a:	7902                	ld	s2,32(sp)
    355c:	69e2                	ld	s3,24(sp)
    355e:	6121                	addi	sp,sp,64
    3560:	8082                	ret
    x = -xx;
    3562:	40b005bb          	negw	a1,a1
    neg = 1;
    3566:	4885                	li	a7,1
    x = -xx;
    3568:	bf8d                	j	34da <printint+0x1a>

000000000000356a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    356a:	7119                	addi	sp,sp,-128
    356c:	fc86                	sd	ra,120(sp)
    356e:	f8a2                	sd	s0,112(sp)
    3570:	f4a6                	sd	s1,104(sp)
    3572:	f0ca                	sd	s2,96(sp)
    3574:	ecce                	sd	s3,88(sp)
    3576:	e8d2                	sd	s4,80(sp)
    3578:	e4d6                	sd	s5,72(sp)
    357a:	e0da                	sd	s6,64(sp)
    357c:	fc5e                	sd	s7,56(sp)
    357e:	f862                	sd	s8,48(sp)
    3580:	f466                	sd	s9,40(sp)
    3582:	f06a                	sd	s10,32(sp)
    3584:	ec6e                	sd	s11,24(sp)
    3586:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    3588:	0005c903          	lbu	s2,0(a1)
    358c:	18090f63          	beqz	s2,372a <vprintf+0x1c0>
    3590:	8aaa                	mv	s5,a0
    3592:	8b32                	mv	s6,a2
    3594:	00158493          	addi	s1,a1,1
  state = 0;
    3598:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    359a:	02500a13          	li	s4,37
      if(c == 'd'){
    359e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    35a2:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    35a6:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    35aa:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    35ae:	00000b97          	auipc	s7,0x0
    35b2:	412b8b93          	addi	s7,s7,1042 # 39c0 <digits>
    35b6:	a839                	j	35d4 <vprintf+0x6a>
        putc(fd, c);
    35b8:	85ca                	mv	a1,s2
    35ba:	8556                	mv	a0,s5
    35bc:	00000097          	auipc	ra,0x0
    35c0:	ee2080e7          	jalr	-286(ra) # 349e <putc>
    35c4:	a019                	j	35ca <vprintf+0x60>
    } else if(state == '%'){
    35c6:	01498f63          	beq	s3,s4,35e4 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    35ca:	0485                	addi	s1,s1,1
    35cc:	fff4c903          	lbu	s2,-1(s1)
    35d0:	14090d63          	beqz	s2,372a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    35d4:	0009079b          	sext.w	a5,s2
    if(state == 0){
    35d8:	fe0997e3          	bnez	s3,35c6 <vprintf+0x5c>
      if(c == '%'){
    35dc:	fd479ee3          	bne	a5,s4,35b8 <vprintf+0x4e>
        state = '%';
    35e0:	89be                	mv	s3,a5
    35e2:	b7e5                	j	35ca <vprintf+0x60>
      if(c == 'd'){
    35e4:	05878063          	beq	a5,s8,3624 <vprintf+0xba>
      } else if(c == 'l') {
    35e8:	05978c63          	beq	a5,s9,3640 <vprintf+0xd6>
      } else if(c == 'x') {
    35ec:	07a78863          	beq	a5,s10,365c <vprintf+0xf2>
      } else if(c == 'p') {
    35f0:	09b78463          	beq	a5,s11,3678 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    35f4:	07300713          	li	a4,115
    35f8:	0ce78663          	beq	a5,a4,36c4 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    35fc:	06300713          	li	a4,99
    3600:	0ee78e63          	beq	a5,a4,36fc <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    3604:	11478863          	beq	a5,s4,3714 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3608:	85d2                	mv	a1,s4
    360a:	8556                	mv	a0,s5
    360c:	00000097          	auipc	ra,0x0
    3610:	e92080e7          	jalr	-366(ra) # 349e <putc>
        putc(fd, c);
    3614:	85ca                	mv	a1,s2
    3616:	8556                	mv	a0,s5
    3618:	00000097          	auipc	ra,0x0
    361c:	e86080e7          	jalr	-378(ra) # 349e <putc>
      }
      state = 0;
    3620:	4981                	li	s3,0
    3622:	b765                	j	35ca <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    3624:	008b0913          	addi	s2,s6,8
    3628:	4685                	li	a3,1
    362a:	4629                	li	a2,10
    362c:	000b2583          	lw	a1,0(s6)
    3630:	8556                	mv	a0,s5
    3632:	00000097          	auipc	ra,0x0
    3636:	e8e080e7          	jalr	-370(ra) # 34c0 <printint>
    363a:	8b4a                	mv	s6,s2
      state = 0;
    363c:	4981                	li	s3,0
    363e:	b771                	j	35ca <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    3640:	008b0913          	addi	s2,s6,8
    3644:	4681                	li	a3,0
    3646:	4629                	li	a2,10
    3648:	000b2583          	lw	a1,0(s6)
    364c:	8556                	mv	a0,s5
    364e:	00000097          	auipc	ra,0x0
    3652:	e72080e7          	jalr	-398(ra) # 34c0 <printint>
    3656:	8b4a                	mv	s6,s2
      state = 0;
    3658:	4981                	li	s3,0
    365a:	bf85                	j	35ca <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    365c:	008b0913          	addi	s2,s6,8
    3660:	4681                	li	a3,0
    3662:	4641                	li	a2,16
    3664:	000b2583          	lw	a1,0(s6)
    3668:	8556                	mv	a0,s5
    366a:	00000097          	auipc	ra,0x0
    366e:	e56080e7          	jalr	-426(ra) # 34c0 <printint>
    3672:	8b4a                	mv	s6,s2
      state = 0;
    3674:	4981                	li	s3,0
    3676:	bf91                	j	35ca <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    3678:	008b0793          	addi	a5,s6,8
    367c:	f8f43423          	sd	a5,-120(s0)
    3680:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    3684:	03000593          	li	a1,48
    3688:	8556                	mv	a0,s5
    368a:	00000097          	auipc	ra,0x0
    368e:	e14080e7          	jalr	-492(ra) # 349e <putc>
  putc(fd, 'x');
    3692:	85ea                	mv	a1,s10
    3694:	8556                	mv	a0,s5
    3696:	00000097          	auipc	ra,0x0
    369a:	e08080e7          	jalr	-504(ra) # 349e <putc>
    369e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    36a0:	03c9d793          	srli	a5,s3,0x3c
    36a4:	97de                	add	a5,a5,s7
    36a6:	0007c583          	lbu	a1,0(a5)
    36aa:	8556                	mv	a0,s5
    36ac:	00000097          	auipc	ra,0x0
    36b0:	df2080e7          	jalr	-526(ra) # 349e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    36b4:	0992                	slli	s3,s3,0x4
    36b6:	397d                	addiw	s2,s2,-1
    36b8:	fe0914e3          	bnez	s2,36a0 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    36bc:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    36c0:	4981                	li	s3,0
    36c2:	b721                	j	35ca <vprintf+0x60>
        s = va_arg(ap, char*);
    36c4:	008b0993          	addi	s3,s6,8
    36c8:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    36cc:	02090163          	beqz	s2,36ee <vprintf+0x184>
        while(*s != 0){
    36d0:	00094583          	lbu	a1,0(s2)
    36d4:	c9a1                	beqz	a1,3724 <vprintf+0x1ba>
          putc(fd, *s);
    36d6:	8556                	mv	a0,s5
    36d8:	00000097          	auipc	ra,0x0
    36dc:	dc6080e7          	jalr	-570(ra) # 349e <putc>
          s++;
    36e0:	0905                	addi	s2,s2,1
        while(*s != 0){
    36e2:	00094583          	lbu	a1,0(s2)
    36e6:	f9e5                	bnez	a1,36d6 <vprintf+0x16c>
        s = va_arg(ap, char*);
    36e8:	8b4e                	mv	s6,s3
      state = 0;
    36ea:	4981                	li	s3,0
    36ec:	bdf9                	j	35ca <vprintf+0x60>
          s = "(null)";
    36ee:	00000917          	auipc	s2,0x0
    36f2:	2ca90913          	addi	s2,s2,714 # 39b8 <malloc+0x184>
        while(*s != 0){
    36f6:	02800593          	li	a1,40
    36fa:	bff1                	j	36d6 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    36fc:	008b0913          	addi	s2,s6,8
    3700:	000b4583          	lbu	a1,0(s6)
    3704:	8556                	mv	a0,s5
    3706:	00000097          	auipc	ra,0x0
    370a:	d98080e7          	jalr	-616(ra) # 349e <putc>
    370e:	8b4a                	mv	s6,s2
      state = 0;
    3710:	4981                	li	s3,0
    3712:	bd65                	j	35ca <vprintf+0x60>
        putc(fd, c);
    3714:	85d2                	mv	a1,s4
    3716:	8556                	mv	a0,s5
    3718:	00000097          	auipc	ra,0x0
    371c:	d86080e7          	jalr	-634(ra) # 349e <putc>
      state = 0;
    3720:	4981                	li	s3,0
    3722:	b565                	j	35ca <vprintf+0x60>
        s = va_arg(ap, char*);
    3724:	8b4e                	mv	s6,s3
      state = 0;
    3726:	4981                	li	s3,0
    3728:	b54d                	j	35ca <vprintf+0x60>
    }
  }
}
    372a:	70e6                	ld	ra,120(sp)
    372c:	7446                	ld	s0,112(sp)
    372e:	74a6                	ld	s1,104(sp)
    3730:	7906                	ld	s2,96(sp)
    3732:	69e6                	ld	s3,88(sp)
    3734:	6a46                	ld	s4,80(sp)
    3736:	6aa6                	ld	s5,72(sp)
    3738:	6b06                	ld	s6,64(sp)
    373a:	7be2                	ld	s7,56(sp)
    373c:	7c42                	ld	s8,48(sp)
    373e:	7ca2                	ld	s9,40(sp)
    3740:	7d02                	ld	s10,32(sp)
    3742:	6de2                	ld	s11,24(sp)
    3744:	6109                	addi	sp,sp,128
    3746:	8082                	ret

0000000000003748 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    3748:	715d                	addi	sp,sp,-80
    374a:	ec06                	sd	ra,24(sp)
    374c:	e822                	sd	s0,16(sp)
    374e:	1000                	addi	s0,sp,32
    3750:	e010                	sd	a2,0(s0)
    3752:	e414                	sd	a3,8(s0)
    3754:	e818                	sd	a4,16(s0)
    3756:	ec1c                	sd	a5,24(s0)
    3758:	03043023          	sd	a6,32(s0)
    375c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    3760:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    3764:	8622                	mv	a2,s0
    3766:	00000097          	auipc	ra,0x0
    376a:	e04080e7          	jalr	-508(ra) # 356a <vprintf>
}
    376e:	60e2                	ld	ra,24(sp)
    3770:	6442                	ld	s0,16(sp)
    3772:	6161                	addi	sp,sp,80
    3774:	8082                	ret

0000000000003776 <printf>:

void
printf(const char *fmt, ...)
{
    3776:	711d                	addi	sp,sp,-96
    3778:	ec06                	sd	ra,24(sp)
    377a:	e822                	sd	s0,16(sp)
    377c:	1000                	addi	s0,sp,32
    377e:	e40c                	sd	a1,8(s0)
    3780:	e810                	sd	a2,16(s0)
    3782:	ec14                	sd	a3,24(s0)
    3784:	f018                	sd	a4,32(s0)
    3786:	f41c                	sd	a5,40(s0)
    3788:	03043823          	sd	a6,48(s0)
    378c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    3790:	00840613          	addi	a2,s0,8
    3794:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    3798:	85aa                	mv	a1,a0
    379a:	4505                	li	a0,1
    379c:	00000097          	auipc	ra,0x0
    37a0:	dce080e7          	jalr	-562(ra) # 356a <vprintf>
}
    37a4:	60e2                	ld	ra,24(sp)
    37a6:	6442                	ld	s0,16(sp)
    37a8:	6125                	addi	sp,sp,96
    37aa:	8082                	ret

00000000000037ac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    37ac:	1141                	addi	sp,sp,-16
    37ae:	e422                	sd	s0,8(sp)
    37b0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    37b2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    37b6:	00001797          	auipc	a5,0x1
    37ba:	84a7b783          	ld	a5,-1974(a5) # 4000 <freep>
    37be:	a805                	j	37ee <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    37c0:	4618                	lw	a4,8(a2)
    37c2:	9db9                	addw	a1,a1,a4
    37c4:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    37c8:	6398                	ld	a4,0(a5)
    37ca:	6318                	ld	a4,0(a4)
    37cc:	fee53823          	sd	a4,-16(a0)
    37d0:	a091                	j	3814 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    37d2:	ff852703          	lw	a4,-8(a0)
    37d6:	9e39                	addw	a2,a2,a4
    37d8:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    37da:	ff053703          	ld	a4,-16(a0)
    37de:	e398                	sd	a4,0(a5)
    37e0:	a099                	j	3826 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    37e2:	6398                	ld	a4,0(a5)
    37e4:	00e7e463          	bltu	a5,a4,37ec <free+0x40>
    37e8:	00e6ea63          	bltu	a3,a4,37fc <free+0x50>
{
    37ec:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    37ee:	fed7fae3          	bgeu	a5,a3,37e2 <free+0x36>
    37f2:	6398                	ld	a4,0(a5)
    37f4:	00e6e463          	bltu	a3,a4,37fc <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    37f8:	fee7eae3          	bltu	a5,a4,37ec <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    37fc:	ff852583          	lw	a1,-8(a0)
    3800:	6390                	ld	a2,0(a5)
    3802:	02059713          	slli	a4,a1,0x20
    3806:	9301                	srli	a4,a4,0x20
    3808:	0712                	slli	a4,a4,0x4
    380a:	9736                	add	a4,a4,a3
    380c:	fae60ae3          	beq	a2,a4,37c0 <free+0x14>
    bp->s.ptr = p->s.ptr;
    3810:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    3814:	4790                	lw	a2,8(a5)
    3816:	02061713          	slli	a4,a2,0x20
    381a:	9301                	srli	a4,a4,0x20
    381c:	0712                	slli	a4,a4,0x4
    381e:	973e                	add	a4,a4,a5
    3820:	fae689e3          	beq	a3,a4,37d2 <free+0x26>
  } else
    p->s.ptr = bp;
    3824:	e394                	sd	a3,0(a5)
  freep = p;
    3826:	00000717          	auipc	a4,0x0
    382a:	7cf73d23          	sd	a5,2010(a4) # 4000 <freep>
}
    382e:	6422                	ld	s0,8(sp)
    3830:	0141                	addi	sp,sp,16
    3832:	8082                	ret

0000000000003834 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3834:	7139                	addi	sp,sp,-64
    3836:	fc06                	sd	ra,56(sp)
    3838:	f822                	sd	s0,48(sp)
    383a:	f426                	sd	s1,40(sp)
    383c:	f04a                	sd	s2,32(sp)
    383e:	ec4e                	sd	s3,24(sp)
    3840:	e852                	sd	s4,16(sp)
    3842:	e456                	sd	s5,8(sp)
    3844:	e05a                	sd	s6,0(sp)
    3846:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3848:	02051493          	slli	s1,a0,0x20
    384c:	9081                	srli	s1,s1,0x20
    384e:	04bd                	addi	s1,s1,15
    3850:	8091                	srli	s1,s1,0x4
    3852:	0014899b          	addiw	s3,s1,1
    3856:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    3858:	00000517          	auipc	a0,0x0
    385c:	7a853503          	ld	a0,1960(a0) # 4000 <freep>
    3860:	c515                	beqz	a0,388c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3862:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3864:	4798                	lw	a4,8(a5)
    3866:	02977f63          	bgeu	a4,s1,38a4 <malloc+0x70>
    386a:	8a4e                	mv	s4,s3
    386c:	0009871b          	sext.w	a4,s3
    3870:	6685                	lui	a3,0x1
    3872:	00d77363          	bgeu	a4,a3,3878 <malloc+0x44>
    3876:	6a05                	lui	s4,0x1
    3878:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    387c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3880:	00000917          	auipc	s2,0x0
    3884:	78090913          	addi	s2,s2,1920 # 4000 <freep>
  if(p == (char*)-1)
    3888:	5afd                	li	s5,-1
    388a:	a88d                	j	38fc <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    388c:	00000797          	auipc	a5,0x0
    3890:	78478793          	addi	a5,a5,1924 # 4010 <base>
    3894:	00000717          	auipc	a4,0x0
    3898:	76f73623          	sd	a5,1900(a4) # 4000 <freep>
    389c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    389e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    38a2:	b7e1                	j	386a <malloc+0x36>
      if(p->s.size == nunits)
    38a4:	02e48b63          	beq	s1,a4,38da <malloc+0xa6>
        p->s.size -= nunits;
    38a8:	4137073b          	subw	a4,a4,s3
    38ac:	c798                	sw	a4,8(a5)
        p += p->s.size;
    38ae:	1702                	slli	a4,a4,0x20
    38b0:	9301                	srli	a4,a4,0x20
    38b2:	0712                	slli	a4,a4,0x4
    38b4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    38b6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    38ba:	00000717          	auipc	a4,0x0
    38be:	74a73323          	sd	a0,1862(a4) # 4000 <freep>
      return (void*)(p + 1);
    38c2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    38c6:	70e2                	ld	ra,56(sp)
    38c8:	7442                	ld	s0,48(sp)
    38ca:	74a2                	ld	s1,40(sp)
    38cc:	7902                	ld	s2,32(sp)
    38ce:	69e2                	ld	s3,24(sp)
    38d0:	6a42                	ld	s4,16(sp)
    38d2:	6aa2                	ld	s5,8(sp)
    38d4:	6b02                	ld	s6,0(sp)
    38d6:	6121                	addi	sp,sp,64
    38d8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    38da:	6398                	ld	a4,0(a5)
    38dc:	e118                	sd	a4,0(a0)
    38de:	bff1                	j	38ba <malloc+0x86>
  hp->s.size = nu;
    38e0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    38e4:	0541                	addi	a0,a0,16
    38e6:	00000097          	auipc	ra,0x0
    38ea:	ec6080e7          	jalr	-314(ra) # 37ac <free>
  return freep;
    38ee:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    38f2:	d971                	beqz	a0,38c6 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    38f4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    38f6:	4798                	lw	a4,8(a5)
    38f8:	fa9776e3          	bgeu	a4,s1,38a4 <malloc+0x70>
    if(p == freep)
    38fc:	00093703          	ld	a4,0(s2)
    3900:	853e                	mv	a0,a5
    3902:	fef719e3          	bne	a4,a5,38f4 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3906:	8552                	mv	a0,s4
    3908:	00000097          	auipc	ra,0x0
    390c:	b56080e7          	jalr	-1194(ra) # 345e <sbrk>
  if(p == (char*)-1)
    3910:	fd5518e3          	bne	a0,s5,38e0 <malloc+0xac>
        return 0;
    3914:	4501                	li	a0,0
    3916:	bf45                	j	38c6 <malloc+0x92>
