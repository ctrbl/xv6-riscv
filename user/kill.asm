
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
    3000:	1101                	addi	sp,sp,-32
    3002:	ec06                	sd	ra,24(sp)
    3004:	e822                	sd	s0,16(sp)
    3006:	e426                	sd	s1,8(sp)
    3008:	e04a                	sd	s2,0(sp)
    300a:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
    300c:	4785                	li	a5,1
    300e:	02a7dd63          	bge	a5,a0,3048 <main+0x48>
    3012:	00858493          	addi	s1,a1,8
    3016:	ffe5091b          	addiw	s2,a0,-2
    301a:	1902                	slli	s2,s2,0x20
    301c:	02095913          	srli	s2,s2,0x20
    3020:	090e                	slli	s2,s2,0x3
    3022:	05c1                	addi	a1,a1,16
    3024:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
    3026:	6088                	ld	a0,0(s1)
    3028:	00000097          	auipc	ra,0x0
    302c:	1c8080e7          	jalr	456(ra) # 31f0 <atoi>
    3030:	00000097          	auipc	ra,0x0
    3034:	34c080e7          	jalr	844(ra) # 337c <kill>
  for(i=1; i<argc; i++)
    3038:	04a1                	addi	s1,s1,8
    303a:	ff2496e3          	bne	s1,s2,3026 <main+0x26>
  exit(0);
    303e:	4501                	li	a0,0
    3040:	00000097          	auipc	ra,0x0
    3044:	304080e7          	jalr	772(ra) # 3344 <exit>
    fprintf(2, "usage: kill pid...\n");
    3048:	00001597          	auipc	a1,0x1
    304c:	84858593          	addi	a1,a1,-1976 # 3890 <malloc+0xe6>
    3050:	4509                	li	a0,2
    3052:	00000097          	auipc	ra,0x0
    3056:	66c080e7          	jalr	1644(ra) # 36be <fprintf>
    exit(1);
    305a:	4505                	li	a0,1
    305c:	00000097          	auipc	ra,0x0
    3060:	2e8080e7          	jalr	744(ra) # 3344 <exit>

0000000000003064 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    3064:	1141                	addi	sp,sp,-16
    3066:	e406                	sd	ra,8(sp)
    3068:	e022                	sd	s0,0(sp)
    306a:	0800                	addi	s0,sp,16
  extern int main();
  main();
    306c:	00000097          	auipc	ra,0x0
    3070:	f94080e7          	jalr	-108(ra) # 3000 <main>
  exit(0);
    3074:	4501                	li	a0,0
    3076:	00000097          	auipc	ra,0x0
    307a:	2ce080e7          	jalr	718(ra) # 3344 <exit>

000000000000307e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    307e:	1141                	addi	sp,sp,-16
    3080:	e422                	sd	s0,8(sp)
    3082:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3084:	87aa                	mv	a5,a0
    3086:	0585                	addi	a1,a1,1
    3088:	0785                	addi	a5,a5,1
    308a:	fff5c703          	lbu	a4,-1(a1)
    308e:	fee78fa3          	sb	a4,-1(a5)
    3092:	fb75                	bnez	a4,3086 <strcpy+0x8>
    ;
  return os;
}
    3094:	6422                	ld	s0,8(sp)
    3096:	0141                	addi	sp,sp,16
    3098:	8082                	ret

000000000000309a <strcmp>:

int
strcmp(const char *p, const char *q)
{
    309a:	1141                	addi	sp,sp,-16
    309c:	e422                	sd	s0,8(sp)
    309e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    30a0:	00054783          	lbu	a5,0(a0)
    30a4:	cb91                	beqz	a5,30b8 <strcmp+0x1e>
    30a6:	0005c703          	lbu	a4,0(a1)
    30aa:	00f71763          	bne	a4,a5,30b8 <strcmp+0x1e>
    p++, q++;
    30ae:	0505                	addi	a0,a0,1
    30b0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    30b2:	00054783          	lbu	a5,0(a0)
    30b6:	fbe5                	bnez	a5,30a6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    30b8:	0005c503          	lbu	a0,0(a1)
}
    30bc:	40a7853b          	subw	a0,a5,a0
    30c0:	6422                	ld	s0,8(sp)
    30c2:	0141                	addi	sp,sp,16
    30c4:	8082                	ret

00000000000030c6 <strlen>:

uint
strlen(const char *s)
{
    30c6:	1141                	addi	sp,sp,-16
    30c8:	e422                	sd	s0,8(sp)
    30ca:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    30cc:	00054783          	lbu	a5,0(a0)
    30d0:	cf91                	beqz	a5,30ec <strlen+0x26>
    30d2:	0505                	addi	a0,a0,1
    30d4:	87aa                	mv	a5,a0
    30d6:	4685                	li	a3,1
    30d8:	9e89                	subw	a3,a3,a0
    30da:	00f6853b          	addw	a0,a3,a5
    30de:	0785                	addi	a5,a5,1
    30e0:	fff7c703          	lbu	a4,-1(a5)
    30e4:	fb7d                	bnez	a4,30da <strlen+0x14>
    ;
  return n;
}
    30e6:	6422                	ld	s0,8(sp)
    30e8:	0141                	addi	sp,sp,16
    30ea:	8082                	ret
  for(n = 0; s[n]; n++)
    30ec:	4501                	li	a0,0
    30ee:	bfe5                	j	30e6 <strlen+0x20>

00000000000030f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    30f0:	1141                	addi	sp,sp,-16
    30f2:	e422                	sd	s0,8(sp)
    30f4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    30f6:	ca19                	beqz	a2,310c <memset+0x1c>
    30f8:	87aa                	mv	a5,a0
    30fa:	1602                	slli	a2,a2,0x20
    30fc:	9201                	srli	a2,a2,0x20
    30fe:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    3102:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    3106:	0785                	addi	a5,a5,1
    3108:	fee79de3          	bne	a5,a4,3102 <memset+0x12>
  }
  return dst;
}
    310c:	6422                	ld	s0,8(sp)
    310e:	0141                	addi	sp,sp,16
    3110:	8082                	ret

0000000000003112 <strchr>:

char*
strchr(const char *s, char c)
{
    3112:	1141                	addi	sp,sp,-16
    3114:	e422                	sd	s0,8(sp)
    3116:	0800                	addi	s0,sp,16
  for(; *s; s++)
    3118:	00054783          	lbu	a5,0(a0)
    311c:	cb99                	beqz	a5,3132 <strchr+0x20>
    if(*s == c)
    311e:	00f58763          	beq	a1,a5,312c <strchr+0x1a>
  for(; *s; s++)
    3122:	0505                	addi	a0,a0,1
    3124:	00054783          	lbu	a5,0(a0)
    3128:	fbfd                	bnez	a5,311e <strchr+0xc>
      return (char*)s;
  return 0;
    312a:	4501                	li	a0,0
}
    312c:	6422                	ld	s0,8(sp)
    312e:	0141                	addi	sp,sp,16
    3130:	8082                	ret
  return 0;
    3132:	4501                	li	a0,0
    3134:	bfe5                	j	312c <strchr+0x1a>

0000000000003136 <gets>:

char*
gets(char *buf, int max)
{
    3136:	711d                	addi	sp,sp,-96
    3138:	ec86                	sd	ra,88(sp)
    313a:	e8a2                	sd	s0,80(sp)
    313c:	e4a6                	sd	s1,72(sp)
    313e:	e0ca                	sd	s2,64(sp)
    3140:	fc4e                	sd	s3,56(sp)
    3142:	f852                	sd	s4,48(sp)
    3144:	f456                	sd	s5,40(sp)
    3146:	f05a                	sd	s6,32(sp)
    3148:	ec5e                	sd	s7,24(sp)
    314a:	1080                	addi	s0,sp,96
    314c:	8baa                	mv	s7,a0
    314e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3150:	892a                	mv	s2,a0
    3152:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3154:	4aa9                	li	s5,10
    3156:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    3158:	89a6                	mv	s3,s1
    315a:	2485                	addiw	s1,s1,1
    315c:	0344d863          	bge	s1,s4,318c <gets+0x56>
    cc = read(0, &c, 1);
    3160:	4605                	li	a2,1
    3162:	faf40593          	addi	a1,s0,-81
    3166:	4501                	li	a0,0
    3168:	00000097          	auipc	ra,0x0
    316c:	1fc080e7          	jalr	508(ra) # 3364 <read>
    if(cc < 1)
    3170:	00a05e63          	blez	a0,318c <gets+0x56>
    buf[i++] = c;
    3174:	faf44783          	lbu	a5,-81(s0)
    3178:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    317c:	01578763          	beq	a5,s5,318a <gets+0x54>
    3180:	0905                	addi	s2,s2,1
    3182:	fd679be3          	bne	a5,s6,3158 <gets+0x22>
  for(i=0; i+1 < max; ){
    3186:	89a6                	mv	s3,s1
    3188:	a011                	j	318c <gets+0x56>
    318a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    318c:	99de                	add	s3,s3,s7
    318e:	00098023          	sb	zero,0(s3)
  return buf;
}
    3192:	855e                	mv	a0,s7
    3194:	60e6                	ld	ra,88(sp)
    3196:	6446                	ld	s0,80(sp)
    3198:	64a6                	ld	s1,72(sp)
    319a:	6906                	ld	s2,64(sp)
    319c:	79e2                	ld	s3,56(sp)
    319e:	7a42                	ld	s4,48(sp)
    31a0:	7aa2                	ld	s5,40(sp)
    31a2:	7b02                	ld	s6,32(sp)
    31a4:	6be2                	ld	s7,24(sp)
    31a6:	6125                	addi	sp,sp,96
    31a8:	8082                	ret

00000000000031aa <stat>:

int
stat(const char *n, struct stat *st)
{
    31aa:	1101                	addi	sp,sp,-32
    31ac:	ec06                	sd	ra,24(sp)
    31ae:	e822                	sd	s0,16(sp)
    31b0:	e426                	sd	s1,8(sp)
    31b2:	e04a                	sd	s2,0(sp)
    31b4:	1000                	addi	s0,sp,32
    31b6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    31b8:	4581                	li	a1,0
    31ba:	00000097          	auipc	ra,0x0
    31be:	1d2080e7          	jalr	466(ra) # 338c <open>
  if(fd < 0)
    31c2:	02054563          	bltz	a0,31ec <stat+0x42>
    31c6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    31c8:	85ca                	mv	a1,s2
    31ca:	00000097          	auipc	ra,0x0
    31ce:	1da080e7          	jalr	474(ra) # 33a4 <fstat>
    31d2:	892a                	mv	s2,a0
  close(fd);
    31d4:	8526                	mv	a0,s1
    31d6:	00000097          	auipc	ra,0x0
    31da:	19e080e7          	jalr	414(ra) # 3374 <close>
  return r;
}
    31de:	854a                	mv	a0,s2
    31e0:	60e2                	ld	ra,24(sp)
    31e2:	6442                	ld	s0,16(sp)
    31e4:	64a2                	ld	s1,8(sp)
    31e6:	6902                	ld	s2,0(sp)
    31e8:	6105                	addi	sp,sp,32
    31ea:	8082                	ret
    return -1;
    31ec:	597d                	li	s2,-1
    31ee:	bfc5                	j	31de <stat+0x34>

00000000000031f0 <atoi>:

int
atoi(const char *s)
{
    31f0:	1141                	addi	sp,sp,-16
    31f2:	e422                	sd	s0,8(sp)
    31f4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    31f6:	00054603          	lbu	a2,0(a0)
    31fa:	fd06079b          	addiw	a5,a2,-48
    31fe:	0ff7f793          	andi	a5,a5,255
    3202:	4725                	li	a4,9
    3204:	02f76963          	bltu	a4,a5,3236 <atoi+0x46>
    3208:	86aa                	mv	a3,a0
  n = 0;
    320a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    320c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    320e:	0685                	addi	a3,a3,1
    3210:	0025179b          	slliw	a5,a0,0x2
    3214:	9fa9                	addw	a5,a5,a0
    3216:	0017979b          	slliw	a5,a5,0x1
    321a:	9fb1                	addw	a5,a5,a2
    321c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    3220:	0006c603          	lbu	a2,0(a3)
    3224:	fd06071b          	addiw	a4,a2,-48
    3228:	0ff77713          	andi	a4,a4,255
    322c:	fee5f1e3          	bgeu	a1,a4,320e <atoi+0x1e>
  return n;
}
    3230:	6422                	ld	s0,8(sp)
    3232:	0141                	addi	sp,sp,16
    3234:	8082                	ret
  n = 0;
    3236:	4501                	li	a0,0
    3238:	bfe5                	j	3230 <atoi+0x40>

000000000000323a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    323a:	1141                	addi	sp,sp,-16
    323c:	e422                	sd	s0,8(sp)
    323e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    3240:	02b57463          	bgeu	a0,a1,3268 <memmove+0x2e>
    while(n-- > 0)
    3244:	00c05f63          	blez	a2,3262 <memmove+0x28>
    3248:	1602                	slli	a2,a2,0x20
    324a:	9201                	srli	a2,a2,0x20
    324c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    3250:	872a                	mv	a4,a0
      *dst++ = *src++;
    3252:	0585                	addi	a1,a1,1
    3254:	0705                	addi	a4,a4,1
    3256:	fff5c683          	lbu	a3,-1(a1)
    325a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    325e:	fee79ae3          	bne	a5,a4,3252 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    3262:	6422                	ld	s0,8(sp)
    3264:	0141                	addi	sp,sp,16
    3266:	8082                	ret
    dst += n;
    3268:	00c50733          	add	a4,a0,a2
    src += n;
    326c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    326e:	fec05ae3          	blez	a2,3262 <memmove+0x28>
    3272:	fff6079b          	addiw	a5,a2,-1
    3276:	1782                	slli	a5,a5,0x20
    3278:	9381                	srli	a5,a5,0x20
    327a:	fff7c793          	not	a5,a5
    327e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3280:	15fd                	addi	a1,a1,-1
    3282:	177d                	addi	a4,a4,-1
    3284:	0005c683          	lbu	a3,0(a1)
    3288:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    328c:	fee79ae3          	bne	a5,a4,3280 <memmove+0x46>
    3290:	bfc9                	j	3262 <memmove+0x28>

0000000000003292 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    3292:	1141                	addi	sp,sp,-16
    3294:	e422                	sd	s0,8(sp)
    3296:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    3298:	ca05                	beqz	a2,32c8 <memcmp+0x36>
    329a:	fff6069b          	addiw	a3,a2,-1
    329e:	1682                	slli	a3,a3,0x20
    32a0:	9281                	srli	a3,a3,0x20
    32a2:	0685                	addi	a3,a3,1
    32a4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    32a6:	00054783          	lbu	a5,0(a0)
    32aa:	0005c703          	lbu	a4,0(a1)
    32ae:	00e79863          	bne	a5,a4,32be <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    32b2:	0505                	addi	a0,a0,1
    p2++;
    32b4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    32b6:	fed518e3          	bne	a0,a3,32a6 <memcmp+0x14>
  }
  return 0;
    32ba:	4501                	li	a0,0
    32bc:	a019                	j	32c2 <memcmp+0x30>
      return *p1 - *p2;
    32be:	40e7853b          	subw	a0,a5,a4
}
    32c2:	6422                	ld	s0,8(sp)
    32c4:	0141                	addi	sp,sp,16
    32c6:	8082                	ret
  return 0;
    32c8:	4501                	li	a0,0
    32ca:	bfe5                	j	32c2 <memcmp+0x30>

00000000000032cc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    32cc:	1141                	addi	sp,sp,-16
    32ce:	e406                	sd	ra,8(sp)
    32d0:	e022                	sd	s0,0(sp)
    32d2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    32d4:	00000097          	auipc	ra,0x0
    32d8:	f66080e7          	jalr	-154(ra) # 323a <memmove>
}
    32dc:	60a2                	ld	ra,8(sp)
    32de:	6402                	ld	s0,0(sp)
    32e0:	0141                	addi	sp,sp,16
    32e2:	8082                	ret

00000000000032e4 <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    32e4:	1141                	addi	sp,sp,-16
    32e6:	e422                	sd	s0,8(sp)
    32e8:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    32ea:	00052023          	sw	zero,0(a0)
}  
    32ee:	6422                	ld	s0,8(sp)
    32f0:	0141                	addi	sp,sp,16
    32f2:	8082                	ret

00000000000032f4 <lock>:

void lock(struct spinlock * lk) 
{    
    32f4:	1141                	addi	sp,sp,-16
    32f6:	e422                	sd	s0,8(sp)
    32f8:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    32fa:	4705                	li	a4,1
    32fc:	87ba                	mv	a5,a4
    32fe:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    3302:	2781                	sext.w	a5,a5
    3304:	ffe5                	bnez	a5,32fc <lock+0x8>
}  
    3306:	6422                	ld	s0,8(sp)
    3308:	0141                	addi	sp,sp,16
    330a:	8082                	ret

000000000000330c <unlock>:

void unlock(struct spinlock * lk) 
{   
    330c:	1141                	addi	sp,sp,-16
    330e:	e422                	sd	s0,8(sp)
    3310:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    3312:	0f50000f          	fence	iorw,ow
    3316:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    331a:	6422                	ld	s0,8(sp)
    331c:	0141                	addi	sp,sp,16
    331e:	8082                	ret

0000000000003320 <isDigit>:

unsigned int isDigit(char *c) {
    3320:	1141                	addi	sp,sp,-16
    3322:	e422                	sd	s0,8(sp)
    3324:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    3326:	00054503          	lbu	a0,0(a0)
    332a:	fd05051b          	addiw	a0,a0,-48
    332e:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    3332:	00a53513          	sltiu	a0,a0,10
    3336:	6422                	ld	s0,8(sp)
    3338:	0141                	addi	sp,sp,16
    333a:	8082                	ret

000000000000333c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    333c:	4885                	li	a7,1
 ecall
    333e:	00000073          	ecall
 ret
    3342:	8082                	ret

0000000000003344 <exit>:
.global exit
exit:
 li a7, SYS_exit
    3344:	4889                	li	a7,2
 ecall
    3346:	00000073          	ecall
 ret
    334a:	8082                	ret

000000000000334c <wait>:
.global wait
wait:
 li a7, SYS_wait
    334c:	488d                	li	a7,3
 ecall
    334e:	00000073          	ecall
 ret
    3352:	8082                	ret

0000000000003354 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    3354:	48e1                	li	a7,24
 ecall
    3356:	00000073          	ecall
 ret
    335a:	8082                	ret

000000000000335c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    335c:	4891                	li	a7,4
 ecall
    335e:	00000073          	ecall
 ret
    3362:	8082                	ret

0000000000003364 <read>:
.global read
read:
 li a7, SYS_read
    3364:	4895                	li	a7,5
 ecall
    3366:	00000073          	ecall
 ret
    336a:	8082                	ret

000000000000336c <write>:
.global write
write:
 li a7, SYS_write
    336c:	48c1                	li	a7,16
 ecall
    336e:	00000073          	ecall
 ret
    3372:	8082                	ret

0000000000003374 <close>:
.global close
close:
 li a7, SYS_close
    3374:	48d5                	li	a7,21
 ecall
    3376:	00000073          	ecall
 ret
    337a:	8082                	ret

000000000000337c <kill>:
.global kill
kill:
 li a7, SYS_kill
    337c:	4899                	li	a7,6
 ecall
    337e:	00000073          	ecall
 ret
    3382:	8082                	ret

0000000000003384 <exec>:
.global exec
exec:
 li a7, SYS_exec
    3384:	489d                	li	a7,7
 ecall
    3386:	00000073          	ecall
 ret
    338a:	8082                	ret

000000000000338c <open>:
.global open
open:
 li a7, SYS_open
    338c:	48bd                	li	a7,15
 ecall
    338e:	00000073          	ecall
 ret
    3392:	8082                	ret

0000000000003394 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    3394:	48c5                	li	a7,17
 ecall
    3396:	00000073          	ecall
 ret
    339a:	8082                	ret

000000000000339c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    339c:	48c9                	li	a7,18
 ecall
    339e:	00000073          	ecall
 ret
    33a2:	8082                	ret

00000000000033a4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    33a4:	48a1                	li	a7,8
 ecall
    33a6:	00000073          	ecall
 ret
    33aa:	8082                	ret

00000000000033ac <link>:
.global link
link:
 li a7, SYS_link
    33ac:	48cd                	li	a7,19
 ecall
    33ae:	00000073          	ecall
 ret
    33b2:	8082                	ret

00000000000033b4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    33b4:	48d1                	li	a7,20
 ecall
    33b6:	00000073          	ecall
 ret
    33ba:	8082                	ret

00000000000033bc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    33bc:	48a5                	li	a7,9
 ecall
    33be:	00000073          	ecall
 ret
    33c2:	8082                	ret

00000000000033c4 <dup>:
.global dup
dup:
 li a7, SYS_dup
    33c4:	48a9                	li	a7,10
 ecall
    33c6:	00000073          	ecall
 ret
    33ca:	8082                	ret

00000000000033cc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    33cc:	48ad                	li	a7,11
 ecall
    33ce:	00000073          	ecall
 ret
    33d2:	8082                	ret

00000000000033d4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    33d4:	48b1                	li	a7,12
 ecall
    33d6:	00000073          	ecall
 ret
    33da:	8082                	ret

00000000000033dc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    33dc:	48b5                	li	a7,13
 ecall
    33de:	00000073          	ecall
 ret
    33e2:	8082                	ret

00000000000033e4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    33e4:	48b9                	li	a7,14
 ecall
    33e6:	00000073          	ecall
 ret
    33ea:	8082                	ret

00000000000033ec <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    33ec:	48d9                	li	a7,22
 ecall
    33ee:	00000073          	ecall
 ret
    33f2:	8082                	ret

00000000000033f4 <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    33f4:	48dd                	li	a7,23
 ecall
    33f6:	00000073          	ecall
 ret
    33fa:	8082                	ret

00000000000033fc <ps>:
.global ps
ps:
 li a7, SYS_ps
    33fc:	48e5                	li	a7,25
 ecall
    33fe:	00000073          	ecall
 ret
    3402:	8082                	ret

0000000000003404 <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    3404:	48e9                	li	a7,26
 ecall
    3406:	00000073          	ecall
 ret
    340a:	8082                	ret

000000000000340c <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    340c:	48ed                	li	a7,27
 ecall
    340e:	00000073          	ecall
 ret
    3412:	8082                	ret

0000000000003414 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    3414:	1101                	addi	sp,sp,-32
    3416:	ec06                	sd	ra,24(sp)
    3418:	e822                	sd	s0,16(sp)
    341a:	1000                	addi	s0,sp,32
    341c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    3420:	4605                	li	a2,1
    3422:	fef40593          	addi	a1,s0,-17
    3426:	00000097          	auipc	ra,0x0
    342a:	f46080e7          	jalr	-186(ra) # 336c <write>
}
    342e:	60e2                	ld	ra,24(sp)
    3430:	6442                	ld	s0,16(sp)
    3432:	6105                	addi	sp,sp,32
    3434:	8082                	ret

0000000000003436 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3436:	7139                	addi	sp,sp,-64
    3438:	fc06                	sd	ra,56(sp)
    343a:	f822                	sd	s0,48(sp)
    343c:	f426                	sd	s1,40(sp)
    343e:	f04a                	sd	s2,32(sp)
    3440:	ec4e                	sd	s3,24(sp)
    3442:	0080                	addi	s0,sp,64
    3444:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3446:	c299                	beqz	a3,344c <printint+0x16>
    3448:	0805c863          	bltz	a1,34d8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    344c:	2581                	sext.w	a1,a1
  neg = 0;
    344e:	4881                	li	a7,0
    3450:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    3454:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    3456:	2601                	sext.w	a2,a2
    3458:	00000517          	auipc	a0,0x0
    345c:	45850513          	addi	a0,a0,1112 # 38b0 <digits>
    3460:	883a                	mv	a6,a4
    3462:	2705                	addiw	a4,a4,1
    3464:	02c5f7bb          	remuw	a5,a1,a2
    3468:	1782                	slli	a5,a5,0x20
    346a:	9381                	srli	a5,a5,0x20
    346c:	97aa                	add	a5,a5,a0
    346e:	0007c783          	lbu	a5,0(a5)
    3472:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    3476:	0005879b          	sext.w	a5,a1
    347a:	02c5d5bb          	divuw	a1,a1,a2
    347e:	0685                	addi	a3,a3,1
    3480:	fec7f0e3          	bgeu	a5,a2,3460 <printint+0x2a>
  if(neg)
    3484:	00088b63          	beqz	a7,349a <printint+0x64>
    buf[i++] = '-';
    3488:	fd040793          	addi	a5,s0,-48
    348c:	973e                	add	a4,a4,a5
    348e:	02d00793          	li	a5,45
    3492:	fef70823          	sb	a5,-16(a4)
    3496:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    349a:	02e05863          	blez	a4,34ca <printint+0x94>
    349e:	fc040793          	addi	a5,s0,-64
    34a2:	00e78933          	add	s2,a5,a4
    34a6:	fff78993          	addi	s3,a5,-1
    34aa:	99ba                	add	s3,s3,a4
    34ac:	377d                	addiw	a4,a4,-1
    34ae:	1702                	slli	a4,a4,0x20
    34b0:	9301                	srli	a4,a4,0x20
    34b2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    34b6:	fff94583          	lbu	a1,-1(s2)
    34ba:	8526                	mv	a0,s1
    34bc:	00000097          	auipc	ra,0x0
    34c0:	f58080e7          	jalr	-168(ra) # 3414 <putc>
  while(--i >= 0)
    34c4:	197d                	addi	s2,s2,-1
    34c6:	ff3918e3          	bne	s2,s3,34b6 <printint+0x80>
}
    34ca:	70e2                	ld	ra,56(sp)
    34cc:	7442                	ld	s0,48(sp)
    34ce:	74a2                	ld	s1,40(sp)
    34d0:	7902                	ld	s2,32(sp)
    34d2:	69e2                	ld	s3,24(sp)
    34d4:	6121                	addi	sp,sp,64
    34d6:	8082                	ret
    x = -xx;
    34d8:	40b005bb          	negw	a1,a1
    neg = 1;
    34dc:	4885                	li	a7,1
    x = -xx;
    34de:	bf8d                	j	3450 <printint+0x1a>

00000000000034e0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    34e0:	7119                	addi	sp,sp,-128
    34e2:	fc86                	sd	ra,120(sp)
    34e4:	f8a2                	sd	s0,112(sp)
    34e6:	f4a6                	sd	s1,104(sp)
    34e8:	f0ca                	sd	s2,96(sp)
    34ea:	ecce                	sd	s3,88(sp)
    34ec:	e8d2                	sd	s4,80(sp)
    34ee:	e4d6                	sd	s5,72(sp)
    34f0:	e0da                	sd	s6,64(sp)
    34f2:	fc5e                	sd	s7,56(sp)
    34f4:	f862                	sd	s8,48(sp)
    34f6:	f466                	sd	s9,40(sp)
    34f8:	f06a                	sd	s10,32(sp)
    34fa:	ec6e                	sd	s11,24(sp)
    34fc:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    34fe:	0005c903          	lbu	s2,0(a1)
    3502:	18090f63          	beqz	s2,36a0 <vprintf+0x1c0>
    3506:	8aaa                	mv	s5,a0
    3508:	8b32                	mv	s6,a2
    350a:	00158493          	addi	s1,a1,1
  state = 0;
    350e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3510:	02500a13          	li	s4,37
      if(c == 'd'){
    3514:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    3518:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    351c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    3520:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3524:	00000b97          	auipc	s7,0x0
    3528:	38cb8b93          	addi	s7,s7,908 # 38b0 <digits>
    352c:	a839                	j	354a <vprintf+0x6a>
        putc(fd, c);
    352e:	85ca                	mv	a1,s2
    3530:	8556                	mv	a0,s5
    3532:	00000097          	auipc	ra,0x0
    3536:	ee2080e7          	jalr	-286(ra) # 3414 <putc>
    353a:	a019                	j	3540 <vprintf+0x60>
    } else if(state == '%'){
    353c:	01498f63          	beq	s3,s4,355a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    3540:	0485                	addi	s1,s1,1
    3542:	fff4c903          	lbu	s2,-1(s1)
    3546:	14090d63          	beqz	s2,36a0 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    354a:	0009079b          	sext.w	a5,s2
    if(state == 0){
    354e:	fe0997e3          	bnez	s3,353c <vprintf+0x5c>
      if(c == '%'){
    3552:	fd479ee3          	bne	a5,s4,352e <vprintf+0x4e>
        state = '%';
    3556:	89be                	mv	s3,a5
    3558:	b7e5                	j	3540 <vprintf+0x60>
      if(c == 'd'){
    355a:	05878063          	beq	a5,s8,359a <vprintf+0xba>
      } else if(c == 'l') {
    355e:	05978c63          	beq	a5,s9,35b6 <vprintf+0xd6>
      } else if(c == 'x') {
    3562:	07a78863          	beq	a5,s10,35d2 <vprintf+0xf2>
      } else if(c == 'p') {
    3566:	09b78463          	beq	a5,s11,35ee <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    356a:	07300713          	li	a4,115
    356e:	0ce78663          	beq	a5,a4,363a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3572:	06300713          	li	a4,99
    3576:	0ee78e63          	beq	a5,a4,3672 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    357a:	11478863          	beq	a5,s4,368a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    357e:	85d2                	mv	a1,s4
    3580:	8556                	mv	a0,s5
    3582:	00000097          	auipc	ra,0x0
    3586:	e92080e7          	jalr	-366(ra) # 3414 <putc>
        putc(fd, c);
    358a:	85ca                	mv	a1,s2
    358c:	8556                	mv	a0,s5
    358e:	00000097          	auipc	ra,0x0
    3592:	e86080e7          	jalr	-378(ra) # 3414 <putc>
      }
      state = 0;
    3596:	4981                	li	s3,0
    3598:	b765                	j	3540 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    359a:	008b0913          	addi	s2,s6,8
    359e:	4685                	li	a3,1
    35a0:	4629                	li	a2,10
    35a2:	000b2583          	lw	a1,0(s6)
    35a6:	8556                	mv	a0,s5
    35a8:	00000097          	auipc	ra,0x0
    35ac:	e8e080e7          	jalr	-370(ra) # 3436 <printint>
    35b0:	8b4a                	mv	s6,s2
      state = 0;
    35b2:	4981                	li	s3,0
    35b4:	b771                	j	3540 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    35b6:	008b0913          	addi	s2,s6,8
    35ba:	4681                	li	a3,0
    35bc:	4629                	li	a2,10
    35be:	000b2583          	lw	a1,0(s6)
    35c2:	8556                	mv	a0,s5
    35c4:	00000097          	auipc	ra,0x0
    35c8:	e72080e7          	jalr	-398(ra) # 3436 <printint>
    35cc:	8b4a                	mv	s6,s2
      state = 0;
    35ce:	4981                	li	s3,0
    35d0:	bf85                	j	3540 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    35d2:	008b0913          	addi	s2,s6,8
    35d6:	4681                	li	a3,0
    35d8:	4641                	li	a2,16
    35da:	000b2583          	lw	a1,0(s6)
    35de:	8556                	mv	a0,s5
    35e0:	00000097          	auipc	ra,0x0
    35e4:	e56080e7          	jalr	-426(ra) # 3436 <printint>
    35e8:	8b4a                	mv	s6,s2
      state = 0;
    35ea:	4981                	li	s3,0
    35ec:	bf91                	j	3540 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    35ee:	008b0793          	addi	a5,s6,8
    35f2:	f8f43423          	sd	a5,-120(s0)
    35f6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    35fa:	03000593          	li	a1,48
    35fe:	8556                	mv	a0,s5
    3600:	00000097          	auipc	ra,0x0
    3604:	e14080e7          	jalr	-492(ra) # 3414 <putc>
  putc(fd, 'x');
    3608:	85ea                	mv	a1,s10
    360a:	8556                	mv	a0,s5
    360c:	00000097          	auipc	ra,0x0
    3610:	e08080e7          	jalr	-504(ra) # 3414 <putc>
    3614:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3616:	03c9d793          	srli	a5,s3,0x3c
    361a:	97de                	add	a5,a5,s7
    361c:	0007c583          	lbu	a1,0(a5)
    3620:	8556                	mv	a0,s5
    3622:	00000097          	auipc	ra,0x0
    3626:	df2080e7          	jalr	-526(ra) # 3414 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    362a:	0992                	slli	s3,s3,0x4
    362c:	397d                	addiw	s2,s2,-1
    362e:	fe0914e3          	bnez	s2,3616 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    3632:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    3636:	4981                	li	s3,0
    3638:	b721                	j	3540 <vprintf+0x60>
        s = va_arg(ap, char*);
    363a:	008b0993          	addi	s3,s6,8
    363e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    3642:	02090163          	beqz	s2,3664 <vprintf+0x184>
        while(*s != 0){
    3646:	00094583          	lbu	a1,0(s2)
    364a:	c9a1                	beqz	a1,369a <vprintf+0x1ba>
          putc(fd, *s);
    364c:	8556                	mv	a0,s5
    364e:	00000097          	auipc	ra,0x0
    3652:	dc6080e7          	jalr	-570(ra) # 3414 <putc>
          s++;
    3656:	0905                	addi	s2,s2,1
        while(*s != 0){
    3658:	00094583          	lbu	a1,0(s2)
    365c:	f9e5                	bnez	a1,364c <vprintf+0x16c>
        s = va_arg(ap, char*);
    365e:	8b4e                	mv	s6,s3
      state = 0;
    3660:	4981                	li	s3,0
    3662:	bdf9                	j	3540 <vprintf+0x60>
          s = "(null)";
    3664:	00000917          	auipc	s2,0x0
    3668:	24490913          	addi	s2,s2,580 # 38a8 <malloc+0xfe>
        while(*s != 0){
    366c:	02800593          	li	a1,40
    3670:	bff1                	j	364c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    3672:	008b0913          	addi	s2,s6,8
    3676:	000b4583          	lbu	a1,0(s6)
    367a:	8556                	mv	a0,s5
    367c:	00000097          	auipc	ra,0x0
    3680:	d98080e7          	jalr	-616(ra) # 3414 <putc>
    3684:	8b4a                	mv	s6,s2
      state = 0;
    3686:	4981                	li	s3,0
    3688:	bd65                	j	3540 <vprintf+0x60>
        putc(fd, c);
    368a:	85d2                	mv	a1,s4
    368c:	8556                	mv	a0,s5
    368e:	00000097          	auipc	ra,0x0
    3692:	d86080e7          	jalr	-634(ra) # 3414 <putc>
      state = 0;
    3696:	4981                	li	s3,0
    3698:	b565                	j	3540 <vprintf+0x60>
        s = va_arg(ap, char*);
    369a:	8b4e                	mv	s6,s3
      state = 0;
    369c:	4981                	li	s3,0
    369e:	b54d                	j	3540 <vprintf+0x60>
    }
  }
}
    36a0:	70e6                	ld	ra,120(sp)
    36a2:	7446                	ld	s0,112(sp)
    36a4:	74a6                	ld	s1,104(sp)
    36a6:	7906                	ld	s2,96(sp)
    36a8:	69e6                	ld	s3,88(sp)
    36aa:	6a46                	ld	s4,80(sp)
    36ac:	6aa6                	ld	s5,72(sp)
    36ae:	6b06                	ld	s6,64(sp)
    36b0:	7be2                	ld	s7,56(sp)
    36b2:	7c42                	ld	s8,48(sp)
    36b4:	7ca2                	ld	s9,40(sp)
    36b6:	7d02                	ld	s10,32(sp)
    36b8:	6de2                	ld	s11,24(sp)
    36ba:	6109                	addi	sp,sp,128
    36bc:	8082                	ret

00000000000036be <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    36be:	715d                	addi	sp,sp,-80
    36c0:	ec06                	sd	ra,24(sp)
    36c2:	e822                	sd	s0,16(sp)
    36c4:	1000                	addi	s0,sp,32
    36c6:	e010                	sd	a2,0(s0)
    36c8:	e414                	sd	a3,8(s0)
    36ca:	e818                	sd	a4,16(s0)
    36cc:	ec1c                	sd	a5,24(s0)
    36ce:	03043023          	sd	a6,32(s0)
    36d2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    36d6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    36da:	8622                	mv	a2,s0
    36dc:	00000097          	auipc	ra,0x0
    36e0:	e04080e7          	jalr	-508(ra) # 34e0 <vprintf>
}
    36e4:	60e2                	ld	ra,24(sp)
    36e6:	6442                	ld	s0,16(sp)
    36e8:	6161                	addi	sp,sp,80
    36ea:	8082                	ret

00000000000036ec <printf>:

void
printf(const char *fmt, ...)
{
    36ec:	711d                	addi	sp,sp,-96
    36ee:	ec06                	sd	ra,24(sp)
    36f0:	e822                	sd	s0,16(sp)
    36f2:	1000                	addi	s0,sp,32
    36f4:	e40c                	sd	a1,8(s0)
    36f6:	e810                	sd	a2,16(s0)
    36f8:	ec14                	sd	a3,24(s0)
    36fa:	f018                	sd	a4,32(s0)
    36fc:	f41c                	sd	a5,40(s0)
    36fe:	03043823          	sd	a6,48(s0)
    3702:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    3706:	00840613          	addi	a2,s0,8
    370a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    370e:	85aa                	mv	a1,a0
    3710:	4505                	li	a0,1
    3712:	00000097          	auipc	ra,0x0
    3716:	dce080e7          	jalr	-562(ra) # 34e0 <vprintf>
}
    371a:	60e2                	ld	ra,24(sp)
    371c:	6442                	ld	s0,16(sp)
    371e:	6125                	addi	sp,sp,96
    3720:	8082                	ret

0000000000003722 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3722:	1141                	addi	sp,sp,-16
    3724:	e422                	sd	s0,8(sp)
    3726:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3728:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    372c:	00001797          	auipc	a5,0x1
    3730:	8d47b783          	ld	a5,-1836(a5) # 4000 <freep>
    3734:	a805                	j	3764 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3736:	4618                	lw	a4,8(a2)
    3738:	9db9                	addw	a1,a1,a4
    373a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    373e:	6398                	ld	a4,0(a5)
    3740:	6318                	ld	a4,0(a4)
    3742:	fee53823          	sd	a4,-16(a0)
    3746:	a091                	j	378a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3748:	ff852703          	lw	a4,-8(a0)
    374c:	9e39                	addw	a2,a2,a4
    374e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    3750:	ff053703          	ld	a4,-16(a0)
    3754:	e398                	sd	a4,0(a5)
    3756:	a099                	j	379c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3758:	6398                	ld	a4,0(a5)
    375a:	00e7e463          	bltu	a5,a4,3762 <free+0x40>
    375e:	00e6ea63          	bltu	a3,a4,3772 <free+0x50>
{
    3762:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3764:	fed7fae3          	bgeu	a5,a3,3758 <free+0x36>
    3768:	6398                	ld	a4,0(a5)
    376a:	00e6e463          	bltu	a3,a4,3772 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    376e:	fee7eae3          	bltu	a5,a4,3762 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    3772:	ff852583          	lw	a1,-8(a0)
    3776:	6390                	ld	a2,0(a5)
    3778:	02059713          	slli	a4,a1,0x20
    377c:	9301                	srli	a4,a4,0x20
    377e:	0712                	slli	a4,a4,0x4
    3780:	9736                	add	a4,a4,a3
    3782:	fae60ae3          	beq	a2,a4,3736 <free+0x14>
    bp->s.ptr = p->s.ptr;
    3786:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    378a:	4790                	lw	a2,8(a5)
    378c:	02061713          	slli	a4,a2,0x20
    3790:	9301                	srli	a4,a4,0x20
    3792:	0712                	slli	a4,a4,0x4
    3794:	973e                	add	a4,a4,a5
    3796:	fae689e3          	beq	a3,a4,3748 <free+0x26>
  } else
    p->s.ptr = bp;
    379a:	e394                	sd	a3,0(a5)
  freep = p;
    379c:	00001717          	auipc	a4,0x1
    37a0:	86f73223          	sd	a5,-1948(a4) # 4000 <freep>
}
    37a4:	6422                	ld	s0,8(sp)
    37a6:	0141                	addi	sp,sp,16
    37a8:	8082                	ret

00000000000037aa <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    37aa:	7139                	addi	sp,sp,-64
    37ac:	fc06                	sd	ra,56(sp)
    37ae:	f822                	sd	s0,48(sp)
    37b0:	f426                	sd	s1,40(sp)
    37b2:	f04a                	sd	s2,32(sp)
    37b4:	ec4e                	sd	s3,24(sp)
    37b6:	e852                	sd	s4,16(sp)
    37b8:	e456                	sd	s5,8(sp)
    37ba:	e05a                	sd	s6,0(sp)
    37bc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    37be:	02051493          	slli	s1,a0,0x20
    37c2:	9081                	srli	s1,s1,0x20
    37c4:	04bd                	addi	s1,s1,15
    37c6:	8091                	srli	s1,s1,0x4
    37c8:	0014899b          	addiw	s3,s1,1
    37cc:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    37ce:	00001517          	auipc	a0,0x1
    37d2:	83253503          	ld	a0,-1998(a0) # 4000 <freep>
    37d6:	c515                	beqz	a0,3802 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    37d8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    37da:	4798                	lw	a4,8(a5)
    37dc:	02977f63          	bgeu	a4,s1,381a <malloc+0x70>
    37e0:	8a4e                	mv	s4,s3
    37e2:	0009871b          	sext.w	a4,s3
    37e6:	6685                	lui	a3,0x1
    37e8:	00d77363          	bgeu	a4,a3,37ee <malloc+0x44>
    37ec:	6a05                	lui	s4,0x1
    37ee:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    37f2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    37f6:	00001917          	auipc	s2,0x1
    37fa:	80a90913          	addi	s2,s2,-2038 # 4000 <freep>
  if(p == (char*)-1)
    37fe:	5afd                	li	s5,-1
    3800:	a88d                	j	3872 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    3802:	00001797          	auipc	a5,0x1
    3806:	80e78793          	addi	a5,a5,-2034 # 4010 <base>
    380a:	00000717          	auipc	a4,0x0
    380e:	7ef73b23          	sd	a5,2038(a4) # 4000 <freep>
    3812:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    3814:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    3818:	b7e1                	j	37e0 <malloc+0x36>
      if(p->s.size == nunits)
    381a:	02e48b63          	beq	s1,a4,3850 <malloc+0xa6>
        p->s.size -= nunits;
    381e:	4137073b          	subw	a4,a4,s3
    3822:	c798                	sw	a4,8(a5)
        p += p->s.size;
    3824:	1702                	slli	a4,a4,0x20
    3826:	9301                	srli	a4,a4,0x20
    3828:	0712                	slli	a4,a4,0x4
    382a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    382c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    3830:	00000717          	auipc	a4,0x0
    3834:	7ca73823          	sd	a0,2000(a4) # 4000 <freep>
      return (void*)(p + 1);
    3838:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    383c:	70e2                	ld	ra,56(sp)
    383e:	7442                	ld	s0,48(sp)
    3840:	74a2                	ld	s1,40(sp)
    3842:	7902                	ld	s2,32(sp)
    3844:	69e2                	ld	s3,24(sp)
    3846:	6a42                	ld	s4,16(sp)
    3848:	6aa2                	ld	s5,8(sp)
    384a:	6b02                	ld	s6,0(sp)
    384c:	6121                	addi	sp,sp,64
    384e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3850:	6398                	ld	a4,0(a5)
    3852:	e118                	sd	a4,0(a0)
    3854:	bff1                	j	3830 <malloc+0x86>
  hp->s.size = nu;
    3856:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    385a:	0541                	addi	a0,a0,16
    385c:	00000097          	auipc	ra,0x0
    3860:	ec6080e7          	jalr	-314(ra) # 3722 <free>
  return freep;
    3864:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    3868:	d971                	beqz	a0,383c <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    386a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    386c:	4798                	lw	a4,8(a5)
    386e:	fa9776e3          	bgeu	a4,s1,381a <malloc+0x70>
    if(p == freep)
    3872:	00093703          	ld	a4,0(s2)
    3876:	853e                	mv	a0,a5
    3878:	fef719e3          	bne	a4,a5,386a <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    387c:	8552                	mv	a0,s4
    387e:	00000097          	auipc	ra,0x0
    3882:	b56080e7          	jalr	-1194(ra) # 33d4 <sbrk>
  if(p == (char*)-1)
    3886:	fd5518e3          	bne	a0,s5,3856 <malloc+0xac>
        return 0;
    388a:	4501                	li	a0,0
    388c:	bf45                	j	383c <malloc+0x92>
