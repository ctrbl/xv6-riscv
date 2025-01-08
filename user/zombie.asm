
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
    3000:	1141                	addi	sp,sp,-16
    3002:	e406                	sd	ra,8(sp)
    3004:	e022                	sd	s0,0(sp)
    3006:	0800                	addi	s0,sp,16
  if(fork() > 0)
    3008:	00000097          	auipc	ra,0x0
    300c:	2fa080e7          	jalr	762(ra) # 3302 <fork>
    3010:	00a04763          	bgtz	a0,301e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
    3014:	4501                	li	a0,0
    3016:	00000097          	auipc	ra,0x0
    301a:	2f4080e7          	jalr	756(ra) # 330a <exit>
    sleep(5);  // Let child exit before parent.
    301e:	4515                	li	a0,5
    3020:	00000097          	auipc	ra,0x0
    3024:	382080e7          	jalr	898(ra) # 33a2 <sleep>
    3028:	b7f5                	j	3014 <main+0x14>

000000000000302a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    302a:	1141                	addi	sp,sp,-16
    302c:	e406                	sd	ra,8(sp)
    302e:	e022                	sd	s0,0(sp)
    3030:	0800                	addi	s0,sp,16
  extern int main();
  main();
    3032:	00000097          	auipc	ra,0x0
    3036:	fce080e7          	jalr	-50(ra) # 3000 <main>
  exit(0);
    303a:	4501                	li	a0,0
    303c:	00000097          	auipc	ra,0x0
    3040:	2ce080e7          	jalr	718(ra) # 330a <exit>

0000000000003044 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3044:	1141                	addi	sp,sp,-16
    3046:	e422                	sd	s0,8(sp)
    3048:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    304a:	87aa                	mv	a5,a0
    304c:	0585                	addi	a1,a1,1
    304e:	0785                	addi	a5,a5,1
    3050:	fff5c703          	lbu	a4,-1(a1)
    3054:	fee78fa3          	sb	a4,-1(a5)
    3058:	fb75                	bnez	a4,304c <strcpy+0x8>
    ;
  return os;
}
    305a:	6422                	ld	s0,8(sp)
    305c:	0141                	addi	sp,sp,16
    305e:	8082                	ret

0000000000003060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3060:	1141                	addi	sp,sp,-16
    3062:	e422                	sd	s0,8(sp)
    3064:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    3066:	00054783          	lbu	a5,0(a0)
    306a:	cb91                	beqz	a5,307e <strcmp+0x1e>
    306c:	0005c703          	lbu	a4,0(a1)
    3070:	00f71763          	bne	a4,a5,307e <strcmp+0x1e>
    p++, q++;
    3074:	0505                	addi	a0,a0,1
    3076:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    3078:	00054783          	lbu	a5,0(a0)
    307c:	fbe5                	bnez	a5,306c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    307e:	0005c503          	lbu	a0,0(a1)
}
    3082:	40a7853b          	subw	a0,a5,a0
    3086:	6422                	ld	s0,8(sp)
    3088:	0141                	addi	sp,sp,16
    308a:	8082                	ret

000000000000308c <strlen>:

uint
strlen(const char *s)
{
    308c:	1141                	addi	sp,sp,-16
    308e:	e422                	sd	s0,8(sp)
    3090:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    3092:	00054783          	lbu	a5,0(a0)
    3096:	cf91                	beqz	a5,30b2 <strlen+0x26>
    3098:	0505                	addi	a0,a0,1
    309a:	87aa                	mv	a5,a0
    309c:	4685                	li	a3,1
    309e:	9e89                	subw	a3,a3,a0
    30a0:	00f6853b          	addw	a0,a3,a5
    30a4:	0785                	addi	a5,a5,1
    30a6:	fff7c703          	lbu	a4,-1(a5)
    30aa:	fb7d                	bnez	a4,30a0 <strlen+0x14>
    ;
  return n;
}
    30ac:	6422                	ld	s0,8(sp)
    30ae:	0141                	addi	sp,sp,16
    30b0:	8082                	ret
  for(n = 0; s[n]; n++)
    30b2:	4501                	li	a0,0
    30b4:	bfe5                	j	30ac <strlen+0x20>

00000000000030b6 <memset>:

void*
memset(void *dst, int c, uint n)
{
    30b6:	1141                	addi	sp,sp,-16
    30b8:	e422                	sd	s0,8(sp)
    30ba:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    30bc:	ca19                	beqz	a2,30d2 <memset+0x1c>
    30be:	87aa                	mv	a5,a0
    30c0:	1602                	slli	a2,a2,0x20
    30c2:	9201                	srli	a2,a2,0x20
    30c4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    30c8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    30cc:	0785                	addi	a5,a5,1
    30ce:	fee79de3          	bne	a5,a4,30c8 <memset+0x12>
  }
  return dst;
}
    30d2:	6422                	ld	s0,8(sp)
    30d4:	0141                	addi	sp,sp,16
    30d6:	8082                	ret

00000000000030d8 <strchr>:

char*
strchr(const char *s, char c)
{
    30d8:	1141                	addi	sp,sp,-16
    30da:	e422                	sd	s0,8(sp)
    30dc:	0800                	addi	s0,sp,16
  for(; *s; s++)
    30de:	00054783          	lbu	a5,0(a0)
    30e2:	cb99                	beqz	a5,30f8 <strchr+0x20>
    if(*s == c)
    30e4:	00f58763          	beq	a1,a5,30f2 <strchr+0x1a>
  for(; *s; s++)
    30e8:	0505                	addi	a0,a0,1
    30ea:	00054783          	lbu	a5,0(a0)
    30ee:	fbfd                	bnez	a5,30e4 <strchr+0xc>
      return (char*)s;
  return 0;
    30f0:	4501                	li	a0,0
}
    30f2:	6422                	ld	s0,8(sp)
    30f4:	0141                	addi	sp,sp,16
    30f6:	8082                	ret
  return 0;
    30f8:	4501                	li	a0,0
    30fa:	bfe5                	j	30f2 <strchr+0x1a>

00000000000030fc <gets>:

char*
gets(char *buf, int max)
{
    30fc:	711d                	addi	sp,sp,-96
    30fe:	ec86                	sd	ra,88(sp)
    3100:	e8a2                	sd	s0,80(sp)
    3102:	e4a6                	sd	s1,72(sp)
    3104:	e0ca                	sd	s2,64(sp)
    3106:	fc4e                	sd	s3,56(sp)
    3108:	f852                	sd	s4,48(sp)
    310a:	f456                	sd	s5,40(sp)
    310c:	f05a                	sd	s6,32(sp)
    310e:	ec5e                	sd	s7,24(sp)
    3110:	1080                	addi	s0,sp,96
    3112:	8baa                	mv	s7,a0
    3114:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3116:	892a                	mv	s2,a0
    3118:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    311a:	4aa9                	li	s5,10
    311c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    311e:	89a6                	mv	s3,s1
    3120:	2485                	addiw	s1,s1,1
    3122:	0344d863          	bge	s1,s4,3152 <gets+0x56>
    cc = read(0, &c, 1);
    3126:	4605                	li	a2,1
    3128:	faf40593          	addi	a1,s0,-81
    312c:	4501                	li	a0,0
    312e:	00000097          	auipc	ra,0x0
    3132:	1fc080e7          	jalr	508(ra) # 332a <read>
    if(cc < 1)
    3136:	00a05e63          	blez	a0,3152 <gets+0x56>
    buf[i++] = c;
    313a:	faf44783          	lbu	a5,-81(s0)
    313e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3142:	01578763          	beq	a5,s5,3150 <gets+0x54>
    3146:	0905                	addi	s2,s2,1
    3148:	fd679be3          	bne	a5,s6,311e <gets+0x22>
  for(i=0; i+1 < max; ){
    314c:	89a6                	mv	s3,s1
    314e:	a011                	j	3152 <gets+0x56>
    3150:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3152:	99de                	add	s3,s3,s7
    3154:	00098023          	sb	zero,0(s3)
  return buf;
}
    3158:	855e                	mv	a0,s7
    315a:	60e6                	ld	ra,88(sp)
    315c:	6446                	ld	s0,80(sp)
    315e:	64a6                	ld	s1,72(sp)
    3160:	6906                	ld	s2,64(sp)
    3162:	79e2                	ld	s3,56(sp)
    3164:	7a42                	ld	s4,48(sp)
    3166:	7aa2                	ld	s5,40(sp)
    3168:	7b02                	ld	s6,32(sp)
    316a:	6be2                	ld	s7,24(sp)
    316c:	6125                	addi	sp,sp,96
    316e:	8082                	ret

0000000000003170 <stat>:

int
stat(const char *n, struct stat *st)
{
    3170:	1101                	addi	sp,sp,-32
    3172:	ec06                	sd	ra,24(sp)
    3174:	e822                	sd	s0,16(sp)
    3176:	e426                	sd	s1,8(sp)
    3178:	e04a                	sd	s2,0(sp)
    317a:	1000                	addi	s0,sp,32
    317c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    317e:	4581                	li	a1,0
    3180:	00000097          	auipc	ra,0x0
    3184:	1d2080e7          	jalr	466(ra) # 3352 <open>
  if(fd < 0)
    3188:	02054563          	bltz	a0,31b2 <stat+0x42>
    318c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    318e:	85ca                	mv	a1,s2
    3190:	00000097          	auipc	ra,0x0
    3194:	1da080e7          	jalr	474(ra) # 336a <fstat>
    3198:	892a                	mv	s2,a0
  close(fd);
    319a:	8526                	mv	a0,s1
    319c:	00000097          	auipc	ra,0x0
    31a0:	19e080e7          	jalr	414(ra) # 333a <close>
  return r;
}
    31a4:	854a                	mv	a0,s2
    31a6:	60e2                	ld	ra,24(sp)
    31a8:	6442                	ld	s0,16(sp)
    31aa:	64a2                	ld	s1,8(sp)
    31ac:	6902                	ld	s2,0(sp)
    31ae:	6105                	addi	sp,sp,32
    31b0:	8082                	ret
    return -1;
    31b2:	597d                	li	s2,-1
    31b4:	bfc5                	j	31a4 <stat+0x34>

00000000000031b6 <atoi>:

int
atoi(const char *s)
{
    31b6:	1141                	addi	sp,sp,-16
    31b8:	e422                	sd	s0,8(sp)
    31ba:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    31bc:	00054603          	lbu	a2,0(a0)
    31c0:	fd06079b          	addiw	a5,a2,-48
    31c4:	0ff7f793          	andi	a5,a5,255
    31c8:	4725                	li	a4,9
    31ca:	02f76963          	bltu	a4,a5,31fc <atoi+0x46>
    31ce:	86aa                	mv	a3,a0
  n = 0;
    31d0:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    31d2:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    31d4:	0685                	addi	a3,a3,1
    31d6:	0025179b          	slliw	a5,a0,0x2
    31da:	9fa9                	addw	a5,a5,a0
    31dc:	0017979b          	slliw	a5,a5,0x1
    31e0:	9fb1                	addw	a5,a5,a2
    31e2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    31e6:	0006c603          	lbu	a2,0(a3)
    31ea:	fd06071b          	addiw	a4,a2,-48
    31ee:	0ff77713          	andi	a4,a4,255
    31f2:	fee5f1e3          	bgeu	a1,a4,31d4 <atoi+0x1e>
  return n;
}
    31f6:	6422                	ld	s0,8(sp)
    31f8:	0141                	addi	sp,sp,16
    31fa:	8082                	ret
  n = 0;
    31fc:	4501                	li	a0,0
    31fe:	bfe5                	j	31f6 <atoi+0x40>

0000000000003200 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3200:	1141                	addi	sp,sp,-16
    3202:	e422                	sd	s0,8(sp)
    3204:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    3206:	02b57463          	bgeu	a0,a1,322e <memmove+0x2e>
    while(n-- > 0)
    320a:	00c05f63          	blez	a2,3228 <memmove+0x28>
    320e:	1602                	slli	a2,a2,0x20
    3210:	9201                	srli	a2,a2,0x20
    3212:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    3216:	872a                	mv	a4,a0
      *dst++ = *src++;
    3218:	0585                	addi	a1,a1,1
    321a:	0705                	addi	a4,a4,1
    321c:	fff5c683          	lbu	a3,-1(a1)
    3220:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3224:	fee79ae3          	bne	a5,a4,3218 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    3228:	6422                	ld	s0,8(sp)
    322a:	0141                	addi	sp,sp,16
    322c:	8082                	ret
    dst += n;
    322e:	00c50733          	add	a4,a0,a2
    src += n;
    3232:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    3234:	fec05ae3          	blez	a2,3228 <memmove+0x28>
    3238:	fff6079b          	addiw	a5,a2,-1
    323c:	1782                	slli	a5,a5,0x20
    323e:	9381                	srli	a5,a5,0x20
    3240:	fff7c793          	not	a5,a5
    3244:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3246:	15fd                	addi	a1,a1,-1
    3248:	177d                	addi	a4,a4,-1
    324a:	0005c683          	lbu	a3,0(a1)
    324e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3252:	fee79ae3          	bne	a5,a4,3246 <memmove+0x46>
    3256:	bfc9                	j	3228 <memmove+0x28>

0000000000003258 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    3258:	1141                	addi	sp,sp,-16
    325a:	e422                	sd	s0,8(sp)
    325c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    325e:	ca05                	beqz	a2,328e <memcmp+0x36>
    3260:	fff6069b          	addiw	a3,a2,-1
    3264:	1682                	slli	a3,a3,0x20
    3266:	9281                	srli	a3,a3,0x20
    3268:	0685                	addi	a3,a3,1
    326a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    326c:	00054783          	lbu	a5,0(a0)
    3270:	0005c703          	lbu	a4,0(a1)
    3274:	00e79863          	bne	a5,a4,3284 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    3278:	0505                	addi	a0,a0,1
    p2++;
    327a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    327c:	fed518e3          	bne	a0,a3,326c <memcmp+0x14>
  }
  return 0;
    3280:	4501                	li	a0,0
    3282:	a019                	j	3288 <memcmp+0x30>
      return *p1 - *p2;
    3284:	40e7853b          	subw	a0,a5,a4
}
    3288:	6422                	ld	s0,8(sp)
    328a:	0141                	addi	sp,sp,16
    328c:	8082                	ret
  return 0;
    328e:	4501                	li	a0,0
    3290:	bfe5                	j	3288 <memcmp+0x30>

0000000000003292 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    3292:	1141                	addi	sp,sp,-16
    3294:	e406                	sd	ra,8(sp)
    3296:	e022                	sd	s0,0(sp)
    3298:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    329a:	00000097          	auipc	ra,0x0
    329e:	f66080e7          	jalr	-154(ra) # 3200 <memmove>
}
    32a2:	60a2                	ld	ra,8(sp)
    32a4:	6402                	ld	s0,0(sp)
    32a6:	0141                	addi	sp,sp,16
    32a8:	8082                	ret

00000000000032aa <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    32aa:	1141                	addi	sp,sp,-16
    32ac:	e422                	sd	s0,8(sp)
    32ae:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    32b0:	00052023          	sw	zero,0(a0)
}  
    32b4:	6422                	ld	s0,8(sp)
    32b6:	0141                	addi	sp,sp,16
    32b8:	8082                	ret

00000000000032ba <lock>:

void lock(struct spinlock * lk) 
{    
    32ba:	1141                	addi	sp,sp,-16
    32bc:	e422                	sd	s0,8(sp)
    32be:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    32c0:	4705                	li	a4,1
    32c2:	87ba                	mv	a5,a4
    32c4:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    32c8:	2781                	sext.w	a5,a5
    32ca:	ffe5                	bnez	a5,32c2 <lock+0x8>
}  
    32cc:	6422                	ld	s0,8(sp)
    32ce:	0141                	addi	sp,sp,16
    32d0:	8082                	ret

00000000000032d2 <unlock>:

void unlock(struct spinlock * lk) 
{   
    32d2:	1141                	addi	sp,sp,-16
    32d4:	e422                	sd	s0,8(sp)
    32d6:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    32d8:	0f50000f          	fence	iorw,ow
    32dc:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    32e0:	6422                	ld	s0,8(sp)
    32e2:	0141                	addi	sp,sp,16
    32e4:	8082                	ret

00000000000032e6 <isDigit>:

unsigned int isDigit(char *c) {
    32e6:	1141                	addi	sp,sp,-16
    32e8:	e422                	sd	s0,8(sp)
    32ea:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    32ec:	00054503          	lbu	a0,0(a0)
    32f0:	fd05051b          	addiw	a0,a0,-48
    32f4:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    32f8:	00a53513          	sltiu	a0,a0,10
    32fc:	6422                	ld	s0,8(sp)
    32fe:	0141                	addi	sp,sp,16
    3300:	8082                	ret

0000000000003302 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    3302:	4885                	li	a7,1
 ecall
    3304:	00000073          	ecall
 ret
    3308:	8082                	ret

000000000000330a <exit>:
.global exit
exit:
 li a7, SYS_exit
    330a:	4889                	li	a7,2
 ecall
    330c:	00000073          	ecall
 ret
    3310:	8082                	ret

0000000000003312 <wait>:
.global wait
wait:
 li a7, SYS_wait
    3312:	488d                	li	a7,3
 ecall
    3314:	00000073          	ecall
 ret
    3318:	8082                	ret

000000000000331a <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    331a:	48e1                	li	a7,24
 ecall
    331c:	00000073          	ecall
 ret
    3320:	8082                	ret

0000000000003322 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    3322:	4891                	li	a7,4
 ecall
    3324:	00000073          	ecall
 ret
    3328:	8082                	ret

000000000000332a <read>:
.global read
read:
 li a7, SYS_read
    332a:	4895                	li	a7,5
 ecall
    332c:	00000073          	ecall
 ret
    3330:	8082                	ret

0000000000003332 <write>:
.global write
write:
 li a7, SYS_write
    3332:	48c1                	li	a7,16
 ecall
    3334:	00000073          	ecall
 ret
    3338:	8082                	ret

000000000000333a <close>:
.global close
close:
 li a7, SYS_close
    333a:	48d5                	li	a7,21
 ecall
    333c:	00000073          	ecall
 ret
    3340:	8082                	ret

0000000000003342 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3342:	4899                	li	a7,6
 ecall
    3344:	00000073          	ecall
 ret
    3348:	8082                	ret

000000000000334a <exec>:
.global exec
exec:
 li a7, SYS_exec
    334a:	489d                	li	a7,7
 ecall
    334c:	00000073          	ecall
 ret
    3350:	8082                	ret

0000000000003352 <open>:
.global open
open:
 li a7, SYS_open
    3352:	48bd                	li	a7,15
 ecall
    3354:	00000073          	ecall
 ret
    3358:	8082                	ret

000000000000335a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    335a:	48c5                	li	a7,17
 ecall
    335c:	00000073          	ecall
 ret
    3360:	8082                	ret

0000000000003362 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3362:	48c9                	li	a7,18
 ecall
    3364:	00000073          	ecall
 ret
    3368:	8082                	ret

000000000000336a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    336a:	48a1                	li	a7,8
 ecall
    336c:	00000073          	ecall
 ret
    3370:	8082                	ret

0000000000003372 <link>:
.global link
link:
 li a7, SYS_link
    3372:	48cd                	li	a7,19
 ecall
    3374:	00000073          	ecall
 ret
    3378:	8082                	ret

000000000000337a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    337a:	48d1                	li	a7,20
 ecall
    337c:	00000073          	ecall
 ret
    3380:	8082                	ret

0000000000003382 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3382:	48a5                	li	a7,9
 ecall
    3384:	00000073          	ecall
 ret
    3388:	8082                	ret

000000000000338a <dup>:
.global dup
dup:
 li a7, SYS_dup
    338a:	48a9                	li	a7,10
 ecall
    338c:	00000073          	ecall
 ret
    3390:	8082                	ret

0000000000003392 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    3392:	48ad                	li	a7,11
 ecall
    3394:	00000073          	ecall
 ret
    3398:	8082                	ret

000000000000339a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    339a:	48b1                	li	a7,12
 ecall
    339c:	00000073          	ecall
 ret
    33a0:	8082                	ret

00000000000033a2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    33a2:	48b5                	li	a7,13
 ecall
    33a4:	00000073          	ecall
 ret
    33a8:	8082                	ret

00000000000033aa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    33aa:	48b9                	li	a7,14
 ecall
    33ac:	00000073          	ecall
 ret
    33b0:	8082                	ret

00000000000033b2 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    33b2:	48d9                	li	a7,22
 ecall
    33b4:	00000073          	ecall
 ret
    33b8:	8082                	ret

00000000000033ba <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    33ba:	48dd                	li	a7,23
 ecall
    33bc:	00000073          	ecall
 ret
    33c0:	8082                	ret

00000000000033c2 <ps>:
.global ps
ps:
 li a7, SYS_ps
    33c2:	48e5                	li	a7,25
 ecall
    33c4:	00000073          	ecall
 ret
    33c8:	8082                	ret

00000000000033ca <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    33ca:	48e9                	li	a7,26
 ecall
    33cc:	00000073          	ecall
 ret
    33d0:	8082                	ret

00000000000033d2 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    33d2:	48ed                	li	a7,27
 ecall
    33d4:	00000073          	ecall
 ret
    33d8:	8082                	ret

00000000000033da <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    33da:	1101                	addi	sp,sp,-32
    33dc:	ec06                	sd	ra,24(sp)
    33de:	e822                	sd	s0,16(sp)
    33e0:	1000                	addi	s0,sp,32
    33e2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    33e6:	4605                	li	a2,1
    33e8:	fef40593          	addi	a1,s0,-17
    33ec:	00000097          	auipc	ra,0x0
    33f0:	f46080e7          	jalr	-186(ra) # 3332 <write>
}
    33f4:	60e2                	ld	ra,24(sp)
    33f6:	6442                	ld	s0,16(sp)
    33f8:	6105                	addi	sp,sp,32
    33fa:	8082                	ret

00000000000033fc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    33fc:	7139                	addi	sp,sp,-64
    33fe:	fc06                	sd	ra,56(sp)
    3400:	f822                	sd	s0,48(sp)
    3402:	f426                	sd	s1,40(sp)
    3404:	f04a                	sd	s2,32(sp)
    3406:	ec4e                	sd	s3,24(sp)
    3408:	0080                	addi	s0,sp,64
    340a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    340c:	c299                	beqz	a3,3412 <printint+0x16>
    340e:	0805c863          	bltz	a1,349e <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3412:	2581                	sext.w	a1,a1
  neg = 0;
    3414:	4881                	li	a7,0
    3416:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    341a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    341c:	2601                	sext.w	a2,a2
    341e:	00000517          	auipc	a0,0x0
    3422:	44a50513          	addi	a0,a0,1098 # 3868 <digits>
    3426:	883a                	mv	a6,a4
    3428:	2705                	addiw	a4,a4,1
    342a:	02c5f7bb          	remuw	a5,a1,a2
    342e:	1782                	slli	a5,a5,0x20
    3430:	9381                	srli	a5,a5,0x20
    3432:	97aa                	add	a5,a5,a0
    3434:	0007c783          	lbu	a5,0(a5)
    3438:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    343c:	0005879b          	sext.w	a5,a1
    3440:	02c5d5bb          	divuw	a1,a1,a2
    3444:	0685                	addi	a3,a3,1
    3446:	fec7f0e3          	bgeu	a5,a2,3426 <printint+0x2a>
  if(neg)
    344a:	00088b63          	beqz	a7,3460 <printint+0x64>
    buf[i++] = '-';
    344e:	fd040793          	addi	a5,s0,-48
    3452:	973e                	add	a4,a4,a5
    3454:	02d00793          	li	a5,45
    3458:	fef70823          	sb	a5,-16(a4)
    345c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    3460:	02e05863          	blez	a4,3490 <printint+0x94>
    3464:	fc040793          	addi	a5,s0,-64
    3468:	00e78933          	add	s2,a5,a4
    346c:	fff78993          	addi	s3,a5,-1
    3470:	99ba                	add	s3,s3,a4
    3472:	377d                	addiw	a4,a4,-1
    3474:	1702                	slli	a4,a4,0x20
    3476:	9301                	srli	a4,a4,0x20
    3478:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    347c:	fff94583          	lbu	a1,-1(s2)
    3480:	8526                	mv	a0,s1
    3482:	00000097          	auipc	ra,0x0
    3486:	f58080e7          	jalr	-168(ra) # 33da <putc>
  while(--i >= 0)
    348a:	197d                	addi	s2,s2,-1
    348c:	ff3918e3          	bne	s2,s3,347c <printint+0x80>
}
    3490:	70e2                	ld	ra,56(sp)
    3492:	7442                	ld	s0,48(sp)
    3494:	74a2                	ld	s1,40(sp)
    3496:	7902                	ld	s2,32(sp)
    3498:	69e2                	ld	s3,24(sp)
    349a:	6121                	addi	sp,sp,64
    349c:	8082                	ret
    x = -xx;
    349e:	40b005bb          	negw	a1,a1
    neg = 1;
    34a2:	4885                	li	a7,1
    x = -xx;
    34a4:	bf8d                	j	3416 <printint+0x1a>

00000000000034a6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    34a6:	7119                	addi	sp,sp,-128
    34a8:	fc86                	sd	ra,120(sp)
    34aa:	f8a2                	sd	s0,112(sp)
    34ac:	f4a6                	sd	s1,104(sp)
    34ae:	f0ca                	sd	s2,96(sp)
    34b0:	ecce                	sd	s3,88(sp)
    34b2:	e8d2                	sd	s4,80(sp)
    34b4:	e4d6                	sd	s5,72(sp)
    34b6:	e0da                	sd	s6,64(sp)
    34b8:	fc5e                	sd	s7,56(sp)
    34ba:	f862                	sd	s8,48(sp)
    34bc:	f466                	sd	s9,40(sp)
    34be:	f06a                	sd	s10,32(sp)
    34c0:	ec6e                	sd	s11,24(sp)
    34c2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    34c4:	0005c903          	lbu	s2,0(a1)
    34c8:	18090f63          	beqz	s2,3666 <vprintf+0x1c0>
    34cc:	8aaa                	mv	s5,a0
    34ce:	8b32                	mv	s6,a2
    34d0:	00158493          	addi	s1,a1,1
  state = 0;
    34d4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    34d6:	02500a13          	li	s4,37
      if(c == 'd'){
    34da:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    34de:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    34e2:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    34e6:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    34ea:	00000b97          	auipc	s7,0x0
    34ee:	37eb8b93          	addi	s7,s7,894 # 3868 <digits>
    34f2:	a839                	j	3510 <vprintf+0x6a>
        putc(fd, c);
    34f4:	85ca                	mv	a1,s2
    34f6:	8556                	mv	a0,s5
    34f8:	00000097          	auipc	ra,0x0
    34fc:	ee2080e7          	jalr	-286(ra) # 33da <putc>
    3500:	a019                	j	3506 <vprintf+0x60>
    } else if(state == '%'){
    3502:	01498f63          	beq	s3,s4,3520 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    3506:	0485                	addi	s1,s1,1
    3508:	fff4c903          	lbu	s2,-1(s1)
    350c:	14090d63          	beqz	s2,3666 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    3510:	0009079b          	sext.w	a5,s2
    if(state == 0){
    3514:	fe0997e3          	bnez	s3,3502 <vprintf+0x5c>
      if(c == '%'){
    3518:	fd479ee3          	bne	a5,s4,34f4 <vprintf+0x4e>
        state = '%';
    351c:	89be                	mv	s3,a5
    351e:	b7e5                	j	3506 <vprintf+0x60>
      if(c == 'd'){
    3520:	05878063          	beq	a5,s8,3560 <vprintf+0xba>
      } else if(c == 'l') {
    3524:	05978c63          	beq	a5,s9,357c <vprintf+0xd6>
      } else if(c == 'x') {
    3528:	07a78863          	beq	a5,s10,3598 <vprintf+0xf2>
      } else if(c == 'p') {
    352c:	09b78463          	beq	a5,s11,35b4 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    3530:	07300713          	li	a4,115
    3534:	0ce78663          	beq	a5,a4,3600 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3538:	06300713          	li	a4,99
    353c:	0ee78e63          	beq	a5,a4,3638 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    3540:	11478863          	beq	a5,s4,3650 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3544:	85d2                	mv	a1,s4
    3546:	8556                	mv	a0,s5
    3548:	00000097          	auipc	ra,0x0
    354c:	e92080e7          	jalr	-366(ra) # 33da <putc>
        putc(fd, c);
    3550:	85ca                	mv	a1,s2
    3552:	8556                	mv	a0,s5
    3554:	00000097          	auipc	ra,0x0
    3558:	e86080e7          	jalr	-378(ra) # 33da <putc>
      }
      state = 0;
    355c:	4981                	li	s3,0
    355e:	b765                	j	3506 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    3560:	008b0913          	addi	s2,s6,8
    3564:	4685                	li	a3,1
    3566:	4629                	li	a2,10
    3568:	000b2583          	lw	a1,0(s6)
    356c:	8556                	mv	a0,s5
    356e:	00000097          	auipc	ra,0x0
    3572:	e8e080e7          	jalr	-370(ra) # 33fc <printint>
    3576:	8b4a                	mv	s6,s2
      state = 0;
    3578:	4981                	li	s3,0
    357a:	b771                	j	3506 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    357c:	008b0913          	addi	s2,s6,8
    3580:	4681                	li	a3,0
    3582:	4629                	li	a2,10
    3584:	000b2583          	lw	a1,0(s6)
    3588:	8556                	mv	a0,s5
    358a:	00000097          	auipc	ra,0x0
    358e:	e72080e7          	jalr	-398(ra) # 33fc <printint>
    3592:	8b4a                	mv	s6,s2
      state = 0;
    3594:	4981                	li	s3,0
    3596:	bf85                	j	3506 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    3598:	008b0913          	addi	s2,s6,8
    359c:	4681                	li	a3,0
    359e:	4641                	li	a2,16
    35a0:	000b2583          	lw	a1,0(s6)
    35a4:	8556                	mv	a0,s5
    35a6:	00000097          	auipc	ra,0x0
    35aa:	e56080e7          	jalr	-426(ra) # 33fc <printint>
    35ae:	8b4a                	mv	s6,s2
      state = 0;
    35b0:	4981                	li	s3,0
    35b2:	bf91                	j	3506 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    35b4:	008b0793          	addi	a5,s6,8
    35b8:	f8f43423          	sd	a5,-120(s0)
    35bc:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    35c0:	03000593          	li	a1,48
    35c4:	8556                	mv	a0,s5
    35c6:	00000097          	auipc	ra,0x0
    35ca:	e14080e7          	jalr	-492(ra) # 33da <putc>
  putc(fd, 'x');
    35ce:	85ea                	mv	a1,s10
    35d0:	8556                	mv	a0,s5
    35d2:	00000097          	auipc	ra,0x0
    35d6:	e08080e7          	jalr	-504(ra) # 33da <putc>
    35da:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    35dc:	03c9d793          	srli	a5,s3,0x3c
    35e0:	97de                	add	a5,a5,s7
    35e2:	0007c583          	lbu	a1,0(a5)
    35e6:	8556                	mv	a0,s5
    35e8:	00000097          	auipc	ra,0x0
    35ec:	df2080e7          	jalr	-526(ra) # 33da <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    35f0:	0992                	slli	s3,s3,0x4
    35f2:	397d                	addiw	s2,s2,-1
    35f4:	fe0914e3          	bnez	s2,35dc <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    35f8:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    35fc:	4981                	li	s3,0
    35fe:	b721                	j	3506 <vprintf+0x60>
        s = va_arg(ap, char*);
    3600:	008b0993          	addi	s3,s6,8
    3604:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    3608:	02090163          	beqz	s2,362a <vprintf+0x184>
        while(*s != 0){
    360c:	00094583          	lbu	a1,0(s2)
    3610:	c9a1                	beqz	a1,3660 <vprintf+0x1ba>
          putc(fd, *s);
    3612:	8556                	mv	a0,s5
    3614:	00000097          	auipc	ra,0x0
    3618:	dc6080e7          	jalr	-570(ra) # 33da <putc>
          s++;
    361c:	0905                	addi	s2,s2,1
        while(*s != 0){
    361e:	00094583          	lbu	a1,0(s2)
    3622:	f9e5                	bnez	a1,3612 <vprintf+0x16c>
        s = va_arg(ap, char*);
    3624:	8b4e                	mv	s6,s3
      state = 0;
    3626:	4981                	li	s3,0
    3628:	bdf9                	j	3506 <vprintf+0x60>
          s = "(null)";
    362a:	00000917          	auipc	s2,0x0
    362e:	23690913          	addi	s2,s2,566 # 3860 <malloc+0xf0>
        while(*s != 0){
    3632:	02800593          	li	a1,40
    3636:	bff1                	j	3612 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    3638:	008b0913          	addi	s2,s6,8
    363c:	000b4583          	lbu	a1,0(s6)
    3640:	8556                	mv	a0,s5
    3642:	00000097          	auipc	ra,0x0
    3646:	d98080e7          	jalr	-616(ra) # 33da <putc>
    364a:	8b4a                	mv	s6,s2
      state = 0;
    364c:	4981                	li	s3,0
    364e:	bd65                	j	3506 <vprintf+0x60>
        putc(fd, c);
    3650:	85d2                	mv	a1,s4
    3652:	8556                	mv	a0,s5
    3654:	00000097          	auipc	ra,0x0
    3658:	d86080e7          	jalr	-634(ra) # 33da <putc>
      state = 0;
    365c:	4981                	li	s3,0
    365e:	b565                	j	3506 <vprintf+0x60>
        s = va_arg(ap, char*);
    3660:	8b4e                	mv	s6,s3
      state = 0;
    3662:	4981                	li	s3,0
    3664:	b54d                	j	3506 <vprintf+0x60>
    }
  }
}
    3666:	70e6                	ld	ra,120(sp)
    3668:	7446                	ld	s0,112(sp)
    366a:	74a6                	ld	s1,104(sp)
    366c:	7906                	ld	s2,96(sp)
    366e:	69e6                	ld	s3,88(sp)
    3670:	6a46                	ld	s4,80(sp)
    3672:	6aa6                	ld	s5,72(sp)
    3674:	6b06                	ld	s6,64(sp)
    3676:	7be2                	ld	s7,56(sp)
    3678:	7c42                	ld	s8,48(sp)
    367a:	7ca2                	ld	s9,40(sp)
    367c:	7d02                	ld	s10,32(sp)
    367e:	6de2                	ld	s11,24(sp)
    3680:	6109                	addi	sp,sp,128
    3682:	8082                	ret

0000000000003684 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    3684:	715d                	addi	sp,sp,-80
    3686:	ec06                	sd	ra,24(sp)
    3688:	e822                	sd	s0,16(sp)
    368a:	1000                	addi	s0,sp,32
    368c:	e010                	sd	a2,0(s0)
    368e:	e414                	sd	a3,8(s0)
    3690:	e818                	sd	a4,16(s0)
    3692:	ec1c                	sd	a5,24(s0)
    3694:	03043023          	sd	a6,32(s0)
    3698:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    369c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    36a0:	8622                	mv	a2,s0
    36a2:	00000097          	auipc	ra,0x0
    36a6:	e04080e7          	jalr	-508(ra) # 34a6 <vprintf>
}
    36aa:	60e2                	ld	ra,24(sp)
    36ac:	6442                	ld	s0,16(sp)
    36ae:	6161                	addi	sp,sp,80
    36b0:	8082                	ret

00000000000036b2 <printf>:

void
printf(const char *fmt, ...)
{
    36b2:	711d                	addi	sp,sp,-96
    36b4:	ec06                	sd	ra,24(sp)
    36b6:	e822                	sd	s0,16(sp)
    36b8:	1000                	addi	s0,sp,32
    36ba:	e40c                	sd	a1,8(s0)
    36bc:	e810                	sd	a2,16(s0)
    36be:	ec14                	sd	a3,24(s0)
    36c0:	f018                	sd	a4,32(s0)
    36c2:	f41c                	sd	a5,40(s0)
    36c4:	03043823          	sd	a6,48(s0)
    36c8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    36cc:	00840613          	addi	a2,s0,8
    36d0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    36d4:	85aa                	mv	a1,a0
    36d6:	4505                	li	a0,1
    36d8:	00000097          	auipc	ra,0x0
    36dc:	dce080e7          	jalr	-562(ra) # 34a6 <vprintf>
}
    36e0:	60e2                	ld	ra,24(sp)
    36e2:	6442                	ld	s0,16(sp)
    36e4:	6125                	addi	sp,sp,96
    36e6:	8082                	ret

00000000000036e8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    36e8:	1141                	addi	sp,sp,-16
    36ea:	e422                	sd	s0,8(sp)
    36ec:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    36ee:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    36f2:	00001797          	auipc	a5,0x1
    36f6:	90e7b783          	ld	a5,-1778(a5) # 4000 <freep>
    36fa:	a805                	j	372a <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    36fc:	4618                	lw	a4,8(a2)
    36fe:	9db9                	addw	a1,a1,a4
    3700:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    3704:	6398                	ld	a4,0(a5)
    3706:	6318                	ld	a4,0(a4)
    3708:	fee53823          	sd	a4,-16(a0)
    370c:	a091                	j	3750 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    370e:	ff852703          	lw	a4,-8(a0)
    3712:	9e39                	addw	a2,a2,a4
    3714:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    3716:	ff053703          	ld	a4,-16(a0)
    371a:	e398                	sd	a4,0(a5)
    371c:	a099                	j	3762 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    371e:	6398                	ld	a4,0(a5)
    3720:	00e7e463          	bltu	a5,a4,3728 <free+0x40>
    3724:	00e6ea63          	bltu	a3,a4,3738 <free+0x50>
{
    3728:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    372a:	fed7fae3          	bgeu	a5,a3,371e <free+0x36>
    372e:	6398                	ld	a4,0(a5)
    3730:	00e6e463          	bltu	a3,a4,3738 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3734:	fee7eae3          	bltu	a5,a4,3728 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    3738:	ff852583          	lw	a1,-8(a0)
    373c:	6390                	ld	a2,0(a5)
    373e:	02059713          	slli	a4,a1,0x20
    3742:	9301                	srli	a4,a4,0x20
    3744:	0712                	slli	a4,a4,0x4
    3746:	9736                	add	a4,a4,a3
    3748:	fae60ae3          	beq	a2,a4,36fc <free+0x14>
    bp->s.ptr = p->s.ptr;
    374c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    3750:	4790                	lw	a2,8(a5)
    3752:	02061713          	slli	a4,a2,0x20
    3756:	9301                	srli	a4,a4,0x20
    3758:	0712                	slli	a4,a4,0x4
    375a:	973e                	add	a4,a4,a5
    375c:	fae689e3          	beq	a3,a4,370e <free+0x26>
  } else
    p->s.ptr = bp;
    3760:	e394                	sd	a3,0(a5)
  freep = p;
    3762:	00001717          	auipc	a4,0x1
    3766:	88f73f23          	sd	a5,-1890(a4) # 4000 <freep>
}
    376a:	6422                	ld	s0,8(sp)
    376c:	0141                	addi	sp,sp,16
    376e:	8082                	ret

0000000000003770 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3770:	7139                	addi	sp,sp,-64
    3772:	fc06                	sd	ra,56(sp)
    3774:	f822                	sd	s0,48(sp)
    3776:	f426                	sd	s1,40(sp)
    3778:	f04a                	sd	s2,32(sp)
    377a:	ec4e                	sd	s3,24(sp)
    377c:	e852                	sd	s4,16(sp)
    377e:	e456                	sd	s5,8(sp)
    3780:	e05a                	sd	s6,0(sp)
    3782:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3784:	02051493          	slli	s1,a0,0x20
    3788:	9081                	srli	s1,s1,0x20
    378a:	04bd                	addi	s1,s1,15
    378c:	8091                	srli	s1,s1,0x4
    378e:	0014899b          	addiw	s3,s1,1
    3792:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    3794:	00001517          	auipc	a0,0x1
    3798:	86c53503          	ld	a0,-1940(a0) # 4000 <freep>
    379c:	c515                	beqz	a0,37c8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    379e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    37a0:	4798                	lw	a4,8(a5)
    37a2:	02977f63          	bgeu	a4,s1,37e0 <malloc+0x70>
    37a6:	8a4e                	mv	s4,s3
    37a8:	0009871b          	sext.w	a4,s3
    37ac:	6685                	lui	a3,0x1
    37ae:	00d77363          	bgeu	a4,a3,37b4 <malloc+0x44>
    37b2:	6a05                	lui	s4,0x1
    37b4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    37b8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    37bc:	00001917          	auipc	s2,0x1
    37c0:	84490913          	addi	s2,s2,-1980 # 4000 <freep>
  if(p == (char*)-1)
    37c4:	5afd                	li	s5,-1
    37c6:	a88d                	j	3838 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    37c8:	00001797          	auipc	a5,0x1
    37cc:	84878793          	addi	a5,a5,-1976 # 4010 <base>
    37d0:	00001717          	auipc	a4,0x1
    37d4:	82f73823          	sd	a5,-2000(a4) # 4000 <freep>
    37d8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    37da:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    37de:	b7e1                	j	37a6 <malloc+0x36>
      if(p->s.size == nunits)
    37e0:	02e48b63          	beq	s1,a4,3816 <malloc+0xa6>
        p->s.size -= nunits;
    37e4:	4137073b          	subw	a4,a4,s3
    37e8:	c798                	sw	a4,8(a5)
        p += p->s.size;
    37ea:	1702                	slli	a4,a4,0x20
    37ec:	9301                	srli	a4,a4,0x20
    37ee:	0712                	slli	a4,a4,0x4
    37f0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    37f2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    37f6:	00001717          	auipc	a4,0x1
    37fa:	80a73523          	sd	a0,-2038(a4) # 4000 <freep>
      return (void*)(p + 1);
    37fe:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3802:	70e2                	ld	ra,56(sp)
    3804:	7442                	ld	s0,48(sp)
    3806:	74a2                	ld	s1,40(sp)
    3808:	7902                	ld	s2,32(sp)
    380a:	69e2                	ld	s3,24(sp)
    380c:	6a42                	ld	s4,16(sp)
    380e:	6aa2                	ld	s5,8(sp)
    3810:	6b02                	ld	s6,0(sp)
    3812:	6121                	addi	sp,sp,64
    3814:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3816:	6398                	ld	a4,0(a5)
    3818:	e118                	sd	a4,0(a0)
    381a:	bff1                	j	37f6 <malloc+0x86>
  hp->s.size = nu;
    381c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    3820:	0541                	addi	a0,a0,16
    3822:	00000097          	auipc	ra,0x0
    3826:	ec6080e7          	jalr	-314(ra) # 36e8 <free>
  return freep;
    382a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    382e:	d971                	beqz	a0,3802 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3830:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3832:	4798                	lw	a4,8(a5)
    3834:	fa9776e3          	bgeu	a4,s1,37e0 <malloc+0x70>
    if(p == freep)
    3838:	00093703          	ld	a4,0(s2)
    383c:	853e                	mv	a0,a5
    383e:	fef719e3          	bne	a4,a5,3830 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3842:	8552                	mv	a0,s4
    3844:	00000097          	auipc	ra,0x0
    3848:	b56080e7          	jalr	-1194(ra) # 339a <sbrk>
  if(p == (char*)-1)
    384c:	fd5518e3          	bne	a0,s5,381c <malloc+0xac>
        return 0;
    3850:	4501                	li	a0,0
    3852:	bf45                	j	3802 <malloc+0x92>
