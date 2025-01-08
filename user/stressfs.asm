
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
    3000:	dd010113          	addi	sp,sp,-560
    3004:	22113423          	sd	ra,552(sp)
    3008:	22813023          	sd	s0,544(sp)
    300c:	20913c23          	sd	s1,536(sp)
    3010:	21213823          	sd	s2,528(sp)
    3014:	1c00                	addi	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
    3016:	00001797          	auipc	a5,0x1
    301a:	95a78793          	addi	a5,a5,-1702 # 3970 <malloc+0x11e>
    301e:	6398                	ld	a4,0(a5)
    3020:	fce43823          	sd	a4,-48(s0)
    3024:	0087d783          	lhu	a5,8(a5)
    3028:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
    302c:	00001517          	auipc	a0,0x1
    3030:	91450513          	addi	a0,a0,-1772 # 3940 <malloc+0xee>
    3034:	00000097          	auipc	ra,0x0
    3038:	760080e7          	jalr	1888(ra) # 3794 <printf>
  memset(data, 'a', sizeof(data));
    303c:	20000613          	li	a2,512
    3040:	06100593          	li	a1,97
    3044:	dd040513          	addi	a0,s0,-560
    3048:	00000097          	auipc	ra,0x0
    304c:	150080e7          	jalr	336(ra) # 3198 <memset>

  for(i = 0; i < 4; i++)
    3050:	4481                	li	s1,0
    3052:	4911                	li	s2,4
    if(fork() > 0)
    3054:	00000097          	auipc	ra,0x0
    3058:	390080e7          	jalr	912(ra) # 33e4 <fork>
    305c:	00a04563          	bgtz	a0,3066 <main+0x66>
  for(i = 0; i < 4; i++)
    3060:	2485                	addiw	s1,s1,1
    3062:	ff2499e3          	bne	s1,s2,3054 <main+0x54>
      break;

  printf("write %d\n", i);
    3066:	85a6                	mv	a1,s1
    3068:	00001517          	auipc	a0,0x1
    306c:	8f050513          	addi	a0,a0,-1808 # 3958 <malloc+0x106>
    3070:	00000097          	auipc	ra,0x0
    3074:	724080e7          	jalr	1828(ra) # 3794 <printf>

  path[8] += i;
    3078:	fd844783          	lbu	a5,-40(s0)
    307c:	9cbd                	addw	s1,s1,a5
    307e:	fc940c23          	sb	s1,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
    3082:	20200593          	li	a1,514
    3086:	fd040513          	addi	a0,s0,-48
    308a:	00000097          	auipc	ra,0x0
    308e:	3aa080e7          	jalr	938(ra) # 3434 <open>
    3092:	892a                	mv	s2,a0
    3094:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
    3096:	20000613          	li	a2,512
    309a:	dd040593          	addi	a1,s0,-560
    309e:	854a                	mv	a0,s2
    30a0:	00000097          	auipc	ra,0x0
    30a4:	374080e7          	jalr	884(ra) # 3414 <write>
  for(i = 0; i < 20; i++)
    30a8:	34fd                	addiw	s1,s1,-1
    30aa:	f4f5                	bnez	s1,3096 <main+0x96>
  close(fd);
    30ac:	854a                	mv	a0,s2
    30ae:	00000097          	auipc	ra,0x0
    30b2:	36e080e7          	jalr	878(ra) # 341c <close>

  printf("read\n");
    30b6:	00001517          	auipc	a0,0x1
    30ba:	8b250513          	addi	a0,a0,-1870 # 3968 <malloc+0x116>
    30be:	00000097          	auipc	ra,0x0
    30c2:	6d6080e7          	jalr	1750(ra) # 3794 <printf>

  fd = open(path, O_RDONLY);
    30c6:	4581                	li	a1,0
    30c8:	fd040513          	addi	a0,s0,-48
    30cc:	00000097          	auipc	ra,0x0
    30d0:	368080e7          	jalr	872(ra) # 3434 <open>
    30d4:	892a                	mv	s2,a0
    30d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
    30d8:	20000613          	li	a2,512
    30dc:	dd040593          	addi	a1,s0,-560
    30e0:	854a                	mv	a0,s2
    30e2:	00000097          	auipc	ra,0x0
    30e6:	32a080e7          	jalr	810(ra) # 340c <read>
  for (i = 0; i < 20; i++)
    30ea:	34fd                	addiw	s1,s1,-1
    30ec:	f4f5                	bnez	s1,30d8 <main+0xd8>
  close(fd);
    30ee:	854a                	mv	a0,s2
    30f0:	00000097          	auipc	ra,0x0
    30f4:	32c080e7          	jalr	812(ra) # 341c <close>

  wait(0);
    30f8:	4501                	li	a0,0
    30fa:	00000097          	auipc	ra,0x0
    30fe:	2fa080e7          	jalr	762(ra) # 33f4 <wait>

  exit(0);
    3102:	4501                	li	a0,0
    3104:	00000097          	auipc	ra,0x0
    3108:	2e8080e7          	jalr	744(ra) # 33ec <exit>

000000000000310c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    310c:	1141                	addi	sp,sp,-16
    310e:	e406                	sd	ra,8(sp)
    3110:	e022                	sd	s0,0(sp)
    3112:	0800                	addi	s0,sp,16
  extern int main();
  main();
    3114:	00000097          	auipc	ra,0x0
    3118:	eec080e7          	jalr	-276(ra) # 3000 <main>
  exit(0);
    311c:	4501                	li	a0,0
    311e:	00000097          	auipc	ra,0x0
    3122:	2ce080e7          	jalr	718(ra) # 33ec <exit>

0000000000003126 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3126:	1141                	addi	sp,sp,-16
    3128:	e422                	sd	s0,8(sp)
    312a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    312c:	87aa                	mv	a5,a0
    312e:	0585                	addi	a1,a1,1
    3130:	0785                	addi	a5,a5,1
    3132:	fff5c703          	lbu	a4,-1(a1)
    3136:	fee78fa3          	sb	a4,-1(a5)
    313a:	fb75                	bnez	a4,312e <strcpy+0x8>
    ;
  return os;
}
    313c:	6422                	ld	s0,8(sp)
    313e:	0141                	addi	sp,sp,16
    3140:	8082                	ret

0000000000003142 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3142:	1141                	addi	sp,sp,-16
    3144:	e422                	sd	s0,8(sp)
    3146:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    3148:	00054783          	lbu	a5,0(a0)
    314c:	cb91                	beqz	a5,3160 <strcmp+0x1e>
    314e:	0005c703          	lbu	a4,0(a1)
    3152:	00f71763          	bne	a4,a5,3160 <strcmp+0x1e>
    p++, q++;
    3156:	0505                	addi	a0,a0,1
    3158:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    315a:	00054783          	lbu	a5,0(a0)
    315e:	fbe5                	bnez	a5,314e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    3160:	0005c503          	lbu	a0,0(a1)
}
    3164:	40a7853b          	subw	a0,a5,a0
    3168:	6422                	ld	s0,8(sp)
    316a:	0141                	addi	sp,sp,16
    316c:	8082                	ret

000000000000316e <strlen>:

uint
strlen(const char *s)
{
    316e:	1141                	addi	sp,sp,-16
    3170:	e422                	sd	s0,8(sp)
    3172:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    3174:	00054783          	lbu	a5,0(a0)
    3178:	cf91                	beqz	a5,3194 <strlen+0x26>
    317a:	0505                	addi	a0,a0,1
    317c:	87aa                	mv	a5,a0
    317e:	4685                	li	a3,1
    3180:	9e89                	subw	a3,a3,a0
    3182:	00f6853b          	addw	a0,a3,a5
    3186:	0785                	addi	a5,a5,1
    3188:	fff7c703          	lbu	a4,-1(a5)
    318c:	fb7d                	bnez	a4,3182 <strlen+0x14>
    ;
  return n;
}
    318e:	6422                	ld	s0,8(sp)
    3190:	0141                	addi	sp,sp,16
    3192:	8082                	ret
  for(n = 0; s[n]; n++)
    3194:	4501                	li	a0,0
    3196:	bfe5                	j	318e <strlen+0x20>

0000000000003198 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3198:	1141                	addi	sp,sp,-16
    319a:	e422                	sd	s0,8(sp)
    319c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    319e:	ca19                	beqz	a2,31b4 <memset+0x1c>
    31a0:	87aa                	mv	a5,a0
    31a2:	1602                	slli	a2,a2,0x20
    31a4:	9201                	srli	a2,a2,0x20
    31a6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    31aa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    31ae:	0785                	addi	a5,a5,1
    31b0:	fee79de3          	bne	a5,a4,31aa <memset+0x12>
  }
  return dst;
}
    31b4:	6422                	ld	s0,8(sp)
    31b6:	0141                	addi	sp,sp,16
    31b8:	8082                	ret

00000000000031ba <strchr>:

char*
strchr(const char *s, char c)
{
    31ba:	1141                	addi	sp,sp,-16
    31bc:	e422                	sd	s0,8(sp)
    31be:	0800                	addi	s0,sp,16
  for(; *s; s++)
    31c0:	00054783          	lbu	a5,0(a0)
    31c4:	cb99                	beqz	a5,31da <strchr+0x20>
    if(*s == c)
    31c6:	00f58763          	beq	a1,a5,31d4 <strchr+0x1a>
  for(; *s; s++)
    31ca:	0505                	addi	a0,a0,1
    31cc:	00054783          	lbu	a5,0(a0)
    31d0:	fbfd                	bnez	a5,31c6 <strchr+0xc>
      return (char*)s;
  return 0;
    31d2:	4501                	li	a0,0
}
    31d4:	6422                	ld	s0,8(sp)
    31d6:	0141                	addi	sp,sp,16
    31d8:	8082                	ret
  return 0;
    31da:	4501                	li	a0,0
    31dc:	bfe5                	j	31d4 <strchr+0x1a>

00000000000031de <gets>:

char*
gets(char *buf, int max)
{
    31de:	711d                	addi	sp,sp,-96
    31e0:	ec86                	sd	ra,88(sp)
    31e2:	e8a2                	sd	s0,80(sp)
    31e4:	e4a6                	sd	s1,72(sp)
    31e6:	e0ca                	sd	s2,64(sp)
    31e8:	fc4e                	sd	s3,56(sp)
    31ea:	f852                	sd	s4,48(sp)
    31ec:	f456                	sd	s5,40(sp)
    31ee:	f05a                	sd	s6,32(sp)
    31f0:	ec5e                	sd	s7,24(sp)
    31f2:	1080                	addi	s0,sp,96
    31f4:	8baa                	mv	s7,a0
    31f6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    31f8:	892a                	mv	s2,a0
    31fa:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    31fc:	4aa9                	li	s5,10
    31fe:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    3200:	89a6                	mv	s3,s1
    3202:	2485                	addiw	s1,s1,1
    3204:	0344d863          	bge	s1,s4,3234 <gets+0x56>
    cc = read(0, &c, 1);
    3208:	4605                	li	a2,1
    320a:	faf40593          	addi	a1,s0,-81
    320e:	4501                	li	a0,0
    3210:	00000097          	auipc	ra,0x0
    3214:	1fc080e7          	jalr	508(ra) # 340c <read>
    if(cc < 1)
    3218:	00a05e63          	blez	a0,3234 <gets+0x56>
    buf[i++] = c;
    321c:	faf44783          	lbu	a5,-81(s0)
    3220:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3224:	01578763          	beq	a5,s5,3232 <gets+0x54>
    3228:	0905                	addi	s2,s2,1
    322a:	fd679be3          	bne	a5,s6,3200 <gets+0x22>
  for(i=0; i+1 < max; ){
    322e:	89a6                	mv	s3,s1
    3230:	a011                	j	3234 <gets+0x56>
    3232:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3234:	99de                	add	s3,s3,s7
    3236:	00098023          	sb	zero,0(s3)
  return buf;
}
    323a:	855e                	mv	a0,s7
    323c:	60e6                	ld	ra,88(sp)
    323e:	6446                	ld	s0,80(sp)
    3240:	64a6                	ld	s1,72(sp)
    3242:	6906                	ld	s2,64(sp)
    3244:	79e2                	ld	s3,56(sp)
    3246:	7a42                	ld	s4,48(sp)
    3248:	7aa2                	ld	s5,40(sp)
    324a:	7b02                	ld	s6,32(sp)
    324c:	6be2                	ld	s7,24(sp)
    324e:	6125                	addi	sp,sp,96
    3250:	8082                	ret

0000000000003252 <stat>:

int
stat(const char *n, struct stat *st)
{
    3252:	1101                	addi	sp,sp,-32
    3254:	ec06                	sd	ra,24(sp)
    3256:	e822                	sd	s0,16(sp)
    3258:	e426                	sd	s1,8(sp)
    325a:	e04a                	sd	s2,0(sp)
    325c:	1000                	addi	s0,sp,32
    325e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3260:	4581                	li	a1,0
    3262:	00000097          	auipc	ra,0x0
    3266:	1d2080e7          	jalr	466(ra) # 3434 <open>
  if(fd < 0)
    326a:	02054563          	bltz	a0,3294 <stat+0x42>
    326e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    3270:	85ca                	mv	a1,s2
    3272:	00000097          	auipc	ra,0x0
    3276:	1da080e7          	jalr	474(ra) # 344c <fstat>
    327a:	892a                	mv	s2,a0
  close(fd);
    327c:	8526                	mv	a0,s1
    327e:	00000097          	auipc	ra,0x0
    3282:	19e080e7          	jalr	414(ra) # 341c <close>
  return r;
}
    3286:	854a                	mv	a0,s2
    3288:	60e2                	ld	ra,24(sp)
    328a:	6442                	ld	s0,16(sp)
    328c:	64a2                	ld	s1,8(sp)
    328e:	6902                	ld	s2,0(sp)
    3290:	6105                	addi	sp,sp,32
    3292:	8082                	ret
    return -1;
    3294:	597d                	li	s2,-1
    3296:	bfc5                	j	3286 <stat+0x34>

0000000000003298 <atoi>:

int
atoi(const char *s)
{
    3298:	1141                	addi	sp,sp,-16
    329a:	e422                	sd	s0,8(sp)
    329c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    329e:	00054603          	lbu	a2,0(a0)
    32a2:	fd06079b          	addiw	a5,a2,-48
    32a6:	0ff7f793          	andi	a5,a5,255
    32aa:	4725                	li	a4,9
    32ac:	02f76963          	bltu	a4,a5,32de <atoi+0x46>
    32b0:	86aa                	mv	a3,a0
  n = 0;
    32b2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    32b4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    32b6:	0685                	addi	a3,a3,1
    32b8:	0025179b          	slliw	a5,a0,0x2
    32bc:	9fa9                	addw	a5,a5,a0
    32be:	0017979b          	slliw	a5,a5,0x1
    32c2:	9fb1                	addw	a5,a5,a2
    32c4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    32c8:	0006c603          	lbu	a2,0(a3)
    32cc:	fd06071b          	addiw	a4,a2,-48
    32d0:	0ff77713          	andi	a4,a4,255
    32d4:	fee5f1e3          	bgeu	a1,a4,32b6 <atoi+0x1e>
  return n;
}
    32d8:	6422                	ld	s0,8(sp)
    32da:	0141                	addi	sp,sp,16
    32dc:	8082                	ret
  n = 0;
    32de:	4501                	li	a0,0
    32e0:	bfe5                	j	32d8 <atoi+0x40>

00000000000032e2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    32e2:	1141                	addi	sp,sp,-16
    32e4:	e422                	sd	s0,8(sp)
    32e6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    32e8:	02b57463          	bgeu	a0,a1,3310 <memmove+0x2e>
    while(n-- > 0)
    32ec:	00c05f63          	blez	a2,330a <memmove+0x28>
    32f0:	1602                	slli	a2,a2,0x20
    32f2:	9201                	srli	a2,a2,0x20
    32f4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    32f8:	872a                	mv	a4,a0
      *dst++ = *src++;
    32fa:	0585                	addi	a1,a1,1
    32fc:	0705                	addi	a4,a4,1
    32fe:	fff5c683          	lbu	a3,-1(a1)
    3302:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3306:	fee79ae3          	bne	a5,a4,32fa <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    330a:	6422                	ld	s0,8(sp)
    330c:	0141                	addi	sp,sp,16
    330e:	8082                	ret
    dst += n;
    3310:	00c50733          	add	a4,a0,a2
    src += n;
    3314:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    3316:	fec05ae3          	blez	a2,330a <memmove+0x28>
    331a:	fff6079b          	addiw	a5,a2,-1
    331e:	1782                	slli	a5,a5,0x20
    3320:	9381                	srli	a5,a5,0x20
    3322:	fff7c793          	not	a5,a5
    3326:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3328:	15fd                	addi	a1,a1,-1
    332a:	177d                	addi	a4,a4,-1
    332c:	0005c683          	lbu	a3,0(a1)
    3330:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3334:	fee79ae3          	bne	a5,a4,3328 <memmove+0x46>
    3338:	bfc9                	j	330a <memmove+0x28>

000000000000333a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    333a:	1141                	addi	sp,sp,-16
    333c:	e422                	sd	s0,8(sp)
    333e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    3340:	ca05                	beqz	a2,3370 <memcmp+0x36>
    3342:	fff6069b          	addiw	a3,a2,-1
    3346:	1682                	slli	a3,a3,0x20
    3348:	9281                	srli	a3,a3,0x20
    334a:	0685                	addi	a3,a3,1
    334c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    334e:	00054783          	lbu	a5,0(a0)
    3352:	0005c703          	lbu	a4,0(a1)
    3356:	00e79863          	bne	a5,a4,3366 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    335a:	0505                	addi	a0,a0,1
    p2++;
    335c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    335e:	fed518e3          	bne	a0,a3,334e <memcmp+0x14>
  }
  return 0;
    3362:	4501                	li	a0,0
    3364:	a019                	j	336a <memcmp+0x30>
      return *p1 - *p2;
    3366:	40e7853b          	subw	a0,a5,a4
}
    336a:	6422                	ld	s0,8(sp)
    336c:	0141                	addi	sp,sp,16
    336e:	8082                	ret
  return 0;
    3370:	4501                	li	a0,0
    3372:	bfe5                	j	336a <memcmp+0x30>

0000000000003374 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    3374:	1141                	addi	sp,sp,-16
    3376:	e406                	sd	ra,8(sp)
    3378:	e022                	sd	s0,0(sp)
    337a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    337c:	00000097          	auipc	ra,0x0
    3380:	f66080e7          	jalr	-154(ra) # 32e2 <memmove>
}
    3384:	60a2                	ld	ra,8(sp)
    3386:	6402                	ld	s0,0(sp)
    3388:	0141                	addi	sp,sp,16
    338a:	8082                	ret

000000000000338c <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    338c:	1141                	addi	sp,sp,-16
    338e:	e422                	sd	s0,8(sp)
    3390:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    3392:	00052023          	sw	zero,0(a0)
}  
    3396:	6422                	ld	s0,8(sp)
    3398:	0141                	addi	sp,sp,16
    339a:	8082                	ret

000000000000339c <lock>:

void lock(struct spinlock * lk) 
{    
    339c:	1141                	addi	sp,sp,-16
    339e:	e422                	sd	s0,8(sp)
    33a0:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    33a2:	4705                	li	a4,1
    33a4:	87ba                	mv	a5,a4
    33a6:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    33aa:	2781                	sext.w	a5,a5
    33ac:	ffe5                	bnez	a5,33a4 <lock+0x8>
}  
    33ae:	6422                	ld	s0,8(sp)
    33b0:	0141                	addi	sp,sp,16
    33b2:	8082                	ret

00000000000033b4 <unlock>:

void unlock(struct spinlock * lk) 
{   
    33b4:	1141                	addi	sp,sp,-16
    33b6:	e422                	sd	s0,8(sp)
    33b8:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    33ba:	0f50000f          	fence	iorw,ow
    33be:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    33c2:	6422                	ld	s0,8(sp)
    33c4:	0141                	addi	sp,sp,16
    33c6:	8082                	ret

00000000000033c8 <isDigit>:

unsigned int isDigit(char *c) {
    33c8:	1141                	addi	sp,sp,-16
    33ca:	e422                	sd	s0,8(sp)
    33cc:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    33ce:	00054503          	lbu	a0,0(a0)
    33d2:	fd05051b          	addiw	a0,a0,-48
    33d6:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    33da:	00a53513          	sltiu	a0,a0,10
    33de:	6422                	ld	s0,8(sp)
    33e0:	0141                	addi	sp,sp,16
    33e2:	8082                	ret

00000000000033e4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    33e4:	4885                	li	a7,1
 ecall
    33e6:	00000073          	ecall
 ret
    33ea:	8082                	ret

00000000000033ec <exit>:
.global exit
exit:
 li a7, SYS_exit
    33ec:	4889                	li	a7,2
 ecall
    33ee:	00000073          	ecall
 ret
    33f2:	8082                	ret

00000000000033f4 <wait>:
.global wait
wait:
 li a7, SYS_wait
    33f4:	488d                	li	a7,3
 ecall
    33f6:	00000073          	ecall
 ret
    33fa:	8082                	ret

00000000000033fc <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    33fc:	48e1                	li	a7,24
 ecall
    33fe:	00000073          	ecall
 ret
    3402:	8082                	ret

0000000000003404 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    3404:	4891                	li	a7,4
 ecall
    3406:	00000073          	ecall
 ret
    340a:	8082                	ret

000000000000340c <read>:
.global read
read:
 li a7, SYS_read
    340c:	4895                	li	a7,5
 ecall
    340e:	00000073          	ecall
 ret
    3412:	8082                	ret

0000000000003414 <write>:
.global write
write:
 li a7, SYS_write
    3414:	48c1                	li	a7,16
 ecall
    3416:	00000073          	ecall
 ret
    341a:	8082                	ret

000000000000341c <close>:
.global close
close:
 li a7, SYS_close
    341c:	48d5                	li	a7,21
 ecall
    341e:	00000073          	ecall
 ret
    3422:	8082                	ret

0000000000003424 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3424:	4899                	li	a7,6
 ecall
    3426:	00000073          	ecall
 ret
    342a:	8082                	ret

000000000000342c <exec>:
.global exec
exec:
 li a7, SYS_exec
    342c:	489d                	li	a7,7
 ecall
    342e:	00000073          	ecall
 ret
    3432:	8082                	ret

0000000000003434 <open>:
.global open
open:
 li a7, SYS_open
    3434:	48bd                	li	a7,15
 ecall
    3436:	00000073          	ecall
 ret
    343a:	8082                	ret

000000000000343c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    343c:	48c5                	li	a7,17
 ecall
    343e:	00000073          	ecall
 ret
    3442:	8082                	ret

0000000000003444 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3444:	48c9                	li	a7,18
 ecall
    3446:	00000073          	ecall
 ret
    344a:	8082                	ret

000000000000344c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    344c:	48a1                	li	a7,8
 ecall
    344e:	00000073          	ecall
 ret
    3452:	8082                	ret

0000000000003454 <link>:
.global link
link:
 li a7, SYS_link
    3454:	48cd                	li	a7,19
 ecall
    3456:	00000073          	ecall
 ret
    345a:	8082                	ret

000000000000345c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    345c:	48d1                	li	a7,20
 ecall
    345e:	00000073          	ecall
 ret
    3462:	8082                	ret

0000000000003464 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3464:	48a5                	li	a7,9
 ecall
    3466:	00000073          	ecall
 ret
    346a:	8082                	ret

000000000000346c <dup>:
.global dup
dup:
 li a7, SYS_dup
    346c:	48a9                	li	a7,10
 ecall
    346e:	00000073          	ecall
 ret
    3472:	8082                	ret

0000000000003474 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    3474:	48ad                	li	a7,11
 ecall
    3476:	00000073          	ecall
 ret
    347a:	8082                	ret

000000000000347c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    347c:	48b1                	li	a7,12
 ecall
    347e:	00000073          	ecall
 ret
    3482:	8082                	ret

0000000000003484 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    3484:	48b5                	li	a7,13
 ecall
    3486:	00000073          	ecall
 ret
    348a:	8082                	ret

000000000000348c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    348c:	48b9                	li	a7,14
 ecall
    348e:	00000073          	ecall
 ret
    3492:	8082                	ret

0000000000003494 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    3494:	48d9                	li	a7,22
 ecall
    3496:	00000073          	ecall
 ret
    349a:	8082                	ret

000000000000349c <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    349c:	48dd                	li	a7,23
 ecall
    349e:	00000073          	ecall
 ret
    34a2:	8082                	ret

00000000000034a4 <ps>:
.global ps
ps:
 li a7, SYS_ps
    34a4:	48e5                	li	a7,25
 ecall
    34a6:	00000073          	ecall
 ret
    34aa:	8082                	ret

00000000000034ac <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    34ac:	48e9                	li	a7,26
 ecall
    34ae:	00000073          	ecall
 ret
    34b2:	8082                	ret

00000000000034b4 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    34b4:	48ed                	li	a7,27
 ecall
    34b6:	00000073          	ecall
 ret
    34ba:	8082                	ret

00000000000034bc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    34bc:	1101                	addi	sp,sp,-32
    34be:	ec06                	sd	ra,24(sp)
    34c0:	e822                	sd	s0,16(sp)
    34c2:	1000                	addi	s0,sp,32
    34c4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    34c8:	4605                	li	a2,1
    34ca:	fef40593          	addi	a1,s0,-17
    34ce:	00000097          	auipc	ra,0x0
    34d2:	f46080e7          	jalr	-186(ra) # 3414 <write>
}
    34d6:	60e2                	ld	ra,24(sp)
    34d8:	6442                	ld	s0,16(sp)
    34da:	6105                	addi	sp,sp,32
    34dc:	8082                	ret

00000000000034de <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    34de:	7139                	addi	sp,sp,-64
    34e0:	fc06                	sd	ra,56(sp)
    34e2:	f822                	sd	s0,48(sp)
    34e4:	f426                	sd	s1,40(sp)
    34e6:	f04a                	sd	s2,32(sp)
    34e8:	ec4e                	sd	s3,24(sp)
    34ea:	0080                	addi	s0,sp,64
    34ec:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    34ee:	c299                	beqz	a3,34f4 <printint+0x16>
    34f0:	0805c863          	bltz	a1,3580 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    34f4:	2581                	sext.w	a1,a1
  neg = 0;
    34f6:	4881                	li	a7,0
    34f8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    34fc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    34fe:	2601                	sext.w	a2,a2
    3500:	00000517          	auipc	a0,0x0
    3504:	48850513          	addi	a0,a0,1160 # 3988 <digits>
    3508:	883a                	mv	a6,a4
    350a:	2705                	addiw	a4,a4,1
    350c:	02c5f7bb          	remuw	a5,a1,a2
    3510:	1782                	slli	a5,a5,0x20
    3512:	9381                	srli	a5,a5,0x20
    3514:	97aa                	add	a5,a5,a0
    3516:	0007c783          	lbu	a5,0(a5)
    351a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    351e:	0005879b          	sext.w	a5,a1
    3522:	02c5d5bb          	divuw	a1,a1,a2
    3526:	0685                	addi	a3,a3,1
    3528:	fec7f0e3          	bgeu	a5,a2,3508 <printint+0x2a>
  if(neg)
    352c:	00088b63          	beqz	a7,3542 <printint+0x64>
    buf[i++] = '-';
    3530:	fd040793          	addi	a5,s0,-48
    3534:	973e                	add	a4,a4,a5
    3536:	02d00793          	li	a5,45
    353a:	fef70823          	sb	a5,-16(a4)
    353e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    3542:	02e05863          	blez	a4,3572 <printint+0x94>
    3546:	fc040793          	addi	a5,s0,-64
    354a:	00e78933          	add	s2,a5,a4
    354e:	fff78993          	addi	s3,a5,-1
    3552:	99ba                	add	s3,s3,a4
    3554:	377d                	addiw	a4,a4,-1
    3556:	1702                	slli	a4,a4,0x20
    3558:	9301                	srli	a4,a4,0x20
    355a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    355e:	fff94583          	lbu	a1,-1(s2)
    3562:	8526                	mv	a0,s1
    3564:	00000097          	auipc	ra,0x0
    3568:	f58080e7          	jalr	-168(ra) # 34bc <putc>
  while(--i >= 0)
    356c:	197d                	addi	s2,s2,-1
    356e:	ff3918e3          	bne	s2,s3,355e <printint+0x80>
}
    3572:	70e2                	ld	ra,56(sp)
    3574:	7442                	ld	s0,48(sp)
    3576:	74a2                	ld	s1,40(sp)
    3578:	7902                	ld	s2,32(sp)
    357a:	69e2                	ld	s3,24(sp)
    357c:	6121                	addi	sp,sp,64
    357e:	8082                	ret
    x = -xx;
    3580:	40b005bb          	negw	a1,a1
    neg = 1;
    3584:	4885                	li	a7,1
    x = -xx;
    3586:	bf8d                	j	34f8 <printint+0x1a>

0000000000003588 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    3588:	7119                	addi	sp,sp,-128
    358a:	fc86                	sd	ra,120(sp)
    358c:	f8a2                	sd	s0,112(sp)
    358e:	f4a6                	sd	s1,104(sp)
    3590:	f0ca                	sd	s2,96(sp)
    3592:	ecce                	sd	s3,88(sp)
    3594:	e8d2                	sd	s4,80(sp)
    3596:	e4d6                	sd	s5,72(sp)
    3598:	e0da                	sd	s6,64(sp)
    359a:	fc5e                	sd	s7,56(sp)
    359c:	f862                	sd	s8,48(sp)
    359e:	f466                	sd	s9,40(sp)
    35a0:	f06a                	sd	s10,32(sp)
    35a2:	ec6e                	sd	s11,24(sp)
    35a4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    35a6:	0005c903          	lbu	s2,0(a1)
    35aa:	18090f63          	beqz	s2,3748 <vprintf+0x1c0>
    35ae:	8aaa                	mv	s5,a0
    35b0:	8b32                	mv	s6,a2
    35b2:	00158493          	addi	s1,a1,1
  state = 0;
    35b6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    35b8:	02500a13          	li	s4,37
      if(c == 'd'){
    35bc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    35c0:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    35c4:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    35c8:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    35cc:	00000b97          	auipc	s7,0x0
    35d0:	3bcb8b93          	addi	s7,s7,956 # 3988 <digits>
    35d4:	a839                	j	35f2 <vprintf+0x6a>
        putc(fd, c);
    35d6:	85ca                	mv	a1,s2
    35d8:	8556                	mv	a0,s5
    35da:	00000097          	auipc	ra,0x0
    35de:	ee2080e7          	jalr	-286(ra) # 34bc <putc>
    35e2:	a019                	j	35e8 <vprintf+0x60>
    } else if(state == '%'){
    35e4:	01498f63          	beq	s3,s4,3602 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    35e8:	0485                	addi	s1,s1,1
    35ea:	fff4c903          	lbu	s2,-1(s1)
    35ee:	14090d63          	beqz	s2,3748 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    35f2:	0009079b          	sext.w	a5,s2
    if(state == 0){
    35f6:	fe0997e3          	bnez	s3,35e4 <vprintf+0x5c>
      if(c == '%'){
    35fa:	fd479ee3          	bne	a5,s4,35d6 <vprintf+0x4e>
        state = '%';
    35fe:	89be                	mv	s3,a5
    3600:	b7e5                	j	35e8 <vprintf+0x60>
      if(c == 'd'){
    3602:	05878063          	beq	a5,s8,3642 <vprintf+0xba>
      } else if(c == 'l') {
    3606:	05978c63          	beq	a5,s9,365e <vprintf+0xd6>
      } else if(c == 'x') {
    360a:	07a78863          	beq	a5,s10,367a <vprintf+0xf2>
      } else if(c == 'p') {
    360e:	09b78463          	beq	a5,s11,3696 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    3612:	07300713          	li	a4,115
    3616:	0ce78663          	beq	a5,a4,36e2 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    361a:	06300713          	li	a4,99
    361e:	0ee78e63          	beq	a5,a4,371a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    3622:	11478863          	beq	a5,s4,3732 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3626:	85d2                	mv	a1,s4
    3628:	8556                	mv	a0,s5
    362a:	00000097          	auipc	ra,0x0
    362e:	e92080e7          	jalr	-366(ra) # 34bc <putc>
        putc(fd, c);
    3632:	85ca                	mv	a1,s2
    3634:	8556                	mv	a0,s5
    3636:	00000097          	auipc	ra,0x0
    363a:	e86080e7          	jalr	-378(ra) # 34bc <putc>
      }
      state = 0;
    363e:	4981                	li	s3,0
    3640:	b765                	j	35e8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    3642:	008b0913          	addi	s2,s6,8
    3646:	4685                	li	a3,1
    3648:	4629                	li	a2,10
    364a:	000b2583          	lw	a1,0(s6)
    364e:	8556                	mv	a0,s5
    3650:	00000097          	auipc	ra,0x0
    3654:	e8e080e7          	jalr	-370(ra) # 34de <printint>
    3658:	8b4a                	mv	s6,s2
      state = 0;
    365a:	4981                	li	s3,0
    365c:	b771                	j	35e8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    365e:	008b0913          	addi	s2,s6,8
    3662:	4681                	li	a3,0
    3664:	4629                	li	a2,10
    3666:	000b2583          	lw	a1,0(s6)
    366a:	8556                	mv	a0,s5
    366c:	00000097          	auipc	ra,0x0
    3670:	e72080e7          	jalr	-398(ra) # 34de <printint>
    3674:	8b4a                	mv	s6,s2
      state = 0;
    3676:	4981                	li	s3,0
    3678:	bf85                	j	35e8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    367a:	008b0913          	addi	s2,s6,8
    367e:	4681                	li	a3,0
    3680:	4641                	li	a2,16
    3682:	000b2583          	lw	a1,0(s6)
    3686:	8556                	mv	a0,s5
    3688:	00000097          	auipc	ra,0x0
    368c:	e56080e7          	jalr	-426(ra) # 34de <printint>
    3690:	8b4a                	mv	s6,s2
      state = 0;
    3692:	4981                	li	s3,0
    3694:	bf91                	j	35e8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    3696:	008b0793          	addi	a5,s6,8
    369a:	f8f43423          	sd	a5,-120(s0)
    369e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    36a2:	03000593          	li	a1,48
    36a6:	8556                	mv	a0,s5
    36a8:	00000097          	auipc	ra,0x0
    36ac:	e14080e7          	jalr	-492(ra) # 34bc <putc>
  putc(fd, 'x');
    36b0:	85ea                	mv	a1,s10
    36b2:	8556                	mv	a0,s5
    36b4:	00000097          	auipc	ra,0x0
    36b8:	e08080e7          	jalr	-504(ra) # 34bc <putc>
    36bc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    36be:	03c9d793          	srli	a5,s3,0x3c
    36c2:	97de                	add	a5,a5,s7
    36c4:	0007c583          	lbu	a1,0(a5)
    36c8:	8556                	mv	a0,s5
    36ca:	00000097          	auipc	ra,0x0
    36ce:	df2080e7          	jalr	-526(ra) # 34bc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    36d2:	0992                	slli	s3,s3,0x4
    36d4:	397d                	addiw	s2,s2,-1
    36d6:	fe0914e3          	bnez	s2,36be <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    36da:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    36de:	4981                	li	s3,0
    36e0:	b721                	j	35e8 <vprintf+0x60>
        s = va_arg(ap, char*);
    36e2:	008b0993          	addi	s3,s6,8
    36e6:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    36ea:	02090163          	beqz	s2,370c <vprintf+0x184>
        while(*s != 0){
    36ee:	00094583          	lbu	a1,0(s2)
    36f2:	c9a1                	beqz	a1,3742 <vprintf+0x1ba>
          putc(fd, *s);
    36f4:	8556                	mv	a0,s5
    36f6:	00000097          	auipc	ra,0x0
    36fa:	dc6080e7          	jalr	-570(ra) # 34bc <putc>
          s++;
    36fe:	0905                	addi	s2,s2,1
        while(*s != 0){
    3700:	00094583          	lbu	a1,0(s2)
    3704:	f9e5                	bnez	a1,36f4 <vprintf+0x16c>
        s = va_arg(ap, char*);
    3706:	8b4e                	mv	s6,s3
      state = 0;
    3708:	4981                	li	s3,0
    370a:	bdf9                	j	35e8 <vprintf+0x60>
          s = "(null)";
    370c:	00000917          	auipc	s2,0x0
    3710:	27490913          	addi	s2,s2,628 # 3980 <malloc+0x12e>
        while(*s != 0){
    3714:	02800593          	li	a1,40
    3718:	bff1                	j	36f4 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    371a:	008b0913          	addi	s2,s6,8
    371e:	000b4583          	lbu	a1,0(s6)
    3722:	8556                	mv	a0,s5
    3724:	00000097          	auipc	ra,0x0
    3728:	d98080e7          	jalr	-616(ra) # 34bc <putc>
    372c:	8b4a                	mv	s6,s2
      state = 0;
    372e:	4981                	li	s3,0
    3730:	bd65                	j	35e8 <vprintf+0x60>
        putc(fd, c);
    3732:	85d2                	mv	a1,s4
    3734:	8556                	mv	a0,s5
    3736:	00000097          	auipc	ra,0x0
    373a:	d86080e7          	jalr	-634(ra) # 34bc <putc>
      state = 0;
    373e:	4981                	li	s3,0
    3740:	b565                	j	35e8 <vprintf+0x60>
        s = va_arg(ap, char*);
    3742:	8b4e                	mv	s6,s3
      state = 0;
    3744:	4981                	li	s3,0
    3746:	b54d                	j	35e8 <vprintf+0x60>
    }
  }
}
    3748:	70e6                	ld	ra,120(sp)
    374a:	7446                	ld	s0,112(sp)
    374c:	74a6                	ld	s1,104(sp)
    374e:	7906                	ld	s2,96(sp)
    3750:	69e6                	ld	s3,88(sp)
    3752:	6a46                	ld	s4,80(sp)
    3754:	6aa6                	ld	s5,72(sp)
    3756:	6b06                	ld	s6,64(sp)
    3758:	7be2                	ld	s7,56(sp)
    375a:	7c42                	ld	s8,48(sp)
    375c:	7ca2                	ld	s9,40(sp)
    375e:	7d02                	ld	s10,32(sp)
    3760:	6de2                	ld	s11,24(sp)
    3762:	6109                	addi	sp,sp,128
    3764:	8082                	ret

0000000000003766 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    3766:	715d                	addi	sp,sp,-80
    3768:	ec06                	sd	ra,24(sp)
    376a:	e822                	sd	s0,16(sp)
    376c:	1000                	addi	s0,sp,32
    376e:	e010                	sd	a2,0(s0)
    3770:	e414                	sd	a3,8(s0)
    3772:	e818                	sd	a4,16(s0)
    3774:	ec1c                	sd	a5,24(s0)
    3776:	03043023          	sd	a6,32(s0)
    377a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    377e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    3782:	8622                	mv	a2,s0
    3784:	00000097          	auipc	ra,0x0
    3788:	e04080e7          	jalr	-508(ra) # 3588 <vprintf>
}
    378c:	60e2                	ld	ra,24(sp)
    378e:	6442                	ld	s0,16(sp)
    3790:	6161                	addi	sp,sp,80
    3792:	8082                	ret

0000000000003794 <printf>:

void
printf(const char *fmt, ...)
{
    3794:	711d                	addi	sp,sp,-96
    3796:	ec06                	sd	ra,24(sp)
    3798:	e822                	sd	s0,16(sp)
    379a:	1000                	addi	s0,sp,32
    379c:	e40c                	sd	a1,8(s0)
    379e:	e810                	sd	a2,16(s0)
    37a0:	ec14                	sd	a3,24(s0)
    37a2:	f018                	sd	a4,32(s0)
    37a4:	f41c                	sd	a5,40(s0)
    37a6:	03043823          	sd	a6,48(s0)
    37aa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    37ae:	00840613          	addi	a2,s0,8
    37b2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    37b6:	85aa                	mv	a1,a0
    37b8:	4505                	li	a0,1
    37ba:	00000097          	auipc	ra,0x0
    37be:	dce080e7          	jalr	-562(ra) # 3588 <vprintf>
}
    37c2:	60e2                	ld	ra,24(sp)
    37c4:	6442                	ld	s0,16(sp)
    37c6:	6125                	addi	sp,sp,96
    37c8:	8082                	ret

00000000000037ca <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    37ca:	1141                	addi	sp,sp,-16
    37cc:	e422                	sd	s0,8(sp)
    37ce:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    37d0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    37d4:	00001797          	auipc	a5,0x1
    37d8:	82c7b783          	ld	a5,-2004(a5) # 4000 <freep>
    37dc:	a805                	j	380c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    37de:	4618                	lw	a4,8(a2)
    37e0:	9db9                	addw	a1,a1,a4
    37e2:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    37e6:	6398                	ld	a4,0(a5)
    37e8:	6318                	ld	a4,0(a4)
    37ea:	fee53823          	sd	a4,-16(a0)
    37ee:	a091                	j	3832 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    37f0:	ff852703          	lw	a4,-8(a0)
    37f4:	9e39                	addw	a2,a2,a4
    37f6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    37f8:	ff053703          	ld	a4,-16(a0)
    37fc:	e398                	sd	a4,0(a5)
    37fe:	a099                	j	3844 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3800:	6398                	ld	a4,0(a5)
    3802:	00e7e463          	bltu	a5,a4,380a <free+0x40>
    3806:	00e6ea63          	bltu	a3,a4,381a <free+0x50>
{
    380a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    380c:	fed7fae3          	bgeu	a5,a3,3800 <free+0x36>
    3810:	6398                	ld	a4,0(a5)
    3812:	00e6e463          	bltu	a3,a4,381a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3816:	fee7eae3          	bltu	a5,a4,380a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    381a:	ff852583          	lw	a1,-8(a0)
    381e:	6390                	ld	a2,0(a5)
    3820:	02059713          	slli	a4,a1,0x20
    3824:	9301                	srli	a4,a4,0x20
    3826:	0712                	slli	a4,a4,0x4
    3828:	9736                	add	a4,a4,a3
    382a:	fae60ae3          	beq	a2,a4,37de <free+0x14>
    bp->s.ptr = p->s.ptr;
    382e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    3832:	4790                	lw	a2,8(a5)
    3834:	02061713          	slli	a4,a2,0x20
    3838:	9301                	srli	a4,a4,0x20
    383a:	0712                	slli	a4,a4,0x4
    383c:	973e                	add	a4,a4,a5
    383e:	fae689e3          	beq	a3,a4,37f0 <free+0x26>
  } else
    p->s.ptr = bp;
    3842:	e394                	sd	a3,0(a5)
  freep = p;
    3844:	00000717          	auipc	a4,0x0
    3848:	7af73e23          	sd	a5,1980(a4) # 4000 <freep>
}
    384c:	6422                	ld	s0,8(sp)
    384e:	0141                	addi	sp,sp,16
    3850:	8082                	ret

0000000000003852 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3852:	7139                	addi	sp,sp,-64
    3854:	fc06                	sd	ra,56(sp)
    3856:	f822                	sd	s0,48(sp)
    3858:	f426                	sd	s1,40(sp)
    385a:	f04a                	sd	s2,32(sp)
    385c:	ec4e                	sd	s3,24(sp)
    385e:	e852                	sd	s4,16(sp)
    3860:	e456                	sd	s5,8(sp)
    3862:	e05a                	sd	s6,0(sp)
    3864:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3866:	02051493          	slli	s1,a0,0x20
    386a:	9081                	srli	s1,s1,0x20
    386c:	04bd                	addi	s1,s1,15
    386e:	8091                	srli	s1,s1,0x4
    3870:	0014899b          	addiw	s3,s1,1
    3874:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    3876:	00000517          	auipc	a0,0x0
    387a:	78a53503          	ld	a0,1930(a0) # 4000 <freep>
    387e:	c515                	beqz	a0,38aa <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3880:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3882:	4798                	lw	a4,8(a5)
    3884:	02977f63          	bgeu	a4,s1,38c2 <malloc+0x70>
    3888:	8a4e                	mv	s4,s3
    388a:	0009871b          	sext.w	a4,s3
    388e:	6685                	lui	a3,0x1
    3890:	00d77363          	bgeu	a4,a3,3896 <malloc+0x44>
    3894:	6a05                	lui	s4,0x1
    3896:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    389a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    389e:	00000917          	auipc	s2,0x0
    38a2:	76290913          	addi	s2,s2,1890 # 4000 <freep>
  if(p == (char*)-1)
    38a6:	5afd                	li	s5,-1
    38a8:	a88d                	j	391a <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    38aa:	00000797          	auipc	a5,0x0
    38ae:	76678793          	addi	a5,a5,1894 # 4010 <base>
    38b2:	00000717          	auipc	a4,0x0
    38b6:	74f73723          	sd	a5,1870(a4) # 4000 <freep>
    38ba:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    38bc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    38c0:	b7e1                	j	3888 <malloc+0x36>
      if(p->s.size == nunits)
    38c2:	02e48b63          	beq	s1,a4,38f8 <malloc+0xa6>
        p->s.size -= nunits;
    38c6:	4137073b          	subw	a4,a4,s3
    38ca:	c798                	sw	a4,8(a5)
        p += p->s.size;
    38cc:	1702                	slli	a4,a4,0x20
    38ce:	9301                	srli	a4,a4,0x20
    38d0:	0712                	slli	a4,a4,0x4
    38d2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    38d4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    38d8:	00000717          	auipc	a4,0x0
    38dc:	72a73423          	sd	a0,1832(a4) # 4000 <freep>
      return (void*)(p + 1);
    38e0:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    38e4:	70e2                	ld	ra,56(sp)
    38e6:	7442                	ld	s0,48(sp)
    38e8:	74a2                	ld	s1,40(sp)
    38ea:	7902                	ld	s2,32(sp)
    38ec:	69e2                	ld	s3,24(sp)
    38ee:	6a42                	ld	s4,16(sp)
    38f0:	6aa2                	ld	s5,8(sp)
    38f2:	6b02                	ld	s6,0(sp)
    38f4:	6121                	addi	sp,sp,64
    38f6:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    38f8:	6398                	ld	a4,0(a5)
    38fa:	e118                	sd	a4,0(a0)
    38fc:	bff1                	j	38d8 <malloc+0x86>
  hp->s.size = nu;
    38fe:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    3902:	0541                	addi	a0,a0,16
    3904:	00000097          	auipc	ra,0x0
    3908:	ec6080e7          	jalr	-314(ra) # 37ca <free>
  return freep;
    390c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    3910:	d971                	beqz	a0,38e4 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3912:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3914:	4798                	lw	a4,8(a5)
    3916:	fa9776e3          	bgeu	a4,s1,38c2 <malloc+0x70>
    if(p == freep)
    391a:	00093703          	ld	a4,0(s2)
    391e:	853e                	mv	a0,a5
    3920:	fef719e3          	bne	a4,a5,3912 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3924:	8552                	mv	a0,s4
    3926:	00000097          	auipc	ra,0x0
    392a:	b56080e7          	jalr	-1194(ra) # 347c <sbrk>
  if(p == (char*)-1)
    392e:	fd5518e3          	bne	a0,s5,38fe <malloc+0xac>
        return 0;
    3932:	4501                	li	a0,0
    3934:	bf45                	j	38e4 <malloc+0x92>
