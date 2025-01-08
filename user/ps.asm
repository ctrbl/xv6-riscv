
user/_ps:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <main>:
#include "kernel/stat.h"
#include "user/user.h"


// Get information about a process (using flag -p or -n) or all processes
int main(int argc, char *argv[]) {  
    3000:	1101                	addi	sp,sp,-32
    3002:	ec06                	sd	ra,24(sp)
    3004:	e822                	sd	s0,16(sp)
    3006:	e426                	sd	s1,8(sp)
    3008:	1000                	addi	s0,sp,32
  if (argc <= 1) {
    300a:	4785                	li	a5,1
    300c:	02a7de63          	bge	a5,a0,3048 <main+0x48>
    3010:	84ae                	mv	s1,a1
    ps(0, 0, 0); 
    exit(0);  
  } else if (!strcmp(argv[1], "-p")) {
    3012:	00001597          	auipc	a1,0x1
    3016:	8be58593          	addi	a1,a1,-1858 # 38d0 <malloc+0xe8>
    301a:	6488                	ld	a0,8(s1)
    301c:	00000097          	auipc	ra,0x0
    3020:	0bc080e7          	jalr	188(ra) # 30d8 <strcmp>
    3024:	ed15                	bnez	a0,3060 <main+0x60>
    ps(1, atoi(argv[2]), 0); 
    3026:	6888                	ld	a0,16(s1)
    3028:	00000097          	auipc	ra,0x0
    302c:	206080e7          	jalr	518(ra) # 322e <atoi>
    3030:	85aa                	mv	a1,a0
    3032:	4601                	li	a2,0
    3034:	4505                	li	a0,1
    3036:	00000097          	auipc	ra,0x0
    303a:	404080e7          	jalr	1028(ra) # 343a <ps>
  } else if (!strcmp(argv[1], "-n")) {
    ps(2, strlen(argv[2]), (uint64)argv[2]); 
  } else {
    printf("ps: use option -p for pid and -n for name\n");  
  }
  exit(0); 
    303e:	4501                	li	a0,0
    3040:	00000097          	auipc	ra,0x0
    3044:	342080e7          	jalr	834(ra) # 3382 <exit>
    ps(0, 0, 0); 
    3048:	4601                	li	a2,0
    304a:	4581                	li	a1,0
    304c:	4501                	li	a0,0
    304e:	00000097          	auipc	ra,0x0
    3052:	3ec080e7          	jalr	1004(ra) # 343a <ps>
    exit(0);  
    3056:	4501                	li	a0,0
    3058:	00000097          	auipc	ra,0x0
    305c:	32a080e7          	jalr	810(ra) # 3382 <exit>
  } else if (!strcmp(argv[1], "-n")) {
    3060:	00001597          	auipc	a1,0x1
    3064:	87858593          	addi	a1,a1,-1928 # 38d8 <malloc+0xf0>
    3068:	6488                	ld	a0,8(s1)
    306a:	00000097          	auipc	ra,0x0
    306e:	06e080e7          	jalr	110(ra) # 30d8 <strcmp>
    3072:	ed19                	bnez	a0,3090 <main+0x90>
    ps(2, strlen(argv[2]), (uint64)argv[2]); 
    3074:	6888                	ld	a0,16(s1)
    3076:	00000097          	auipc	ra,0x0
    307a:	08e080e7          	jalr	142(ra) # 3104 <strlen>
    307e:	6890                	ld	a2,16(s1)
    3080:	0005059b          	sext.w	a1,a0
    3084:	4509                	li	a0,2
    3086:	00000097          	auipc	ra,0x0
    308a:	3b4080e7          	jalr	948(ra) # 343a <ps>
    308e:	bf45                	j	303e <main+0x3e>
    printf("ps: use option -p for pid and -n for name\n");  
    3090:	00001517          	auipc	a0,0x1
    3094:	85050513          	addi	a0,a0,-1968 # 38e0 <malloc+0xf8>
    3098:	00000097          	auipc	ra,0x0
    309c:	692080e7          	jalr	1682(ra) # 372a <printf>
    30a0:	bf79                	j	303e <main+0x3e>

00000000000030a2 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    30a2:	1141                	addi	sp,sp,-16
    30a4:	e406                	sd	ra,8(sp)
    30a6:	e022                	sd	s0,0(sp)
    30a8:	0800                	addi	s0,sp,16
  extern int main();
  main();
    30aa:	00000097          	auipc	ra,0x0
    30ae:	f56080e7          	jalr	-170(ra) # 3000 <main>
  exit(0);
    30b2:	4501                	li	a0,0
    30b4:	00000097          	auipc	ra,0x0
    30b8:	2ce080e7          	jalr	718(ra) # 3382 <exit>

00000000000030bc <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    30bc:	1141                	addi	sp,sp,-16
    30be:	e422                	sd	s0,8(sp)
    30c0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    30c2:	87aa                	mv	a5,a0
    30c4:	0585                	addi	a1,a1,1
    30c6:	0785                	addi	a5,a5,1
    30c8:	fff5c703          	lbu	a4,-1(a1)
    30cc:	fee78fa3          	sb	a4,-1(a5)
    30d0:	fb75                	bnez	a4,30c4 <strcpy+0x8>
    ;
  return os;
}
    30d2:	6422                	ld	s0,8(sp)
    30d4:	0141                	addi	sp,sp,16
    30d6:	8082                	ret

00000000000030d8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    30d8:	1141                	addi	sp,sp,-16
    30da:	e422                	sd	s0,8(sp)
    30dc:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    30de:	00054783          	lbu	a5,0(a0)
    30e2:	cb91                	beqz	a5,30f6 <strcmp+0x1e>
    30e4:	0005c703          	lbu	a4,0(a1)
    30e8:	00f71763          	bne	a4,a5,30f6 <strcmp+0x1e>
    p++, q++;
    30ec:	0505                	addi	a0,a0,1
    30ee:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    30f0:	00054783          	lbu	a5,0(a0)
    30f4:	fbe5                	bnez	a5,30e4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    30f6:	0005c503          	lbu	a0,0(a1)
}
    30fa:	40a7853b          	subw	a0,a5,a0
    30fe:	6422                	ld	s0,8(sp)
    3100:	0141                	addi	sp,sp,16
    3102:	8082                	ret

0000000000003104 <strlen>:

uint
strlen(const char *s)
{
    3104:	1141                	addi	sp,sp,-16
    3106:	e422                	sd	s0,8(sp)
    3108:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    310a:	00054783          	lbu	a5,0(a0)
    310e:	cf91                	beqz	a5,312a <strlen+0x26>
    3110:	0505                	addi	a0,a0,1
    3112:	87aa                	mv	a5,a0
    3114:	4685                	li	a3,1
    3116:	9e89                	subw	a3,a3,a0
    3118:	00f6853b          	addw	a0,a3,a5
    311c:	0785                	addi	a5,a5,1
    311e:	fff7c703          	lbu	a4,-1(a5)
    3122:	fb7d                	bnez	a4,3118 <strlen+0x14>
    ;
  return n;
}
    3124:	6422                	ld	s0,8(sp)
    3126:	0141                	addi	sp,sp,16
    3128:	8082                	ret
  for(n = 0; s[n]; n++)
    312a:	4501                	li	a0,0
    312c:	bfe5                	j	3124 <strlen+0x20>

000000000000312e <memset>:

void*
memset(void *dst, int c, uint n)
{
    312e:	1141                	addi	sp,sp,-16
    3130:	e422                	sd	s0,8(sp)
    3132:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    3134:	ca19                	beqz	a2,314a <memset+0x1c>
    3136:	87aa                	mv	a5,a0
    3138:	1602                	slli	a2,a2,0x20
    313a:	9201                	srli	a2,a2,0x20
    313c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    3140:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    3144:	0785                	addi	a5,a5,1
    3146:	fee79de3          	bne	a5,a4,3140 <memset+0x12>
  }
  return dst;
}
    314a:	6422                	ld	s0,8(sp)
    314c:	0141                	addi	sp,sp,16
    314e:	8082                	ret

0000000000003150 <strchr>:

char*
strchr(const char *s, char c)
{
    3150:	1141                	addi	sp,sp,-16
    3152:	e422                	sd	s0,8(sp)
    3154:	0800                	addi	s0,sp,16
  for(; *s; s++)
    3156:	00054783          	lbu	a5,0(a0)
    315a:	cb99                	beqz	a5,3170 <strchr+0x20>
    if(*s == c)
    315c:	00f58763          	beq	a1,a5,316a <strchr+0x1a>
  for(; *s; s++)
    3160:	0505                	addi	a0,a0,1
    3162:	00054783          	lbu	a5,0(a0)
    3166:	fbfd                	bnez	a5,315c <strchr+0xc>
      return (char*)s;
  return 0;
    3168:	4501                	li	a0,0
}
    316a:	6422                	ld	s0,8(sp)
    316c:	0141                	addi	sp,sp,16
    316e:	8082                	ret
  return 0;
    3170:	4501                	li	a0,0
    3172:	bfe5                	j	316a <strchr+0x1a>

0000000000003174 <gets>:

char*
gets(char *buf, int max)
{
    3174:	711d                	addi	sp,sp,-96
    3176:	ec86                	sd	ra,88(sp)
    3178:	e8a2                	sd	s0,80(sp)
    317a:	e4a6                	sd	s1,72(sp)
    317c:	e0ca                	sd	s2,64(sp)
    317e:	fc4e                	sd	s3,56(sp)
    3180:	f852                	sd	s4,48(sp)
    3182:	f456                	sd	s5,40(sp)
    3184:	f05a                	sd	s6,32(sp)
    3186:	ec5e                	sd	s7,24(sp)
    3188:	1080                	addi	s0,sp,96
    318a:	8baa                	mv	s7,a0
    318c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    318e:	892a                	mv	s2,a0
    3190:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3192:	4aa9                	li	s5,10
    3194:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    3196:	89a6                	mv	s3,s1
    3198:	2485                	addiw	s1,s1,1
    319a:	0344d863          	bge	s1,s4,31ca <gets+0x56>
    cc = read(0, &c, 1);
    319e:	4605                	li	a2,1
    31a0:	faf40593          	addi	a1,s0,-81
    31a4:	4501                	li	a0,0
    31a6:	00000097          	auipc	ra,0x0
    31aa:	1fc080e7          	jalr	508(ra) # 33a2 <read>
    if(cc < 1)
    31ae:	00a05e63          	blez	a0,31ca <gets+0x56>
    buf[i++] = c;
    31b2:	faf44783          	lbu	a5,-81(s0)
    31b6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    31ba:	01578763          	beq	a5,s5,31c8 <gets+0x54>
    31be:	0905                	addi	s2,s2,1
    31c0:	fd679be3          	bne	a5,s6,3196 <gets+0x22>
  for(i=0; i+1 < max; ){
    31c4:	89a6                	mv	s3,s1
    31c6:	a011                	j	31ca <gets+0x56>
    31c8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    31ca:	99de                	add	s3,s3,s7
    31cc:	00098023          	sb	zero,0(s3)
  return buf;
}
    31d0:	855e                	mv	a0,s7
    31d2:	60e6                	ld	ra,88(sp)
    31d4:	6446                	ld	s0,80(sp)
    31d6:	64a6                	ld	s1,72(sp)
    31d8:	6906                	ld	s2,64(sp)
    31da:	79e2                	ld	s3,56(sp)
    31dc:	7a42                	ld	s4,48(sp)
    31de:	7aa2                	ld	s5,40(sp)
    31e0:	7b02                	ld	s6,32(sp)
    31e2:	6be2                	ld	s7,24(sp)
    31e4:	6125                	addi	sp,sp,96
    31e6:	8082                	ret

00000000000031e8 <stat>:

int
stat(const char *n, struct stat *st)
{
    31e8:	1101                	addi	sp,sp,-32
    31ea:	ec06                	sd	ra,24(sp)
    31ec:	e822                	sd	s0,16(sp)
    31ee:	e426                	sd	s1,8(sp)
    31f0:	e04a                	sd	s2,0(sp)
    31f2:	1000                	addi	s0,sp,32
    31f4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    31f6:	4581                	li	a1,0
    31f8:	00000097          	auipc	ra,0x0
    31fc:	1d2080e7          	jalr	466(ra) # 33ca <open>
  if(fd < 0)
    3200:	02054563          	bltz	a0,322a <stat+0x42>
    3204:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    3206:	85ca                	mv	a1,s2
    3208:	00000097          	auipc	ra,0x0
    320c:	1da080e7          	jalr	474(ra) # 33e2 <fstat>
    3210:	892a                	mv	s2,a0
  close(fd);
    3212:	8526                	mv	a0,s1
    3214:	00000097          	auipc	ra,0x0
    3218:	19e080e7          	jalr	414(ra) # 33b2 <close>
  return r;
}
    321c:	854a                	mv	a0,s2
    321e:	60e2                	ld	ra,24(sp)
    3220:	6442                	ld	s0,16(sp)
    3222:	64a2                	ld	s1,8(sp)
    3224:	6902                	ld	s2,0(sp)
    3226:	6105                	addi	sp,sp,32
    3228:	8082                	ret
    return -1;
    322a:	597d                	li	s2,-1
    322c:	bfc5                	j	321c <stat+0x34>

000000000000322e <atoi>:

int
atoi(const char *s)
{
    322e:	1141                	addi	sp,sp,-16
    3230:	e422                	sd	s0,8(sp)
    3232:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3234:	00054603          	lbu	a2,0(a0)
    3238:	fd06079b          	addiw	a5,a2,-48
    323c:	0ff7f793          	andi	a5,a5,255
    3240:	4725                	li	a4,9
    3242:	02f76963          	bltu	a4,a5,3274 <atoi+0x46>
    3246:	86aa                	mv	a3,a0
  n = 0;
    3248:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    324a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    324c:	0685                	addi	a3,a3,1
    324e:	0025179b          	slliw	a5,a0,0x2
    3252:	9fa9                	addw	a5,a5,a0
    3254:	0017979b          	slliw	a5,a5,0x1
    3258:	9fb1                	addw	a5,a5,a2
    325a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    325e:	0006c603          	lbu	a2,0(a3)
    3262:	fd06071b          	addiw	a4,a2,-48
    3266:	0ff77713          	andi	a4,a4,255
    326a:	fee5f1e3          	bgeu	a1,a4,324c <atoi+0x1e>
  return n;
}
    326e:	6422                	ld	s0,8(sp)
    3270:	0141                	addi	sp,sp,16
    3272:	8082                	ret
  n = 0;
    3274:	4501                	li	a0,0
    3276:	bfe5                	j	326e <atoi+0x40>

0000000000003278 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3278:	1141                	addi	sp,sp,-16
    327a:	e422                	sd	s0,8(sp)
    327c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    327e:	02b57463          	bgeu	a0,a1,32a6 <memmove+0x2e>
    while(n-- > 0)
    3282:	00c05f63          	blez	a2,32a0 <memmove+0x28>
    3286:	1602                	slli	a2,a2,0x20
    3288:	9201                	srli	a2,a2,0x20
    328a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    328e:	872a                	mv	a4,a0
      *dst++ = *src++;
    3290:	0585                	addi	a1,a1,1
    3292:	0705                	addi	a4,a4,1
    3294:	fff5c683          	lbu	a3,-1(a1)
    3298:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    329c:	fee79ae3          	bne	a5,a4,3290 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    32a0:	6422                	ld	s0,8(sp)
    32a2:	0141                	addi	sp,sp,16
    32a4:	8082                	ret
    dst += n;
    32a6:	00c50733          	add	a4,a0,a2
    src += n;
    32aa:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    32ac:	fec05ae3          	blez	a2,32a0 <memmove+0x28>
    32b0:	fff6079b          	addiw	a5,a2,-1
    32b4:	1782                	slli	a5,a5,0x20
    32b6:	9381                	srli	a5,a5,0x20
    32b8:	fff7c793          	not	a5,a5
    32bc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    32be:	15fd                	addi	a1,a1,-1
    32c0:	177d                	addi	a4,a4,-1
    32c2:	0005c683          	lbu	a3,0(a1)
    32c6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    32ca:	fee79ae3          	bne	a5,a4,32be <memmove+0x46>
    32ce:	bfc9                	j	32a0 <memmove+0x28>

00000000000032d0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    32d0:	1141                	addi	sp,sp,-16
    32d2:	e422                	sd	s0,8(sp)
    32d4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    32d6:	ca05                	beqz	a2,3306 <memcmp+0x36>
    32d8:	fff6069b          	addiw	a3,a2,-1
    32dc:	1682                	slli	a3,a3,0x20
    32de:	9281                	srli	a3,a3,0x20
    32e0:	0685                	addi	a3,a3,1
    32e2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    32e4:	00054783          	lbu	a5,0(a0)
    32e8:	0005c703          	lbu	a4,0(a1)
    32ec:	00e79863          	bne	a5,a4,32fc <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    32f0:	0505                	addi	a0,a0,1
    p2++;
    32f2:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    32f4:	fed518e3          	bne	a0,a3,32e4 <memcmp+0x14>
  }
  return 0;
    32f8:	4501                	li	a0,0
    32fa:	a019                	j	3300 <memcmp+0x30>
      return *p1 - *p2;
    32fc:	40e7853b          	subw	a0,a5,a4
}
    3300:	6422                	ld	s0,8(sp)
    3302:	0141                	addi	sp,sp,16
    3304:	8082                	ret
  return 0;
    3306:	4501                	li	a0,0
    3308:	bfe5                	j	3300 <memcmp+0x30>

000000000000330a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    330a:	1141                	addi	sp,sp,-16
    330c:	e406                	sd	ra,8(sp)
    330e:	e022                	sd	s0,0(sp)
    3310:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    3312:	00000097          	auipc	ra,0x0
    3316:	f66080e7          	jalr	-154(ra) # 3278 <memmove>
}
    331a:	60a2                	ld	ra,8(sp)
    331c:	6402                	ld	s0,0(sp)
    331e:	0141                	addi	sp,sp,16
    3320:	8082                	ret

0000000000003322 <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    3322:	1141                	addi	sp,sp,-16
    3324:	e422                	sd	s0,8(sp)
    3326:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    3328:	00052023          	sw	zero,0(a0)
}  
    332c:	6422                	ld	s0,8(sp)
    332e:	0141                	addi	sp,sp,16
    3330:	8082                	ret

0000000000003332 <lock>:

void lock(struct spinlock * lk) 
{    
    3332:	1141                	addi	sp,sp,-16
    3334:	e422                	sd	s0,8(sp)
    3336:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    3338:	4705                	li	a4,1
    333a:	87ba                	mv	a5,a4
    333c:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    3340:	2781                	sext.w	a5,a5
    3342:	ffe5                	bnez	a5,333a <lock+0x8>
}  
    3344:	6422                	ld	s0,8(sp)
    3346:	0141                	addi	sp,sp,16
    3348:	8082                	ret

000000000000334a <unlock>:

void unlock(struct spinlock * lk) 
{   
    334a:	1141                	addi	sp,sp,-16
    334c:	e422                	sd	s0,8(sp)
    334e:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    3350:	0f50000f          	fence	iorw,ow
    3354:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    3358:	6422                	ld	s0,8(sp)
    335a:	0141                	addi	sp,sp,16
    335c:	8082                	ret

000000000000335e <isDigit>:

unsigned int isDigit(char *c) {
    335e:	1141                	addi	sp,sp,-16
    3360:	e422                	sd	s0,8(sp)
    3362:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    3364:	00054503          	lbu	a0,0(a0)
    3368:	fd05051b          	addiw	a0,a0,-48
    336c:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    3370:	00a53513          	sltiu	a0,a0,10
    3374:	6422                	ld	s0,8(sp)
    3376:	0141                	addi	sp,sp,16
    3378:	8082                	ret

000000000000337a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    337a:	4885                	li	a7,1
 ecall
    337c:	00000073          	ecall
 ret
    3380:	8082                	ret

0000000000003382 <exit>:
.global exit
exit:
 li a7, SYS_exit
    3382:	4889                	li	a7,2
 ecall
    3384:	00000073          	ecall
 ret
    3388:	8082                	ret

000000000000338a <wait>:
.global wait
wait:
 li a7, SYS_wait
    338a:	488d                	li	a7,3
 ecall
    338c:	00000073          	ecall
 ret
    3390:	8082                	ret

0000000000003392 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    3392:	48e1                	li	a7,24
 ecall
    3394:	00000073          	ecall
 ret
    3398:	8082                	ret

000000000000339a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    339a:	4891                	li	a7,4
 ecall
    339c:	00000073          	ecall
 ret
    33a0:	8082                	ret

00000000000033a2 <read>:
.global read
read:
 li a7, SYS_read
    33a2:	4895                	li	a7,5
 ecall
    33a4:	00000073          	ecall
 ret
    33a8:	8082                	ret

00000000000033aa <write>:
.global write
write:
 li a7, SYS_write
    33aa:	48c1                	li	a7,16
 ecall
    33ac:	00000073          	ecall
 ret
    33b0:	8082                	ret

00000000000033b2 <close>:
.global close
close:
 li a7, SYS_close
    33b2:	48d5                	li	a7,21
 ecall
    33b4:	00000073          	ecall
 ret
    33b8:	8082                	ret

00000000000033ba <kill>:
.global kill
kill:
 li a7, SYS_kill
    33ba:	4899                	li	a7,6
 ecall
    33bc:	00000073          	ecall
 ret
    33c0:	8082                	ret

00000000000033c2 <exec>:
.global exec
exec:
 li a7, SYS_exec
    33c2:	489d                	li	a7,7
 ecall
    33c4:	00000073          	ecall
 ret
    33c8:	8082                	ret

00000000000033ca <open>:
.global open
open:
 li a7, SYS_open
    33ca:	48bd                	li	a7,15
 ecall
    33cc:	00000073          	ecall
 ret
    33d0:	8082                	ret

00000000000033d2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    33d2:	48c5                	li	a7,17
 ecall
    33d4:	00000073          	ecall
 ret
    33d8:	8082                	ret

00000000000033da <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    33da:	48c9                	li	a7,18
 ecall
    33dc:	00000073          	ecall
 ret
    33e0:	8082                	ret

00000000000033e2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    33e2:	48a1                	li	a7,8
 ecall
    33e4:	00000073          	ecall
 ret
    33e8:	8082                	ret

00000000000033ea <link>:
.global link
link:
 li a7, SYS_link
    33ea:	48cd                	li	a7,19
 ecall
    33ec:	00000073          	ecall
 ret
    33f0:	8082                	ret

00000000000033f2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    33f2:	48d1                	li	a7,20
 ecall
    33f4:	00000073          	ecall
 ret
    33f8:	8082                	ret

00000000000033fa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    33fa:	48a5                	li	a7,9
 ecall
    33fc:	00000073          	ecall
 ret
    3400:	8082                	ret

0000000000003402 <dup>:
.global dup
dup:
 li a7, SYS_dup
    3402:	48a9                	li	a7,10
 ecall
    3404:	00000073          	ecall
 ret
    3408:	8082                	ret

000000000000340a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    340a:	48ad                	li	a7,11
 ecall
    340c:	00000073          	ecall
 ret
    3410:	8082                	ret

0000000000003412 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    3412:	48b1                	li	a7,12
 ecall
    3414:	00000073          	ecall
 ret
    3418:	8082                	ret

000000000000341a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    341a:	48b5                	li	a7,13
 ecall
    341c:	00000073          	ecall
 ret
    3420:	8082                	ret

0000000000003422 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    3422:	48b9                	li	a7,14
 ecall
    3424:	00000073          	ecall
 ret
    3428:	8082                	ret

000000000000342a <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    342a:	48d9                	li	a7,22
 ecall
    342c:	00000073          	ecall
 ret
    3430:	8082                	ret

0000000000003432 <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    3432:	48dd                	li	a7,23
 ecall
    3434:	00000073          	ecall
 ret
    3438:	8082                	ret

000000000000343a <ps>:
.global ps
ps:
 li a7, SYS_ps
    343a:	48e5                	li	a7,25
 ecall
    343c:	00000073          	ecall
 ret
    3440:	8082                	ret

0000000000003442 <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    3442:	48e9                	li	a7,26
 ecall
    3444:	00000073          	ecall
 ret
    3448:	8082                	ret

000000000000344a <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    344a:	48ed                	li	a7,27
 ecall
    344c:	00000073          	ecall
 ret
    3450:	8082                	ret

0000000000003452 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    3452:	1101                	addi	sp,sp,-32
    3454:	ec06                	sd	ra,24(sp)
    3456:	e822                	sd	s0,16(sp)
    3458:	1000                	addi	s0,sp,32
    345a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    345e:	4605                	li	a2,1
    3460:	fef40593          	addi	a1,s0,-17
    3464:	00000097          	auipc	ra,0x0
    3468:	f46080e7          	jalr	-186(ra) # 33aa <write>
}
    346c:	60e2                	ld	ra,24(sp)
    346e:	6442                	ld	s0,16(sp)
    3470:	6105                	addi	sp,sp,32
    3472:	8082                	ret

0000000000003474 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3474:	7139                	addi	sp,sp,-64
    3476:	fc06                	sd	ra,56(sp)
    3478:	f822                	sd	s0,48(sp)
    347a:	f426                	sd	s1,40(sp)
    347c:	f04a                	sd	s2,32(sp)
    347e:	ec4e                	sd	s3,24(sp)
    3480:	0080                	addi	s0,sp,64
    3482:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3484:	c299                	beqz	a3,348a <printint+0x16>
    3486:	0805c863          	bltz	a1,3516 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    348a:	2581                	sext.w	a1,a1
  neg = 0;
    348c:	4881                	li	a7,0
    348e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    3492:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    3494:	2601                	sext.w	a2,a2
    3496:	00000517          	auipc	a0,0x0
    349a:	48250513          	addi	a0,a0,1154 # 3918 <digits>
    349e:	883a                	mv	a6,a4
    34a0:	2705                	addiw	a4,a4,1
    34a2:	02c5f7bb          	remuw	a5,a1,a2
    34a6:	1782                	slli	a5,a5,0x20
    34a8:	9381                	srli	a5,a5,0x20
    34aa:	97aa                	add	a5,a5,a0
    34ac:	0007c783          	lbu	a5,0(a5)
    34b0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    34b4:	0005879b          	sext.w	a5,a1
    34b8:	02c5d5bb          	divuw	a1,a1,a2
    34bc:	0685                	addi	a3,a3,1
    34be:	fec7f0e3          	bgeu	a5,a2,349e <printint+0x2a>
  if(neg)
    34c2:	00088b63          	beqz	a7,34d8 <printint+0x64>
    buf[i++] = '-';
    34c6:	fd040793          	addi	a5,s0,-48
    34ca:	973e                	add	a4,a4,a5
    34cc:	02d00793          	li	a5,45
    34d0:	fef70823          	sb	a5,-16(a4)
    34d4:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    34d8:	02e05863          	blez	a4,3508 <printint+0x94>
    34dc:	fc040793          	addi	a5,s0,-64
    34e0:	00e78933          	add	s2,a5,a4
    34e4:	fff78993          	addi	s3,a5,-1
    34e8:	99ba                	add	s3,s3,a4
    34ea:	377d                	addiw	a4,a4,-1
    34ec:	1702                	slli	a4,a4,0x20
    34ee:	9301                	srli	a4,a4,0x20
    34f0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    34f4:	fff94583          	lbu	a1,-1(s2)
    34f8:	8526                	mv	a0,s1
    34fa:	00000097          	auipc	ra,0x0
    34fe:	f58080e7          	jalr	-168(ra) # 3452 <putc>
  while(--i >= 0)
    3502:	197d                	addi	s2,s2,-1
    3504:	ff3918e3          	bne	s2,s3,34f4 <printint+0x80>
}
    3508:	70e2                	ld	ra,56(sp)
    350a:	7442                	ld	s0,48(sp)
    350c:	74a2                	ld	s1,40(sp)
    350e:	7902                	ld	s2,32(sp)
    3510:	69e2                	ld	s3,24(sp)
    3512:	6121                	addi	sp,sp,64
    3514:	8082                	ret
    x = -xx;
    3516:	40b005bb          	negw	a1,a1
    neg = 1;
    351a:	4885                	li	a7,1
    x = -xx;
    351c:	bf8d                	j	348e <printint+0x1a>

000000000000351e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    351e:	7119                	addi	sp,sp,-128
    3520:	fc86                	sd	ra,120(sp)
    3522:	f8a2                	sd	s0,112(sp)
    3524:	f4a6                	sd	s1,104(sp)
    3526:	f0ca                	sd	s2,96(sp)
    3528:	ecce                	sd	s3,88(sp)
    352a:	e8d2                	sd	s4,80(sp)
    352c:	e4d6                	sd	s5,72(sp)
    352e:	e0da                	sd	s6,64(sp)
    3530:	fc5e                	sd	s7,56(sp)
    3532:	f862                	sd	s8,48(sp)
    3534:	f466                	sd	s9,40(sp)
    3536:	f06a                	sd	s10,32(sp)
    3538:	ec6e                	sd	s11,24(sp)
    353a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    353c:	0005c903          	lbu	s2,0(a1)
    3540:	18090f63          	beqz	s2,36de <vprintf+0x1c0>
    3544:	8aaa                	mv	s5,a0
    3546:	8b32                	mv	s6,a2
    3548:	00158493          	addi	s1,a1,1
  state = 0;
    354c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    354e:	02500a13          	li	s4,37
      if(c == 'd'){
    3552:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    3556:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    355a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    355e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3562:	00000b97          	auipc	s7,0x0
    3566:	3b6b8b93          	addi	s7,s7,950 # 3918 <digits>
    356a:	a839                	j	3588 <vprintf+0x6a>
        putc(fd, c);
    356c:	85ca                	mv	a1,s2
    356e:	8556                	mv	a0,s5
    3570:	00000097          	auipc	ra,0x0
    3574:	ee2080e7          	jalr	-286(ra) # 3452 <putc>
    3578:	a019                	j	357e <vprintf+0x60>
    } else if(state == '%'){
    357a:	01498f63          	beq	s3,s4,3598 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    357e:	0485                	addi	s1,s1,1
    3580:	fff4c903          	lbu	s2,-1(s1)
    3584:	14090d63          	beqz	s2,36de <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    3588:	0009079b          	sext.w	a5,s2
    if(state == 0){
    358c:	fe0997e3          	bnez	s3,357a <vprintf+0x5c>
      if(c == '%'){
    3590:	fd479ee3          	bne	a5,s4,356c <vprintf+0x4e>
        state = '%';
    3594:	89be                	mv	s3,a5
    3596:	b7e5                	j	357e <vprintf+0x60>
      if(c == 'd'){
    3598:	05878063          	beq	a5,s8,35d8 <vprintf+0xba>
      } else if(c == 'l') {
    359c:	05978c63          	beq	a5,s9,35f4 <vprintf+0xd6>
      } else if(c == 'x') {
    35a0:	07a78863          	beq	a5,s10,3610 <vprintf+0xf2>
      } else if(c == 'p') {
    35a4:	09b78463          	beq	a5,s11,362c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    35a8:	07300713          	li	a4,115
    35ac:	0ce78663          	beq	a5,a4,3678 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    35b0:	06300713          	li	a4,99
    35b4:	0ee78e63          	beq	a5,a4,36b0 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    35b8:	11478863          	beq	a5,s4,36c8 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    35bc:	85d2                	mv	a1,s4
    35be:	8556                	mv	a0,s5
    35c0:	00000097          	auipc	ra,0x0
    35c4:	e92080e7          	jalr	-366(ra) # 3452 <putc>
        putc(fd, c);
    35c8:	85ca                	mv	a1,s2
    35ca:	8556                	mv	a0,s5
    35cc:	00000097          	auipc	ra,0x0
    35d0:	e86080e7          	jalr	-378(ra) # 3452 <putc>
      }
      state = 0;
    35d4:	4981                	li	s3,0
    35d6:	b765                	j	357e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    35d8:	008b0913          	addi	s2,s6,8
    35dc:	4685                	li	a3,1
    35de:	4629                	li	a2,10
    35e0:	000b2583          	lw	a1,0(s6)
    35e4:	8556                	mv	a0,s5
    35e6:	00000097          	auipc	ra,0x0
    35ea:	e8e080e7          	jalr	-370(ra) # 3474 <printint>
    35ee:	8b4a                	mv	s6,s2
      state = 0;
    35f0:	4981                	li	s3,0
    35f2:	b771                	j	357e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    35f4:	008b0913          	addi	s2,s6,8
    35f8:	4681                	li	a3,0
    35fa:	4629                	li	a2,10
    35fc:	000b2583          	lw	a1,0(s6)
    3600:	8556                	mv	a0,s5
    3602:	00000097          	auipc	ra,0x0
    3606:	e72080e7          	jalr	-398(ra) # 3474 <printint>
    360a:	8b4a                	mv	s6,s2
      state = 0;
    360c:	4981                	li	s3,0
    360e:	bf85                	j	357e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    3610:	008b0913          	addi	s2,s6,8
    3614:	4681                	li	a3,0
    3616:	4641                	li	a2,16
    3618:	000b2583          	lw	a1,0(s6)
    361c:	8556                	mv	a0,s5
    361e:	00000097          	auipc	ra,0x0
    3622:	e56080e7          	jalr	-426(ra) # 3474 <printint>
    3626:	8b4a                	mv	s6,s2
      state = 0;
    3628:	4981                	li	s3,0
    362a:	bf91                	j	357e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    362c:	008b0793          	addi	a5,s6,8
    3630:	f8f43423          	sd	a5,-120(s0)
    3634:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    3638:	03000593          	li	a1,48
    363c:	8556                	mv	a0,s5
    363e:	00000097          	auipc	ra,0x0
    3642:	e14080e7          	jalr	-492(ra) # 3452 <putc>
  putc(fd, 'x');
    3646:	85ea                	mv	a1,s10
    3648:	8556                	mv	a0,s5
    364a:	00000097          	auipc	ra,0x0
    364e:	e08080e7          	jalr	-504(ra) # 3452 <putc>
    3652:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3654:	03c9d793          	srli	a5,s3,0x3c
    3658:	97de                	add	a5,a5,s7
    365a:	0007c583          	lbu	a1,0(a5)
    365e:	8556                	mv	a0,s5
    3660:	00000097          	auipc	ra,0x0
    3664:	df2080e7          	jalr	-526(ra) # 3452 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    3668:	0992                	slli	s3,s3,0x4
    366a:	397d                	addiw	s2,s2,-1
    366c:	fe0914e3          	bnez	s2,3654 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    3670:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    3674:	4981                	li	s3,0
    3676:	b721                	j	357e <vprintf+0x60>
        s = va_arg(ap, char*);
    3678:	008b0993          	addi	s3,s6,8
    367c:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    3680:	02090163          	beqz	s2,36a2 <vprintf+0x184>
        while(*s != 0){
    3684:	00094583          	lbu	a1,0(s2)
    3688:	c9a1                	beqz	a1,36d8 <vprintf+0x1ba>
          putc(fd, *s);
    368a:	8556                	mv	a0,s5
    368c:	00000097          	auipc	ra,0x0
    3690:	dc6080e7          	jalr	-570(ra) # 3452 <putc>
          s++;
    3694:	0905                	addi	s2,s2,1
        while(*s != 0){
    3696:	00094583          	lbu	a1,0(s2)
    369a:	f9e5                	bnez	a1,368a <vprintf+0x16c>
        s = va_arg(ap, char*);
    369c:	8b4e                	mv	s6,s3
      state = 0;
    369e:	4981                	li	s3,0
    36a0:	bdf9                	j	357e <vprintf+0x60>
          s = "(null)";
    36a2:	00000917          	auipc	s2,0x0
    36a6:	26e90913          	addi	s2,s2,622 # 3910 <malloc+0x128>
        while(*s != 0){
    36aa:	02800593          	li	a1,40
    36ae:	bff1                	j	368a <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    36b0:	008b0913          	addi	s2,s6,8
    36b4:	000b4583          	lbu	a1,0(s6)
    36b8:	8556                	mv	a0,s5
    36ba:	00000097          	auipc	ra,0x0
    36be:	d98080e7          	jalr	-616(ra) # 3452 <putc>
    36c2:	8b4a                	mv	s6,s2
      state = 0;
    36c4:	4981                	li	s3,0
    36c6:	bd65                	j	357e <vprintf+0x60>
        putc(fd, c);
    36c8:	85d2                	mv	a1,s4
    36ca:	8556                	mv	a0,s5
    36cc:	00000097          	auipc	ra,0x0
    36d0:	d86080e7          	jalr	-634(ra) # 3452 <putc>
      state = 0;
    36d4:	4981                	li	s3,0
    36d6:	b565                	j	357e <vprintf+0x60>
        s = va_arg(ap, char*);
    36d8:	8b4e                	mv	s6,s3
      state = 0;
    36da:	4981                	li	s3,0
    36dc:	b54d                	j	357e <vprintf+0x60>
    }
  }
}
    36de:	70e6                	ld	ra,120(sp)
    36e0:	7446                	ld	s0,112(sp)
    36e2:	74a6                	ld	s1,104(sp)
    36e4:	7906                	ld	s2,96(sp)
    36e6:	69e6                	ld	s3,88(sp)
    36e8:	6a46                	ld	s4,80(sp)
    36ea:	6aa6                	ld	s5,72(sp)
    36ec:	6b06                	ld	s6,64(sp)
    36ee:	7be2                	ld	s7,56(sp)
    36f0:	7c42                	ld	s8,48(sp)
    36f2:	7ca2                	ld	s9,40(sp)
    36f4:	7d02                	ld	s10,32(sp)
    36f6:	6de2                	ld	s11,24(sp)
    36f8:	6109                	addi	sp,sp,128
    36fa:	8082                	ret

00000000000036fc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    36fc:	715d                	addi	sp,sp,-80
    36fe:	ec06                	sd	ra,24(sp)
    3700:	e822                	sd	s0,16(sp)
    3702:	1000                	addi	s0,sp,32
    3704:	e010                	sd	a2,0(s0)
    3706:	e414                	sd	a3,8(s0)
    3708:	e818                	sd	a4,16(s0)
    370a:	ec1c                	sd	a5,24(s0)
    370c:	03043023          	sd	a6,32(s0)
    3710:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    3714:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    3718:	8622                	mv	a2,s0
    371a:	00000097          	auipc	ra,0x0
    371e:	e04080e7          	jalr	-508(ra) # 351e <vprintf>
}
    3722:	60e2                	ld	ra,24(sp)
    3724:	6442                	ld	s0,16(sp)
    3726:	6161                	addi	sp,sp,80
    3728:	8082                	ret

000000000000372a <printf>:

void
printf(const char *fmt, ...)
{
    372a:	711d                	addi	sp,sp,-96
    372c:	ec06                	sd	ra,24(sp)
    372e:	e822                	sd	s0,16(sp)
    3730:	1000                	addi	s0,sp,32
    3732:	e40c                	sd	a1,8(s0)
    3734:	e810                	sd	a2,16(s0)
    3736:	ec14                	sd	a3,24(s0)
    3738:	f018                	sd	a4,32(s0)
    373a:	f41c                	sd	a5,40(s0)
    373c:	03043823          	sd	a6,48(s0)
    3740:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    3744:	00840613          	addi	a2,s0,8
    3748:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    374c:	85aa                	mv	a1,a0
    374e:	4505                	li	a0,1
    3750:	00000097          	auipc	ra,0x0
    3754:	dce080e7          	jalr	-562(ra) # 351e <vprintf>
}
    3758:	60e2                	ld	ra,24(sp)
    375a:	6442                	ld	s0,16(sp)
    375c:	6125                	addi	sp,sp,96
    375e:	8082                	ret

0000000000003760 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3760:	1141                	addi	sp,sp,-16
    3762:	e422                	sd	s0,8(sp)
    3764:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3766:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    376a:	00001797          	auipc	a5,0x1
    376e:	8967b783          	ld	a5,-1898(a5) # 4000 <freep>
    3772:	a805                	j	37a2 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3774:	4618                	lw	a4,8(a2)
    3776:	9db9                	addw	a1,a1,a4
    3778:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    377c:	6398                	ld	a4,0(a5)
    377e:	6318                	ld	a4,0(a4)
    3780:	fee53823          	sd	a4,-16(a0)
    3784:	a091                	j	37c8 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3786:	ff852703          	lw	a4,-8(a0)
    378a:	9e39                	addw	a2,a2,a4
    378c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    378e:	ff053703          	ld	a4,-16(a0)
    3792:	e398                	sd	a4,0(a5)
    3794:	a099                	j	37da <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3796:	6398                	ld	a4,0(a5)
    3798:	00e7e463          	bltu	a5,a4,37a0 <free+0x40>
    379c:	00e6ea63          	bltu	a3,a4,37b0 <free+0x50>
{
    37a0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    37a2:	fed7fae3          	bgeu	a5,a3,3796 <free+0x36>
    37a6:	6398                	ld	a4,0(a5)
    37a8:	00e6e463          	bltu	a3,a4,37b0 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    37ac:	fee7eae3          	bltu	a5,a4,37a0 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    37b0:	ff852583          	lw	a1,-8(a0)
    37b4:	6390                	ld	a2,0(a5)
    37b6:	02059713          	slli	a4,a1,0x20
    37ba:	9301                	srli	a4,a4,0x20
    37bc:	0712                	slli	a4,a4,0x4
    37be:	9736                	add	a4,a4,a3
    37c0:	fae60ae3          	beq	a2,a4,3774 <free+0x14>
    bp->s.ptr = p->s.ptr;
    37c4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    37c8:	4790                	lw	a2,8(a5)
    37ca:	02061713          	slli	a4,a2,0x20
    37ce:	9301                	srli	a4,a4,0x20
    37d0:	0712                	slli	a4,a4,0x4
    37d2:	973e                	add	a4,a4,a5
    37d4:	fae689e3          	beq	a3,a4,3786 <free+0x26>
  } else
    p->s.ptr = bp;
    37d8:	e394                	sd	a3,0(a5)
  freep = p;
    37da:	00001717          	auipc	a4,0x1
    37de:	82f73323          	sd	a5,-2010(a4) # 4000 <freep>
}
    37e2:	6422                	ld	s0,8(sp)
    37e4:	0141                	addi	sp,sp,16
    37e6:	8082                	ret

00000000000037e8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    37e8:	7139                	addi	sp,sp,-64
    37ea:	fc06                	sd	ra,56(sp)
    37ec:	f822                	sd	s0,48(sp)
    37ee:	f426                	sd	s1,40(sp)
    37f0:	f04a                	sd	s2,32(sp)
    37f2:	ec4e                	sd	s3,24(sp)
    37f4:	e852                	sd	s4,16(sp)
    37f6:	e456                	sd	s5,8(sp)
    37f8:	e05a                	sd	s6,0(sp)
    37fa:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    37fc:	02051493          	slli	s1,a0,0x20
    3800:	9081                	srli	s1,s1,0x20
    3802:	04bd                	addi	s1,s1,15
    3804:	8091                	srli	s1,s1,0x4
    3806:	0014899b          	addiw	s3,s1,1
    380a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    380c:	00000517          	auipc	a0,0x0
    3810:	7f453503          	ld	a0,2036(a0) # 4000 <freep>
    3814:	c515                	beqz	a0,3840 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3816:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3818:	4798                	lw	a4,8(a5)
    381a:	02977f63          	bgeu	a4,s1,3858 <malloc+0x70>
    381e:	8a4e                	mv	s4,s3
    3820:	0009871b          	sext.w	a4,s3
    3824:	6685                	lui	a3,0x1
    3826:	00d77363          	bgeu	a4,a3,382c <malloc+0x44>
    382a:	6a05                	lui	s4,0x1
    382c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    3830:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3834:	00000917          	auipc	s2,0x0
    3838:	7cc90913          	addi	s2,s2,1996 # 4000 <freep>
  if(p == (char*)-1)
    383c:	5afd                	li	s5,-1
    383e:	a88d                	j	38b0 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    3840:	00000797          	auipc	a5,0x0
    3844:	7d078793          	addi	a5,a5,2000 # 4010 <base>
    3848:	00000717          	auipc	a4,0x0
    384c:	7af73c23          	sd	a5,1976(a4) # 4000 <freep>
    3850:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    3852:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    3856:	b7e1                	j	381e <malloc+0x36>
      if(p->s.size == nunits)
    3858:	02e48b63          	beq	s1,a4,388e <malloc+0xa6>
        p->s.size -= nunits;
    385c:	4137073b          	subw	a4,a4,s3
    3860:	c798                	sw	a4,8(a5)
        p += p->s.size;
    3862:	1702                	slli	a4,a4,0x20
    3864:	9301                	srli	a4,a4,0x20
    3866:	0712                	slli	a4,a4,0x4
    3868:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    386a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    386e:	00000717          	auipc	a4,0x0
    3872:	78a73923          	sd	a0,1938(a4) # 4000 <freep>
      return (void*)(p + 1);
    3876:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    387a:	70e2                	ld	ra,56(sp)
    387c:	7442                	ld	s0,48(sp)
    387e:	74a2                	ld	s1,40(sp)
    3880:	7902                	ld	s2,32(sp)
    3882:	69e2                	ld	s3,24(sp)
    3884:	6a42                	ld	s4,16(sp)
    3886:	6aa2                	ld	s5,8(sp)
    3888:	6b02                	ld	s6,0(sp)
    388a:	6121                	addi	sp,sp,64
    388c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    388e:	6398                	ld	a4,0(a5)
    3890:	e118                	sd	a4,0(a0)
    3892:	bff1                	j	386e <malloc+0x86>
  hp->s.size = nu;
    3894:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    3898:	0541                	addi	a0,a0,16
    389a:	00000097          	auipc	ra,0x0
    389e:	ec6080e7          	jalr	-314(ra) # 3760 <free>
  return freep;
    38a2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    38a6:	d971                	beqz	a0,387a <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    38a8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    38aa:	4798                	lw	a4,8(a5)
    38ac:	fa9776e3          	bgeu	a4,s1,3858 <malloc+0x70>
    if(p == freep)
    38b0:	00093703          	ld	a4,0(s2)
    38b4:	853e                	mv	a0,a5
    38b6:	fef719e3          	bne	a4,a5,38a8 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    38ba:	8552                	mv	a0,s4
    38bc:	00000097          	auipc	ra,0x0
    38c0:	b56080e7          	jalr	-1194(ra) # 3412 <sbrk>
  if(p == (char*)-1)
    38c4:	fd5518e3          	bne	a0,s5,3894 <malloc+0xac>
        return 0;
    38c8:	4501                	li	a0,0
    38ca:	bf45                	j	387a <malloc+0x92>
