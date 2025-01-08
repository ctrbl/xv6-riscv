
user/_null2:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main()
{
    3000:	1141                	addi	sp,sp,-16
    3002:	e406                	sd	ra,8(sp)
    3004:	e022                	sd	s0,0(sp)
    3006:	0800                	addi	s0,sp,16
    // Unmapped page 2
    int *p = (int*)(0x1000);
    printf("Null pointer at page 2 (starting address 0x%x)\n", p);
    3008:	6585                	lui	a1,0x1
    300a:	00001517          	auipc	a0,0x1
    300e:	86650513          	addi	a0,a0,-1946 # 3870 <malloc+0xf2>
    3012:	00000097          	auipc	ra,0x0
    3016:	6ae080e7          	jalr	1710(ra) # 36c0 <printf>
    printf("*p: %x\n", *p);
    301a:	6785                	lui	a5,0x1
    301c:	438c                	lw	a1,0(a5)
    301e:	00001517          	auipc	a0,0x1
    3022:	88250513          	addi	a0,a0,-1918 # 38a0 <malloc+0x122>
    3026:	00000097          	auipc	ra,0x0
    302a:	69a080e7          	jalr	1690(ra) # 36c0 <printf>
    exit(0);
    302e:	4501                	li	a0,0
    3030:	00000097          	auipc	ra,0x0
    3034:	2e8080e7          	jalr	744(ra) # 3318 <exit>

0000000000003038 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    3038:	1141                	addi	sp,sp,-16
    303a:	e406                	sd	ra,8(sp)
    303c:	e022                	sd	s0,0(sp)
    303e:	0800                	addi	s0,sp,16
  extern int main();
  main();
    3040:	00000097          	auipc	ra,0x0
    3044:	fc0080e7          	jalr	-64(ra) # 3000 <main>
  exit(0);
    3048:	4501                	li	a0,0
    304a:	00000097          	auipc	ra,0x0
    304e:	2ce080e7          	jalr	718(ra) # 3318 <exit>

0000000000003052 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3052:	1141                	addi	sp,sp,-16
    3054:	e422                	sd	s0,8(sp)
    3056:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3058:	87aa                	mv	a5,a0
    305a:	0585                	addi	a1,a1,1
    305c:	0785                	addi	a5,a5,1
    305e:	fff5c703          	lbu	a4,-1(a1) # fff <main-0x2001>
    3062:	fee78fa3          	sb	a4,-1(a5) # fff <main-0x2001>
    3066:	fb75                	bnez	a4,305a <strcpy+0x8>
    ;
  return os;
}
    3068:	6422                	ld	s0,8(sp)
    306a:	0141                	addi	sp,sp,16
    306c:	8082                	ret

000000000000306e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    306e:	1141                	addi	sp,sp,-16
    3070:	e422                	sd	s0,8(sp)
    3072:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    3074:	00054783          	lbu	a5,0(a0)
    3078:	cb91                	beqz	a5,308c <strcmp+0x1e>
    307a:	0005c703          	lbu	a4,0(a1)
    307e:	00f71763          	bne	a4,a5,308c <strcmp+0x1e>
    p++, q++;
    3082:	0505                	addi	a0,a0,1
    3084:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    3086:	00054783          	lbu	a5,0(a0)
    308a:	fbe5                	bnez	a5,307a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    308c:	0005c503          	lbu	a0,0(a1)
}
    3090:	40a7853b          	subw	a0,a5,a0
    3094:	6422                	ld	s0,8(sp)
    3096:	0141                	addi	sp,sp,16
    3098:	8082                	ret

000000000000309a <strlen>:

uint
strlen(const char *s)
{
    309a:	1141                	addi	sp,sp,-16
    309c:	e422                	sd	s0,8(sp)
    309e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    30a0:	00054783          	lbu	a5,0(a0)
    30a4:	cf91                	beqz	a5,30c0 <strlen+0x26>
    30a6:	0505                	addi	a0,a0,1
    30a8:	87aa                	mv	a5,a0
    30aa:	4685                	li	a3,1
    30ac:	9e89                	subw	a3,a3,a0
    30ae:	00f6853b          	addw	a0,a3,a5
    30b2:	0785                	addi	a5,a5,1
    30b4:	fff7c703          	lbu	a4,-1(a5)
    30b8:	fb7d                	bnez	a4,30ae <strlen+0x14>
    ;
  return n;
}
    30ba:	6422                	ld	s0,8(sp)
    30bc:	0141                	addi	sp,sp,16
    30be:	8082                	ret
  for(n = 0; s[n]; n++)
    30c0:	4501                	li	a0,0
    30c2:	bfe5                	j	30ba <strlen+0x20>

00000000000030c4 <memset>:

void*
memset(void *dst, int c, uint n)
{
    30c4:	1141                	addi	sp,sp,-16
    30c6:	e422                	sd	s0,8(sp)
    30c8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    30ca:	ca19                	beqz	a2,30e0 <memset+0x1c>
    30cc:	87aa                	mv	a5,a0
    30ce:	1602                	slli	a2,a2,0x20
    30d0:	9201                	srli	a2,a2,0x20
    30d2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    30d6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    30da:	0785                	addi	a5,a5,1
    30dc:	fee79de3          	bne	a5,a4,30d6 <memset+0x12>
  }
  return dst;
}
    30e0:	6422                	ld	s0,8(sp)
    30e2:	0141                	addi	sp,sp,16
    30e4:	8082                	ret

00000000000030e6 <strchr>:

char*
strchr(const char *s, char c)
{
    30e6:	1141                	addi	sp,sp,-16
    30e8:	e422                	sd	s0,8(sp)
    30ea:	0800                	addi	s0,sp,16
  for(; *s; s++)
    30ec:	00054783          	lbu	a5,0(a0)
    30f0:	cb99                	beqz	a5,3106 <strchr+0x20>
    if(*s == c)
    30f2:	00f58763          	beq	a1,a5,3100 <strchr+0x1a>
  for(; *s; s++)
    30f6:	0505                	addi	a0,a0,1
    30f8:	00054783          	lbu	a5,0(a0)
    30fc:	fbfd                	bnez	a5,30f2 <strchr+0xc>
      return (char*)s;
  return 0;
    30fe:	4501                	li	a0,0
}
    3100:	6422                	ld	s0,8(sp)
    3102:	0141                	addi	sp,sp,16
    3104:	8082                	ret
  return 0;
    3106:	4501                	li	a0,0
    3108:	bfe5                	j	3100 <strchr+0x1a>

000000000000310a <gets>:

char*
gets(char *buf, int max)
{
    310a:	711d                	addi	sp,sp,-96
    310c:	ec86                	sd	ra,88(sp)
    310e:	e8a2                	sd	s0,80(sp)
    3110:	e4a6                	sd	s1,72(sp)
    3112:	e0ca                	sd	s2,64(sp)
    3114:	fc4e                	sd	s3,56(sp)
    3116:	f852                	sd	s4,48(sp)
    3118:	f456                	sd	s5,40(sp)
    311a:	f05a                	sd	s6,32(sp)
    311c:	ec5e                	sd	s7,24(sp)
    311e:	1080                	addi	s0,sp,96
    3120:	8baa                	mv	s7,a0
    3122:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3124:	892a                	mv	s2,a0
    3126:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3128:	4aa9                	li	s5,10
    312a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    312c:	89a6                	mv	s3,s1
    312e:	2485                	addiw	s1,s1,1
    3130:	0344d863          	bge	s1,s4,3160 <gets+0x56>
    cc = read(0, &c, 1);
    3134:	4605                	li	a2,1
    3136:	faf40593          	addi	a1,s0,-81
    313a:	4501                	li	a0,0
    313c:	00000097          	auipc	ra,0x0
    3140:	1fc080e7          	jalr	508(ra) # 3338 <read>
    if(cc < 1)
    3144:	00a05e63          	blez	a0,3160 <gets+0x56>
    buf[i++] = c;
    3148:	faf44783          	lbu	a5,-81(s0)
    314c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3150:	01578763          	beq	a5,s5,315e <gets+0x54>
    3154:	0905                	addi	s2,s2,1
    3156:	fd679be3          	bne	a5,s6,312c <gets+0x22>
  for(i=0; i+1 < max; ){
    315a:	89a6                	mv	s3,s1
    315c:	a011                	j	3160 <gets+0x56>
    315e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3160:	99de                	add	s3,s3,s7
    3162:	00098023          	sb	zero,0(s3)
  return buf;
}
    3166:	855e                	mv	a0,s7
    3168:	60e6                	ld	ra,88(sp)
    316a:	6446                	ld	s0,80(sp)
    316c:	64a6                	ld	s1,72(sp)
    316e:	6906                	ld	s2,64(sp)
    3170:	79e2                	ld	s3,56(sp)
    3172:	7a42                	ld	s4,48(sp)
    3174:	7aa2                	ld	s5,40(sp)
    3176:	7b02                	ld	s6,32(sp)
    3178:	6be2                	ld	s7,24(sp)
    317a:	6125                	addi	sp,sp,96
    317c:	8082                	ret

000000000000317e <stat>:

int
stat(const char *n, struct stat *st)
{
    317e:	1101                	addi	sp,sp,-32
    3180:	ec06                	sd	ra,24(sp)
    3182:	e822                	sd	s0,16(sp)
    3184:	e426                	sd	s1,8(sp)
    3186:	e04a                	sd	s2,0(sp)
    3188:	1000                	addi	s0,sp,32
    318a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    318c:	4581                	li	a1,0
    318e:	00000097          	auipc	ra,0x0
    3192:	1d2080e7          	jalr	466(ra) # 3360 <open>
  if(fd < 0)
    3196:	02054563          	bltz	a0,31c0 <stat+0x42>
    319a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    319c:	85ca                	mv	a1,s2
    319e:	00000097          	auipc	ra,0x0
    31a2:	1da080e7          	jalr	474(ra) # 3378 <fstat>
    31a6:	892a                	mv	s2,a0
  close(fd);
    31a8:	8526                	mv	a0,s1
    31aa:	00000097          	auipc	ra,0x0
    31ae:	19e080e7          	jalr	414(ra) # 3348 <close>
  return r;
}
    31b2:	854a                	mv	a0,s2
    31b4:	60e2                	ld	ra,24(sp)
    31b6:	6442                	ld	s0,16(sp)
    31b8:	64a2                	ld	s1,8(sp)
    31ba:	6902                	ld	s2,0(sp)
    31bc:	6105                	addi	sp,sp,32
    31be:	8082                	ret
    return -1;
    31c0:	597d                	li	s2,-1
    31c2:	bfc5                	j	31b2 <stat+0x34>

00000000000031c4 <atoi>:

int
atoi(const char *s)
{
    31c4:	1141                	addi	sp,sp,-16
    31c6:	e422                	sd	s0,8(sp)
    31c8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    31ca:	00054603          	lbu	a2,0(a0)
    31ce:	fd06079b          	addiw	a5,a2,-48
    31d2:	0ff7f793          	andi	a5,a5,255
    31d6:	4725                	li	a4,9
    31d8:	02f76963          	bltu	a4,a5,320a <atoi+0x46>
    31dc:	86aa                	mv	a3,a0
  n = 0;
    31de:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    31e0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    31e2:	0685                	addi	a3,a3,1
    31e4:	0025179b          	slliw	a5,a0,0x2
    31e8:	9fa9                	addw	a5,a5,a0
    31ea:	0017979b          	slliw	a5,a5,0x1
    31ee:	9fb1                	addw	a5,a5,a2
    31f0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    31f4:	0006c603          	lbu	a2,0(a3)
    31f8:	fd06071b          	addiw	a4,a2,-48
    31fc:	0ff77713          	andi	a4,a4,255
    3200:	fee5f1e3          	bgeu	a1,a4,31e2 <atoi+0x1e>
  return n;
}
    3204:	6422                	ld	s0,8(sp)
    3206:	0141                	addi	sp,sp,16
    3208:	8082                	ret
  n = 0;
    320a:	4501                	li	a0,0
    320c:	bfe5                	j	3204 <atoi+0x40>

000000000000320e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    320e:	1141                	addi	sp,sp,-16
    3210:	e422                	sd	s0,8(sp)
    3212:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    3214:	02b57463          	bgeu	a0,a1,323c <memmove+0x2e>
    while(n-- > 0)
    3218:	00c05f63          	blez	a2,3236 <memmove+0x28>
    321c:	1602                	slli	a2,a2,0x20
    321e:	9201                	srli	a2,a2,0x20
    3220:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    3224:	872a                	mv	a4,a0
      *dst++ = *src++;
    3226:	0585                	addi	a1,a1,1
    3228:	0705                	addi	a4,a4,1
    322a:	fff5c683          	lbu	a3,-1(a1)
    322e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3232:	fee79ae3          	bne	a5,a4,3226 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    3236:	6422                	ld	s0,8(sp)
    3238:	0141                	addi	sp,sp,16
    323a:	8082                	ret
    dst += n;
    323c:	00c50733          	add	a4,a0,a2
    src += n;
    3240:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    3242:	fec05ae3          	blez	a2,3236 <memmove+0x28>
    3246:	fff6079b          	addiw	a5,a2,-1
    324a:	1782                	slli	a5,a5,0x20
    324c:	9381                	srli	a5,a5,0x20
    324e:	fff7c793          	not	a5,a5
    3252:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3254:	15fd                	addi	a1,a1,-1
    3256:	177d                	addi	a4,a4,-1
    3258:	0005c683          	lbu	a3,0(a1)
    325c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3260:	fee79ae3          	bne	a5,a4,3254 <memmove+0x46>
    3264:	bfc9                	j	3236 <memmove+0x28>

0000000000003266 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    3266:	1141                	addi	sp,sp,-16
    3268:	e422                	sd	s0,8(sp)
    326a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    326c:	ca05                	beqz	a2,329c <memcmp+0x36>
    326e:	fff6069b          	addiw	a3,a2,-1
    3272:	1682                	slli	a3,a3,0x20
    3274:	9281                	srli	a3,a3,0x20
    3276:	0685                	addi	a3,a3,1
    3278:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    327a:	00054783          	lbu	a5,0(a0)
    327e:	0005c703          	lbu	a4,0(a1)
    3282:	00e79863          	bne	a5,a4,3292 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    3286:	0505                	addi	a0,a0,1
    p2++;
    3288:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    328a:	fed518e3          	bne	a0,a3,327a <memcmp+0x14>
  }
  return 0;
    328e:	4501                	li	a0,0
    3290:	a019                	j	3296 <memcmp+0x30>
      return *p1 - *p2;
    3292:	40e7853b          	subw	a0,a5,a4
}
    3296:	6422                	ld	s0,8(sp)
    3298:	0141                	addi	sp,sp,16
    329a:	8082                	ret
  return 0;
    329c:	4501                	li	a0,0
    329e:	bfe5                	j	3296 <memcmp+0x30>

00000000000032a0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    32a0:	1141                	addi	sp,sp,-16
    32a2:	e406                	sd	ra,8(sp)
    32a4:	e022                	sd	s0,0(sp)
    32a6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    32a8:	00000097          	auipc	ra,0x0
    32ac:	f66080e7          	jalr	-154(ra) # 320e <memmove>
}
    32b0:	60a2                	ld	ra,8(sp)
    32b2:	6402                	ld	s0,0(sp)
    32b4:	0141                	addi	sp,sp,16
    32b6:	8082                	ret

00000000000032b8 <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    32b8:	1141                	addi	sp,sp,-16
    32ba:	e422                	sd	s0,8(sp)
    32bc:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    32be:	00052023          	sw	zero,0(a0)
}  
    32c2:	6422                	ld	s0,8(sp)
    32c4:	0141                	addi	sp,sp,16
    32c6:	8082                	ret

00000000000032c8 <lock>:

void lock(struct spinlock * lk) 
{    
    32c8:	1141                	addi	sp,sp,-16
    32ca:	e422                	sd	s0,8(sp)
    32cc:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    32ce:	4705                	li	a4,1
    32d0:	87ba                	mv	a5,a4
    32d2:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    32d6:	2781                	sext.w	a5,a5
    32d8:	ffe5                	bnez	a5,32d0 <lock+0x8>
}  
    32da:	6422                	ld	s0,8(sp)
    32dc:	0141                	addi	sp,sp,16
    32de:	8082                	ret

00000000000032e0 <unlock>:

void unlock(struct spinlock * lk) 
{   
    32e0:	1141                	addi	sp,sp,-16
    32e2:	e422                	sd	s0,8(sp)
    32e4:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    32e6:	0f50000f          	fence	iorw,ow
    32ea:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    32ee:	6422                	ld	s0,8(sp)
    32f0:	0141                	addi	sp,sp,16
    32f2:	8082                	ret

00000000000032f4 <isDigit>:

unsigned int isDigit(char *c) {
    32f4:	1141                	addi	sp,sp,-16
    32f6:	e422                	sd	s0,8(sp)
    32f8:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    32fa:	00054503          	lbu	a0,0(a0)
    32fe:	fd05051b          	addiw	a0,a0,-48
    3302:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    3306:	00a53513          	sltiu	a0,a0,10
    330a:	6422                	ld	s0,8(sp)
    330c:	0141                	addi	sp,sp,16
    330e:	8082                	ret

0000000000003310 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    3310:	4885                	li	a7,1
 ecall
    3312:	00000073          	ecall
 ret
    3316:	8082                	ret

0000000000003318 <exit>:
.global exit
exit:
 li a7, SYS_exit
    3318:	4889                	li	a7,2
 ecall
    331a:	00000073          	ecall
 ret
    331e:	8082                	ret

0000000000003320 <wait>:
.global wait
wait:
 li a7, SYS_wait
    3320:	488d                	li	a7,3
 ecall
    3322:	00000073          	ecall
 ret
    3326:	8082                	ret

0000000000003328 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    3328:	48e1                	li	a7,24
 ecall
    332a:	00000073          	ecall
 ret
    332e:	8082                	ret

0000000000003330 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    3330:	4891                	li	a7,4
 ecall
    3332:	00000073          	ecall
 ret
    3336:	8082                	ret

0000000000003338 <read>:
.global read
read:
 li a7, SYS_read
    3338:	4895                	li	a7,5
 ecall
    333a:	00000073          	ecall
 ret
    333e:	8082                	ret

0000000000003340 <write>:
.global write
write:
 li a7, SYS_write
    3340:	48c1                	li	a7,16
 ecall
    3342:	00000073          	ecall
 ret
    3346:	8082                	ret

0000000000003348 <close>:
.global close
close:
 li a7, SYS_close
    3348:	48d5                	li	a7,21
 ecall
    334a:	00000073          	ecall
 ret
    334e:	8082                	ret

0000000000003350 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3350:	4899                	li	a7,6
 ecall
    3352:	00000073          	ecall
 ret
    3356:	8082                	ret

0000000000003358 <exec>:
.global exec
exec:
 li a7, SYS_exec
    3358:	489d                	li	a7,7
 ecall
    335a:	00000073          	ecall
 ret
    335e:	8082                	ret

0000000000003360 <open>:
.global open
open:
 li a7, SYS_open
    3360:	48bd                	li	a7,15
 ecall
    3362:	00000073          	ecall
 ret
    3366:	8082                	ret

0000000000003368 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    3368:	48c5                	li	a7,17
 ecall
    336a:	00000073          	ecall
 ret
    336e:	8082                	ret

0000000000003370 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3370:	48c9                	li	a7,18
 ecall
    3372:	00000073          	ecall
 ret
    3376:	8082                	ret

0000000000003378 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    3378:	48a1                	li	a7,8
 ecall
    337a:	00000073          	ecall
 ret
    337e:	8082                	ret

0000000000003380 <link>:
.global link
link:
 li a7, SYS_link
    3380:	48cd                	li	a7,19
 ecall
    3382:	00000073          	ecall
 ret
    3386:	8082                	ret

0000000000003388 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    3388:	48d1                	li	a7,20
 ecall
    338a:	00000073          	ecall
 ret
    338e:	8082                	ret

0000000000003390 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3390:	48a5                	li	a7,9
 ecall
    3392:	00000073          	ecall
 ret
    3396:	8082                	ret

0000000000003398 <dup>:
.global dup
dup:
 li a7, SYS_dup
    3398:	48a9                	li	a7,10
 ecall
    339a:	00000073          	ecall
 ret
    339e:	8082                	ret

00000000000033a0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    33a0:	48ad                	li	a7,11
 ecall
    33a2:	00000073          	ecall
 ret
    33a6:	8082                	ret

00000000000033a8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    33a8:	48b1                	li	a7,12
 ecall
    33aa:	00000073          	ecall
 ret
    33ae:	8082                	ret

00000000000033b0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    33b0:	48b5                	li	a7,13
 ecall
    33b2:	00000073          	ecall
 ret
    33b6:	8082                	ret

00000000000033b8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    33b8:	48b9                	li	a7,14
 ecall
    33ba:	00000073          	ecall
 ret
    33be:	8082                	ret

00000000000033c0 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    33c0:	48d9                	li	a7,22
 ecall
    33c2:	00000073          	ecall
 ret
    33c6:	8082                	ret

00000000000033c8 <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    33c8:	48dd                	li	a7,23
 ecall
    33ca:	00000073          	ecall
 ret
    33ce:	8082                	ret

00000000000033d0 <ps>:
.global ps
ps:
 li a7, SYS_ps
    33d0:	48e5                	li	a7,25
 ecall
    33d2:	00000073          	ecall
 ret
    33d6:	8082                	ret

00000000000033d8 <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    33d8:	48e9                	li	a7,26
 ecall
    33da:	00000073          	ecall
 ret
    33de:	8082                	ret

00000000000033e0 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    33e0:	48ed                	li	a7,27
 ecall
    33e2:	00000073          	ecall
 ret
    33e6:	8082                	ret

00000000000033e8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    33e8:	1101                	addi	sp,sp,-32
    33ea:	ec06                	sd	ra,24(sp)
    33ec:	e822                	sd	s0,16(sp)
    33ee:	1000                	addi	s0,sp,32
    33f0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    33f4:	4605                	li	a2,1
    33f6:	fef40593          	addi	a1,s0,-17
    33fa:	00000097          	auipc	ra,0x0
    33fe:	f46080e7          	jalr	-186(ra) # 3340 <write>
}
    3402:	60e2                	ld	ra,24(sp)
    3404:	6442                	ld	s0,16(sp)
    3406:	6105                	addi	sp,sp,32
    3408:	8082                	ret

000000000000340a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    340a:	7139                	addi	sp,sp,-64
    340c:	fc06                	sd	ra,56(sp)
    340e:	f822                	sd	s0,48(sp)
    3410:	f426                	sd	s1,40(sp)
    3412:	f04a                	sd	s2,32(sp)
    3414:	ec4e                	sd	s3,24(sp)
    3416:	0080                	addi	s0,sp,64
    3418:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    341a:	c299                	beqz	a3,3420 <printint+0x16>
    341c:	0805c863          	bltz	a1,34ac <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3420:	2581                	sext.w	a1,a1
  neg = 0;
    3422:	4881                	li	a7,0
    3424:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    3428:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    342a:	2601                	sext.w	a2,a2
    342c:	00000517          	auipc	a0,0x0
    3430:	48450513          	addi	a0,a0,1156 # 38b0 <digits>
    3434:	883a                	mv	a6,a4
    3436:	2705                	addiw	a4,a4,1
    3438:	02c5f7bb          	remuw	a5,a1,a2
    343c:	1782                	slli	a5,a5,0x20
    343e:	9381                	srli	a5,a5,0x20
    3440:	97aa                	add	a5,a5,a0
    3442:	0007c783          	lbu	a5,0(a5)
    3446:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    344a:	0005879b          	sext.w	a5,a1
    344e:	02c5d5bb          	divuw	a1,a1,a2
    3452:	0685                	addi	a3,a3,1
    3454:	fec7f0e3          	bgeu	a5,a2,3434 <printint+0x2a>
  if(neg)
    3458:	00088b63          	beqz	a7,346e <printint+0x64>
    buf[i++] = '-';
    345c:	fd040793          	addi	a5,s0,-48
    3460:	973e                	add	a4,a4,a5
    3462:	02d00793          	li	a5,45
    3466:	fef70823          	sb	a5,-16(a4)
    346a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    346e:	02e05863          	blez	a4,349e <printint+0x94>
    3472:	fc040793          	addi	a5,s0,-64
    3476:	00e78933          	add	s2,a5,a4
    347a:	fff78993          	addi	s3,a5,-1
    347e:	99ba                	add	s3,s3,a4
    3480:	377d                	addiw	a4,a4,-1
    3482:	1702                	slli	a4,a4,0x20
    3484:	9301                	srli	a4,a4,0x20
    3486:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    348a:	fff94583          	lbu	a1,-1(s2)
    348e:	8526                	mv	a0,s1
    3490:	00000097          	auipc	ra,0x0
    3494:	f58080e7          	jalr	-168(ra) # 33e8 <putc>
  while(--i >= 0)
    3498:	197d                	addi	s2,s2,-1
    349a:	ff3918e3          	bne	s2,s3,348a <printint+0x80>
}
    349e:	70e2                	ld	ra,56(sp)
    34a0:	7442                	ld	s0,48(sp)
    34a2:	74a2                	ld	s1,40(sp)
    34a4:	7902                	ld	s2,32(sp)
    34a6:	69e2                	ld	s3,24(sp)
    34a8:	6121                	addi	sp,sp,64
    34aa:	8082                	ret
    x = -xx;
    34ac:	40b005bb          	negw	a1,a1
    neg = 1;
    34b0:	4885                	li	a7,1
    x = -xx;
    34b2:	bf8d                	j	3424 <printint+0x1a>

00000000000034b4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    34b4:	7119                	addi	sp,sp,-128
    34b6:	fc86                	sd	ra,120(sp)
    34b8:	f8a2                	sd	s0,112(sp)
    34ba:	f4a6                	sd	s1,104(sp)
    34bc:	f0ca                	sd	s2,96(sp)
    34be:	ecce                	sd	s3,88(sp)
    34c0:	e8d2                	sd	s4,80(sp)
    34c2:	e4d6                	sd	s5,72(sp)
    34c4:	e0da                	sd	s6,64(sp)
    34c6:	fc5e                	sd	s7,56(sp)
    34c8:	f862                	sd	s8,48(sp)
    34ca:	f466                	sd	s9,40(sp)
    34cc:	f06a                	sd	s10,32(sp)
    34ce:	ec6e                	sd	s11,24(sp)
    34d0:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    34d2:	0005c903          	lbu	s2,0(a1)
    34d6:	18090f63          	beqz	s2,3674 <vprintf+0x1c0>
    34da:	8aaa                	mv	s5,a0
    34dc:	8b32                	mv	s6,a2
    34de:	00158493          	addi	s1,a1,1
  state = 0;
    34e2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    34e4:	02500a13          	li	s4,37
      if(c == 'd'){
    34e8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    34ec:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    34f0:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    34f4:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    34f8:	00000b97          	auipc	s7,0x0
    34fc:	3b8b8b93          	addi	s7,s7,952 # 38b0 <digits>
    3500:	a839                	j	351e <vprintf+0x6a>
        putc(fd, c);
    3502:	85ca                	mv	a1,s2
    3504:	8556                	mv	a0,s5
    3506:	00000097          	auipc	ra,0x0
    350a:	ee2080e7          	jalr	-286(ra) # 33e8 <putc>
    350e:	a019                	j	3514 <vprintf+0x60>
    } else if(state == '%'){
    3510:	01498f63          	beq	s3,s4,352e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    3514:	0485                	addi	s1,s1,1
    3516:	fff4c903          	lbu	s2,-1(s1)
    351a:	14090d63          	beqz	s2,3674 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    351e:	0009079b          	sext.w	a5,s2
    if(state == 0){
    3522:	fe0997e3          	bnez	s3,3510 <vprintf+0x5c>
      if(c == '%'){
    3526:	fd479ee3          	bne	a5,s4,3502 <vprintf+0x4e>
        state = '%';
    352a:	89be                	mv	s3,a5
    352c:	b7e5                	j	3514 <vprintf+0x60>
      if(c == 'd'){
    352e:	05878063          	beq	a5,s8,356e <vprintf+0xba>
      } else if(c == 'l') {
    3532:	05978c63          	beq	a5,s9,358a <vprintf+0xd6>
      } else if(c == 'x') {
    3536:	07a78863          	beq	a5,s10,35a6 <vprintf+0xf2>
      } else if(c == 'p') {
    353a:	09b78463          	beq	a5,s11,35c2 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    353e:	07300713          	li	a4,115
    3542:	0ce78663          	beq	a5,a4,360e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3546:	06300713          	li	a4,99
    354a:	0ee78e63          	beq	a5,a4,3646 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    354e:	11478863          	beq	a5,s4,365e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3552:	85d2                	mv	a1,s4
    3554:	8556                	mv	a0,s5
    3556:	00000097          	auipc	ra,0x0
    355a:	e92080e7          	jalr	-366(ra) # 33e8 <putc>
        putc(fd, c);
    355e:	85ca                	mv	a1,s2
    3560:	8556                	mv	a0,s5
    3562:	00000097          	auipc	ra,0x0
    3566:	e86080e7          	jalr	-378(ra) # 33e8 <putc>
      }
      state = 0;
    356a:	4981                	li	s3,0
    356c:	b765                	j	3514 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    356e:	008b0913          	addi	s2,s6,8
    3572:	4685                	li	a3,1
    3574:	4629                	li	a2,10
    3576:	000b2583          	lw	a1,0(s6)
    357a:	8556                	mv	a0,s5
    357c:	00000097          	auipc	ra,0x0
    3580:	e8e080e7          	jalr	-370(ra) # 340a <printint>
    3584:	8b4a                	mv	s6,s2
      state = 0;
    3586:	4981                	li	s3,0
    3588:	b771                	j	3514 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    358a:	008b0913          	addi	s2,s6,8
    358e:	4681                	li	a3,0
    3590:	4629                	li	a2,10
    3592:	000b2583          	lw	a1,0(s6)
    3596:	8556                	mv	a0,s5
    3598:	00000097          	auipc	ra,0x0
    359c:	e72080e7          	jalr	-398(ra) # 340a <printint>
    35a0:	8b4a                	mv	s6,s2
      state = 0;
    35a2:	4981                	li	s3,0
    35a4:	bf85                	j	3514 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    35a6:	008b0913          	addi	s2,s6,8
    35aa:	4681                	li	a3,0
    35ac:	4641                	li	a2,16
    35ae:	000b2583          	lw	a1,0(s6)
    35b2:	8556                	mv	a0,s5
    35b4:	00000097          	auipc	ra,0x0
    35b8:	e56080e7          	jalr	-426(ra) # 340a <printint>
    35bc:	8b4a                	mv	s6,s2
      state = 0;
    35be:	4981                	li	s3,0
    35c0:	bf91                	j	3514 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    35c2:	008b0793          	addi	a5,s6,8
    35c6:	f8f43423          	sd	a5,-120(s0)
    35ca:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    35ce:	03000593          	li	a1,48
    35d2:	8556                	mv	a0,s5
    35d4:	00000097          	auipc	ra,0x0
    35d8:	e14080e7          	jalr	-492(ra) # 33e8 <putc>
  putc(fd, 'x');
    35dc:	85ea                	mv	a1,s10
    35de:	8556                	mv	a0,s5
    35e0:	00000097          	auipc	ra,0x0
    35e4:	e08080e7          	jalr	-504(ra) # 33e8 <putc>
    35e8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    35ea:	03c9d793          	srli	a5,s3,0x3c
    35ee:	97de                	add	a5,a5,s7
    35f0:	0007c583          	lbu	a1,0(a5)
    35f4:	8556                	mv	a0,s5
    35f6:	00000097          	auipc	ra,0x0
    35fa:	df2080e7          	jalr	-526(ra) # 33e8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    35fe:	0992                	slli	s3,s3,0x4
    3600:	397d                	addiw	s2,s2,-1
    3602:	fe0914e3          	bnez	s2,35ea <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    3606:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    360a:	4981                	li	s3,0
    360c:	b721                	j	3514 <vprintf+0x60>
        s = va_arg(ap, char*);
    360e:	008b0993          	addi	s3,s6,8
    3612:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    3616:	02090163          	beqz	s2,3638 <vprintf+0x184>
        while(*s != 0){
    361a:	00094583          	lbu	a1,0(s2)
    361e:	c9a1                	beqz	a1,366e <vprintf+0x1ba>
          putc(fd, *s);
    3620:	8556                	mv	a0,s5
    3622:	00000097          	auipc	ra,0x0
    3626:	dc6080e7          	jalr	-570(ra) # 33e8 <putc>
          s++;
    362a:	0905                	addi	s2,s2,1
        while(*s != 0){
    362c:	00094583          	lbu	a1,0(s2)
    3630:	f9e5                	bnez	a1,3620 <vprintf+0x16c>
        s = va_arg(ap, char*);
    3632:	8b4e                	mv	s6,s3
      state = 0;
    3634:	4981                	li	s3,0
    3636:	bdf9                	j	3514 <vprintf+0x60>
          s = "(null)";
    3638:	00000917          	auipc	s2,0x0
    363c:	27090913          	addi	s2,s2,624 # 38a8 <malloc+0x12a>
        while(*s != 0){
    3640:	02800593          	li	a1,40
    3644:	bff1                	j	3620 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    3646:	008b0913          	addi	s2,s6,8
    364a:	000b4583          	lbu	a1,0(s6)
    364e:	8556                	mv	a0,s5
    3650:	00000097          	auipc	ra,0x0
    3654:	d98080e7          	jalr	-616(ra) # 33e8 <putc>
    3658:	8b4a                	mv	s6,s2
      state = 0;
    365a:	4981                	li	s3,0
    365c:	bd65                	j	3514 <vprintf+0x60>
        putc(fd, c);
    365e:	85d2                	mv	a1,s4
    3660:	8556                	mv	a0,s5
    3662:	00000097          	auipc	ra,0x0
    3666:	d86080e7          	jalr	-634(ra) # 33e8 <putc>
      state = 0;
    366a:	4981                	li	s3,0
    366c:	b565                	j	3514 <vprintf+0x60>
        s = va_arg(ap, char*);
    366e:	8b4e                	mv	s6,s3
      state = 0;
    3670:	4981                	li	s3,0
    3672:	b54d                	j	3514 <vprintf+0x60>
    }
  }
}
    3674:	70e6                	ld	ra,120(sp)
    3676:	7446                	ld	s0,112(sp)
    3678:	74a6                	ld	s1,104(sp)
    367a:	7906                	ld	s2,96(sp)
    367c:	69e6                	ld	s3,88(sp)
    367e:	6a46                	ld	s4,80(sp)
    3680:	6aa6                	ld	s5,72(sp)
    3682:	6b06                	ld	s6,64(sp)
    3684:	7be2                	ld	s7,56(sp)
    3686:	7c42                	ld	s8,48(sp)
    3688:	7ca2                	ld	s9,40(sp)
    368a:	7d02                	ld	s10,32(sp)
    368c:	6de2                	ld	s11,24(sp)
    368e:	6109                	addi	sp,sp,128
    3690:	8082                	ret

0000000000003692 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    3692:	715d                	addi	sp,sp,-80
    3694:	ec06                	sd	ra,24(sp)
    3696:	e822                	sd	s0,16(sp)
    3698:	1000                	addi	s0,sp,32
    369a:	e010                	sd	a2,0(s0)
    369c:	e414                	sd	a3,8(s0)
    369e:	e818                	sd	a4,16(s0)
    36a0:	ec1c                	sd	a5,24(s0)
    36a2:	03043023          	sd	a6,32(s0)
    36a6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    36aa:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    36ae:	8622                	mv	a2,s0
    36b0:	00000097          	auipc	ra,0x0
    36b4:	e04080e7          	jalr	-508(ra) # 34b4 <vprintf>
}
    36b8:	60e2                	ld	ra,24(sp)
    36ba:	6442                	ld	s0,16(sp)
    36bc:	6161                	addi	sp,sp,80
    36be:	8082                	ret

00000000000036c0 <printf>:

void
printf(const char *fmt, ...)
{
    36c0:	711d                	addi	sp,sp,-96
    36c2:	ec06                	sd	ra,24(sp)
    36c4:	e822                	sd	s0,16(sp)
    36c6:	1000                	addi	s0,sp,32
    36c8:	e40c                	sd	a1,8(s0)
    36ca:	e810                	sd	a2,16(s0)
    36cc:	ec14                	sd	a3,24(s0)
    36ce:	f018                	sd	a4,32(s0)
    36d0:	f41c                	sd	a5,40(s0)
    36d2:	03043823          	sd	a6,48(s0)
    36d6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    36da:	00840613          	addi	a2,s0,8
    36de:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    36e2:	85aa                	mv	a1,a0
    36e4:	4505                	li	a0,1
    36e6:	00000097          	auipc	ra,0x0
    36ea:	dce080e7          	jalr	-562(ra) # 34b4 <vprintf>
}
    36ee:	60e2                	ld	ra,24(sp)
    36f0:	6442                	ld	s0,16(sp)
    36f2:	6125                	addi	sp,sp,96
    36f4:	8082                	ret

00000000000036f6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    36f6:	1141                	addi	sp,sp,-16
    36f8:	e422                	sd	s0,8(sp)
    36fa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    36fc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3700:	00001797          	auipc	a5,0x1
    3704:	9007b783          	ld	a5,-1792(a5) # 4000 <freep>
    3708:	a805                	j	3738 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    370a:	4618                	lw	a4,8(a2)
    370c:	9db9                	addw	a1,a1,a4
    370e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    3712:	6398                	ld	a4,0(a5)
    3714:	6318                	ld	a4,0(a4)
    3716:	fee53823          	sd	a4,-16(a0)
    371a:	a091                	j	375e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    371c:	ff852703          	lw	a4,-8(a0)
    3720:	9e39                	addw	a2,a2,a4
    3722:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    3724:	ff053703          	ld	a4,-16(a0)
    3728:	e398                	sd	a4,0(a5)
    372a:	a099                	j	3770 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    372c:	6398                	ld	a4,0(a5)
    372e:	00e7e463          	bltu	a5,a4,3736 <free+0x40>
    3732:	00e6ea63          	bltu	a3,a4,3746 <free+0x50>
{
    3736:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3738:	fed7fae3          	bgeu	a5,a3,372c <free+0x36>
    373c:	6398                	ld	a4,0(a5)
    373e:	00e6e463          	bltu	a3,a4,3746 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3742:	fee7eae3          	bltu	a5,a4,3736 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    3746:	ff852583          	lw	a1,-8(a0)
    374a:	6390                	ld	a2,0(a5)
    374c:	02059713          	slli	a4,a1,0x20
    3750:	9301                	srli	a4,a4,0x20
    3752:	0712                	slli	a4,a4,0x4
    3754:	9736                	add	a4,a4,a3
    3756:	fae60ae3          	beq	a2,a4,370a <free+0x14>
    bp->s.ptr = p->s.ptr;
    375a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    375e:	4790                	lw	a2,8(a5)
    3760:	02061713          	slli	a4,a2,0x20
    3764:	9301                	srli	a4,a4,0x20
    3766:	0712                	slli	a4,a4,0x4
    3768:	973e                	add	a4,a4,a5
    376a:	fae689e3          	beq	a3,a4,371c <free+0x26>
  } else
    p->s.ptr = bp;
    376e:	e394                	sd	a3,0(a5)
  freep = p;
    3770:	00001717          	auipc	a4,0x1
    3774:	88f73823          	sd	a5,-1904(a4) # 4000 <freep>
}
    3778:	6422                	ld	s0,8(sp)
    377a:	0141                	addi	sp,sp,16
    377c:	8082                	ret

000000000000377e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    377e:	7139                	addi	sp,sp,-64
    3780:	fc06                	sd	ra,56(sp)
    3782:	f822                	sd	s0,48(sp)
    3784:	f426                	sd	s1,40(sp)
    3786:	f04a                	sd	s2,32(sp)
    3788:	ec4e                	sd	s3,24(sp)
    378a:	e852                	sd	s4,16(sp)
    378c:	e456                	sd	s5,8(sp)
    378e:	e05a                	sd	s6,0(sp)
    3790:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3792:	02051493          	slli	s1,a0,0x20
    3796:	9081                	srli	s1,s1,0x20
    3798:	04bd                	addi	s1,s1,15
    379a:	8091                	srli	s1,s1,0x4
    379c:	0014899b          	addiw	s3,s1,1
    37a0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    37a2:	00001517          	auipc	a0,0x1
    37a6:	85e53503          	ld	a0,-1954(a0) # 4000 <freep>
    37aa:	c515                	beqz	a0,37d6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    37ac:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    37ae:	4798                	lw	a4,8(a5)
    37b0:	02977f63          	bgeu	a4,s1,37ee <malloc+0x70>
    37b4:	8a4e                	mv	s4,s3
    37b6:	0009871b          	sext.w	a4,s3
    37ba:	6685                	lui	a3,0x1
    37bc:	00d77363          	bgeu	a4,a3,37c2 <malloc+0x44>
    37c0:	6a05                	lui	s4,0x1
    37c2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    37c6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    37ca:	00001917          	auipc	s2,0x1
    37ce:	83690913          	addi	s2,s2,-1994 # 4000 <freep>
  if(p == (char*)-1)
    37d2:	5afd                	li	s5,-1
    37d4:	a88d                	j	3846 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    37d6:	00001797          	auipc	a5,0x1
    37da:	83a78793          	addi	a5,a5,-1990 # 4010 <base>
    37de:	00001717          	auipc	a4,0x1
    37e2:	82f73123          	sd	a5,-2014(a4) # 4000 <freep>
    37e6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    37e8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    37ec:	b7e1                	j	37b4 <malloc+0x36>
      if(p->s.size == nunits)
    37ee:	02e48b63          	beq	s1,a4,3824 <malloc+0xa6>
        p->s.size -= nunits;
    37f2:	4137073b          	subw	a4,a4,s3
    37f6:	c798                	sw	a4,8(a5)
        p += p->s.size;
    37f8:	1702                	slli	a4,a4,0x20
    37fa:	9301                	srli	a4,a4,0x20
    37fc:	0712                	slli	a4,a4,0x4
    37fe:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    3800:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    3804:	00000717          	auipc	a4,0x0
    3808:	7ea73e23          	sd	a0,2044(a4) # 4000 <freep>
      return (void*)(p + 1);
    380c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3810:	70e2                	ld	ra,56(sp)
    3812:	7442                	ld	s0,48(sp)
    3814:	74a2                	ld	s1,40(sp)
    3816:	7902                	ld	s2,32(sp)
    3818:	69e2                	ld	s3,24(sp)
    381a:	6a42                	ld	s4,16(sp)
    381c:	6aa2                	ld	s5,8(sp)
    381e:	6b02                	ld	s6,0(sp)
    3820:	6121                	addi	sp,sp,64
    3822:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3824:	6398                	ld	a4,0(a5)
    3826:	e118                	sd	a4,0(a0)
    3828:	bff1                	j	3804 <malloc+0x86>
  hp->s.size = nu;
    382a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    382e:	0541                	addi	a0,a0,16
    3830:	00000097          	auipc	ra,0x0
    3834:	ec6080e7          	jalr	-314(ra) # 36f6 <free>
  return freep;
    3838:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    383c:	d971                	beqz	a0,3810 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    383e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3840:	4798                	lw	a4,8(a5)
    3842:	fa9776e3          	bgeu	a4,s1,37ee <malloc+0x70>
    if(p == freep)
    3846:	00093703          	ld	a4,0(s2)
    384a:	853e                	mv	a0,a5
    384c:	fef719e3          	bne	a4,a5,383e <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3850:	8552                	mv	a0,s4
    3852:	00000097          	auipc	ra,0x0
    3856:	b56080e7          	jalr	-1194(ra) # 33a8 <sbrk>
  if(p == (char*)-1)
    385a:	fd5518e3          	bne	a0,s5,382a <malloc+0xac>
        return 0;
    385e:	4501                	li	a0,0
    3860:	bf45                	j	3810 <malloc+0x92>
