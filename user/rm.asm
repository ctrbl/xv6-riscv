
user/_rm:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
    3000:	7179                	addi	sp,sp,-48
    3002:	f406                	sd	ra,40(sp)
    3004:	f022                	sd	s0,32(sp)
    3006:	ec26                	sd	s1,24(sp)
    3008:	e84a                	sd	s2,16(sp)
    300a:	e44e                	sd	s3,8(sp)
    300c:	1800                	addi	s0,sp,48
  int i;

  if(argc < 2){
    300e:	4785                	li	a5,1
    3010:	02a7d763          	bge	a5,a0,303e <main+0x3e>
    3014:	00858493          	addi	s1,a1,8
    3018:	ffe5091b          	addiw	s2,a0,-2
    301c:	1902                	slli	s2,s2,0x20
    301e:	02095913          	srli	s2,s2,0x20
    3022:	090e                	slli	s2,s2,0x3
    3024:	05c1                	addi	a1,a1,16
    3026:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: rm files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
    3028:	6088                	ld	a0,0(s1)
    302a:	00000097          	auipc	ra,0x0
    302e:	386080e7          	jalr	902(ra) # 33b0 <unlink>
    3032:	02054463          	bltz	a0,305a <main+0x5a>
  for(i = 1; i < argc; i++){
    3036:	04a1                	addi	s1,s1,8
    3038:	ff2498e3          	bne	s1,s2,3028 <main+0x28>
    303c:	a80d                	j	306e <main+0x6e>
    fprintf(2, "Usage: rm files...\n");
    303e:	00001597          	auipc	a1,0x1
    3042:	87258593          	addi	a1,a1,-1934 # 38b0 <malloc+0xf2>
    3046:	4509                	li	a0,2
    3048:	00000097          	auipc	ra,0x0
    304c:	68a080e7          	jalr	1674(ra) # 36d2 <fprintf>
    exit(1);
    3050:	4505                	li	a0,1
    3052:	00000097          	auipc	ra,0x0
    3056:	306080e7          	jalr	774(ra) # 3358 <exit>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
    305a:	6090                	ld	a2,0(s1)
    305c:	00001597          	auipc	a1,0x1
    3060:	86c58593          	addi	a1,a1,-1940 # 38c8 <malloc+0x10a>
    3064:	4509                	li	a0,2
    3066:	00000097          	auipc	ra,0x0
    306a:	66c080e7          	jalr	1644(ra) # 36d2 <fprintf>
      break;
    }
  }

  exit(0);
    306e:	4501                	li	a0,0
    3070:	00000097          	auipc	ra,0x0
    3074:	2e8080e7          	jalr	744(ra) # 3358 <exit>

0000000000003078 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    3078:	1141                	addi	sp,sp,-16
    307a:	e406                	sd	ra,8(sp)
    307c:	e022                	sd	s0,0(sp)
    307e:	0800                	addi	s0,sp,16
  extern int main();
  main();
    3080:	00000097          	auipc	ra,0x0
    3084:	f80080e7          	jalr	-128(ra) # 3000 <main>
  exit(0);
    3088:	4501                	li	a0,0
    308a:	00000097          	auipc	ra,0x0
    308e:	2ce080e7          	jalr	718(ra) # 3358 <exit>

0000000000003092 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3092:	1141                	addi	sp,sp,-16
    3094:	e422                	sd	s0,8(sp)
    3096:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3098:	87aa                	mv	a5,a0
    309a:	0585                	addi	a1,a1,1
    309c:	0785                	addi	a5,a5,1
    309e:	fff5c703          	lbu	a4,-1(a1)
    30a2:	fee78fa3          	sb	a4,-1(a5)
    30a6:	fb75                	bnez	a4,309a <strcpy+0x8>
    ;
  return os;
}
    30a8:	6422                	ld	s0,8(sp)
    30aa:	0141                	addi	sp,sp,16
    30ac:	8082                	ret

00000000000030ae <strcmp>:

int
strcmp(const char *p, const char *q)
{
    30ae:	1141                	addi	sp,sp,-16
    30b0:	e422                	sd	s0,8(sp)
    30b2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    30b4:	00054783          	lbu	a5,0(a0)
    30b8:	cb91                	beqz	a5,30cc <strcmp+0x1e>
    30ba:	0005c703          	lbu	a4,0(a1)
    30be:	00f71763          	bne	a4,a5,30cc <strcmp+0x1e>
    p++, q++;
    30c2:	0505                	addi	a0,a0,1
    30c4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    30c6:	00054783          	lbu	a5,0(a0)
    30ca:	fbe5                	bnez	a5,30ba <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    30cc:	0005c503          	lbu	a0,0(a1)
}
    30d0:	40a7853b          	subw	a0,a5,a0
    30d4:	6422                	ld	s0,8(sp)
    30d6:	0141                	addi	sp,sp,16
    30d8:	8082                	ret

00000000000030da <strlen>:

uint
strlen(const char *s)
{
    30da:	1141                	addi	sp,sp,-16
    30dc:	e422                	sd	s0,8(sp)
    30de:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    30e0:	00054783          	lbu	a5,0(a0)
    30e4:	cf91                	beqz	a5,3100 <strlen+0x26>
    30e6:	0505                	addi	a0,a0,1
    30e8:	87aa                	mv	a5,a0
    30ea:	4685                	li	a3,1
    30ec:	9e89                	subw	a3,a3,a0
    30ee:	00f6853b          	addw	a0,a3,a5
    30f2:	0785                	addi	a5,a5,1
    30f4:	fff7c703          	lbu	a4,-1(a5)
    30f8:	fb7d                	bnez	a4,30ee <strlen+0x14>
    ;
  return n;
}
    30fa:	6422                	ld	s0,8(sp)
    30fc:	0141                	addi	sp,sp,16
    30fe:	8082                	ret
  for(n = 0; s[n]; n++)
    3100:	4501                	li	a0,0
    3102:	bfe5                	j	30fa <strlen+0x20>

0000000000003104 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3104:	1141                	addi	sp,sp,-16
    3106:	e422                	sd	s0,8(sp)
    3108:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    310a:	ca19                	beqz	a2,3120 <memset+0x1c>
    310c:	87aa                	mv	a5,a0
    310e:	1602                	slli	a2,a2,0x20
    3110:	9201                	srli	a2,a2,0x20
    3112:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    3116:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    311a:	0785                	addi	a5,a5,1
    311c:	fee79de3          	bne	a5,a4,3116 <memset+0x12>
  }
  return dst;
}
    3120:	6422                	ld	s0,8(sp)
    3122:	0141                	addi	sp,sp,16
    3124:	8082                	ret

0000000000003126 <strchr>:

char*
strchr(const char *s, char c)
{
    3126:	1141                	addi	sp,sp,-16
    3128:	e422                	sd	s0,8(sp)
    312a:	0800                	addi	s0,sp,16
  for(; *s; s++)
    312c:	00054783          	lbu	a5,0(a0)
    3130:	cb99                	beqz	a5,3146 <strchr+0x20>
    if(*s == c)
    3132:	00f58763          	beq	a1,a5,3140 <strchr+0x1a>
  for(; *s; s++)
    3136:	0505                	addi	a0,a0,1
    3138:	00054783          	lbu	a5,0(a0)
    313c:	fbfd                	bnez	a5,3132 <strchr+0xc>
      return (char*)s;
  return 0;
    313e:	4501                	li	a0,0
}
    3140:	6422                	ld	s0,8(sp)
    3142:	0141                	addi	sp,sp,16
    3144:	8082                	ret
  return 0;
    3146:	4501                	li	a0,0
    3148:	bfe5                	j	3140 <strchr+0x1a>

000000000000314a <gets>:

char*
gets(char *buf, int max)
{
    314a:	711d                	addi	sp,sp,-96
    314c:	ec86                	sd	ra,88(sp)
    314e:	e8a2                	sd	s0,80(sp)
    3150:	e4a6                	sd	s1,72(sp)
    3152:	e0ca                	sd	s2,64(sp)
    3154:	fc4e                	sd	s3,56(sp)
    3156:	f852                	sd	s4,48(sp)
    3158:	f456                	sd	s5,40(sp)
    315a:	f05a                	sd	s6,32(sp)
    315c:	ec5e                	sd	s7,24(sp)
    315e:	1080                	addi	s0,sp,96
    3160:	8baa                	mv	s7,a0
    3162:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3164:	892a                	mv	s2,a0
    3166:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3168:	4aa9                	li	s5,10
    316a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    316c:	89a6                	mv	s3,s1
    316e:	2485                	addiw	s1,s1,1
    3170:	0344d863          	bge	s1,s4,31a0 <gets+0x56>
    cc = read(0, &c, 1);
    3174:	4605                	li	a2,1
    3176:	faf40593          	addi	a1,s0,-81
    317a:	4501                	li	a0,0
    317c:	00000097          	auipc	ra,0x0
    3180:	1fc080e7          	jalr	508(ra) # 3378 <read>
    if(cc < 1)
    3184:	00a05e63          	blez	a0,31a0 <gets+0x56>
    buf[i++] = c;
    3188:	faf44783          	lbu	a5,-81(s0)
    318c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3190:	01578763          	beq	a5,s5,319e <gets+0x54>
    3194:	0905                	addi	s2,s2,1
    3196:	fd679be3          	bne	a5,s6,316c <gets+0x22>
  for(i=0; i+1 < max; ){
    319a:	89a6                	mv	s3,s1
    319c:	a011                	j	31a0 <gets+0x56>
    319e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    31a0:	99de                	add	s3,s3,s7
    31a2:	00098023          	sb	zero,0(s3)
  return buf;
}
    31a6:	855e                	mv	a0,s7
    31a8:	60e6                	ld	ra,88(sp)
    31aa:	6446                	ld	s0,80(sp)
    31ac:	64a6                	ld	s1,72(sp)
    31ae:	6906                	ld	s2,64(sp)
    31b0:	79e2                	ld	s3,56(sp)
    31b2:	7a42                	ld	s4,48(sp)
    31b4:	7aa2                	ld	s5,40(sp)
    31b6:	7b02                	ld	s6,32(sp)
    31b8:	6be2                	ld	s7,24(sp)
    31ba:	6125                	addi	sp,sp,96
    31bc:	8082                	ret

00000000000031be <stat>:

int
stat(const char *n, struct stat *st)
{
    31be:	1101                	addi	sp,sp,-32
    31c0:	ec06                	sd	ra,24(sp)
    31c2:	e822                	sd	s0,16(sp)
    31c4:	e426                	sd	s1,8(sp)
    31c6:	e04a                	sd	s2,0(sp)
    31c8:	1000                	addi	s0,sp,32
    31ca:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    31cc:	4581                	li	a1,0
    31ce:	00000097          	auipc	ra,0x0
    31d2:	1d2080e7          	jalr	466(ra) # 33a0 <open>
  if(fd < 0)
    31d6:	02054563          	bltz	a0,3200 <stat+0x42>
    31da:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    31dc:	85ca                	mv	a1,s2
    31de:	00000097          	auipc	ra,0x0
    31e2:	1da080e7          	jalr	474(ra) # 33b8 <fstat>
    31e6:	892a                	mv	s2,a0
  close(fd);
    31e8:	8526                	mv	a0,s1
    31ea:	00000097          	auipc	ra,0x0
    31ee:	19e080e7          	jalr	414(ra) # 3388 <close>
  return r;
}
    31f2:	854a                	mv	a0,s2
    31f4:	60e2                	ld	ra,24(sp)
    31f6:	6442                	ld	s0,16(sp)
    31f8:	64a2                	ld	s1,8(sp)
    31fa:	6902                	ld	s2,0(sp)
    31fc:	6105                	addi	sp,sp,32
    31fe:	8082                	ret
    return -1;
    3200:	597d                	li	s2,-1
    3202:	bfc5                	j	31f2 <stat+0x34>

0000000000003204 <atoi>:

int
atoi(const char *s)
{
    3204:	1141                	addi	sp,sp,-16
    3206:	e422                	sd	s0,8(sp)
    3208:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    320a:	00054603          	lbu	a2,0(a0)
    320e:	fd06079b          	addiw	a5,a2,-48
    3212:	0ff7f793          	andi	a5,a5,255
    3216:	4725                	li	a4,9
    3218:	02f76963          	bltu	a4,a5,324a <atoi+0x46>
    321c:	86aa                	mv	a3,a0
  n = 0;
    321e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    3220:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    3222:	0685                	addi	a3,a3,1
    3224:	0025179b          	slliw	a5,a0,0x2
    3228:	9fa9                	addw	a5,a5,a0
    322a:	0017979b          	slliw	a5,a5,0x1
    322e:	9fb1                	addw	a5,a5,a2
    3230:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    3234:	0006c603          	lbu	a2,0(a3)
    3238:	fd06071b          	addiw	a4,a2,-48
    323c:	0ff77713          	andi	a4,a4,255
    3240:	fee5f1e3          	bgeu	a1,a4,3222 <atoi+0x1e>
  return n;
}
    3244:	6422                	ld	s0,8(sp)
    3246:	0141                	addi	sp,sp,16
    3248:	8082                	ret
  n = 0;
    324a:	4501                	li	a0,0
    324c:	bfe5                	j	3244 <atoi+0x40>

000000000000324e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    324e:	1141                	addi	sp,sp,-16
    3250:	e422                	sd	s0,8(sp)
    3252:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    3254:	02b57463          	bgeu	a0,a1,327c <memmove+0x2e>
    while(n-- > 0)
    3258:	00c05f63          	blez	a2,3276 <memmove+0x28>
    325c:	1602                	slli	a2,a2,0x20
    325e:	9201                	srli	a2,a2,0x20
    3260:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    3264:	872a                	mv	a4,a0
      *dst++ = *src++;
    3266:	0585                	addi	a1,a1,1
    3268:	0705                	addi	a4,a4,1
    326a:	fff5c683          	lbu	a3,-1(a1)
    326e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3272:	fee79ae3          	bne	a5,a4,3266 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    3276:	6422                	ld	s0,8(sp)
    3278:	0141                	addi	sp,sp,16
    327a:	8082                	ret
    dst += n;
    327c:	00c50733          	add	a4,a0,a2
    src += n;
    3280:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    3282:	fec05ae3          	blez	a2,3276 <memmove+0x28>
    3286:	fff6079b          	addiw	a5,a2,-1
    328a:	1782                	slli	a5,a5,0x20
    328c:	9381                	srli	a5,a5,0x20
    328e:	fff7c793          	not	a5,a5
    3292:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3294:	15fd                	addi	a1,a1,-1
    3296:	177d                	addi	a4,a4,-1
    3298:	0005c683          	lbu	a3,0(a1)
    329c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    32a0:	fee79ae3          	bne	a5,a4,3294 <memmove+0x46>
    32a4:	bfc9                	j	3276 <memmove+0x28>

00000000000032a6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    32a6:	1141                	addi	sp,sp,-16
    32a8:	e422                	sd	s0,8(sp)
    32aa:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    32ac:	ca05                	beqz	a2,32dc <memcmp+0x36>
    32ae:	fff6069b          	addiw	a3,a2,-1
    32b2:	1682                	slli	a3,a3,0x20
    32b4:	9281                	srli	a3,a3,0x20
    32b6:	0685                	addi	a3,a3,1
    32b8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    32ba:	00054783          	lbu	a5,0(a0)
    32be:	0005c703          	lbu	a4,0(a1)
    32c2:	00e79863          	bne	a5,a4,32d2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    32c6:	0505                	addi	a0,a0,1
    p2++;
    32c8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    32ca:	fed518e3          	bne	a0,a3,32ba <memcmp+0x14>
  }
  return 0;
    32ce:	4501                	li	a0,0
    32d0:	a019                	j	32d6 <memcmp+0x30>
      return *p1 - *p2;
    32d2:	40e7853b          	subw	a0,a5,a4
}
    32d6:	6422                	ld	s0,8(sp)
    32d8:	0141                	addi	sp,sp,16
    32da:	8082                	ret
  return 0;
    32dc:	4501                	li	a0,0
    32de:	bfe5                	j	32d6 <memcmp+0x30>

00000000000032e0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    32e0:	1141                	addi	sp,sp,-16
    32e2:	e406                	sd	ra,8(sp)
    32e4:	e022                	sd	s0,0(sp)
    32e6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    32e8:	00000097          	auipc	ra,0x0
    32ec:	f66080e7          	jalr	-154(ra) # 324e <memmove>
}
    32f0:	60a2                	ld	ra,8(sp)
    32f2:	6402                	ld	s0,0(sp)
    32f4:	0141                	addi	sp,sp,16
    32f6:	8082                	ret

00000000000032f8 <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    32f8:	1141                	addi	sp,sp,-16
    32fa:	e422                	sd	s0,8(sp)
    32fc:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    32fe:	00052023          	sw	zero,0(a0)
}  
    3302:	6422                	ld	s0,8(sp)
    3304:	0141                	addi	sp,sp,16
    3306:	8082                	ret

0000000000003308 <lock>:

void lock(struct spinlock * lk) 
{    
    3308:	1141                	addi	sp,sp,-16
    330a:	e422                	sd	s0,8(sp)
    330c:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    330e:	4705                	li	a4,1
    3310:	87ba                	mv	a5,a4
    3312:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    3316:	2781                	sext.w	a5,a5
    3318:	ffe5                	bnez	a5,3310 <lock+0x8>
}  
    331a:	6422                	ld	s0,8(sp)
    331c:	0141                	addi	sp,sp,16
    331e:	8082                	ret

0000000000003320 <unlock>:

void unlock(struct spinlock * lk) 
{   
    3320:	1141                	addi	sp,sp,-16
    3322:	e422                	sd	s0,8(sp)
    3324:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    3326:	0f50000f          	fence	iorw,ow
    332a:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    332e:	6422                	ld	s0,8(sp)
    3330:	0141                	addi	sp,sp,16
    3332:	8082                	ret

0000000000003334 <isDigit>:

unsigned int isDigit(char *c) {
    3334:	1141                	addi	sp,sp,-16
    3336:	e422                	sd	s0,8(sp)
    3338:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    333a:	00054503          	lbu	a0,0(a0)
    333e:	fd05051b          	addiw	a0,a0,-48
    3342:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    3346:	00a53513          	sltiu	a0,a0,10
    334a:	6422                	ld	s0,8(sp)
    334c:	0141                	addi	sp,sp,16
    334e:	8082                	ret

0000000000003350 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    3350:	4885                	li	a7,1
 ecall
    3352:	00000073          	ecall
 ret
    3356:	8082                	ret

0000000000003358 <exit>:
.global exit
exit:
 li a7, SYS_exit
    3358:	4889                	li	a7,2
 ecall
    335a:	00000073          	ecall
 ret
    335e:	8082                	ret

0000000000003360 <wait>:
.global wait
wait:
 li a7, SYS_wait
    3360:	488d                	li	a7,3
 ecall
    3362:	00000073          	ecall
 ret
    3366:	8082                	ret

0000000000003368 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    3368:	48e1                	li	a7,24
 ecall
    336a:	00000073          	ecall
 ret
    336e:	8082                	ret

0000000000003370 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    3370:	4891                	li	a7,4
 ecall
    3372:	00000073          	ecall
 ret
    3376:	8082                	ret

0000000000003378 <read>:
.global read
read:
 li a7, SYS_read
    3378:	4895                	li	a7,5
 ecall
    337a:	00000073          	ecall
 ret
    337e:	8082                	ret

0000000000003380 <write>:
.global write
write:
 li a7, SYS_write
    3380:	48c1                	li	a7,16
 ecall
    3382:	00000073          	ecall
 ret
    3386:	8082                	ret

0000000000003388 <close>:
.global close
close:
 li a7, SYS_close
    3388:	48d5                	li	a7,21
 ecall
    338a:	00000073          	ecall
 ret
    338e:	8082                	ret

0000000000003390 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3390:	4899                	li	a7,6
 ecall
    3392:	00000073          	ecall
 ret
    3396:	8082                	ret

0000000000003398 <exec>:
.global exec
exec:
 li a7, SYS_exec
    3398:	489d                	li	a7,7
 ecall
    339a:	00000073          	ecall
 ret
    339e:	8082                	ret

00000000000033a0 <open>:
.global open
open:
 li a7, SYS_open
    33a0:	48bd                	li	a7,15
 ecall
    33a2:	00000073          	ecall
 ret
    33a6:	8082                	ret

00000000000033a8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    33a8:	48c5                	li	a7,17
 ecall
    33aa:	00000073          	ecall
 ret
    33ae:	8082                	ret

00000000000033b0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    33b0:	48c9                	li	a7,18
 ecall
    33b2:	00000073          	ecall
 ret
    33b6:	8082                	ret

00000000000033b8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    33b8:	48a1                	li	a7,8
 ecall
    33ba:	00000073          	ecall
 ret
    33be:	8082                	ret

00000000000033c0 <link>:
.global link
link:
 li a7, SYS_link
    33c0:	48cd                	li	a7,19
 ecall
    33c2:	00000073          	ecall
 ret
    33c6:	8082                	ret

00000000000033c8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    33c8:	48d1                	li	a7,20
 ecall
    33ca:	00000073          	ecall
 ret
    33ce:	8082                	ret

00000000000033d0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    33d0:	48a5                	li	a7,9
 ecall
    33d2:	00000073          	ecall
 ret
    33d6:	8082                	ret

00000000000033d8 <dup>:
.global dup
dup:
 li a7, SYS_dup
    33d8:	48a9                	li	a7,10
 ecall
    33da:	00000073          	ecall
 ret
    33de:	8082                	ret

00000000000033e0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    33e0:	48ad                	li	a7,11
 ecall
    33e2:	00000073          	ecall
 ret
    33e6:	8082                	ret

00000000000033e8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    33e8:	48b1                	li	a7,12
 ecall
    33ea:	00000073          	ecall
 ret
    33ee:	8082                	ret

00000000000033f0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    33f0:	48b5                	li	a7,13
 ecall
    33f2:	00000073          	ecall
 ret
    33f6:	8082                	ret

00000000000033f8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    33f8:	48b9                	li	a7,14
 ecall
    33fa:	00000073          	ecall
 ret
    33fe:	8082                	ret

0000000000003400 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    3400:	48d9                	li	a7,22
 ecall
    3402:	00000073          	ecall
 ret
    3406:	8082                	ret

0000000000003408 <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    3408:	48dd                	li	a7,23
 ecall
    340a:	00000073          	ecall
 ret
    340e:	8082                	ret

0000000000003410 <ps>:
.global ps
ps:
 li a7, SYS_ps
    3410:	48e5                	li	a7,25
 ecall
    3412:	00000073          	ecall
 ret
    3416:	8082                	ret

0000000000003418 <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    3418:	48e9                	li	a7,26
 ecall
    341a:	00000073          	ecall
 ret
    341e:	8082                	ret

0000000000003420 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    3420:	48ed                	li	a7,27
 ecall
    3422:	00000073          	ecall
 ret
    3426:	8082                	ret

0000000000003428 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    3428:	1101                	addi	sp,sp,-32
    342a:	ec06                	sd	ra,24(sp)
    342c:	e822                	sd	s0,16(sp)
    342e:	1000                	addi	s0,sp,32
    3430:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    3434:	4605                	li	a2,1
    3436:	fef40593          	addi	a1,s0,-17
    343a:	00000097          	auipc	ra,0x0
    343e:	f46080e7          	jalr	-186(ra) # 3380 <write>
}
    3442:	60e2                	ld	ra,24(sp)
    3444:	6442                	ld	s0,16(sp)
    3446:	6105                	addi	sp,sp,32
    3448:	8082                	ret

000000000000344a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    344a:	7139                	addi	sp,sp,-64
    344c:	fc06                	sd	ra,56(sp)
    344e:	f822                	sd	s0,48(sp)
    3450:	f426                	sd	s1,40(sp)
    3452:	f04a                	sd	s2,32(sp)
    3454:	ec4e                	sd	s3,24(sp)
    3456:	0080                	addi	s0,sp,64
    3458:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    345a:	c299                	beqz	a3,3460 <printint+0x16>
    345c:	0805c863          	bltz	a1,34ec <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3460:	2581                	sext.w	a1,a1
  neg = 0;
    3462:	4881                	li	a7,0
    3464:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    3468:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    346a:	2601                	sext.w	a2,a2
    346c:	00000517          	auipc	a0,0x0
    3470:	48450513          	addi	a0,a0,1156 # 38f0 <digits>
    3474:	883a                	mv	a6,a4
    3476:	2705                	addiw	a4,a4,1
    3478:	02c5f7bb          	remuw	a5,a1,a2
    347c:	1782                	slli	a5,a5,0x20
    347e:	9381                	srli	a5,a5,0x20
    3480:	97aa                	add	a5,a5,a0
    3482:	0007c783          	lbu	a5,0(a5)
    3486:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    348a:	0005879b          	sext.w	a5,a1
    348e:	02c5d5bb          	divuw	a1,a1,a2
    3492:	0685                	addi	a3,a3,1
    3494:	fec7f0e3          	bgeu	a5,a2,3474 <printint+0x2a>
  if(neg)
    3498:	00088b63          	beqz	a7,34ae <printint+0x64>
    buf[i++] = '-';
    349c:	fd040793          	addi	a5,s0,-48
    34a0:	973e                	add	a4,a4,a5
    34a2:	02d00793          	li	a5,45
    34a6:	fef70823          	sb	a5,-16(a4)
    34aa:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    34ae:	02e05863          	blez	a4,34de <printint+0x94>
    34b2:	fc040793          	addi	a5,s0,-64
    34b6:	00e78933          	add	s2,a5,a4
    34ba:	fff78993          	addi	s3,a5,-1
    34be:	99ba                	add	s3,s3,a4
    34c0:	377d                	addiw	a4,a4,-1
    34c2:	1702                	slli	a4,a4,0x20
    34c4:	9301                	srli	a4,a4,0x20
    34c6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    34ca:	fff94583          	lbu	a1,-1(s2)
    34ce:	8526                	mv	a0,s1
    34d0:	00000097          	auipc	ra,0x0
    34d4:	f58080e7          	jalr	-168(ra) # 3428 <putc>
  while(--i >= 0)
    34d8:	197d                	addi	s2,s2,-1
    34da:	ff3918e3          	bne	s2,s3,34ca <printint+0x80>
}
    34de:	70e2                	ld	ra,56(sp)
    34e0:	7442                	ld	s0,48(sp)
    34e2:	74a2                	ld	s1,40(sp)
    34e4:	7902                	ld	s2,32(sp)
    34e6:	69e2                	ld	s3,24(sp)
    34e8:	6121                	addi	sp,sp,64
    34ea:	8082                	ret
    x = -xx;
    34ec:	40b005bb          	negw	a1,a1
    neg = 1;
    34f0:	4885                	li	a7,1
    x = -xx;
    34f2:	bf8d                	j	3464 <printint+0x1a>

00000000000034f4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    34f4:	7119                	addi	sp,sp,-128
    34f6:	fc86                	sd	ra,120(sp)
    34f8:	f8a2                	sd	s0,112(sp)
    34fa:	f4a6                	sd	s1,104(sp)
    34fc:	f0ca                	sd	s2,96(sp)
    34fe:	ecce                	sd	s3,88(sp)
    3500:	e8d2                	sd	s4,80(sp)
    3502:	e4d6                	sd	s5,72(sp)
    3504:	e0da                	sd	s6,64(sp)
    3506:	fc5e                	sd	s7,56(sp)
    3508:	f862                	sd	s8,48(sp)
    350a:	f466                	sd	s9,40(sp)
    350c:	f06a                	sd	s10,32(sp)
    350e:	ec6e                	sd	s11,24(sp)
    3510:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    3512:	0005c903          	lbu	s2,0(a1)
    3516:	18090f63          	beqz	s2,36b4 <vprintf+0x1c0>
    351a:	8aaa                	mv	s5,a0
    351c:	8b32                	mv	s6,a2
    351e:	00158493          	addi	s1,a1,1
  state = 0;
    3522:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3524:	02500a13          	li	s4,37
      if(c == 'd'){
    3528:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    352c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    3530:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    3534:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3538:	00000b97          	auipc	s7,0x0
    353c:	3b8b8b93          	addi	s7,s7,952 # 38f0 <digits>
    3540:	a839                	j	355e <vprintf+0x6a>
        putc(fd, c);
    3542:	85ca                	mv	a1,s2
    3544:	8556                	mv	a0,s5
    3546:	00000097          	auipc	ra,0x0
    354a:	ee2080e7          	jalr	-286(ra) # 3428 <putc>
    354e:	a019                	j	3554 <vprintf+0x60>
    } else if(state == '%'){
    3550:	01498f63          	beq	s3,s4,356e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    3554:	0485                	addi	s1,s1,1
    3556:	fff4c903          	lbu	s2,-1(s1)
    355a:	14090d63          	beqz	s2,36b4 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    355e:	0009079b          	sext.w	a5,s2
    if(state == 0){
    3562:	fe0997e3          	bnez	s3,3550 <vprintf+0x5c>
      if(c == '%'){
    3566:	fd479ee3          	bne	a5,s4,3542 <vprintf+0x4e>
        state = '%';
    356a:	89be                	mv	s3,a5
    356c:	b7e5                	j	3554 <vprintf+0x60>
      if(c == 'd'){
    356e:	05878063          	beq	a5,s8,35ae <vprintf+0xba>
      } else if(c == 'l') {
    3572:	05978c63          	beq	a5,s9,35ca <vprintf+0xd6>
      } else if(c == 'x') {
    3576:	07a78863          	beq	a5,s10,35e6 <vprintf+0xf2>
      } else if(c == 'p') {
    357a:	09b78463          	beq	a5,s11,3602 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    357e:	07300713          	li	a4,115
    3582:	0ce78663          	beq	a5,a4,364e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3586:	06300713          	li	a4,99
    358a:	0ee78e63          	beq	a5,a4,3686 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    358e:	11478863          	beq	a5,s4,369e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3592:	85d2                	mv	a1,s4
    3594:	8556                	mv	a0,s5
    3596:	00000097          	auipc	ra,0x0
    359a:	e92080e7          	jalr	-366(ra) # 3428 <putc>
        putc(fd, c);
    359e:	85ca                	mv	a1,s2
    35a0:	8556                	mv	a0,s5
    35a2:	00000097          	auipc	ra,0x0
    35a6:	e86080e7          	jalr	-378(ra) # 3428 <putc>
      }
      state = 0;
    35aa:	4981                	li	s3,0
    35ac:	b765                	j	3554 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    35ae:	008b0913          	addi	s2,s6,8
    35b2:	4685                	li	a3,1
    35b4:	4629                	li	a2,10
    35b6:	000b2583          	lw	a1,0(s6)
    35ba:	8556                	mv	a0,s5
    35bc:	00000097          	auipc	ra,0x0
    35c0:	e8e080e7          	jalr	-370(ra) # 344a <printint>
    35c4:	8b4a                	mv	s6,s2
      state = 0;
    35c6:	4981                	li	s3,0
    35c8:	b771                	j	3554 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    35ca:	008b0913          	addi	s2,s6,8
    35ce:	4681                	li	a3,0
    35d0:	4629                	li	a2,10
    35d2:	000b2583          	lw	a1,0(s6)
    35d6:	8556                	mv	a0,s5
    35d8:	00000097          	auipc	ra,0x0
    35dc:	e72080e7          	jalr	-398(ra) # 344a <printint>
    35e0:	8b4a                	mv	s6,s2
      state = 0;
    35e2:	4981                	li	s3,0
    35e4:	bf85                	j	3554 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    35e6:	008b0913          	addi	s2,s6,8
    35ea:	4681                	li	a3,0
    35ec:	4641                	li	a2,16
    35ee:	000b2583          	lw	a1,0(s6)
    35f2:	8556                	mv	a0,s5
    35f4:	00000097          	auipc	ra,0x0
    35f8:	e56080e7          	jalr	-426(ra) # 344a <printint>
    35fc:	8b4a                	mv	s6,s2
      state = 0;
    35fe:	4981                	li	s3,0
    3600:	bf91                	j	3554 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    3602:	008b0793          	addi	a5,s6,8
    3606:	f8f43423          	sd	a5,-120(s0)
    360a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    360e:	03000593          	li	a1,48
    3612:	8556                	mv	a0,s5
    3614:	00000097          	auipc	ra,0x0
    3618:	e14080e7          	jalr	-492(ra) # 3428 <putc>
  putc(fd, 'x');
    361c:	85ea                	mv	a1,s10
    361e:	8556                	mv	a0,s5
    3620:	00000097          	auipc	ra,0x0
    3624:	e08080e7          	jalr	-504(ra) # 3428 <putc>
    3628:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    362a:	03c9d793          	srli	a5,s3,0x3c
    362e:	97de                	add	a5,a5,s7
    3630:	0007c583          	lbu	a1,0(a5)
    3634:	8556                	mv	a0,s5
    3636:	00000097          	auipc	ra,0x0
    363a:	df2080e7          	jalr	-526(ra) # 3428 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    363e:	0992                	slli	s3,s3,0x4
    3640:	397d                	addiw	s2,s2,-1
    3642:	fe0914e3          	bnez	s2,362a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    3646:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    364a:	4981                	li	s3,0
    364c:	b721                	j	3554 <vprintf+0x60>
        s = va_arg(ap, char*);
    364e:	008b0993          	addi	s3,s6,8
    3652:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    3656:	02090163          	beqz	s2,3678 <vprintf+0x184>
        while(*s != 0){
    365a:	00094583          	lbu	a1,0(s2)
    365e:	c9a1                	beqz	a1,36ae <vprintf+0x1ba>
          putc(fd, *s);
    3660:	8556                	mv	a0,s5
    3662:	00000097          	auipc	ra,0x0
    3666:	dc6080e7          	jalr	-570(ra) # 3428 <putc>
          s++;
    366a:	0905                	addi	s2,s2,1
        while(*s != 0){
    366c:	00094583          	lbu	a1,0(s2)
    3670:	f9e5                	bnez	a1,3660 <vprintf+0x16c>
        s = va_arg(ap, char*);
    3672:	8b4e                	mv	s6,s3
      state = 0;
    3674:	4981                	li	s3,0
    3676:	bdf9                	j	3554 <vprintf+0x60>
          s = "(null)";
    3678:	00000917          	auipc	s2,0x0
    367c:	27090913          	addi	s2,s2,624 # 38e8 <malloc+0x12a>
        while(*s != 0){
    3680:	02800593          	li	a1,40
    3684:	bff1                	j	3660 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    3686:	008b0913          	addi	s2,s6,8
    368a:	000b4583          	lbu	a1,0(s6)
    368e:	8556                	mv	a0,s5
    3690:	00000097          	auipc	ra,0x0
    3694:	d98080e7          	jalr	-616(ra) # 3428 <putc>
    3698:	8b4a                	mv	s6,s2
      state = 0;
    369a:	4981                	li	s3,0
    369c:	bd65                	j	3554 <vprintf+0x60>
        putc(fd, c);
    369e:	85d2                	mv	a1,s4
    36a0:	8556                	mv	a0,s5
    36a2:	00000097          	auipc	ra,0x0
    36a6:	d86080e7          	jalr	-634(ra) # 3428 <putc>
      state = 0;
    36aa:	4981                	li	s3,0
    36ac:	b565                	j	3554 <vprintf+0x60>
        s = va_arg(ap, char*);
    36ae:	8b4e                	mv	s6,s3
      state = 0;
    36b0:	4981                	li	s3,0
    36b2:	b54d                	j	3554 <vprintf+0x60>
    }
  }
}
    36b4:	70e6                	ld	ra,120(sp)
    36b6:	7446                	ld	s0,112(sp)
    36b8:	74a6                	ld	s1,104(sp)
    36ba:	7906                	ld	s2,96(sp)
    36bc:	69e6                	ld	s3,88(sp)
    36be:	6a46                	ld	s4,80(sp)
    36c0:	6aa6                	ld	s5,72(sp)
    36c2:	6b06                	ld	s6,64(sp)
    36c4:	7be2                	ld	s7,56(sp)
    36c6:	7c42                	ld	s8,48(sp)
    36c8:	7ca2                	ld	s9,40(sp)
    36ca:	7d02                	ld	s10,32(sp)
    36cc:	6de2                	ld	s11,24(sp)
    36ce:	6109                	addi	sp,sp,128
    36d0:	8082                	ret

00000000000036d2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    36d2:	715d                	addi	sp,sp,-80
    36d4:	ec06                	sd	ra,24(sp)
    36d6:	e822                	sd	s0,16(sp)
    36d8:	1000                	addi	s0,sp,32
    36da:	e010                	sd	a2,0(s0)
    36dc:	e414                	sd	a3,8(s0)
    36de:	e818                	sd	a4,16(s0)
    36e0:	ec1c                	sd	a5,24(s0)
    36e2:	03043023          	sd	a6,32(s0)
    36e6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    36ea:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    36ee:	8622                	mv	a2,s0
    36f0:	00000097          	auipc	ra,0x0
    36f4:	e04080e7          	jalr	-508(ra) # 34f4 <vprintf>
}
    36f8:	60e2                	ld	ra,24(sp)
    36fa:	6442                	ld	s0,16(sp)
    36fc:	6161                	addi	sp,sp,80
    36fe:	8082                	ret

0000000000003700 <printf>:

void
printf(const char *fmt, ...)
{
    3700:	711d                	addi	sp,sp,-96
    3702:	ec06                	sd	ra,24(sp)
    3704:	e822                	sd	s0,16(sp)
    3706:	1000                	addi	s0,sp,32
    3708:	e40c                	sd	a1,8(s0)
    370a:	e810                	sd	a2,16(s0)
    370c:	ec14                	sd	a3,24(s0)
    370e:	f018                	sd	a4,32(s0)
    3710:	f41c                	sd	a5,40(s0)
    3712:	03043823          	sd	a6,48(s0)
    3716:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    371a:	00840613          	addi	a2,s0,8
    371e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    3722:	85aa                	mv	a1,a0
    3724:	4505                	li	a0,1
    3726:	00000097          	auipc	ra,0x0
    372a:	dce080e7          	jalr	-562(ra) # 34f4 <vprintf>
}
    372e:	60e2                	ld	ra,24(sp)
    3730:	6442                	ld	s0,16(sp)
    3732:	6125                	addi	sp,sp,96
    3734:	8082                	ret

0000000000003736 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3736:	1141                	addi	sp,sp,-16
    3738:	e422                	sd	s0,8(sp)
    373a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    373c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3740:	00001797          	auipc	a5,0x1
    3744:	8c07b783          	ld	a5,-1856(a5) # 4000 <freep>
    3748:	a805                	j	3778 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    374a:	4618                	lw	a4,8(a2)
    374c:	9db9                	addw	a1,a1,a4
    374e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    3752:	6398                	ld	a4,0(a5)
    3754:	6318                	ld	a4,0(a4)
    3756:	fee53823          	sd	a4,-16(a0)
    375a:	a091                	j	379e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    375c:	ff852703          	lw	a4,-8(a0)
    3760:	9e39                	addw	a2,a2,a4
    3762:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    3764:	ff053703          	ld	a4,-16(a0)
    3768:	e398                	sd	a4,0(a5)
    376a:	a099                	j	37b0 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    376c:	6398                	ld	a4,0(a5)
    376e:	00e7e463          	bltu	a5,a4,3776 <free+0x40>
    3772:	00e6ea63          	bltu	a3,a4,3786 <free+0x50>
{
    3776:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3778:	fed7fae3          	bgeu	a5,a3,376c <free+0x36>
    377c:	6398                	ld	a4,0(a5)
    377e:	00e6e463          	bltu	a3,a4,3786 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3782:	fee7eae3          	bltu	a5,a4,3776 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    3786:	ff852583          	lw	a1,-8(a0)
    378a:	6390                	ld	a2,0(a5)
    378c:	02059713          	slli	a4,a1,0x20
    3790:	9301                	srli	a4,a4,0x20
    3792:	0712                	slli	a4,a4,0x4
    3794:	9736                	add	a4,a4,a3
    3796:	fae60ae3          	beq	a2,a4,374a <free+0x14>
    bp->s.ptr = p->s.ptr;
    379a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    379e:	4790                	lw	a2,8(a5)
    37a0:	02061713          	slli	a4,a2,0x20
    37a4:	9301                	srli	a4,a4,0x20
    37a6:	0712                	slli	a4,a4,0x4
    37a8:	973e                	add	a4,a4,a5
    37aa:	fae689e3          	beq	a3,a4,375c <free+0x26>
  } else
    p->s.ptr = bp;
    37ae:	e394                	sd	a3,0(a5)
  freep = p;
    37b0:	00001717          	auipc	a4,0x1
    37b4:	84f73823          	sd	a5,-1968(a4) # 4000 <freep>
}
    37b8:	6422                	ld	s0,8(sp)
    37ba:	0141                	addi	sp,sp,16
    37bc:	8082                	ret

00000000000037be <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    37be:	7139                	addi	sp,sp,-64
    37c0:	fc06                	sd	ra,56(sp)
    37c2:	f822                	sd	s0,48(sp)
    37c4:	f426                	sd	s1,40(sp)
    37c6:	f04a                	sd	s2,32(sp)
    37c8:	ec4e                	sd	s3,24(sp)
    37ca:	e852                	sd	s4,16(sp)
    37cc:	e456                	sd	s5,8(sp)
    37ce:	e05a                	sd	s6,0(sp)
    37d0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    37d2:	02051493          	slli	s1,a0,0x20
    37d6:	9081                	srli	s1,s1,0x20
    37d8:	04bd                	addi	s1,s1,15
    37da:	8091                	srli	s1,s1,0x4
    37dc:	0014899b          	addiw	s3,s1,1
    37e0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    37e2:	00001517          	auipc	a0,0x1
    37e6:	81e53503          	ld	a0,-2018(a0) # 4000 <freep>
    37ea:	c515                	beqz	a0,3816 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    37ec:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    37ee:	4798                	lw	a4,8(a5)
    37f0:	02977f63          	bgeu	a4,s1,382e <malloc+0x70>
    37f4:	8a4e                	mv	s4,s3
    37f6:	0009871b          	sext.w	a4,s3
    37fa:	6685                	lui	a3,0x1
    37fc:	00d77363          	bgeu	a4,a3,3802 <malloc+0x44>
    3800:	6a05                	lui	s4,0x1
    3802:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    3806:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    380a:	00000917          	auipc	s2,0x0
    380e:	7f690913          	addi	s2,s2,2038 # 4000 <freep>
  if(p == (char*)-1)
    3812:	5afd                	li	s5,-1
    3814:	a88d                	j	3886 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    3816:	00000797          	auipc	a5,0x0
    381a:	7fa78793          	addi	a5,a5,2042 # 4010 <base>
    381e:	00000717          	auipc	a4,0x0
    3822:	7ef73123          	sd	a5,2018(a4) # 4000 <freep>
    3826:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    3828:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    382c:	b7e1                	j	37f4 <malloc+0x36>
      if(p->s.size == nunits)
    382e:	02e48b63          	beq	s1,a4,3864 <malloc+0xa6>
        p->s.size -= nunits;
    3832:	4137073b          	subw	a4,a4,s3
    3836:	c798                	sw	a4,8(a5)
        p += p->s.size;
    3838:	1702                	slli	a4,a4,0x20
    383a:	9301                	srli	a4,a4,0x20
    383c:	0712                	slli	a4,a4,0x4
    383e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    3840:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    3844:	00000717          	auipc	a4,0x0
    3848:	7aa73e23          	sd	a0,1980(a4) # 4000 <freep>
      return (void*)(p + 1);
    384c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3850:	70e2                	ld	ra,56(sp)
    3852:	7442                	ld	s0,48(sp)
    3854:	74a2                	ld	s1,40(sp)
    3856:	7902                	ld	s2,32(sp)
    3858:	69e2                	ld	s3,24(sp)
    385a:	6a42                	ld	s4,16(sp)
    385c:	6aa2                	ld	s5,8(sp)
    385e:	6b02                	ld	s6,0(sp)
    3860:	6121                	addi	sp,sp,64
    3862:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3864:	6398                	ld	a4,0(a5)
    3866:	e118                	sd	a4,0(a0)
    3868:	bff1                	j	3844 <malloc+0x86>
  hp->s.size = nu;
    386a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    386e:	0541                	addi	a0,a0,16
    3870:	00000097          	auipc	ra,0x0
    3874:	ec6080e7          	jalr	-314(ra) # 3736 <free>
  return freep;
    3878:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    387c:	d971                	beqz	a0,3850 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    387e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3880:	4798                	lw	a4,8(a5)
    3882:	fa9776e3          	bgeu	a4,s1,382e <malloc+0x70>
    if(p == freep)
    3886:	00093703          	ld	a4,0(s2)
    388a:	853e                	mv	a0,a5
    388c:	fef719e3          	bne	a4,a5,387e <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3890:	8552                	mv	a0,s4
    3892:	00000097          	auipc	ra,0x0
    3896:	b56080e7          	jalr	-1194(ra) # 33e8 <sbrk>
  if(p == (char*)-1)
    389a:	fd5518e3          	bne	a0,s5,386a <malloc+0xac>
        return 0;
    389e:	4501                	li	a0,0
    38a0:	bf45                	j	3850 <malloc+0x92>
