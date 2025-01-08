
user/_echo:     file format elf64-littleriscv


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
    300c:	e052                	sd	s4,0(sp)
    300e:	1800                	addi	s0,sp,48
  int i;

  for(i = 1; i < argc; i++){
    3010:	4785                	li	a5,1
    3012:	06a7d463          	bge	a5,a0,307a <main+0x7a>
    3016:	00858493          	addi	s1,a1,8
    301a:	ffe5099b          	addiw	s3,a0,-2
    301e:	1982                	slli	s3,s3,0x20
    3020:	0209d993          	srli	s3,s3,0x20
    3024:	098e                	slli	s3,s3,0x3
    3026:	05c1                	addi	a1,a1,16
    3028:	99ae                	add	s3,s3,a1
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
    302a:	00001a17          	auipc	s4,0x1
    302e:	886a0a13          	addi	s4,s4,-1914 # 38b0 <malloc+0xe6>
    write(1, argv[i], strlen(argv[i]));
    3032:	0004b903          	ld	s2,0(s1)
    3036:	854a                	mv	a0,s2
    3038:	00000097          	auipc	ra,0x0
    303c:	0ae080e7          	jalr	174(ra) # 30e6 <strlen>
    3040:	0005061b          	sext.w	a2,a0
    3044:	85ca                	mv	a1,s2
    3046:	4505                	li	a0,1
    3048:	00000097          	auipc	ra,0x0
    304c:	344080e7          	jalr	836(ra) # 338c <write>
    if(i + 1 < argc){
    3050:	04a1                	addi	s1,s1,8
    3052:	01348a63          	beq	s1,s3,3066 <main+0x66>
      write(1, " ", 1);
    3056:	4605                	li	a2,1
    3058:	85d2                	mv	a1,s4
    305a:	4505                	li	a0,1
    305c:	00000097          	auipc	ra,0x0
    3060:	330080e7          	jalr	816(ra) # 338c <write>
  for(i = 1; i < argc; i++){
    3064:	b7f9                	j	3032 <main+0x32>
    } else {
      write(1, "\n", 1);
    3066:	4605                	li	a2,1
    3068:	00001597          	auipc	a1,0x1
    306c:	85058593          	addi	a1,a1,-1968 # 38b8 <malloc+0xee>
    3070:	4505                	li	a0,1
    3072:	00000097          	auipc	ra,0x0
    3076:	31a080e7          	jalr	794(ra) # 338c <write>
    }
  }
  exit(0);
    307a:	4501                	li	a0,0
    307c:	00000097          	auipc	ra,0x0
    3080:	2e8080e7          	jalr	744(ra) # 3364 <exit>

0000000000003084 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    3084:	1141                	addi	sp,sp,-16
    3086:	e406                	sd	ra,8(sp)
    3088:	e022                	sd	s0,0(sp)
    308a:	0800                	addi	s0,sp,16
  extern int main();
  main();
    308c:	00000097          	auipc	ra,0x0
    3090:	f74080e7          	jalr	-140(ra) # 3000 <main>
  exit(0);
    3094:	4501                	li	a0,0
    3096:	00000097          	auipc	ra,0x0
    309a:	2ce080e7          	jalr	718(ra) # 3364 <exit>

000000000000309e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    309e:	1141                	addi	sp,sp,-16
    30a0:	e422                	sd	s0,8(sp)
    30a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    30a4:	87aa                	mv	a5,a0
    30a6:	0585                	addi	a1,a1,1
    30a8:	0785                	addi	a5,a5,1
    30aa:	fff5c703          	lbu	a4,-1(a1)
    30ae:	fee78fa3          	sb	a4,-1(a5)
    30b2:	fb75                	bnez	a4,30a6 <strcpy+0x8>
    ;
  return os;
}
    30b4:	6422                	ld	s0,8(sp)
    30b6:	0141                	addi	sp,sp,16
    30b8:	8082                	ret

00000000000030ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
    30ba:	1141                	addi	sp,sp,-16
    30bc:	e422                	sd	s0,8(sp)
    30be:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    30c0:	00054783          	lbu	a5,0(a0)
    30c4:	cb91                	beqz	a5,30d8 <strcmp+0x1e>
    30c6:	0005c703          	lbu	a4,0(a1)
    30ca:	00f71763          	bne	a4,a5,30d8 <strcmp+0x1e>
    p++, q++;
    30ce:	0505                	addi	a0,a0,1
    30d0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    30d2:	00054783          	lbu	a5,0(a0)
    30d6:	fbe5                	bnez	a5,30c6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    30d8:	0005c503          	lbu	a0,0(a1)
}
    30dc:	40a7853b          	subw	a0,a5,a0
    30e0:	6422                	ld	s0,8(sp)
    30e2:	0141                	addi	sp,sp,16
    30e4:	8082                	ret

00000000000030e6 <strlen>:

uint
strlen(const char *s)
{
    30e6:	1141                	addi	sp,sp,-16
    30e8:	e422                	sd	s0,8(sp)
    30ea:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    30ec:	00054783          	lbu	a5,0(a0)
    30f0:	cf91                	beqz	a5,310c <strlen+0x26>
    30f2:	0505                	addi	a0,a0,1
    30f4:	87aa                	mv	a5,a0
    30f6:	4685                	li	a3,1
    30f8:	9e89                	subw	a3,a3,a0
    30fa:	00f6853b          	addw	a0,a3,a5
    30fe:	0785                	addi	a5,a5,1
    3100:	fff7c703          	lbu	a4,-1(a5)
    3104:	fb7d                	bnez	a4,30fa <strlen+0x14>
    ;
  return n;
}
    3106:	6422                	ld	s0,8(sp)
    3108:	0141                	addi	sp,sp,16
    310a:	8082                	ret
  for(n = 0; s[n]; n++)
    310c:	4501                	li	a0,0
    310e:	bfe5                	j	3106 <strlen+0x20>

0000000000003110 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3110:	1141                	addi	sp,sp,-16
    3112:	e422                	sd	s0,8(sp)
    3114:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    3116:	ca19                	beqz	a2,312c <memset+0x1c>
    3118:	87aa                	mv	a5,a0
    311a:	1602                	slli	a2,a2,0x20
    311c:	9201                	srli	a2,a2,0x20
    311e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    3122:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    3126:	0785                	addi	a5,a5,1
    3128:	fee79de3          	bne	a5,a4,3122 <memset+0x12>
  }
  return dst;
}
    312c:	6422                	ld	s0,8(sp)
    312e:	0141                	addi	sp,sp,16
    3130:	8082                	ret

0000000000003132 <strchr>:

char*
strchr(const char *s, char c)
{
    3132:	1141                	addi	sp,sp,-16
    3134:	e422                	sd	s0,8(sp)
    3136:	0800                	addi	s0,sp,16
  for(; *s; s++)
    3138:	00054783          	lbu	a5,0(a0)
    313c:	cb99                	beqz	a5,3152 <strchr+0x20>
    if(*s == c)
    313e:	00f58763          	beq	a1,a5,314c <strchr+0x1a>
  for(; *s; s++)
    3142:	0505                	addi	a0,a0,1
    3144:	00054783          	lbu	a5,0(a0)
    3148:	fbfd                	bnez	a5,313e <strchr+0xc>
      return (char*)s;
  return 0;
    314a:	4501                	li	a0,0
}
    314c:	6422                	ld	s0,8(sp)
    314e:	0141                	addi	sp,sp,16
    3150:	8082                	ret
  return 0;
    3152:	4501                	li	a0,0
    3154:	bfe5                	j	314c <strchr+0x1a>

0000000000003156 <gets>:

char*
gets(char *buf, int max)
{
    3156:	711d                	addi	sp,sp,-96
    3158:	ec86                	sd	ra,88(sp)
    315a:	e8a2                	sd	s0,80(sp)
    315c:	e4a6                	sd	s1,72(sp)
    315e:	e0ca                	sd	s2,64(sp)
    3160:	fc4e                	sd	s3,56(sp)
    3162:	f852                	sd	s4,48(sp)
    3164:	f456                	sd	s5,40(sp)
    3166:	f05a                	sd	s6,32(sp)
    3168:	ec5e                	sd	s7,24(sp)
    316a:	1080                	addi	s0,sp,96
    316c:	8baa                	mv	s7,a0
    316e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3170:	892a                	mv	s2,a0
    3172:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3174:	4aa9                	li	s5,10
    3176:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    3178:	89a6                	mv	s3,s1
    317a:	2485                	addiw	s1,s1,1
    317c:	0344d863          	bge	s1,s4,31ac <gets+0x56>
    cc = read(0, &c, 1);
    3180:	4605                	li	a2,1
    3182:	faf40593          	addi	a1,s0,-81
    3186:	4501                	li	a0,0
    3188:	00000097          	auipc	ra,0x0
    318c:	1fc080e7          	jalr	508(ra) # 3384 <read>
    if(cc < 1)
    3190:	00a05e63          	blez	a0,31ac <gets+0x56>
    buf[i++] = c;
    3194:	faf44783          	lbu	a5,-81(s0)
    3198:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    319c:	01578763          	beq	a5,s5,31aa <gets+0x54>
    31a0:	0905                	addi	s2,s2,1
    31a2:	fd679be3          	bne	a5,s6,3178 <gets+0x22>
  for(i=0; i+1 < max; ){
    31a6:	89a6                	mv	s3,s1
    31a8:	a011                	j	31ac <gets+0x56>
    31aa:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    31ac:	99de                	add	s3,s3,s7
    31ae:	00098023          	sb	zero,0(s3)
  return buf;
}
    31b2:	855e                	mv	a0,s7
    31b4:	60e6                	ld	ra,88(sp)
    31b6:	6446                	ld	s0,80(sp)
    31b8:	64a6                	ld	s1,72(sp)
    31ba:	6906                	ld	s2,64(sp)
    31bc:	79e2                	ld	s3,56(sp)
    31be:	7a42                	ld	s4,48(sp)
    31c0:	7aa2                	ld	s5,40(sp)
    31c2:	7b02                	ld	s6,32(sp)
    31c4:	6be2                	ld	s7,24(sp)
    31c6:	6125                	addi	sp,sp,96
    31c8:	8082                	ret

00000000000031ca <stat>:

int
stat(const char *n, struct stat *st)
{
    31ca:	1101                	addi	sp,sp,-32
    31cc:	ec06                	sd	ra,24(sp)
    31ce:	e822                	sd	s0,16(sp)
    31d0:	e426                	sd	s1,8(sp)
    31d2:	e04a                	sd	s2,0(sp)
    31d4:	1000                	addi	s0,sp,32
    31d6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    31d8:	4581                	li	a1,0
    31da:	00000097          	auipc	ra,0x0
    31de:	1d2080e7          	jalr	466(ra) # 33ac <open>
  if(fd < 0)
    31e2:	02054563          	bltz	a0,320c <stat+0x42>
    31e6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    31e8:	85ca                	mv	a1,s2
    31ea:	00000097          	auipc	ra,0x0
    31ee:	1da080e7          	jalr	474(ra) # 33c4 <fstat>
    31f2:	892a                	mv	s2,a0
  close(fd);
    31f4:	8526                	mv	a0,s1
    31f6:	00000097          	auipc	ra,0x0
    31fa:	19e080e7          	jalr	414(ra) # 3394 <close>
  return r;
}
    31fe:	854a                	mv	a0,s2
    3200:	60e2                	ld	ra,24(sp)
    3202:	6442                	ld	s0,16(sp)
    3204:	64a2                	ld	s1,8(sp)
    3206:	6902                	ld	s2,0(sp)
    3208:	6105                	addi	sp,sp,32
    320a:	8082                	ret
    return -1;
    320c:	597d                	li	s2,-1
    320e:	bfc5                	j	31fe <stat+0x34>

0000000000003210 <atoi>:

int
atoi(const char *s)
{
    3210:	1141                	addi	sp,sp,-16
    3212:	e422                	sd	s0,8(sp)
    3214:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3216:	00054603          	lbu	a2,0(a0)
    321a:	fd06079b          	addiw	a5,a2,-48
    321e:	0ff7f793          	andi	a5,a5,255
    3222:	4725                	li	a4,9
    3224:	02f76963          	bltu	a4,a5,3256 <atoi+0x46>
    3228:	86aa                	mv	a3,a0
  n = 0;
    322a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    322c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    322e:	0685                	addi	a3,a3,1
    3230:	0025179b          	slliw	a5,a0,0x2
    3234:	9fa9                	addw	a5,a5,a0
    3236:	0017979b          	slliw	a5,a5,0x1
    323a:	9fb1                	addw	a5,a5,a2
    323c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    3240:	0006c603          	lbu	a2,0(a3)
    3244:	fd06071b          	addiw	a4,a2,-48
    3248:	0ff77713          	andi	a4,a4,255
    324c:	fee5f1e3          	bgeu	a1,a4,322e <atoi+0x1e>
  return n;
}
    3250:	6422                	ld	s0,8(sp)
    3252:	0141                	addi	sp,sp,16
    3254:	8082                	ret
  n = 0;
    3256:	4501                	li	a0,0
    3258:	bfe5                	j	3250 <atoi+0x40>

000000000000325a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    325a:	1141                	addi	sp,sp,-16
    325c:	e422                	sd	s0,8(sp)
    325e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    3260:	02b57463          	bgeu	a0,a1,3288 <memmove+0x2e>
    while(n-- > 0)
    3264:	00c05f63          	blez	a2,3282 <memmove+0x28>
    3268:	1602                	slli	a2,a2,0x20
    326a:	9201                	srli	a2,a2,0x20
    326c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    3270:	872a                	mv	a4,a0
      *dst++ = *src++;
    3272:	0585                	addi	a1,a1,1
    3274:	0705                	addi	a4,a4,1
    3276:	fff5c683          	lbu	a3,-1(a1)
    327a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    327e:	fee79ae3          	bne	a5,a4,3272 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    3282:	6422                	ld	s0,8(sp)
    3284:	0141                	addi	sp,sp,16
    3286:	8082                	ret
    dst += n;
    3288:	00c50733          	add	a4,a0,a2
    src += n;
    328c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    328e:	fec05ae3          	blez	a2,3282 <memmove+0x28>
    3292:	fff6079b          	addiw	a5,a2,-1
    3296:	1782                	slli	a5,a5,0x20
    3298:	9381                	srli	a5,a5,0x20
    329a:	fff7c793          	not	a5,a5
    329e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    32a0:	15fd                	addi	a1,a1,-1
    32a2:	177d                	addi	a4,a4,-1
    32a4:	0005c683          	lbu	a3,0(a1)
    32a8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    32ac:	fee79ae3          	bne	a5,a4,32a0 <memmove+0x46>
    32b0:	bfc9                	j	3282 <memmove+0x28>

00000000000032b2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    32b2:	1141                	addi	sp,sp,-16
    32b4:	e422                	sd	s0,8(sp)
    32b6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    32b8:	ca05                	beqz	a2,32e8 <memcmp+0x36>
    32ba:	fff6069b          	addiw	a3,a2,-1
    32be:	1682                	slli	a3,a3,0x20
    32c0:	9281                	srli	a3,a3,0x20
    32c2:	0685                	addi	a3,a3,1
    32c4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    32c6:	00054783          	lbu	a5,0(a0)
    32ca:	0005c703          	lbu	a4,0(a1)
    32ce:	00e79863          	bne	a5,a4,32de <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    32d2:	0505                	addi	a0,a0,1
    p2++;
    32d4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    32d6:	fed518e3          	bne	a0,a3,32c6 <memcmp+0x14>
  }
  return 0;
    32da:	4501                	li	a0,0
    32dc:	a019                	j	32e2 <memcmp+0x30>
      return *p1 - *p2;
    32de:	40e7853b          	subw	a0,a5,a4
}
    32e2:	6422                	ld	s0,8(sp)
    32e4:	0141                	addi	sp,sp,16
    32e6:	8082                	ret
  return 0;
    32e8:	4501                	li	a0,0
    32ea:	bfe5                	j	32e2 <memcmp+0x30>

00000000000032ec <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    32ec:	1141                	addi	sp,sp,-16
    32ee:	e406                	sd	ra,8(sp)
    32f0:	e022                	sd	s0,0(sp)
    32f2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    32f4:	00000097          	auipc	ra,0x0
    32f8:	f66080e7          	jalr	-154(ra) # 325a <memmove>
}
    32fc:	60a2                	ld	ra,8(sp)
    32fe:	6402                	ld	s0,0(sp)
    3300:	0141                	addi	sp,sp,16
    3302:	8082                	ret

0000000000003304 <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    3304:	1141                	addi	sp,sp,-16
    3306:	e422                	sd	s0,8(sp)
    3308:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    330a:	00052023          	sw	zero,0(a0)
}  
    330e:	6422                	ld	s0,8(sp)
    3310:	0141                	addi	sp,sp,16
    3312:	8082                	ret

0000000000003314 <lock>:

void lock(struct spinlock * lk) 
{    
    3314:	1141                	addi	sp,sp,-16
    3316:	e422                	sd	s0,8(sp)
    3318:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    331a:	4705                	li	a4,1
    331c:	87ba                	mv	a5,a4
    331e:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    3322:	2781                	sext.w	a5,a5
    3324:	ffe5                	bnez	a5,331c <lock+0x8>
}  
    3326:	6422                	ld	s0,8(sp)
    3328:	0141                	addi	sp,sp,16
    332a:	8082                	ret

000000000000332c <unlock>:

void unlock(struct spinlock * lk) 
{   
    332c:	1141                	addi	sp,sp,-16
    332e:	e422                	sd	s0,8(sp)
    3330:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    3332:	0f50000f          	fence	iorw,ow
    3336:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    333a:	6422                	ld	s0,8(sp)
    333c:	0141                	addi	sp,sp,16
    333e:	8082                	ret

0000000000003340 <isDigit>:

unsigned int isDigit(char *c) {
    3340:	1141                	addi	sp,sp,-16
    3342:	e422                	sd	s0,8(sp)
    3344:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    3346:	00054503          	lbu	a0,0(a0)
    334a:	fd05051b          	addiw	a0,a0,-48
    334e:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    3352:	00a53513          	sltiu	a0,a0,10
    3356:	6422                	ld	s0,8(sp)
    3358:	0141                	addi	sp,sp,16
    335a:	8082                	ret

000000000000335c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    335c:	4885                	li	a7,1
 ecall
    335e:	00000073          	ecall
 ret
    3362:	8082                	ret

0000000000003364 <exit>:
.global exit
exit:
 li a7, SYS_exit
    3364:	4889                	li	a7,2
 ecall
    3366:	00000073          	ecall
 ret
    336a:	8082                	ret

000000000000336c <wait>:
.global wait
wait:
 li a7, SYS_wait
    336c:	488d                	li	a7,3
 ecall
    336e:	00000073          	ecall
 ret
    3372:	8082                	ret

0000000000003374 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    3374:	48e1                	li	a7,24
 ecall
    3376:	00000073          	ecall
 ret
    337a:	8082                	ret

000000000000337c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    337c:	4891                	li	a7,4
 ecall
    337e:	00000073          	ecall
 ret
    3382:	8082                	ret

0000000000003384 <read>:
.global read
read:
 li a7, SYS_read
    3384:	4895                	li	a7,5
 ecall
    3386:	00000073          	ecall
 ret
    338a:	8082                	ret

000000000000338c <write>:
.global write
write:
 li a7, SYS_write
    338c:	48c1                	li	a7,16
 ecall
    338e:	00000073          	ecall
 ret
    3392:	8082                	ret

0000000000003394 <close>:
.global close
close:
 li a7, SYS_close
    3394:	48d5                	li	a7,21
 ecall
    3396:	00000073          	ecall
 ret
    339a:	8082                	ret

000000000000339c <kill>:
.global kill
kill:
 li a7, SYS_kill
    339c:	4899                	li	a7,6
 ecall
    339e:	00000073          	ecall
 ret
    33a2:	8082                	ret

00000000000033a4 <exec>:
.global exec
exec:
 li a7, SYS_exec
    33a4:	489d                	li	a7,7
 ecall
    33a6:	00000073          	ecall
 ret
    33aa:	8082                	ret

00000000000033ac <open>:
.global open
open:
 li a7, SYS_open
    33ac:	48bd                	li	a7,15
 ecall
    33ae:	00000073          	ecall
 ret
    33b2:	8082                	ret

00000000000033b4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    33b4:	48c5                	li	a7,17
 ecall
    33b6:	00000073          	ecall
 ret
    33ba:	8082                	ret

00000000000033bc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    33bc:	48c9                	li	a7,18
 ecall
    33be:	00000073          	ecall
 ret
    33c2:	8082                	ret

00000000000033c4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    33c4:	48a1                	li	a7,8
 ecall
    33c6:	00000073          	ecall
 ret
    33ca:	8082                	ret

00000000000033cc <link>:
.global link
link:
 li a7, SYS_link
    33cc:	48cd                	li	a7,19
 ecall
    33ce:	00000073          	ecall
 ret
    33d2:	8082                	ret

00000000000033d4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    33d4:	48d1                	li	a7,20
 ecall
    33d6:	00000073          	ecall
 ret
    33da:	8082                	ret

00000000000033dc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    33dc:	48a5                	li	a7,9
 ecall
    33de:	00000073          	ecall
 ret
    33e2:	8082                	ret

00000000000033e4 <dup>:
.global dup
dup:
 li a7, SYS_dup
    33e4:	48a9                	li	a7,10
 ecall
    33e6:	00000073          	ecall
 ret
    33ea:	8082                	ret

00000000000033ec <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    33ec:	48ad                	li	a7,11
 ecall
    33ee:	00000073          	ecall
 ret
    33f2:	8082                	ret

00000000000033f4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    33f4:	48b1                	li	a7,12
 ecall
    33f6:	00000073          	ecall
 ret
    33fa:	8082                	ret

00000000000033fc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    33fc:	48b5                	li	a7,13
 ecall
    33fe:	00000073          	ecall
 ret
    3402:	8082                	ret

0000000000003404 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    3404:	48b9                	li	a7,14
 ecall
    3406:	00000073          	ecall
 ret
    340a:	8082                	ret

000000000000340c <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    340c:	48d9                	li	a7,22
 ecall
    340e:	00000073          	ecall
 ret
    3412:	8082                	ret

0000000000003414 <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    3414:	48dd                	li	a7,23
 ecall
    3416:	00000073          	ecall
 ret
    341a:	8082                	ret

000000000000341c <ps>:
.global ps
ps:
 li a7, SYS_ps
    341c:	48e5                	li	a7,25
 ecall
    341e:	00000073          	ecall
 ret
    3422:	8082                	ret

0000000000003424 <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    3424:	48e9                	li	a7,26
 ecall
    3426:	00000073          	ecall
 ret
    342a:	8082                	ret

000000000000342c <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    342c:	48ed                	li	a7,27
 ecall
    342e:	00000073          	ecall
 ret
    3432:	8082                	ret

0000000000003434 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    3434:	1101                	addi	sp,sp,-32
    3436:	ec06                	sd	ra,24(sp)
    3438:	e822                	sd	s0,16(sp)
    343a:	1000                	addi	s0,sp,32
    343c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    3440:	4605                	li	a2,1
    3442:	fef40593          	addi	a1,s0,-17
    3446:	00000097          	auipc	ra,0x0
    344a:	f46080e7          	jalr	-186(ra) # 338c <write>
}
    344e:	60e2                	ld	ra,24(sp)
    3450:	6442                	ld	s0,16(sp)
    3452:	6105                	addi	sp,sp,32
    3454:	8082                	ret

0000000000003456 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3456:	7139                	addi	sp,sp,-64
    3458:	fc06                	sd	ra,56(sp)
    345a:	f822                	sd	s0,48(sp)
    345c:	f426                	sd	s1,40(sp)
    345e:	f04a                	sd	s2,32(sp)
    3460:	ec4e                	sd	s3,24(sp)
    3462:	0080                	addi	s0,sp,64
    3464:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3466:	c299                	beqz	a3,346c <printint+0x16>
    3468:	0805c863          	bltz	a1,34f8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    346c:	2581                	sext.w	a1,a1
  neg = 0;
    346e:	4881                	li	a7,0
    3470:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    3474:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    3476:	2601                	sext.w	a2,a2
    3478:	00000517          	auipc	a0,0x0
    347c:	45050513          	addi	a0,a0,1104 # 38c8 <digits>
    3480:	883a                	mv	a6,a4
    3482:	2705                	addiw	a4,a4,1
    3484:	02c5f7bb          	remuw	a5,a1,a2
    3488:	1782                	slli	a5,a5,0x20
    348a:	9381                	srli	a5,a5,0x20
    348c:	97aa                	add	a5,a5,a0
    348e:	0007c783          	lbu	a5,0(a5)
    3492:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    3496:	0005879b          	sext.w	a5,a1
    349a:	02c5d5bb          	divuw	a1,a1,a2
    349e:	0685                	addi	a3,a3,1
    34a0:	fec7f0e3          	bgeu	a5,a2,3480 <printint+0x2a>
  if(neg)
    34a4:	00088b63          	beqz	a7,34ba <printint+0x64>
    buf[i++] = '-';
    34a8:	fd040793          	addi	a5,s0,-48
    34ac:	973e                	add	a4,a4,a5
    34ae:	02d00793          	li	a5,45
    34b2:	fef70823          	sb	a5,-16(a4)
    34b6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    34ba:	02e05863          	blez	a4,34ea <printint+0x94>
    34be:	fc040793          	addi	a5,s0,-64
    34c2:	00e78933          	add	s2,a5,a4
    34c6:	fff78993          	addi	s3,a5,-1
    34ca:	99ba                	add	s3,s3,a4
    34cc:	377d                	addiw	a4,a4,-1
    34ce:	1702                	slli	a4,a4,0x20
    34d0:	9301                	srli	a4,a4,0x20
    34d2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    34d6:	fff94583          	lbu	a1,-1(s2)
    34da:	8526                	mv	a0,s1
    34dc:	00000097          	auipc	ra,0x0
    34e0:	f58080e7          	jalr	-168(ra) # 3434 <putc>
  while(--i >= 0)
    34e4:	197d                	addi	s2,s2,-1
    34e6:	ff3918e3          	bne	s2,s3,34d6 <printint+0x80>
}
    34ea:	70e2                	ld	ra,56(sp)
    34ec:	7442                	ld	s0,48(sp)
    34ee:	74a2                	ld	s1,40(sp)
    34f0:	7902                	ld	s2,32(sp)
    34f2:	69e2                	ld	s3,24(sp)
    34f4:	6121                	addi	sp,sp,64
    34f6:	8082                	ret
    x = -xx;
    34f8:	40b005bb          	negw	a1,a1
    neg = 1;
    34fc:	4885                	li	a7,1
    x = -xx;
    34fe:	bf8d                	j	3470 <printint+0x1a>

0000000000003500 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    3500:	7119                	addi	sp,sp,-128
    3502:	fc86                	sd	ra,120(sp)
    3504:	f8a2                	sd	s0,112(sp)
    3506:	f4a6                	sd	s1,104(sp)
    3508:	f0ca                	sd	s2,96(sp)
    350a:	ecce                	sd	s3,88(sp)
    350c:	e8d2                	sd	s4,80(sp)
    350e:	e4d6                	sd	s5,72(sp)
    3510:	e0da                	sd	s6,64(sp)
    3512:	fc5e                	sd	s7,56(sp)
    3514:	f862                	sd	s8,48(sp)
    3516:	f466                	sd	s9,40(sp)
    3518:	f06a                	sd	s10,32(sp)
    351a:	ec6e                	sd	s11,24(sp)
    351c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    351e:	0005c903          	lbu	s2,0(a1)
    3522:	18090f63          	beqz	s2,36c0 <vprintf+0x1c0>
    3526:	8aaa                	mv	s5,a0
    3528:	8b32                	mv	s6,a2
    352a:	00158493          	addi	s1,a1,1
  state = 0;
    352e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3530:	02500a13          	li	s4,37
      if(c == 'd'){
    3534:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    3538:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    353c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    3540:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3544:	00000b97          	auipc	s7,0x0
    3548:	384b8b93          	addi	s7,s7,900 # 38c8 <digits>
    354c:	a839                	j	356a <vprintf+0x6a>
        putc(fd, c);
    354e:	85ca                	mv	a1,s2
    3550:	8556                	mv	a0,s5
    3552:	00000097          	auipc	ra,0x0
    3556:	ee2080e7          	jalr	-286(ra) # 3434 <putc>
    355a:	a019                	j	3560 <vprintf+0x60>
    } else if(state == '%'){
    355c:	01498f63          	beq	s3,s4,357a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    3560:	0485                	addi	s1,s1,1
    3562:	fff4c903          	lbu	s2,-1(s1)
    3566:	14090d63          	beqz	s2,36c0 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    356a:	0009079b          	sext.w	a5,s2
    if(state == 0){
    356e:	fe0997e3          	bnez	s3,355c <vprintf+0x5c>
      if(c == '%'){
    3572:	fd479ee3          	bne	a5,s4,354e <vprintf+0x4e>
        state = '%';
    3576:	89be                	mv	s3,a5
    3578:	b7e5                	j	3560 <vprintf+0x60>
      if(c == 'd'){
    357a:	05878063          	beq	a5,s8,35ba <vprintf+0xba>
      } else if(c == 'l') {
    357e:	05978c63          	beq	a5,s9,35d6 <vprintf+0xd6>
      } else if(c == 'x') {
    3582:	07a78863          	beq	a5,s10,35f2 <vprintf+0xf2>
      } else if(c == 'p') {
    3586:	09b78463          	beq	a5,s11,360e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    358a:	07300713          	li	a4,115
    358e:	0ce78663          	beq	a5,a4,365a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3592:	06300713          	li	a4,99
    3596:	0ee78e63          	beq	a5,a4,3692 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    359a:	11478863          	beq	a5,s4,36aa <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    359e:	85d2                	mv	a1,s4
    35a0:	8556                	mv	a0,s5
    35a2:	00000097          	auipc	ra,0x0
    35a6:	e92080e7          	jalr	-366(ra) # 3434 <putc>
        putc(fd, c);
    35aa:	85ca                	mv	a1,s2
    35ac:	8556                	mv	a0,s5
    35ae:	00000097          	auipc	ra,0x0
    35b2:	e86080e7          	jalr	-378(ra) # 3434 <putc>
      }
      state = 0;
    35b6:	4981                	li	s3,0
    35b8:	b765                	j	3560 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    35ba:	008b0913          	addi	s2,s6,8
    35be:	4685                	li	a3,1
    35c0:	4629                	li	a2,10
    35c2:	000b2583          	lw	a1,0(s6)
    35c6:	8556                	mv	a0,s5
    35c8:	00000097          	auipc	ra,0x0
    35cc:	e8e080e7          	jalr	-370(ra) # 3456 <printint>
    35d0:	8b4a                	mv	s6,s2
      state = 0;
    35d2:	4981                	li	s3,0
    35d4:	b771                	j	3560 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    35d6:	008b0913          	addi	s2,s6,8
    35da:	4681                	li	a3,0
    35dc:	4629                	li	a2,10
    35de:	000b2583          	lw	a1,0(s6)
    35e2:	8556                	mv	a0,s5
    35e4:	00000097          	auipc	ra,0x0
    35e8:	e72080e7          	jalr	-398(ra) # 3456 <printint>
    35ec:	8b4a                	mv	s6,s2
      state = 0;
    35ee:	4981                	li	s3,0
    35f0:	bf85                	j	3560 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    35f2:	008b0913          	addi	s2,s6,8
    35f6:	4681                	li	a3,0
    35f8:	4641                	li	a2,16
    35fa:	000b2583          	lw	a1,0(s6)
    35fe:	8556                	mv	a0,s5
    3600:	00000097          	auipc	ra,0x0
    3604:	e56080e7          	jalr	-426(ra) # 3456 <printint>
    3608:	8b4a                	mv	s6,s2
      state = 0;
    360a:	4981                	li	s3,0
    360c:	bf91                	j	3560 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    360e:	008b0793          	addi	a5,s6,8
    3612:	f8f43423          	sd	a5,-120(s0)
    3616:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    361a:	03000593          	li	a1,48
    361e:	8556                	mv	a0,s5
    3620:	00000097          	auipc	ra,0x0
    3624:	e14080e7          	jalr	-492(ra) # 3434 <putc>
  putc(fd, 'x');
    3628:	85ea                	mv	a1,s10
    362a:	8556                	mv	a0,s5
    362c:	00000097          	auipc	ra,0x0
    3630:	e08080e7          	jalr	-504(ra) # 3434 <putc>
    3634:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3636:	03c9d793          	srli	a5,s3,0x3c
    363a:	97de                	add	a5,a5,s7
    363c:	0007c583          	lbu	a1,0(a5)
    3640:	8556                	mv	a0,s5
    3642:	00000097          	auipc	ra,0x0
    3646:	df2080e7          	jalr	-526(ra) # 3434 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    364a:	0992                	slli	s3,s3,0x4
    364c:	397d                	addiw	s2,s2,-1
    364e:	fe0914e3          	bnez	s2,3636 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    3652:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    3656:	4981                	li	s3,0
    3658:	b721                	j	3560 <vprintf+0x60>
        s = va_arg(ap, char*);
    365a:	008b0993          	addi	s3,s6,8
    365e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    3662:	02090163          	beqz	s2,3684 <vprintf+0x184>
        while(*s != 0){
    3666:	00094583          	lbu	a1,0(s2)
    366a:	c9a1                	beqz	a1,36ba <vprintf+0x1ba>
          putc(fd, *s);
    366c:	8556                	mv	a0,s5
    366e:	00000097          	auipc	ra,0x0
    3672:	dc6080e7          	jalr	-570(ra) # 3434 <putc>
          s++;
    3676:	0905                	addi	s2,s2,1
        while(*s != 0){
    3678:	00094583          	lbu	a1,0(s2)
    367c:	f9e5                	bnez	a1,366c <vprintf+0x16c>
        s = va_arg(ap, char*);
    367e:	8b4e                	mv	s6,s3
      state = 0;
    3680:	4981                	li	s3,0
    3682:	bdf9                	j	3560 <vprintf+0x60>
          s = "(null)";
    3684:	00000917          	auipc	s2,0x0
    3688:	23c90913          	addi	s2,s2,572 # 38c0 <malloc+0xf6>
        while(*s != 0){
    368c:	02800593          	li	a1,40
    3690:	bff1                	j	366c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    3692:	008b0913          	addi	s2,s6,8
    3696:	000b4583          	lbu	a1,0(s6)
    369a:	8556                	mv	a0,s5
    369c:	00000097          	auipc	ra,0x0
    36a0:	d98080e7          	jalr	-616(ra) # 3434 <putc>
    36a4:	8b4a                	mv	s6,s2
      state = 0;
    36a6:	4981                	li	s3,0
    36a8:	bd65                	j	3560 <vprintf+0x60>
        putc(fd, c);
    36aa:	85d2                	mv	a1,s4
    36ac:	8556                	mv	a0,s5
    36ae:	00000097          	auipc	ra,0x0
    36b2:	d86080e7          	jalr	-634(ra) # 3434 <putc>
      state = 0;
    36b6:	4981                	li	s3,0
    36b8:	b565                	j	3560 <vprintf+0x60>
        s = va_arg(ap, char*);
    36ba:	8b4e                	mv	s6,s3
      state = 0;
    36bc:	4981                	li	s3,0
    36be:	b54d                	j	3560 <vprintf+0x60>
    }
  }
}
    36c0:	70e6                	ld	ra,120(sp)
    36c2:	7446                	ld	s0,112(sp)
    36c4:	74a6                	ld	s1,104(sp)
    36c6:	7906                	ld	s2,96(sp)
    36c8:	69e6                	ld	s3,88(sp)
    36ca:	6a46                	ld	s4,80(sp)
    36cc:	6aa6                	ld	s5,72(sp)
    36ce:	6b06                	ld	s6,64(sp)
    36d0:	7be2                	ld	s7,56(sp)
    36d2:	7c42                	ld	s8,48(sp)
    36d4:	7ca2                	ld	s9,40(sp)
    36d6:	7d02                	ld	s10,32(sp)
    36d8:	6de2                	ld	s11,24(sp)
    36da:	6109                	addi	sp,sp,128
    36dc:	8082                	ret

00000000000036de <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    36de:	715d                	addi	sp,sp,-80
    36e0:	ec06                	sd	ra,24(sp)
    36e2:	e822                	sd	s0,16(sp)
    36e4:	1000                	addi	s0,sp,32
    36e6:	e010                	sd	a2,0(s0)
    36e8:	e414                	sd	a3,8(s0)
    36ea:	e818                	sd	a4,16(s0)
    36ec:	ec1c                	sd	a5,24(s0)
    36ee:	03043023          	sd	a6,32(s0)
    36f2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    36f6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    36fa:	8622                	mv	a2,s0
    36fc:	00000097          	auipc	ra,0x0
    3700:	e04080e7          	jalr	-508(ra) # 3500 <vprintf>
}
    3704:	60e2                	ld	ra,24(sp)
    3706:	6442                	ld	s0,16(sp)
    3708:	6161                	addi	sp,sp,80
    370a:	8082                	ret

000000000000370c <printf>:

void
printf(const char *fmt, ...)
{
    370c:	711d                	addi	sp,sp,-96
    370e:	ec06                	sd	ra,24(sp)
    3710:	e822                	sd	s0,16(sp)
    3712:	1000                	addi	s0,sp,32
    3714:	e40c                	sd	a1,8(s0)
    3716:	e810                	sd	a2,16(s0)
    3718:	ec14                	sd	a3,24(s0)
    371a:	f018                	sd	a4,32(s0)
    371c:	f41c                	sd	a5,40(s0)
    371e:	03043823          	sd	a6,48(s0)
    3722:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    3726:	00840613          	addi	a2,s0,8
    372a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    372e:	85aa                	mv	a1,a0
    3730:	4505                	li	a0,1
    3732:	00000097          	auipc	ra,0x0
    3736:	dce080e7          	jalr	-562(ra) # 3500 <vprintf>
}
    373a:	60e2                	ld	ra,24(sp)
    373c:	6442                	ld	s0,16(sp)
    373e:	6125                	addi	sp,sp,96
    3740:	8082                	ret

0000000000003742 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3742:	1141                	addi	sp,sp,-16
    3744:	e422                	sd	s0,8(sp)
    3746:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3748:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    374c:	00001797          	auipc	a5,0x1
    3750:	8b47b783          	ld	a5,-1868(a5) # 4000 <freep>
    3754:	a805                	j	3784 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3756:	4618                	lw	a4,8(a2)
    3758:	9db9                	addw	a1,a1,a4
    375a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    375e:	6398                	ld	a4,0(a5)
    3760:	6318                	ld	a4,0(a4)
    3762:	fee53823          	sd	a4,-16(a0)
    3766:	a091                	j	37aa <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3768:	ff852703          	lw	a4,-8(a0)
    376c:	9e39                	addw	a2,a2,a4
    376e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    3770:	ff053703          	ld	a4,-16(a0)
    3774:	e398                	sd	a4,0(a5)
    3776:	a099                	j	37bc <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3778:	6398                	ld	a4,0(a5)
    377a:	00e7e463          	bltu	a5,a4,3782 <free+0x40>
    377e:	00e6ea63          	bltu	a3,a4,3792 <free+0x50>
{
    3782:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3784:	fed7fae3          	bgeu	a5,a3,3778 <free+0x36>
    3788:	6398                	ld	a4,0(a5)
    378a:	00e6e463          	bltu	a3,a4,3792 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    378e:	fee7eae3          	bltu	a5,a4,3782 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    3792:	ff852583          	lw	a1,-8(a0)
    3796:	6390                	ld	a2,0(a5)
    3798:	02059713          	slli	a4,a1,0x20
    379c:	9301                	srli	a4,a4,0x20
    379e:	0712                	slli	a4,a4,0x4
    37a0:	9736                	add	a4,a4,a3
    37a2:	fae60ae3          	beq	a2,a4,3756 <free+0x14>
    bp->s.ptr = p->s.ptr;
    37a6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    37aa:	4790                	lw	a2,8(a5)
    37ac:	02061713          	slli	a4,a2,0x20
    37b0:	9301                	srli	a4,a4,0x20
    37b2:	0712                	slli	a4,a4,0x4
    37b4:	973e                	add	a4,a4,a5
    37b6:	fae689e3          	beq	a3,a4,3768 <free+0x26>
  } else
    p->s.ptr = bp;
    37ba:	e394                	sd	a3,0(a5)
  freep = p;
    37bc:	00001717          	auipc	a4,0x1
    37c0:	84f73223          	sd	a5,-1980(a4) # 4000 <freep>
}
    37c4:	6422                	ld	s0,8(sp)
    37c6:	0141                	addi	sp,sp,16
    37c8:	8082                	ret

00000000000037ca <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    37ca:	7139                	addi	sp,sp,-64
    37cc:	fc06                	sd	ra,56(sp)
    37ce:	f822                	sd	s0,48(sp)
    37d0:	f426                	sd	s1,40(sp)
    37d2:	f04a                	sd	s2,32(sp)
    37d4:	ec4e                	sd	s3,24(sp)
    37d6:	e852                	sd	s4,16(sp)
    37d8:	e456                	sd	s5,8(sp)
    37da:	e05a                	sd	s6,0(sp)
    37dc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    37de:	02051493          	slli	s1,a0,0x20
    37e2:	9081                	srli	s1,s1,0x20
    37e4:	04bd                	addi	s1,s1,15
    37e6:	8091                	srli	s1,s1,0x4
    37e8:	0014899b          	addiw	s3,s1,1
    37ec:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    37ee:	00001517          	auipc	a0,0x1
    37f2:	81253503          	ld	a0,-2030(a0) # 4000 <freep>
    37f6:	c515                	beqz	a0,3822 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    37f8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    37fa:	4798                	lw	a4,8(a5)
    37fc:	02977f63          	bgeu	a4,s1,383a <malloc+0x70>
    3800:	8a4e                	mv	s4,s3
    3802:	0009871b          	sext.w	a4,s3
    3806:	6685                	lui	a3,0x1
    3808:	00d77363          	bgeu	a4,a3,380e <malloc+0x44>
    380c:	6a05                	lui	s4,0x1
    380e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    3812:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3816:	00000917          	auipc	s2,0x0
    381a:	7ea90913          	addi	s2,s2,2026 # 4000 <freep>
  if(p == (char*)-1)
    381e:	5afd                	li	s5,-1
    3820:	a88d                	j	3892 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    3822:	00000797          	auipc	a5,0x0
    3826:	7ee78793          	addi	a5,a5,2030 # 4010 <base>
    382a:	00000717          	auipc	a4,0x0
    382e:	7cf73b23          	sd	a5,2006(a4) # 4000 <freep>
    3832:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    3834:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    3838:	b7e1                	j	3800 <malloc+0x36>
      if(p->s.size == nunits)
    383a:	02e48b63          	beq	s1,a4,3870 <malloc+0xa6>
        p->s.size -= nunits;
    383e:	4137073b          	subw	a4,a4,s3
    3842:	c798                	sw	a4,8(a5)
        p += p->s.size;
    3844:	1702                	slli	a4,a4,0x20
    3846:	9301                	srli	a4,a4,0x20
    3848:	0712                	slli	a4,a4,0x4
    384a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    384c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    3850:	00000717          	auipc	a4,0x0
    3854:	7aa73823          	sd	a0,1968(a4) # 4000 <freep>
      return (void*)(p + 1);
    3858:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    385c:	70e2                	ld	ra,56(sp)
    385e:	7442                	ld	s0,48(sp)
    3860:	74a2                	ld	s1,40(sp)
    3862:	7902                	ld	s2,32(sp)
    3864:	69e2                	ld	s3,24(sp)
    3866:	6a42                	ld	s4,16(sp)
    3868:	6aa2                	ld	s5,8(sp)
    386a:	6b02                	ld	s6,0(sp)
    386c:	6121                	addi	sp,sp,64
    386e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3870:	6398                	ld	a4,0(a5)
    3872:	e118                	sd	a4,0(a0)
    3874:	bff1                	j	3850 <malloc+0x86>
  hp->s.size = nu;
    3876:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    387a:	0541                	addi	a0,a0,16
    387c:	00000097          	auipc	ra,0x0
    3880:	ec6080e7          	jalr	-314(ra) # 3742 <free>
  return freep;
    3884:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    3888:	d971                	beqz	a0,385c <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    388a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    388c:	4798                	lw	a4,8(a5)
    388e:	fa9776e3          	bgeu	a4,s1,383a <malloc+0x70>
    if(p == freep)
    3892:	00093703          	ld	a4,0(s2)
    3896:	853e                	mv	a0,a5
    3898:	fef719e3          	bne	a4,a5,388a <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    389c:	8552                	mv	a0,s4
    389e:	00000097          	auipc	ra,0x0
    38a2:	b56080e7          	jalr	-1194(ra) # 33f4 <sbrk>
  if(p == (char*)-1)
    38a6:	fd5518e3          	bne	a0,s5,3876 <malloc+0xac>
        return 0;
    38aa:	4501                	li	a0,0
    38ac:	bf45                	j	385c <malloc+0x92>
