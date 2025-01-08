
user/_stack3:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <recurse>:
}

void
recurse(int n) 
{
  if(n > 0)
    3000:	00a04363          	bgtz	a0,3006 <recurse+0x6>
    3004:	8082                	ret
{
    3006:	1141                	addi	sp,sp,-16
    3008:	e406                	sd	ra,8(sp)
    300a:	e022                	sd	s0,0(sp)
    300c:	0800                	addi	s0,sp,16
    recurse(n-1);
    300e:	357d                	addiw	a0,a0,-1
    3010:	00000097          	auipc	ra,0x0
    3014:	ff0080e7          	jalr	-16(ra) # 3000 <recurse>
}
    3018:	60a2                	ld	ra,8(sp)
    301a:	6402                	ld	s0,0(sp)
    301c:	0141                	addi	sp,sp,16
    301e:	8082                	ret

0000000000003020 <main>:

int
main(int argc, char *argv[])
{
    3020:	1141                	addi	sp,sp,-16
    3022:	e406                	sd	ra,8(sp)
    3024:	e022                	sd	s0,0(sp)
    3026:	0800                	addi	s0,sp,16
  int pid = fork();
    3028:	00000097          	auipc	ra,0x0
    302c:	31c080e7          	jalr	796(ra) # 3344 <fork>
  if(pid == 0) {
    3030:	e505                	bnez	a0,3058 <main+0x38>
    // the following command will hit the gap, you need to handle the fault and move the gap further down
    recurse(500); // if the fault is not handled, we will not reach the print
    3032:	1f400513          	li	a0,500
    3036:	00000097          	auipc	ra,0x0
    303a:	fca080e7          	jalr	-54(ra) # 3000 <recurse>
    printf("TEST PASSED\n");
    303e:	00001517          	auipc	a0,0x1
    3042:	86250513          	addi	a0,a0,-1950 # 38a0 <malloc+0xee>
    3046:	00000097          	auipc	ra,0x0
    304a:	6ae080e7          	jalr	1710(ra) # 36f4 <printf>
    exit(0);
    304e:	4501                	li	a0,0
    3050:	00000097          	auipc	ra,0x0
    3054:	2fc080e7          	jalr	764(ra) # 334c <exit>
  } else {
    wait(0);
    3058:	4501                	li	a0,0
    305a:	00000097          	auipc	ra,0x0
    305e:	2fa080e7          	jalr	762(ra) # 3354 <wait>
  }
  exit(0);
    3062:	4501                	li	a0,0
    3064:	00000097          	auipc	ra,0x0
    3068:	2e8080e7          	jalr	744(ra) # 334c <exit>

000000000000306c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    306c:	1141                	addi	sp,sp,-16
    306e:	e406                	sd	ra,8(sp)
    3070:	e022                	sd	s0,0(sp)
    3072:	0800                	addi	s0,sp,16
  extern int main();
  main();
    3074:	00000097          	auipc	ra,0x0
    3078:	fac080e7          	jalr	-84(ra) # 3020 <main>
  exit(0);
    307c:	4501                	li	a0,0
    307e:	00000097          	auipc	ra,0x0
    3082:	2ce080e7          	jalr	718(ra) # 334c <exit>

0000000000003086 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3086:	1141                	addi	sp,sp,-16
    3088:	e422                	sd	s0,8(sp)
    308a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    308c:	87aa                	mv	a5,a0
    308e:	0585                	addi	a1,a1,1
    3090:	0785                	addi	a5,a5,1
    3092:	fff5c703          	lbu	a4,-1(a1)
    3096:	fee78fa3          	sb	a4,-1(a5)
    309a:	fb75                	bnez	a4,308e <strcpy+0x8>
    ;
  return os;
}
    309c:	6422                	ld	s0,8(sp)
    309e:	0141                	addi	sp,sp,16
    30a0:	8082                	ret

00000000000030a2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    30a2:	1141                	addi	sp,sp,-16
    30a4:	e422                	sd	s0,8(sp)
    30a6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    30a8:	00054783          	lbu	a5,0(a0)
    30ac:	cb91                	beqz	a5,30c0 <strcmp+0x1e>
    30ae:	0005c703          	lbu	a4,0(a1)
    30b2:	00f71763          	bne	a4,a5,30c0 <strcmp+0x1e>
    p++, q++;
    30b6:	0505                	addi	a0,a0,1
    30b8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    30ba:	00054783          	lbu	a5,0(a0)
    30be:	fbe5                	bnez	a5,30ae <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    30c0:	0005c503          	lbu	a0,0(a1)
}
    30c4:	40a7853b          	subw	a0,a5,a0
    30c8:	6422                	ld	s0,8(sp)
    30ca:	0141                	addi	sp,sp,16
    30cc:	8082                	ret

00000000000030ce <strlen>:

uint
strlen(const char *s)
{
    30ce:	1141                	addi	sp,sp,-16
    30d0:	e422                	sd	s0,8(sp)
    30d2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    30d4:	00054783          	lbu	a5,0(a0)
    30d8:	cf91                	beqz	a5,30f4 <strlen+0x26>
    30da:	0505                	addi	a0,a0,1
    30dc:	87aa                	mv	a5,a0
    30de:	4685                	li	a3,1
    30e0:	9e89                	subw	a3,a3,a0
    30e2:	00f6853b          	addw	a0,a3,a5
    30e6:	0785                	addi	a5,a5,1
    30e8:	fff7c703          	lbu	a4,-1(a5)
    30ec:	fb7d                	bnez	a4,30e2 <strlen+0x14>
    ;
  return n;
}
    30ee:	6422                	ld	s0,8(sp)
    30f0:	0141                	addi	sp,sp,16
    30f2:	8082                	ret
  for(n = 0; s[n]; n++)
    30f4:	4501                	li	a0,0
    30f6:	bfe5                	j	30ee <strlen+0x20>

00000000000030f8 <memset>:

void*
memset(void *dst, int c, uint n)
{
    30f8:	1141                	addi	sp,sp,-16
    30fa:	e422                	sd	s0,8(sp)
    30fc:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    30fe:	ca19                	beqz	a2,3114 <memset+0x1c>
    3100:	87aa                	mv	a5,a0
    3102:	1602                	slli	a2,a2,0x20
    3104:	9201                	srli	a2,a2,0x20
    3106:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    310a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    310e:	0785                	addi	a5,a5,1
    3110:	fee79de3          	bne	a5,a4,310a <memset+0x12>
  }
  return dst;
}
    3114:	6422                	ld	s0,8(sp)
    3116:	0141                	addi	sp,sp,16
    3118:	8082                	ret

000000000000311a <strchr>:

char*
strchr(const char *s, char c)
{
    311a:	1141                	addi	sp,sp,-16
    311c:	e422                	sd	s0,8(sp)
    311e:	0800                	addi	s0,sp,16
  for(; *s; s++)
    3120:	00054783          	lbu	a5,0(a0)
    3124:	cb99                	beqz	a5,313a <strchr+0x20>
    if(*s == c)
    3126:	00f58763          	beq	a1,a5,3134 <strchr+0x1a>
  for(; *s; s++)
    312a:	0505                	addi	a0,a0,1
    312c:	00054783          	lbu	a5,0(a0)
    3130:	fbfd                	bnez	a5,3126 <strchr+0xc>
      return (char*)s;
  return 0;
    3132:	4501                	li	a0,0
}
    3134:	6422                	ld	s0,8(sp)
    3136:	0141                	addi	sp,sp,16
    3138:	8082                	ret
  return 0;
    313a:	4501                	li	a0,0
    313c:	bfe5                	j	3134 <strchr+0x1a>

000000000000313e <gets>:

char*
gets(char *buf, int max)
{
    313e:	711d                	addi	sp,sp,-96
    3140:	ec86                	sd	ra,88(sp)
    3142:	e8a2                	sd	s0,80(sp)
    3144:	e4a6                	sd	s1,72(sp)
    3146:	e0ca                	sd	s2,64(sp)
    3148:	fc4e                	sd	s3,56(sp)
    314a:	f852                	sd	s4,48(sp)
    314c:	f456                	sd	s5,40(sp)
    314e:	f05a                	sd	s6,32(sp)
    3150:	ec5e                	sd	s7,24(sp)
    3152:	1080                	addi	s0,sp,96
    3154:	8baa                	mv	s7,a0
    3156:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3158:	892a                	mv	s2,a0
    315a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    315c:	4aa9                	li	s5,10
    315e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    3160:	89a6                	mv	s3,s1
    3162:	2485                	addiw	s1,s1,1
    3164:	0344d863          	bge	s1,s4,3194 <gets+0x56>
    cc = read(0, &c, 1);
    3168:	4605                	li	a2,1
    316a:	faf40593          	addi	a1,s0,-81
    316e:	4501                	li	a0,0
    3170:	00000097          	auipc	ra,0x0
    3174:	1fc080e7          	jalr	508(ra) # 336c <read>
    if(cc < 1)
    3178:	00a05e63          	blez	a0,3194 <gets+0x56>
    buf[i++] = c;
    317c:	faf44783          	lbu	a5,-81(s0)
    3180:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3184:	01578763          	beq	a5,s5,3192 <gets+0x54>
    3188:	0905                	addi	s2,s2,1
    318a:	fd679be3          	bne	a5,s6,3160 <gets+0x22>
  for(i=0; i+1 < max; ){
    318e:	89a6                	mv	s3,s1
    3190:	a011                	j	3194 <gets+0x56>
    3192:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3194:	99de                	add	s3,s3,s7
    3196:	00098023          	sb	zero,0(s3)
  return buf;
}
    319a:	855e                	mv	a0,s7
    319c:	60e6                	ld	ra,88(sp)
    319e:	6446                	ld	s0,80(sp)
    31a0:	64a6                	ld	s1,72(sp)
    31a2:	6906                	ld	s2,64(sp)
    31a4:	79e2                	ld	s3,56(sp)
    31a6:	7a42                	ld	s4,48(sp)
    31a8:	7aa2                	ld	s5,40(sp)
    31aa:	7b02                	ld	s6,32(sp)
    31ac:	6be2                	ld	s7,24(sp)
    31ae:	6125                	addi	sp,sp,96
    31b0:	8082                	ret

00000000000031b2 <stat>:

int
stat(const char *n, struct stat *st)
{
    31b2:	1101                	addi	sp,sp,-32
    31b4:	ec06                	sd	ra,24(sp)
    31b6:	e822                	sd	s0,16(sp)
    31b8:	e426                	sd	s1,8(sp)
    31ba:	e04a                	sd	s2,0(sp)
    31bc:	1000                	addi	s0,sp,32
    31be:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    31c0:	4581                	li	a1,0
    31c2:	00000097          	auipc	ra,0x0
    31c6:	1d2080e7          	jalr	466(ra) # 3394 <open>
  if(fd < 0)
    31ca:	02054563          	bltz	a0,31f4 <stat+0x42>
    31ce:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    31d0:	85ca                	mv	a1,s2
    31d2:	00000097          	auipc	ra,0x0
    31d6:	1da080e7          	jalr	474(ra) # 33ac <fstat>
    31da:	892a                	mv	s2,a0
  close(fd);
    31dc:	8526                	mv	a0,s1
    31de:	00000097          	auipc	ra,0x0
    31e2:	19e080e7          	jalr	414(ra) # 337c <close>
  return r;
}
    31e6:	854a                	mv	a0,s2
    31e8:	60e2                	ld	ra,24(sp)
    31ea:	6442                	ld	s0,16(sp)
    31ec:	64a2                	ld	s1,8(sp)
    31ee:	6902                	ld	s2,0(sp)
    31f0:	6105                	addi	sp,sp,32
    31f2:	8082                	ret
    return -1;
    31f4:	597d                	li	s2,-1
    31f6:	bfc5                	j	31e6 <stat+0x34>

00000000000031f8 <atoi>:

int
atoi(const char *s)
{
    31f8:	1141                	addi	sp,sp,-16
    31fa:	e422                	sd	s0,8(sp)
    31fc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    31fe:	00054603          	lbu	a2,0(a0)
    3202:	fd06079b          	addiw	a5,a2,-48
    3206:	0ff7f793          	andi	a5,a5,255
    320a:	4725                	li	a4,9
    320c:	02f76963          	bltu	a4,a5,323e <atoi+0x46>
    3210:	86aa                	mv	a3,a0
  n = 0;
    3212:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    3214:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    3216:	0685                	addi	a3,a3,1
    3218:	0025179b          	slliw	a5,a0,0x2
    321c:	9fa9                	addw	a5,a5,a0
    321e:	0017979b          	slliw	a5,a5,0x1
    3222:	9fb1                	addw	a5,a5,a2
    3224:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    3228:	0006c603          	lbu	a2,0(a3)
    322c:	fd06071b          	addiw	a4,a2,-48
    3230:	0ff77713          	andi	a4,a4,255
    3234:	fee5f1e3          	bgeu	a1,a4,3216 <atoi+0x1e>
  return n;
}
    3238:	6422                	ld	s0,8(sp)
    323a:	0141                	addi	sp,sp,16
    323c:	8082                	ret
  n = 0;
    323e:	4501                	li	a0,0
    3240:	bfe5                	j	3238 <atoi+0x40>

0000000000003242 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3242:	1141                	addi	sp,sp,-16
    3244:	e422                	sd	s0,8(sp)
    3246:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    3248:	02b57463          	bgeu	a0,a1,3270 <memmove+0x2e>
    while(n-- > 0)
    324c:	00c05f63          	blez	a2,326a <memmove+0x28>
    3250:	1602                	slli	a2,a2,0x20
    3252:	9201                	srli	a2,a2,0x20
    3254:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    3258:	872a                	mv	a4,a0
      *dst++ = *src++;
    325a:	0585                	addi	a1,a1,1
    325c:	0705                	addi	a4,a4,1
    325e:	fff5c683          	lbu	a3,-1(a1)
    3262:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3266:	fee79ae3          	bne	a5,a4,325a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    326a:	6422                	ld	s0,8(sp)
    326c:	0141                	addi	sp,sp,16
    326e:	8082                	ret
    dst += n;
    3270:	00c50733          	add	a4,a0,a2
    src += n;
    3274:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    3276:	fec05ae3          	blez	a2,326a <memmove+0x28>
    327a:	fff6079b          	addiw	a5,a2,-1
    327e:	1782                	slli	a5,a5,0x20
    3280:	9381                	srli	a5,a5,0x20
    3282:	fff7c793          	not	a5,a5
    3286:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3288:	15fd                	addi	a1,a1,-1
    328a:	177d                	addi	a4,a4,-1
    328c:	0005c683          	lbu	a3,0(a1)
    3290:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3294:	fee79ae3          	bne	a5,a4,3288 <memmove+0x46>
    3298:	bfc9                	j	326a <memmove+0x28>

000000000000329a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    329a:	1141                	addi	sp,sp,-16
    329c:	e422                	sd	s0,8(sp)
    329e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    32a0:	ca05                	beqz	a2,32d0 <memcmp+0x36>
    32a2:	fff6069b          	addiw	a3,a2,-1
    32a6:	1682                	slli	a3,a3,0x20
    32a8:	9281                	srli	a3,a3,0x20
    32aa:	0685                	addi	a3,a3,1
    32ac:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    32ae:	00054783          	lbu	a5,0(a0)
    32b2:	0005c703          	lbu	a4,0(a1)
    32b6:	00e79863          	bne	a5,a4,32c6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    32ba:	0505                	addi	a0,a0,1
    p2++;
    32bc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    32be:	fed518e3          	bne	a0,a3,32ae <memcmp+0x14>
  }
  return 0;
    32c2:	4501                	li	a0,0
    32c4:	a019                	j	32ca <memcmp+0x30>
      return *p1 - *p2;
    32c6:	40e7853b          	subw	a0,a5,a4
}
    32ca:	6422                	ld	s0,8(sp)
    32cc:	0141                	addi	sp,sp,16
    32ce:	8082                	ret
  return 0;
    32d0:	4501                	li	a0,0
    32d2:	bfe5                	j	32ca <memcmp+0x30>

00000000000032d4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    32d4:	1141                	addi	sp,sp,-16
    32d6:	e406                	sd	ra,8(sp)
    32d8:	e022                	sd	s0,0(sp)
    32da:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    32dc:	00000097          	auipc	ra,0x0
    32e0:	f66080e7          	jalr	-154(ra) # 3242 <memmove>
}
    32e4:	60a2                	ld	ra,8(sp)
    32e6:	6402                	ld	s0,0(sp)
    32e8:	0141                	addi	sp,sp,16
    32ea:	8082                	ret

00000000000032ec <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    32ec:	1141                	addi	sp,sp,-16
    32ee:	e422                	sd	s0,8(sp)
    32f0:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    32f2:	00052023          	sw	zero,0(a0)
}  
    32f6:	6422                	ld	s0,8(sp)
    32f8:	0141                	addi	sp,sp,16
    32fa:	8082                	ret

00000000000032fc <lock>:

void lock(struct spinlock * lk) 
{    
    32fc:	1141                	addi	sp,sp,-16
    32fe:	e422                	sd	s0,8(sp)
    3300:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    3302:	4705                	li	a4,1
    3304:	87ba                	mv	a5,a4
    3306:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    330a:	2781                	sext.w	a5,a5
    330c:	ffe5                	bnez	a5,3304 <lock+0x8>
}  
    330e:	6422                	ld	s0,8(sp)
    3310:	0141                	addi	sp,sp,16
    3312:	8082                	ret

0000000000003314 <unlock>:

void unlock(struct spinlock * lk) 
{   
    3314:	1141                	addi	sp,sp,-16
    3316:	e422                	sd	s0,8(sp)
    3318:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    331a:	0f50000f          	fence	iorw,ow
    331e:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    3322:	6422                	ld	s0,8(sp)
    3324:	0141                	addi	sp,sp,16
    3326:	8082                	ret

0000000000003328 <isDigit>:

unsigned int isDigit(char *c) {
    3328:	1141                	addi	sp,sp,-16
    332a:	e422                	sd	s0,8(sp)
    332c:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    332e:	00054503          	lbu	a0,0(a0)
    3332:	fd05051b          	addiw	a0,a0,-48
    3336:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    333a:	00a53513          	sltiu	a0,a0,10
    333e:	6422                	ld	s0,8(sp)
    3340:	0141                	addi	sp,sp,16
    3342:	8082                	ret

0000000000003344 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    3344:	4885                	li	a7,1
 ecall
    3346:	00000073          	ecall
 ret
    334a:	8082                	ret

000000000000334c <exit>:
.global exit
exit:
 li a7, SYS_exit
    334c:	4889                	li	a7,2
 ecall
    334e:	00000073          	ecall
 ret
    3352:	8082                	ret

0000000000003354 <wait>:
.global wait
wait:
 li a7, SYS_wait
    3354:	488d                	li	a7,3
 ecall
    3356:	00000073          	ecall
 ret
    335a:	8082                	ret

000000000000335c <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    335c:	48e1                	li	a7,24
 ecall
    335e:	00000073          	ecall
 ret
    3362:	8082                	ret

0000000000003364 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    3364:	4891                	li	a7,4
 ecall
    3366:	00000073          	ecall
 ret
    336a:	8082                	ret

000000000000336c <read>:
.global read
read:
 li a7, SYS_read
    336c:	4895                	li	a7,5
 ecall
    336e:	00000073          	ecall
 ret
    3372:	8082                	ret

0000000000003374 <write>:
.global write
write:
 li a7, SYS_write
    3374:	48c1                	li	a7,16
 ecall
    3376:	00000073          	ecall
 ret
    337a:	8082                	ret

000000000000337c <close>:
.global close
close:
 li a7, SYS_close
    337c:	48d5                	li	a7,21
 ecall
    337e:	00000073          	ecall
 ret
    3382:	8082                	ret

0000000000003384 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3384:	4899                	li	a7,6
 ecall
    3386:	00000073          	ecall
 ret
    338a:	8082                	ret

000000000000338c <exec>:
.global exec
exec:
 li a7, SYS_exec
    338c:	489d                	li	a7,7
 ecall
    338e:	00000073          	ecall
 ret
    3392:	8082                	ret

0000000000003394 <open>:
.global open
open:
 li a7, SYS_open
    3394:	48bd                	li	a7,15
 ecall
    3396:	00000073          	ecall
 ret
    339a:	8082                	ret

000000000000339c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    339c:	48c5                	li	a7,17
 ecall
    339e:	00000073          	ecall
 ret
    33a2:	8082                	ret

00000000000033a4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    33a4:	48c9                	li	a7,18
 ecall
    33a6:	00000073          	ecall
 ret
    33aa:	8082                	ret

00000000000033ac <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    33ac:	48a1                	li	a7,8
 ecall
    33ae:	00000073          	ecall
 ret
    33b2:	8082                	ret

00000000000033b4 <link>:
.global link
link:
 li a7, SYS_link
    33b4:	48cd                	li	a7,19
 ecall
    33b6:	00000073          	ecall
 ret
    33ba:	8082                	ret

00000000000033bc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    33bc:	48d1                	li	a7,20
 ecall
    33be:	00000073          	ecall
 ret
    33c2:	8082                	ret

00000000000033c4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    33c4:	48a5                	li	a7,9
 ecall
    33c6:	00000073          	ecall
 ret
    33ca:	8082                	ret

00000000000033cc <dup>:
.global dup
dup:
 li a7, SYS_dup
    33cc:	48a9                	li	a7,10
 ecall
    33ce:	00000073          	ecall
 ret
    33d2:	8082                	ret

00000000000033d4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    33d4:	48ad                	li	a7,11
 ecall
    33d6:	00000073          	ecall
 ret
    33da:	8082                	ret

00000000000033dc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    33dc:	48b1                	li	a7,12
 ecall
    33de:	00000073          	ecall
 ret
    33e2:	8082                	ret

00000000000033e4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    33e4:	48b5                	li	a7,13
 ecall
    33e6:	00000073          	ecall
 ret
    33ea:	8082                	ret

00000000000033ec <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    33ec:	48b9                	li	a7,14
 ecall
    33ee:	00000073          	ecall
 ret
    33f2:	8082                	ret

00000000000033f4 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    33f4:	48d9                	li	a7,22
 ecall
    33f6:	00000073          	ecall
 ret
    33fa:	8082                	ret

00000000000033fc <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    33fc:	48dd                	li	a7,23
 ecall
    33fe:	00000073          	ecall
 ret
    3402:	8082                	ret

0000000000003404 <ps>:
.global ps
ps:
 li a7, SYS_ps
    3404:	48e5                	li	a7,25
 ecall
    3406:	00000073          	ecall
 ret
    340a:	8082                	ret

000000000000340c <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    340c:	48e9                	li	a7,26
 ecall
    340e:	00000073          	ecall
 ret
    3412:	8082                	ret

0000000000003414 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    3414:	48ed                	li	a7,27
 ecall
    3416:	00000073          	ecall
 ret
    341a:	8082                	ret

000000000000341c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    341c:	1101                	addi	sp,sp,-32
    341e:	ec06                	sd	ra,24(sp)
    3420:	e822                	sd	s0,16(sp)
    3422:	1000                	addi	s0,sp,32
    3424:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    3428:	4605                	li	a2,1
    342a:	fef40593          	addi	a1,s0,-17
    342e:	00000097          	auipc	ra,0x0
    3432:	f46080e7          	jalr	-186(ra) # 3374 <write>
}
    3436:	60e2                	ld	ra,24(sp)
    3438:	6442                	ld	s0,16(sp)
    343a:	6105                	addi	sp,sp,32
    343c:	8082                	ret

000000000000343e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    343e:	7139                	addi	sp,sp,-64
    3440:	fc06                	sd	ra,56(sp)
    3442:	f822                	sd	s0,48(sp)
    3444:	f426                	sd	s1,40(sp)
    3446:	f04a                	sd	s2,32(sp)
    3448:	ec4e                	sd	s3,24(sp)
    344a:	0080                	addi	s0,sp,64
    344c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    344e:	c299                	beqz	a3,3454 <printint+0x16>
    3450:	0805c863          	bltz	a1,34e0 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3454:	2581                	sext.w	a1,a1
  neg = 0;
    3456:	4881                	li	a7,0
    3458:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    345c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    345e:	2601                	sext.w	a2,a2
    3460:	00000517          	auipc	a0,0x0
    3464:	45850513          	addi	a0,a0,1112 # 38b8 <digits>
    3468:	883a                	mv	a6,a4
    346a:	2705                	addiw	a4,a4,1
    346c:	02c5f7bb          	remuw	a5,a1,a2
    3470:	1782                	slli	a5,a5,0x20
    3472:	9381                	srli	a5,a5,0x20
    3474:	97aa                	add	a5,a5,a0
    3476:	0007c783          	lbu	a5,0(a5)
    347a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    347e:	0005879b          	sext.w	a5,a1
    3482:	02c5d5bb          	divuw	a1,a1,a2
    3486:	0685                	addi	a3,a3,1
    3488:	fec7f0e3          	bgeu	a5,a2,3468 <printint+0x2a>
  if(neg)
    348c:	00088b63          	beqz	a7,34a2 <printint+0x64>
    buf[i++] = '-';
    3490:	fd040793          	addi	a5,s0,-48
    3494:	973e                	add	a4,a4,a5
    3496:	02d00793          	li	a5,45
    349a:	fef70823          	sb	a5,-16(a4)
    349e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    34a2:	02e05863          	blez	a4,34d2 <printint+0x94>
    34a6:	fc040793          	addi	a5,s0,-64
    34aa:	00e78933          	add	s2,a5,a4
    34ae:	fff78993          	addi	s3,a5,-1
    34b2:	99ba                	add	s3,s3,a4
    34b4:	377d                	addiw	a4,a4,-1
    34b6:	1702                	slli	a4,a4,0x20
    34b8:	9301                	srli	a4,a4,0x20
    34ba:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    34be:	fff94583          	lbu	a1,-1(s2)
    34c2:	8526                	mv	a0,s1
    34c4:	00000097          	auipc	ra,0x0
    34c8:	f58080e7          	jalr	-168(ra) # 341c <putc>
  while(--i >= 0)
    34cc:	197d                	addi	s2,s2,-1
    34ce:	ff3918e3          	bne	s2,s3,34be <printint+0x80>
}
    34d2:	70e2                	ld	ra,56(sp)
    34d4:	7442                	ld	s0,48(sp)
    34d6:	74a2                	ld	s1,40(sp)
    34d8:	7902                	ld	s2,32(sp)
    34da:	69e2                	ld	s3,24(sp)
    34dc:	6121                	addi	sp,sp,64
    34de:	8082                	ret
    x = -xx;
    34e0:	40b005bb          	negw	a1,a1
    neg = 1;
    34e4:	4885                	li	a7,1
    x = -xx;
    34e6:	bf8d                	j	3458 <printint+0x1a>

00000000000034e8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    34e8:	7119                	addi	sp,sp,-128
    34ea:	fc86                	sd	ra,120(sp)
    34ec:	f8a2                	sd	s0,112(sp)
    34ee:	f4a6                	sd	s1,104(sp)
    34f0:	f0ca                	sd	s2,96(sp)
    34f2:	ecce                	sd	s3,88(sp)
    34f4:	e8d2                	sd	s4,80(sp)
    34f6:	e4d6                	sd	s5,72(sp)
    34f8:	e0da                	sd	s6,64(sp)
    34fa:	fc5e                	sd	s7,56(sp)
    34fc:	f862                	sd	s8,48(sp)
    34fe:	f466                	sd	s9,40(sp)
    3500:	f06a                	sd	s10,32(sp)
    3502:	ec6e                	sd	s11,24(sp)
    3504:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    3506:	0005c903          	lbu	s2,0(a1)
    350a:	18090f63          	beqz	s2,36a8 <vprintf+0x1c0>
    350e:	8aaa                	mv	s5,a0
    3510:	8b32                	mv	s6,a2
    3512:	00158493          	addi	s1,a1,1
  state = 0;
    3516:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3518:	02500a13          	li	s4,37
      if(c == 'd'){
    351c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    3520:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    3524:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    3528:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    352c:	00000b97          	auipc	s7,0x0
    3530:	38cb8b93          	addi	s7,s7,908 # 38b8 <digits>
    3534:	a839                	j	3552 <vprintf+0x6a>
        putc(fd, c);
    3536:	85ca                	mv	a1,s2
    3538:	8556                	mv	a0,s5
    353a:	00000097          	auipc	ra,0x0
    353e:	ee2080e7          	jalr	-286(ra) # 341c <putc>
    3542:	a019                	j	3548 <vprintf+0x60>
    } else if(state == '%'){
    3544:	01498f63          	beq	s3,s4,3562 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    3548:	0485                	addi	s1,s1,1
    354a:	fff4c903          	lbu	s2,-1(s1)
    354e:	14090d63          	beqz	s2,36a8 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    3552:	0009079b          	sext.w	a5,s2
    if(state == 0){
    3556:	fe0997e3          	bnez	s3,3544 <vprintf+0x5c>
      if(c == '%'){
    355a:	fd479ee3          	bne	a5,s4,3536 <vprintf+0x4e>
        state = '%';
    355e:	89be                	mv	s3,a5
    3560:	b7e5                	j	3548 <vprintf+0x60>
      if(c == 'd'){
    3562:	05878063          	beq	a5,s8,35a2 <vprintf+0xba>
      } else if(c == 'l') {
    3566:	05978c63          	beq	a5,s9,35be <vprintf+0xd6>
      } else if(c == 'x') {
    356a:	07a78863          	beq	a5,s10,35da <vprintf+0xf2>
      } else if(c == 'p') {
    356e:	09b78463          	beq	a5,s11,35f6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    3572:	07300713          	li	a4,115
    3576:	0ce78663          	beq	a5,a4,3642 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    357a:	06300713          	li	a4,99
    357e:	0ee78e63          	beq	a5,a4,367a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    3582:	11478863          	beq	a5,s4,3692 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3586:	85d2                	mv	a1,s4
    3588:	8556                	mv	a0,s5
    358a:	00000097          	auipc	ra,0x0
    358e:	e92080e7          	jalr	-366(ra) # 341c <putc>
        putc(fd, c);
    3592:	85ca                	mv	a1,s2
    3594:	8556                	mv	a0,s5
    3596:	00000097          	auipc	ra,0x0
    359a:	e86080e7          	jalr	-378(ra) # 341c <putc>
      }
      state = 0;
    359e:	4981                	li	s3,0
    35a0:	b765                	j	3548 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    35a2:	008b0913          	addi	s2,s6,8
    35a6:	4685                	li	a3,1
    35a8:	4629                	li	a2,10
    35aa:	000b2583          	lw	a1,0(s6)
    35ae:	8556                	mv	a0,s5
    35b0:	00000097          	auipc	ra,0x0
    35b4:	e8e080e7          	jalr	-370(ra) # 343e <printint>
    35b8:	8b4a                	mv	s6,s2
      state = 0;
    35ba:	4981                	li	s3,0
    35bc:	b771                	j	3548 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    35be:	008b0913          	addi	s2,s6,8
    35c2:	4681                	li	a3,0
    35c4:	4629                	li	a2,10
    35c6:	000b2583          	lw	a1,0(s6)
    35ca:	8556                	mv	a0,s5
    35cc:	00000097          	auipc	ra,0x0
    35d0:	e72080e7          	jalr	-398(ra) # 343e <printint>
    35d4:	8b4a                	mv	s6,s2
      state = 0;
    35d6:	4981                	li	s3,0
    35d8:	bf85                	j	3548 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    35da:	008b0913          	addi	s2,s6,8
    35de:	4681                	li	a3,0
    35e0:	4641                	li	a2,16
    35e2:	000b2583          	lw	a1,0(s6)
    35e6:	8556                	mv	a0,s5
    35e8:	00000097          	auipc	ra,0x0
    35ec:	e56080e7          	jalr	-426(ra) # 343e <printint>
    35f0:	8b4a                	mv	s6,s2
      state = 0;
    35f2:	4981                	li	s3,0
    35f4:	bf91                	j	3548 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    35f6:	008b0793          	addi	a5,s6,8
    35fa:	f8f43423          	sd	a5,-120(s0)
    35fe:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    3602:	03000593          	li	a1,48
    3606:	8556                	mv	a0,s5
    3608:	00000097          	auipc	ra,0x0
    360c:	e14080e7          	jalr	-492(ra) # 341c <putc>
  putc(fd, 'x');
    3610:	85ea                	mv	a1,s10
    3612:	8556                	mv	a0,s5
    3614:	00000097          	auipc	ra,0x0
    3618:	e08080e7          	jalr	-504(ra) # 341c <putc>
    361c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    361e:	03c9d793          	srli	a5,s3,0x3c
    3622:	97de                	add	a5,a5,s7
    3624:	0007c583          	lbu	a1,0(a5)
    3628:	8556                	mv	a0,s5
    362a:	00000097          	auipc	ra,0x0
    362e:	df2080e7          	jalr	-526(ra) # 341c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    3632:	0992                	slli	s3,s3,0x4
    3634:	397d                	addiw	s2,s2,-1
    3636:	fe0914e3          	bnez	s2,361e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    363a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    363e:	4981                	li	s3,0
    3640:	b721                	j	3548 <vprintf+0x60>
        s = va_arg(ap, char*);
    3642:	008b0993          	addi	s3,s6,8
    3646:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    364a:	02090163          	beqz	s2,366c <vprintf+0x184>
        while(*s != 0){
    364e:	00094583          	lbu	a1,0(s2)
    3652:	c9a1                	beqz	a1,36a2 <vprintf+0x1ba>
          putc(fd, *s);
    3654:	8556                	mv	a0,s5
    3656:	00000097          	auipc	ra,0x0
    365a:	dc6080e7          	jalr	-570(ra) # 341c <putc>
          s++;
    365e:	0905                	addi	s2,s2,1
        while(*s != 0){
    3660:	00094583          	lbu	a1,0(s2)
    3664:	f9e5                	bnez	a1,3654 <vprintf+0x16c>
        s = va_arg(ap, char*);
    3666:	8b4e                	mv	s6,s3
      state = 0;
    3668:	4981                	li	s3,0
    366a:	bdf9                	j	3548 <vprintf+0x60>
          s = "(null)";
    366c:	00000917          	auipc	s2,0x0
    3670:	24490913          	addi	s2,s2,580 # 38b0 <malloc+0xfe>
        while(*s != 0){
    3674:	02800593          	li	a1,40
    3678:	bff1                	j	3654 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    367a:	008b0913          	addi	s2,s6,8
    367e:	000b4583          	lbu	a1,0(s6)
    3682:	8556                	mv	a0,s5
    3684:	00000097          	auipc	ra,0x0
    3688:	d98080e7          	jalr	-616(ra) # 341c <putc>
    368c:	8b4a                	mv	s6,s2
      state = 0;
    368e:	4981                	li	s3,0
    3690:	bd65                	j	3548 <vprintf+0x60>
        putc(fd, c);
    3692:	85d2                	mv	a1,s4
    3694:	8556                	mv	a0,s5
    3696:	00000097          	auipc	ra,0x0
    369a:	d86080e7          	jalr	-634(ra) # 341c <putc>
      state = 0;
    369e:	4981                	li	s3,0
    36a0:	b565                	j	3548 <vprintf+0x60>
        s = va_arg(ap, char*);
    36a2:	8b4e                	mv	s6,s3
      state = 0;
    36a4:	4981                	li	s3,0
    36a6:	b54d                	j	3548 <vprintf+0x60>
    }
  }
}
    36a8:	70e6                	ld	ra,120(sp)
    36aa:	7446                	ld	s0,112(sp)
    36ac:	74a6                	ld	s1,104(sp)
    36ae:	7906                	ld	s2,96(sp)
    36b0:	69e6                	ld	s3,88(sp)
    36b2:	6a46                	ld	s4,80(sp)
    36b4:	6aa6                	ld	s5,72(sp)
    36b6:	6b06                	ld	s6,64(sp)
    36b8:	7be2                	ld	s7,56(sp)
    36ba:	7c42                	ld	s8,48(sp)
    36bc:	7ca2                	ld	s9,40(sp)
    36be:	7d02                	ld	s10,32(sp)
    36c0:	6de2                	ld	s11,24(sp)
    36c2:	6109                	addi	sp,sp,128
    36c4:	8082                	ret

00000000000036c6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    36c6:	715d                	addi	sp,sp,-80
    36c8:	ec06                	sd	ra,24(sp)
    36ca:	e822                	sd	s0,16(sp)
    36cc:	1000                	addi	s0,sp,32
    36ce:	e010                	sd	a2,0(s0)
    36d0:	e414                	sd	a3,8(s0)
    36d2:	e818                	sd	a4,16(s0)
    36d4:	ec1c                	sd	a5,24(s0)
    36d6:	03043023          	sd	a6,32(s0)
    36da:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    36de:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    36e2:	8622                	mv	a2,s0
    36e4:	00000097          	auipc	ra,0x0
    36e8:	e04080e7          	jalr	-508(ra) # 34e8 <vprintf>
}
    36ec:	60e2                	ld	ra,24(sp)
    36ee:	6442                	ld	s0,16(sp)
    36f0:	6161                	addi	sp,sp,80
    36f2:	8082                	ret

00000000000036f4 <printf>:

void
printf(const char *fmt, ...)
{
    36f4:	711d                	addi	sp,sp,-96
    36f6:	ec06                	sd	ra,24(sp)
    36f8:	e822                	sd	s0,16(sp)
    36fa:	1000                	addi	s0,sp,32
    36fc:	e40c                	sd	a1,8(s0)
    36fe:	e810                	sd	a2,16(s0)
    3700:	ec14                	sd	a3,24(s0)
    3702:	f018                	sd	a4,32(s0)
    3704:	f41c                	sd	a5,40(s0)
    3706:	03043823          	sd	a6,48(s0)
    370a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    370e:	00840613          	addi	a2,s0,8
    3712:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    3716:	85aa                	mv	a1,a0
    3718:	4505                	li	a0,1
    371a:	00000097          	auipc	ra,0x0
    371e:	dce080e7          	jalr	-562(ra) # 34e8 <vprintf>
}
    3722:	60e2                	ld	ra,24(sp)
    3724:	6442                	ld	s0,16(sp)
    3726:	6125                	addi	sp,sp,96
    3728:	8082                	ret

000000000000372a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    372a:	1141                	addi	sp,sp,-16
    372c:	e422                	sd	s0,8(sp)
    372e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3730:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3734:	00001797          	auipc	a5,0x1
    3738:	8cc7b783          	ld	a5,-1844(a5) # 4000 <freep>
    373c:	a805                	j	376c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    373e:	4618                	lw	a4,8(a2)
    3740:	9db9                	addw	a1,a1,a4
    3742:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    3746:	6398                	ld	a4,0(a5)
    3748:	6318                	ld	a4,0(a4)
    374a:	fee53823          	sd	a4,-16(a0)
    374e:	a091                	j	3792 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3750:	ff852703          	lw	a4,-8(a0)
    3754:	9e39                	addw	a2,a2,a4
    3756:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    3758:	ff053703          	ld	a4,-16(a0)
    375c:	e398                	sd	a4,0(a5)
    375e:	a099                	j	37a4 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3760:	6398                	ld	a4,0(a5)
    3762:	00e7e463          	bltu	a5,a4,376a <free+0x40>
    3766:	00e6ea63          	bltu	a3,a4,377a <free+0x50>
{
    376a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    376c:	fed7fae3          	bgeu	a5,a3,3760 <free+0x36>
    3770:	6398                	ld	a4,0(a5)
    3772:	00e6e463          	bltu	a3,a4,377a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3776:	fee7eae3          	bltu	a5,a4,376a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    377a:	ff852583          	lw	a1,-8(a0)
    377e:	6390                	ld	a2,0(a5)
    3780:	02059713          	slli	a4,a1,0x20
    3784:	9301                	srli	a4,a4,0x20
    3786:	0712                	slli	a4,a4,0x4
    3788:	9736                	add	a4,a4,a3
    378a:	fae60ae3          	beq	a2,a4,373e <free+0x14>
    bp->s.ptr = p->s.ptr;
    378e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    3792:	4790                	lw	a2,8(a5)
    3794:	02061713          	slli	a4,a2,0x20
    3798:	9301                	srli	a4,a4,0x20
    379a:	0712                	slli	a4,a4,0x4
    379c:	973e                	add	a4,a4,a5
    379e:	fae689e3          	beq	a3,a4,3750 <free+0x26>
  } else
    p->s.ptr = bp;
    37a2:	e394                	sd	a3,0(a5)
  freep = p;
    37a4:	00001717          	auipc	a4,0x1
    37a8:	84f73e23          	sd	a5,-1956(a4) # 4000 <freep>
}
    37ac:	6422                	ld	s0,8(sp)
    37ae:	0141                	addi	sp,sp,16
    37b0:	8082                	ret

00000000000037b2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    37b2:	7139                	addi	sp,sp,-64
    37b4:	fc06                	sd	ra,56(sp)
    37b6:	f822                	sd	s0,48(sp)
    37b8:	f426                	sd	s1,40(sp)
    37ba:	f04a                	sd	s2,32(sp)
    37bc:	ec4e                	sd	s3,24(sp)
    37be:	e852                	sd	s4,16(sp)
    37c0:	e456                	sd	s5,8(sp)
    37c2:	e05a                	sd	s6,0(sp)
    37c4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    37c6:	02051493          	slli	s1,a0,0x20
    37ca:	9081                	srli	s1,s1,0x20
    37cc:	04bd                	addi	s1,s1,15
    37ce:	8091                	srli	s1,s1,0x4
    37d0:	0014899b          	addiw	s3,s1,1
    37d4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    37d6:	00001517          	auipc	a0,0x1
    37da:	82a53503          	ld	a0,-2006(a0) # 4000 <freep>
    37de:	c515                	beqz	a0,380a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    37e0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    37e2:	4798                	lw	a4,8(a5)
    37e4:	02977f63          	bgeu	a4,s1,3822 <malloc+0x70>
    37e8:	8a4e                	mv	s4,s3
    37ea:	0009871b          	sext.w	a4,s3
    37ee:	6685                	lui	a3,0x1
    37f0:	00d77363          	bgeu	a4,a3,37f6 <malloc+0x44>
    37f4:	6a05                	lui	s4,0x1
    37f6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    37fa:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    37fe:	00001917          	auipc	s2,0x1
    3802:	80290913          	addi	s2,s2,-2046 # 4000 <freep>
  if(p == (char*)-1)
    3806:	5afd                	li	s5,-1
    3808:	a88d                	j	387a <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    380a:	00001797          	auipc	a5,0x1
    380e:	80678793          	addi	a5,a5,-2042 # 4010 <base>
    3812:	00000717          	auipc	a4,0x0
    3816:	7ef73723          	sd	a5,2030(a4) # 4000 <freep>
    381a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    381c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    3820:	b7e1                	j	37e8 <malloc+0x36>
      if(p->s.size == nunits)
    3822:	02e48b63          	beq	s1,a4,3858 <malloc+0xa6>
        p->s.size -= nunits;
    3826:	4137073b          	subw	a4,a4,s3
    382a:	c798                	sw	a4,8(a5)
        p += p->s.size;
    382c:	1702                	slli	a4,a4,0x20
    382e:	9301                	srli	a4,a4,0x20
    3830:	0712                	slli	a4,a4,0x4
    3832:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    3834:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    3838:	00000717          	auipc	a4,0x0
    383c:	7ca73423          	sd	a0,1992(a4) # 4000 <freep>
      return (void*)(p + 1);
    3840:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3844:	70e2                	ld	ra,56(sp)
    3846:	7442                	ld	s0,48(sp)
    3848:	74a2                	ld	s1,40(sp)
    384a:	7902                	ld	s2,32(sp)
    384c:	69e2                	ld	s3,24(sp)
    384e:	6a42                	ld	s4,16(sp)
    3850:	6aa2                	ld	s5,8(sp)
    3852:	6b02                	ld	s6,0(sp)
    3854:	6121                	addi	sp,sp,64
    3856:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3858:	6398                	ld	a4,0(a5)
    385a:	e118                	sd	a4,0(a0)
    385c:	bff1                	j	3838 <malloc+0x86>
  hp->s.size = nu;
    385e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    3862:	0541                	addi	a0,a0,16
    3864:	00000097          	auipc	ra,0x0
    3868:	ec6080e7          	jalr	-314(ra) # 372a <free>
  return freep;
    386c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    3870:	d971                	beqz	a0,3844 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3872:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3874:	4798                	lw	a4,8(a5)
    3876:	fa9776e3          	bgeu	a4,s1,3822 <malloc+0x70>
    if(p == freep)
    387a:	00093703          	ld	a4,0(s2)
    387e:	853e                	mv	a0,a5
    3880:	fef719e3          	bne	a4,a5,3872 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3884:	8552                	mv	a0,s4
    3886:	00000097          	auipc	ra,0x0
    388a:	b56080e7          	jalr	-1194(ra) # 33dc <sbrk>
  if(p == (char*)-1)
    388e:	fd5518e3          	bne	a0,s5,385e <malloc+0xac>
        return 0;
    3892:	4501                	li	a0,0
    3894:	bf45                	j	3844 <malloc+0x92>
