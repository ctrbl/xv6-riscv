
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <print>:

#define N  1000

void
print(const char *s)
{
    3000:	1101                	addi	sp,sp,-32
    3002:	ec06                	sd	ra,24(sp)
    3004:	e822                	sd	s0,16(sp)
    3006:	e426                	sd	s1,8(sp)
    3008:	1000                	addi	s0,sp,32
    300a:	84aa                	mv	s1,a0
  write(1, s, strlen(s));
    300c:	00000097          	auipc	ra,0x0
    3010:	174080e7          	jalr	372(ra) # 3180 <strlen>
    3014:	0005061b          	sext.w	a2,a0
    3018:	85a6                	mv	a1,s1
    301a:	4505                	li	a0,1
    301c:	00000097          	auipc	ra,0x0
    3020:	40a080e7          	jalr	1034(ra) # 3426 <write>
}
    3024:	60e2                	ld	ra,24(sp)
    3026:	6442                	ld	s0,16(sp)
    3028:	64a2                	ld	s1,8(sp)
    302a:	6105                	addi	sp,sp,32
    302c:	8082                	ret

000000000000302e <forktest>:

void
forktest(void)
{
    302e:	1101                	addi	sp,sp,-32
    3030:	ec06                	sd	ra,24(sp)
    3032:	e822                	sd	s0,16(sp)
    3034:	e426                	sd	s1,8(sp)
    3036:	e04a                	sd	s2,0(sp)
    3038:	1000                	addi	s0,sp,32
  int n, pid;

  print("fork test\n");
    303a:	00000517          	auipc	a0,0x0
    303e:	49650513          	addi	a0,a0,1174 # 34d0 <set_priority+0xa>
    3042:	00000097          	auipc	ra,0x0
    3046:	fbe080e7          	jalr	-66(ra) # 3000 <print>

  for(n=0; n<N; n++){
    304a:	4481                	li	s1,0
    304c:	3e800913          	li	s2,1000
    pid = fork();
    3050:	00000097          	auipc	ra,0x0
    3054:	3a6080e7          	jalr	934(ra) # 33f6 <fork>
    if(pid < 0)
    3058:	02054763          	bltz	a0,3086 <forktest+0x58>
      break;
    if(pid == 0)
    305c:	c10d                	beqz	a0,307e <forktest+0x50>
  for(n=0; n<N; n++){
    305e:	2485                	addiw	s1,s1,1
    3060:	ff2498e3          	bne	s1,s2,3050 <forktest+0x22>
      exit(0);
  }

  if(n == N){
    print("fork claimed to work N times!\n");
    3064:	00000517          	auipc	a0,0x0
    3068:	47c50513          	addi	a0,a0,1148 # 34e0 <set_priority+0x1a>
    306c:	00000097          	auipc	ra,0x0
    3070:	f94080e7          	jalr	-108(ra) # 3000 <print>
    exit(1);
    3074:	4505                	li	a0,1
    3076:	00000097          	auipc	ra,0x0
    307a:	388080e7          	jalr	904(ra) # 33fe <exit>
      exit(0);
    307e:	00000097          	auipc	ra,0x0
    3082:	380080e7          	jalr	896(ra) # 33fe <exit>
  if(n == N){
    3086:	3e800793          	li	a5,1000
    308a:	fcf48de3          	beq	s1,a5,3064 <forktest+0x36>
  }

  for(; n > 0; n--){
    308e:	00905b63          	blez	s1,30a4 <forktest+0x76>
    if(wait(0) < 0){
    3092:	4501                	li	a0,0
    3094:	00000097          	auipc	ra,0x0
    3098:	372080e7          	jalr	882(ra) # 3406 <wait>
    309c:	02054a63          	bltz	a0,30d0 <forktest+0xa2>
  for(; n > 0; n--){
    30a0:	34fd                	addiw	s1,s1,-1
    30a2:	f8e5                	bnez	s1,3092 <forktest+0x64>
      print("wait stopped early\n");
      exit(1);
    }
  }

  if(wait(0) != -1){
    30a4:	4501                	li	a0,0
    30a6:	00000097          	auipc	ra,0x0
    30aa:	360080e7          	jalr	864(ra) # 3406 <wait>
    30ae:	57fd                	li	a5,-1
    30b0:	02f51d63          	bne	a0,a5,30ea <forktest+0xbc>
    print("wait got too many\n");
    exit(1);
  }

  print("fork test OK\n");
    30b4:	00000517          	auipc	a0,0x0
    30b8:	47c50513          	addi	a0,a0,1148 # 3530 <set_priority+0x6a>
    30bc:	00000097          	auipc	ra,0x0
    30c0:	f44080e7          	jalr	-188(ra) # 3000 <print>
}
    30c4:	60e2                	ld	ra,24(sp)
    30c6:	6442                	ld	s0,16(sp)
    30c8:	64a2                	ld	s1,8(sp)
    30ca:	6902                	ld	s2,0(sp)
    30cc:	6105                	addi	sp,sp,32
    30ce:	8082                	ret
      print("wait stopped early\n");
    30d0:	00000517          	auipc	a0,0x0
    30d4:	43050513          	addi	a0,a0,1072 # 3500 <set_priority+0x3a>
    30d8:	00000097          	auipc	ra,0x0
    30dc:	f28080e7          	jalr	-216(ra) # 3000 <print>
      exit(1);
    30e0:	4505                	li	a0,1
    30e2:	00000097          	auipc	ra,0x0
    30e6:	31c080e7          	jalr	796(ra) # 33fe <exit>
    print("wait got too many\n");
    30ea:	00000517          	auipc	a0,0x0
    30ee:	42e50513          	addi	a0,a0,1070 # 3518 <set_priority+0x52>
    30f2:	00000097          	auipc	ra,0x0
    30f6:	f0e080e7          	jalr	-242(ra) # 3000 <print>
    exit(1);
    30fa:	4505                	li	a0,1
    30fc:	00000097          	auipc	ra,0x0
    3100:	302080e7          	jalr	770(ra) # 33fe <exit>

0000000000003104 <main>:

int
main(void)
{
    3104:	1141                	addi	sp,sp,-16
    3106:	e406                	sd	ra,8(sp)
    3108:	e022                	sd	s0,0(sp)
    310a:	0800                	addi	s0,sp,16
  forktest();
    310c:	00000097          	auipc	ra,0x0
    3110:	f22080e7          	jalr	-222(ra) # 302e <forktest>
  exit(0);
    3114:	4501                	li	a0,0
    3116:	00000097          	auipc	ra,0x0
    311a:	2e8080e7          	jalr	744(ra) # 33fe <exit>

000000000000311e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    311e:	1141                	addi	sp,sp,-16
    3120:	e406                	sd	ra,8(sp)
    3122:	e022                	sd	s0,0(sp)
    3124:	0800                	addi	s0,sp,16
  extern int main();
  main();
    3126:	00000097          	auipc	ra,0x0
    312a:	fde080e7          	jalr	-34(ra) # 3104 <main>
  exit(0);
    312e:	4501                	li	a0,0
    3130:	00000097          	auipc	ra,0x0
    3134:	2ce080e7          	jalr	718(ra) # 33fe <exit>

0000000000003138 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3138:	1141                	addi	sp,sp,-16
    313a:	e422                	sd	s0,8(sp)
    313c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    313e:	87aa                	mv	a5,a0
    3140:	0585                	addi	a1,a1,1
    3142:	0785                	addi	a5,a5,1
    3144:	fff5c703          	lbu	a4,-1(a1)
    3148:	fee78fa3          	sb	a4,-1(a5)
    314c:	fb75                	bnez	a4,3140 <strcpy+0x8>
    ;
  return os;
}
    314e:	6422                	ld	s0,8(sp)
    3150:	0141                	addi	sp,sp,16
    3152:	8082                	ret

0000000000003154 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3154:	1141                	addi	sp,sp,-16
    3156:	e422                	sd	s0,8(sp)
    3158:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    315a:	00054783          	lbu	a5,0(a0)
    315e:	cb91                	beqz	a5,3172 <strcmp+0x1e>
    3160:	0005c703          	lbu	a4,0(a1)
    3164:	00f71763          	bne	a4,a5,3172 <strcmp+0x1e>
    p++, q++;
    3168:	0505                	addi	a0,a0,1
    316a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    316c:	00054783          	lbu	a5,0(a0)
    3170:	fbe5                	bnez	a5,3160 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    3172:	0005c503          	lbu	a0,0(a1)
}
    3176:	40a7853b          	subw	a0,a5,a0
    317a:	6422                	ld	s0,8(sp)
    317c:	0141                	addi	sp,sp,16
    317e:	8082                	ret

0000000000003180 <strlen>:

uint
strlen(const char *s)
{
    3180:	1141                	addi	sp,sp,-16
    3182:	e422                	sd	s0,8(sp)
    3184:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    3186:	00054783          	lbu	a5,0(a0)
    318a:	cf91                	beqz	a5,31a6 <strlen+0x26>
    318c:	0505                	addi	a0,a0,1
    318e:	87aa                	mv	a5,a0
    3190:	4685                	li	a3,1
    3192:	9e89                	subw	a3,a3,a0
    3194:	00f6853b          	addw	a0,a3,a5
    3198:	0785                	addi	a5,a5,1
    319a:	fff7c703          	lbu	a4,-1(a5)
    319e:	fb7d                	bnez	a4,3194 <strlen+0x14>
    ;
  return n;
}
    31a0:	6422                	ld	s0,8(sp)
    31a2:	0141                	addi	sp,sp,16
    31a4:	8082                	ret
  for(n = 0; s[n]; n++)
    31a6:	4501                	li	a0,0
    31a8:	bfe5                	j	31a0 <strlen+0x20>

00000000000031aa <memset>:

void*
memset(void *dst, int c, uint n)
{
    31aa:	1141                	addi	sp,sp,-16
    31ac:	e422                	sd	s0,8(sp)
    31ae:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    31b0:	ca19                	beqz	a2,31c6 <memset+0x1c>
    31b2:	87aa                	mv	a5,a0
    31b4:	1602                	slli	a2,a2,0x20
    31b6:	9201                	srli	a2,a2,0x20
    31b8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    31bc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    31c0:	0785                	addi	a5,a5,1
    31c2:	fee79de3          	bne	a5,a4,31bc <memset+0x12>
  }
  return dst;
}
    31c6:	6422                	ld	s0,8(sp)
    31c8:	0141                	addi	sp,sp,16
    31ca:	8082                	ret

00000000000031cc <strchr>:

char*
strchr(const char *s, char c)
{
    31cc:	1141                	addi	sp,sp,-16
    31ce:	e422                	sd	s0,8(sp)
    31d0:	0800                	addi	s0,sp,16
  for(; *s; s++)
    31d2:	00054783          	lbu	a5,0(a0)
    31d6:	cb99                	beqz	a5,31ec <strchr+0x20>
    if(*s == c)
    31d8:	00f58763          	beq	a1,a5,31e6 <strchr+0x1a>
  for(; *s; s++)
    31dc:	0505                	addi	a0,a0,1
    31de:	00054783          	lbu	a5,0(a0)
    31e2:	fbfd                	bnez	a5,31d8 <strchr+0xc>
      return (char*)s;
  return 0;
    31e4:	4501                	li	a0,0
}
    31e6:	6422                	ld	s0,8(sp)
    31e8:	0141                	addi	sp,sp,16
    31ea:	8082                	ret
  return 0;
    31ec:	4501                	li	a0,0
    31ee:	bfe5                	j	31e6 <strchr+0x1a>

00000000000031f0 <gets>:

char*
gets(char *buf, int max)
{
    31f0:	711d                	addi	sp,sp,-96
    31f2:	ec86                	sd	ra,88(sp)
    31f4:	e8a2                	sd	s0,80(sp)
    31f6:	e4a6                	sd	s1,72(sp)
    31f8:	e0ca                	sd	s2,64(sp)
    31fa:	fc4e                	sd	s3,56(sp)
    31fc:	f852                	sd	s4,48(sp)
    31fe:	f456                	sd	s5,40(sp)
    3200:	f05a                	sd	s6,32(sp)
    3202:	ec5e                	sd	s7,24(sp)
    3204:	1080                	addi	s0,sp,96
    3206:	8baa                	mv	s7,a0
    3208:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    320a:	892a                	mv	s2,a0
    320c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    320e:	4aa9                	li	s5,10
    3210:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    3212:	89a6                	mv	s3,s1
    3214:	2485                	addiw	s1,s1,1
    3216:	0344d863          	bge	s1,s4,3246 <gets+0x56>
    cc = read(0, &c, 1);
    321a:	4605                	li	a2,1
    321c:	faf40593          	addi	a1,s0,-81
    3220:	4501                	li	a0,0
    3222:	00000097          	auipc	ra,0x0
    3226:	1fc080e7          	jalr	508(ra) # 341e <read>
    if(cc < 1)
    322a:	00a05e63          	blez	a0,3246 <gets+0x56>
    buf[i++] = c;
    322e:	faf44783          	lbu	a5,-81(s0)
    3232:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3236:	01578763          	beq	a5,s5,3244 <gets+0x54>
    323a:	0905                	addi	s2,s2,1
    323c:	fd679be3          	bne	a5,s6,3212 <gets+0x22>
  for(i=0; i+1 < max; ){
    3240:	89a6                	mv	s3,s1
    3242:	a011                	j	3246 <gets+0x56>
    3244:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3246:	99de                	add	s3,s3,s7
    3248:	00098023          	sb	zero,0(s3)
  return buf;
}
    324c:	855e                	mv	a0,s7
    324e:	60e6                	ld	ra,88(sp)
    3250:	6446                	ld	s0,80(sp)
    3252:	64a6                	ld	s1,72(sp)
    3254:	6906                	ld	s2,64(sp)
    3256:	79e2                	ld	s3,56(sp)
    3258:	7a42                	ld	s4,48(sp)
    325a:	7aa2                	ld	s5,40(sp)
    325c:	7b02                	ld	s6,32(sp)
    325e:	6be2                	ld	s7,24(sp)
    3260:	6125                	addi	sp,sp,96
    3262:	8082                	ret

0000000000003264 <stat>:

int
stat(const char *n, struct stat *st)
{
    3264:	1101                	addi	sp,sp,-32
    3266:	ec06                	sd	ra,24(sp)
    3268:	e822                	sd	s0,16(sp)
    326a:	e426                	sd	s1,8(sp)
    326c:	e04a                	sd	s2,0(sp)
    326e:	1000                	addi	s0,sp,32
    3270:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3272:	4581                	li	a1,0
    3274:	00000097          	auipc	ra,0x0
    3278:	1d2080e7          	jalr	466(ra) # 3446 <open>
  if(fd < 0)
    327c:	02054563          	bltz	a0,32a6 <stat+0x42>
    3280:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    3282:	85ca                	mv	a1,s2
    3284:	00000097          	auipc	ra,0x0
    3288:	1da080e7          	jalr	474(ra) # 345e <fstat>
    328c:	892a                	mv	s2,a0
  close(fd);
    328e:	8526                	mv	a0,s1
    3290:	00000097          	auipc	ra,0x0
    3294:	19e080e7          	jalr	414(ra) # 342e <close>
  return r;
}
    3298:	854a                	mv	a0,s2
    329a:	60e2                	ld	ra,24(sp)
    329c:	6442                	ld	s0,16(sp)
    329e:	64a2                	ld	s1,8(sp)
    32a0:	6902                	ld	s2,0(sp)
    32a2:	6105                	addi	sp,sp,32
    32a4:	8082                	ret
    return -1;
    32a6:	597d                	li	s2,-1
    32a8:	bfc5                	j	3298 <stat+0x34>

00000000000032aa <atoi>:

int
atoi(const char *s)
{
    32aa:	1141                	addi	sp,sp,-16
    32ac:	e422                	sd	s0,8(sp)
    32ae:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    32b0:	00054603          	lbu	a2,0(a0)
    32b4:	fd06079b          	addiw	a5,a2,-48
    32b8:	0ff7f793          	andi	a5,a5,255
    32bc:	4725                	li	a4,9
    32be:	02f76963          	bltu	a4,a5,32f0 <atoi+0x46>
    32c2:	86aa                	mv	a3,a0
  n = 0;
    32c4:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    32c6:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    32c8:	0685                	addi	a3,a3,1
    32ca:	0025179b          	slliw	a5,a0,0x2
    32ce:	9fa9                	addw	a5,a5,a0
    32d0:	0017979b          	slliw	a5,a5,0x1
    32d4:	9fb1                	addw	a5,a5,a2
    32d6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    32da:	0006c603          	lbu	a2,0(a3)
    32de:	fd06071b          	addiw	a4,a2,-48
    32e2:	0ff77713          	andi	a4,a4,255
    32e6:	fee5f1e3          	bgeu	a1,a4,32c8 <atoi+0x1e>
  return n;
}
    32ea:	6422                	ld	s0,8(sp)
    32ec:	0141                	addi	sp,sp,16
    32ee:	8082                	ret
  n = 0;
    32f0:	4501                	li	a0,0
    32f2:	bfe5                	j	32ea <atoi+0x40>

00000000000032f4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    32f4:	1141                	addi	sp,sp,-16
    32f6:	e422                	sd	s0,8(sp)
    32f8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    32fa:	02b57463          	bgeu	a0,a1,3322 <memmove+0x2e>
    while(n-- > 0)
    32fe:	00c05f63          	blez	a2,331c <memmove+0x28>
    3302:	1602                	slli	a2,a2,0x20
    3304:	9201                	srli	a2,a2,0x20
    3306:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    330a:	872a                	mv	a4,a0
      *dst++ = *src++;
    330c:	0585                	addi	a1,a1,1
    330e:	0705                	addi	a4,a4,1
    3310:	fff5c683          	lbu	a3,-1(a1)
    3314:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3318:	fee79ae3          	bne	a5,a4,330c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    331c:	6422                	ld	s0,8(sp)
    331e:	0141                	addi	sp,sp,16
    3320:	8082                	ret
    dst += n;
    3322:	00c50733          	add	a4,a0,a2
    src += n;
    3326:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    3328:	fec05ae3          	blez	a2,331c <memmove+0x28>
    332c:	fff6079b          	addiw	a5,a2,-1
    3330:	1782                	slli	a5,a5,0x20
    3332:	9381                	srli	a5,a5,0x20
    3334:	fff7c793          	not	a5,a5
    3338:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    333a:	15fd                	addi	a1,a1,-1
    333c:	177d                	addi	a4,a4,-1
    333e:	0005c683          	lbu	a3,0(a1)
    3342:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3346:	fee79ae3          	bne	a5,a4,333a <memmove+0x46>
    334a:	bfc9                	j	331c <memmove+0x28>

000000000000334c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    334c:	1141                	addi	sp,sp,-16
    334e:	e422                	sd	s0,8(sp)
    3350:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    3352:	ca05                	beqz	a2,3382 <memcmp+0x36>
    3354:	fff6069b          	addiw	a3,a2,-1
    3358:	1682                	slli	a3,a3,0x20
    335a:	9281                	srli	a3,a3,0x20
    335c:	0685                	addi	a3,a3,1
    335e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    3360:	00054783          	lbu	a5,0(a0)
    3364:	0005c703          	lbu	a4,0(a1)
    3368:	00e79863          	bne	a5,a4,3378 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    336c:	0505                	addi	a0,a0,1
    p2++;
    336e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    3370:	fed518e3          	bne	a0,a3,3360 <memcmp+0x14>
  }
  return 0;
    3374:	4501                	li	a0,0
    3376:	a019                	j	337c <memcmp+0x30>
      return *p1 - *p2;
    3378:	40e7853b          	subw	a0,a5,a4
}
    337c:	6422                	ld	s0,8(sp)
    337e:	0141                	addi	sp,sp,16
    3380:	8082                	ret
  return 0;
    3382:	4501                	li	a0,0
    3384:	bfe5                	j	337c <memcmp+0x30>

0000000000003386 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    3386:	1141                	addi	sp,sp,-16
    3388:	e406                	sd	ra,8(sp)
    338a:	e022                	sd	s0,0(sp)
    338c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    338e:	00000097          	auipc	ra,0x0
    3392:	f66080e7          	jalr	-154(ra) # 32f4 <memmove>
}
    3396:	60a2                	ld	ra,8(sp)
    3398:	6402                	ld	s0,0(sp)
    339a:	0141                	addi	sp,sp,16
    339c:	8082                	ret

000000000000339e <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    339e:	1141                	addi	sp,sp,-16
    33a0:	e422                	sd	s0,8(sp)
    33a2:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    33a4:	00052023          	sw	zero,0(a0)
}  
    33a8:	6422                	ld	s0,8(sp)
    33aa:	0141                	addi	sp,sp,16
    33ac:	8082                	ret

00000000000033ae <lock>:

void lock(struct spinlock * lk) 
{    
    33ae:	1141                	addi	sp,sp,-16
    33b0:	e422                	sd	s0,8(sp)
    33b2:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    33b4:	4705                	li	a4,1
    33b6:	87ba                	mv	a5,a4
    33b8:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    33bc:	2781                	sext.w	a5,a5
    33be:	ffe5                	bnez	a5,33b6 <lock+0x8>
}  
    33c0:	6422                	ld	s0,8(sp)
    33c2:	0141                	addi	sp,sp,16
    33c4:	8082                	ret

00000000000033c6 <unlock>:

void unlock(struct spinlock * lk) 
{   
    33c6:	1141                	addi	sp,sp,-16
    33c8:	e422                	sd	s0,8(sp)
    33ca:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    33cc:	0f50000f          	fence	iorw,ow
    33d0:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    33d4:	6422                	ld	s0,8(sp)
    33d6:	0141                	addi	sp,sp,16
    33d8:	8082                	ret

00000000000033da <isDigit>:

unsigned int isDigit(char *c) {
    33da:	1141                	addi	sp,sp,-16
    33dc:	e422                	sd	s0,8(sp)
    33de:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    33e0:	00054503          	lbu	a0,0(a0)
    33e4:	fd05051b          	addiw	a0,a0,-48
    33e8:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    33ec:	00a53513          	sltiu	a0,a0,10
    33f0:	6422                	ld	s0,8(sp)
    33f2:	0141                	addi	sp,sp,16
    33f4:	8082                	ret

00000000000033f6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    33f6:	4885                	li	a7,1
 ecall
    33f8:	00000073          	ecall
 ret
    33fc:	8082                	ret

00000000000033fe <exit>:
.global exit
exit:
 li a7, SYS_exit
    33fe:	4889                	li	a7,2
 ecall
    3400:	00000073          	ecall
 ret
    3404:	8082                	ret

0000000000003406 <wait>:
.global wait
wait:
 li a7, SYS_wait
    3406:	488d                	li	a7,3
 ecall
    3408:	00000073          	ecall
 ret
    340c:	8082                	ret

000000000000340e <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    340e:	48e1                	li	a7,24
 ecall
    3410:	00000073          	ecall
 ret
    3414:	8082                	ret

0000000000003416 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    3416:	4891                	li	a7,4
 ecall
    3418:	00000073          	ecall
 ret
    341c:	8082                	ret

000000000000341e <read>:
.global read
read:
 li a7, SYS_read
    341e:	4895                	li	a7,5
 ecall
    3420:	00000073          	ecall
 ret
    3424:	8082                	ret

0000000000003426 <write>:
.global write
write:
 li a7, SYS_write
    3426:	48c1                	li	a7,16
 ecall
    3428:	00000073          	ecall
 ret
    342c:	8082                	ret

000000000000342e <close>:
.global close
close:
 li a7, SYS_close
    342e:	48d5                	li	a7,21
 ecall
    3430:	00000073          	ecall
 ret
    3434:	8082                	ret

0000000000003436 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3436:	4899                	li	a7,6
 ecall
    3438:	00000073          	ecall
 ret
    343c:	8082                	ret

000000000000343e <exec>:
.global exec
exec:
 li a7, SYS_exec
    343e:	489d                	li	a7,7
 ecall
    3440:	00000073          	ecall
 ret
    3444:	8082                	ret

0000000000003446 <open>:
.global open
open:
 li a7, SYS_open
    3446:	48bd                	li	a7,15
 ecall
    3448:	00000073          	ecall
 ret
    344c:	8082                	ret

000000000000344e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    344e:	48c5                	li	a7,17
 ecall
    3450:	00000073          	ecall
 ret
    3454:	8082                	ret

0000000000003456 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3456:	48c9                	li	a7,18
 ecall
    3458:	00000073          	ecall
 ret
    345c:	8082                	ret

000000000000345e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    345e:	48a1                	li	a7,8
 ecall
    3460:	00000073          	ecall
 ret
    3464:	8082                	ret

0000000000003466 <link>:
.global link
link:
 li a7, SYS_link
    3466:	48cd                	li	a7,19
 ecall
    3468:	00000073          	ecall
 ret
    346c:	8082                	ret

000000000000346e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    346e:	48d1                	li	a7,20
 ecall
    3470:	00000073          	ecall
 ret
    3474:	8082                	ret

0000000000003476 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3476:	48a5                	li	a7,9
 ecall
    3478:	00000073          	ecall
 ret
    347c:	8082                	ret

000000000000347e <dup>:
.global dup
dup:
 li a7, SYS_dup
    347e:	48a9                	li	a7,10
 ecall
    3480:	00000073          	ecall
 ret
    3484:	8082                	ret

0000000000003486 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    3486:	48ad                	li	a7,11
 ecall
    3488:	00000073          	ecall
 ret
    348c:	8082                	ret

000000000000348e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    348e:	48b1                	li	a7,12
 ecall
    3490:	00000073          	ecall
 ret
    3494:	8082                	ret

0000000000003496 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    3496:	48b5                	li	a7,13
 ecall
    3498:	00000073          	ecall
 ret
    349c:	8082                	ret

000000000000349e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    349e:	48b9                	li	a7,14
 ecall
    34a0:	00000073          	ecall
 ret
    34a4:	8082                	ret

00000000000034a6 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    34a6:	48d9                	li	a7,22
 ecall
    34a8:	00000073          	ecall
 ret
    34ac:	8082                	ret

00000000000034ae <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    34ae:	48dd                	li	a7,23
 ecall
    34b0:	00000073          	ecall
 ret
    34b4:	8082                	ret

00000000000034b6 <ps>:
.global ps
ps:
 li a7, SYS_ps
    34b6:	48e5                	li	a7,25
 ecall
    34b8:	00000073          	ecall
 ret
    34bc:	8082                	ret

00000000000034be <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    34be:	48e9                	li	a7,26
 ecall
    34c0:	00000073          	ecall
 ret
    34c4:	8082                	ret

00000000000034c6 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    34c6:	48ed                	li	a7,27
 ecall
    34c8:	00000073          	ecall
 ret
    34cc:	8082                	ret
