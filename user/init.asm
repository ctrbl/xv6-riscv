
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
    3000:	1101                	addi	sp,sp,-32
    3002:	ec06                	sd	ra,24(sp)
    3004:	e822                	sd	s0,16(sp)
    3006:	e426                	sd	s1,8(sp)
    3008:	e04a                	sd	s2,0(sp)
    300a:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    300c:	4589                	li	a1,2
    300e:	00001517          	auipc	a0,0x1
    3012:	92250513          	addi	a0,a0,-1758 # 3930 <malloc+0xf2>
    3016:	00000097          	auipc	ra,0x0
    301a:	40a080e7          	jalr	1034(ra) # 3420 <open>
    301e:	06054363          	bltz	a0,3084 <main+0x84>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
    3022:	4501                	li	a0,0
    3024:	00000097          	auipc	ra,0x0
    3028:	434080e7          	jalr	1076(ra) # 3458 <dup>
  dup(0);  // stderr
    302c:	4501                	li	a0,0
    302e:	00000097          	auipc	ra,0x0
    3032:	42a080e7          	jalr	1066(ra) # 3458 <dup>

  for(;;){
    printf("init: starting sh\n");
    3036:	00001917          	auipc	s2,0x1
    303a:	90290913          	addi	s2,s2,-1790 # 3938 <malloc+0xfa>
    303e:	854a                	mv	a0,s2
    3040:	00000097          	auipc	ra,0x0
    3044:	740080e7          	jalr	1856(ra) # 3780 <printf>
    pid = fork();
    3048:	00000097          	auipc	ra,0x0
    304c:	388080e7          	jalr	904(ra) # 33d0 <fork>
    3050:	84aa                	mv	s1,a0
    if(pid < 0){
    3052:	04054d63          	bltz	a0,30ac <main+0xac>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
    3056:	c925                	beqz	a0,30c6 <main+0xc6>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
    3058:	4501                	li	a0,0
    305a:	00000097          	auipc	ra,0x0
    305e:	386080e7          	jalr	902(ra) # 33e0 <wait>
      if(wpid == pid){
    3062:	fca48ee3          	beq	s1,a0,303e <main+0x3e>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
    3066:	fe0559e3          	bgez	a0,3058 <main+0x58>
        printf("init: wait returned an error\n");
    306a:	00001517          	auipc	a0,0x1
    306e:	91e50513          	addi	a0,a0,-1762 # 3988 <malloc+0x14a>
    3072:	00000097          	auipc	ra,0x0
    3076:	70e080e7          	jalr	1806(ra) # 3780 <printf>
        exit(1);
    307a:	4505                	li	a0,1
    307c:	00000097          	auipc	ra,0x0
    3080:	35c080e7          	jalr	860(ra) # 33d8 <exit>
    mknod("console", CONSOLE, 0);
    3084:	4601                	li	a2,0
    3086:	4585                	li	a1,1
    3088:	00001517          	auipc	a0,0x1
    308c:	8a850513          	addi	a0,a0,-1880 # 3930 <malloc+0xf2>
    3090:	00000097          	auipc	ra,0x0
    3094:	398080e7          	jalr	920(ra) # 3428 <mknod>
    open("console", O_RDWR);
    3098:	4589                	li	a1,2
    309a:	00001517          	auipc	a0,0x1
    309e:	89650513          	addi	a0,a0,-1898 # 3930 <malloc+0xf2>
    30a2:	00000097          	auipc	ra,0x0
    30a6:	37e080e7          	jalr	894(ra) # 3420 <open>
    30aa:	bfa5                	j	3022 <main+0x22>
      printf("init: fork failed\n");
    30ac:	00001517          	auipc	a0,0x1
    30b0:	8a450513          	addi	a0,a0,-1884 # 3950 <malloc+0x112>
    30b4:	00000097          	auipc	ra,0x0
    30b8:	6cc080e7          	jalr	1740(ra) # 3780 <printf>
      exit(1);
    30bc:	4505                	li	a0,1
    30be:	00000097          	auipc	ra,0x0
    30c2:	31a080e7          	jalr	794(ra) # 33d8 <exit>
      exec("sh", argv);
    30c6:	00001597          	auipc	a1,0x1
    30ca:	f3a58593          	addi	a1,a1,-198 # 4000 <argv>
    30ce:	00001517          	auipc	a0,0x1
    30d2:	89a50513          	addi	a0,a0,-1894 # 3968 <malloc+0x12a>
    30d6:	00000097          	auipc	ra,0x0
    30da:	342080e7          	jalr	834(ra) # 3418 <exec>
      printf("init: exec sh failed\n");
    30de:	00001517          	auipc	a0,0x1
    30e2:	89250513          	addi	a0,a0,-1902 # 3970 <malloc+0x132>
    30e6:	00000097          	auipc	ra,0x0
    30ea:	69a080e7          	jalr	1690(ra) # 3780 <printf>
      exit(1);
    30ee:	4505                	li	a0,1
    30f0:	00000097          	auipc	ra,0x0
    30f4:	2e8080e7          	jalr	744(ra) # 33d8 <exit>

00000000000030f8 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    30f8:	1141                	addi	sp,sp,-16
    30fa:	e406                	sd	ra,8(sp)
    30fc:	e022                	sd	s0,0(sp)
    30fe:	0800                	addi	s0,sp,16
  extern int main();
  main();
    3100:	00000097          	auipc	ra,0x0
    3104:	f00080e7          	jalr	-256(ra) # 3000 <main>
  exit(0);
    3108:	4501                	li	a0,0
    310a:	00000097          	auipc	ra,0x0
    310e:	2ce080e7          	jalr	718(ra) # 33d8 <exit>

0000000000003112 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3112:	1141                	addi	sp,sp,-16
    3114:	e422                	sd	s0,8(sp)
    3116:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3118:	87aa                	mv	a5,a0
    311a:	0585                	addi	a1,a1,1
    311c:	0785                	addi	a5,a5,1
    311e:	fff5c703          	lbu	a4,-1(a1)
    3122:	fee78fa3          	sb	a4,-1(a5)
    3126:	fb75                	bnez	a4,311a <strcpy+0x8>
    ;
  return os;
}
    3128:	6422                	ld	s0,8(sp)
    312a:	0141                	addi	sp,sp,16
    312c:	8082                	ret

000000000000312e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    312e:	1141                	addi	sp,sp,-16
    3130:	e422                	sd	s0,8(sp)
    3132:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    3134:	00054783          	lbu	a5,0(a0)
    3138:	cb91                	beqz	a5,314c <strcmp+0x1e>
    313a:	0005c703          	lbu	a4,0(a1)
    313e:	00f71763          	bne	a4,a5,314c <strcmp+0x1e>
    p++, q++;
    3142:	0505                	addi	a0,a0,1
    3144:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    3146:	00054783          	lbu	a5,0(a0)
    314a:	fbe5                	bnez	a5,313a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    314c:	0005c503          	lbu	a0,0(a1)
}
    3150:	40a7853b          	subw	a0,a5,a0
    3154:	6422                	ld	s0,8(sp)
    3156:	0141                	addi	sp,sp,16
    3158:	8082                	ret

000000000000315a <strlen>:

uint
strlen(const char *s)
{
    315a:	1141                	addi	sp,sp,-16
    315c:	e422                	sd	s0,8(sp)
    315e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    3160:	00054783          	lbu	a5,0(a0)
    3164:	cf91                	beqz	a5,3180 <strlen+0x26>
    3166:	0505                	addi	a0,a0,1
    3168:	87aa                	mv	a5,a0
    316a:	4685                	li	a3,1
    316c:	9e89                	subw	a3,a3,a0
    316e:	00f6853b          	addw	a0,a3,a5
    3172:	0785                	addi	a5,a5,1
    3174:	fff7c703          	lbu	a4,-1(a5)
    3178:	fb7d                	bnez	a4,316e <strlen+0x14>
    ;
  return n;
}
    317a:	6422                	ld	s0,8(sp)
    317c:	0141                	addi	sp,sp,16
    317e:	8082                	ret
  for(n = 0; s[n]; n++)
    3180:	4501                	li	a0,0
    3182:	bfe5                	j	317a <strlen+0x20>

0000000000003184 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3184:	1141                	addi	sp,sp,-16
    3186:	e422                	sd	s0,8(sp)
    3188:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    318a:	ca19                	beqz	a2,31a0 <memset+0x1c>
    318c:	87aa                	mv	a5,a0
    318e:	1602                	slli	a2,a2,0x20
    3190:	9201                	srli	a2,a2,0x20
    3192:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    3196:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    319a:	0785                	addi	a5,a5,1
    319c:	fee79de3          	bne	a5,a4,3196 <memset+0x12>
  }
  return dst;
}
    31a0:	6422                	ld	s0,8(sp)
    31a2:	0141                	addi	sp,sp,16
    31a4:	8082                	ret

00000000000031a6 <strchr>:

char*
strchr(const char *s, char c)
{
    31a6:	1141                	addi	sp,sp,-16
    31a8:	e422                	sd	s0,8(sp)
    31aa:	0800                	addi	s0,sp,16
  for(; *s; s++)
    31ac:	00054783          	lbu	a5,0(a0)
    31b0:	cb99                	beqz	a5,31c6 <strchr+0x20>
    if(*s == c)
    31b2:	00f58763          	beq	a1,a5,31c0 <strchr+0x1a>
  for(; *s; s++)
    31b6:	0505                	addi	a0,a0,1
    31b8:	00054783          	lbu	a5,0(a0)
    31bc:	fbfd                	bnez	a5,31b2 <strchr+0xc>
      return (char*)s;
  return 0;
    31be:	4501                	li	a0,0
}
    31c0:	6422                	ld	s0,8(sp)
    31c2:	0141                	addi	sp,sp,16
    31c4:	8082                	ret
  return 0;
    31c6:	4501                	li	a0,0
    31c8:	bfe5                	j	31c0 <strchr+0x1a>

00000000000031ca <gets>:

char*
gets(char *buf, int max)
{
    31ca:	711d                	addi	sp,sp,-96
    31cc:	ec86                	sd	ra,88(sp)
    31ce:	e8a2                	sd	s0,80(sp)
    31d0:	e4a6                	sd	s1,72(sp)
    31d2:	e0ca                	sd	s2,64(sp)
    31d4:	fc4e                	sd	s3,56(sp)
    31d6:	f852                	sd	s4,48(sp)
    31d8:	f456                	sd	s5,40(sp)
    31da:	f05a                	sd	s6,32(sp)
    31dc:	ec5e                	sd	s7,24(sp)
    31de:	1080                	addi	s0,sp,96
    31e0:	8baa                	mv	s7,a0
    31e2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    31e4:	892a                	mv	s2,a0
    31e6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    31e8:	4aa9                	li	s5,10
    31ea:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    31ec:	89a6                	mv	s3,s1
    31ee:	2485                	addiw	s1,s1,1
    31f0:	0344d863          	bge	s1,s4,3220 <gets+0x56>
    cc = read(0, &c, 1);
    31f4:	4605                	li	a2,1
    31f6:	faf40593          	addi	a1,s0,-81
    31fa:	4501                	li	a0,0
    31fc:	00000097          	auipc	ra,0x0
    3200:	1fc080e7          	jalr	508(ra) # 33f8 <read>
    if(cc < 1)
    3204:	00a05e63          	blez	a0,3220 <gets+0x56>
    buf[i++] = c;
    3208:	faf44783          	lbu	a5,-81(s0)
    320c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3210:	01578763          	beq	a5,s5,321e <gets+0x54>
    3214:	0905                	addi	s2,s2,1
    3216:	fd679be3          	bne	a5,s6,31ec <gets+0x22>
  for(i=0; i+1 < max; ){
    321a:	89a6                	mv	s3,s1
    321c:	a011                	j	3220 <gets+0x56>
    321e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3220:	99de                	add	s3,s3,s7
    3222:	00098023          	sb	zero,0(s3)
  return buf;
}
    3226:	855e                	mv	a0,s7
    3228:	60e6                	ld	ra,88(sp)
    322a:	6446                	ld	s0,80(sp)
    322c:	64a6                	ld	s1,72(sp)
    322e:	6906                	ld	s2,64(sp)
    3230:	79e2                	ld	s3,56(sp)
    3232:	7a42                	ld	s4,48(sp)
    3234:	7aa2                	ld	s5,40(sp)
    3236:	7b02                	ld	s6,32(sp)
    3238:	6be2                	ld	s7,24(sp)
    323a:	6125                	addi	sp,sp,96
    323c:	8082                	ret

000000000000323e <stat>:

int
stat(const char *n, struct stat *st)
{
    323e:	1101                	addi	sp,sp,-32
    3240:	ec06                	sd	ra,24(sp)
    3242:	e822                	sd	s0,16(sp)
    3244:	e426                	sd	s1,8(sp)
    3246:	e04a                	sd	s2,0(sp)
    3248:	1000                	addi	s0,sp,32
    324a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    324c:	4581                	li	a1,0
    324e:	00000097          	auipc	ra,0x0
    3252:	1d2080e7          	jalr	466(ra) # 3420 <open>
  if(fd < 0)
    3256:	02054563          	bltz	a0,3280 <stat+0x42>
    325a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    325c:	85ca                	mv	a1,s2
    325e:	00000097          	auipc	ra,0x0
    3262:	1da080e7          	jalr	474(ra) # 3438 <fstat>
    3266:	892a                	mv	s2,a0
  close(fd);
    3268:	8526                	mv	a0,s1
    326a:	00000097          	auipc	ra,0x0
    326e:	19e080e7          	jalr	414(ra) # 3408 <close>
  return r;
}
    3272:	854a                	mv	a0,s2
    3274:	60e2                	ld	ra,24(sp)
    3276:	6442                	ld	s0,16(sp)
    3278:	64a2                	ld	s1,8(sp)
    327a:	6902                	ld	s2,0(sp)
    327c:	6105                	addi	sp,sp,32
    327e:	8082                	ret
    return -1;
    3280:	597d                	li	s2,-1
    3282:	bfc5                	j	3272 <stat+0x34>

0000000000003284 <atoi>:

int
atoi(const char *s)
{
    3284:	1141                	addi	sp,sp,-16
    3286:	e422                	sd	s0,8(sp)
    3288:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    328a:	00054603          	lbu	a2,0(a0)
    328e:	fd06079b          	addiw	a5,a2,-48
    3292:	0ff7f793          	andi	a5,a5,255
    3296:	4725                	li	a4,9
    3298:	02f76963          	bltu	a4,a5,32ca <atoi+0x46>
    329c:	86aa                	mv	a3,a0
  n = 0;
    329e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    32a0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    32a2:	0685                	addi	a3,a3,1
    32a4:	0025179b          	slliw	a5,a0,0x2
    32a8:	9fa9                	addw	a5,a5,a0
    32aa:	0017979b          	slliw	a5,a5,0x1
    32ae:	9fb1                	addw	a5,a5,a2
    32b0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    32b4:	0006c603          	lbu	a2,0(a3)
    32b8:	fd06071b          	addiw	a4,a2,-48
    32bc:	0ff77713          	andi	a4,a4,255
    32c0:	fee5f1e3          	bgeu	a1,a4,32a2 <atoi+0x1e>
  return n;
}
    32c4:	6422                	ld	s0,8(sp)
    32c6:	0141                	addi	sp,sp,16
    32c8:	8082                	ret
  n = 0;
    32ca:	4501                	li	a0,0
    32cc:	bfe5                	j	32c4 <atoi+0x40>

00000000000032ce <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    32ce:	1141                	addi	sp,sp,-16
    32d0:	e422                	sd	s0,8(sp)
    32d2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    32d4:	02b57463          	bgeu	a0,a1,32fc <memmove+0x2e>
    while(n-- > 0)
    32d8:	00c05f63          	blez	a2,32f6 <memmove+0x28>
    32dc:	1602                	slli	a2,a2,0x20
    32de:	9201                	srli	a2,a2,0x20
    32e0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    32e4:	872a                	mv	a4,a0
      *dst++ = *src++;
    32e6:	0585                	addi	a1,a1,1
    32e8:	0705                	addi	a4,a4,1
    32ea:	fff5c683          	lbu	a3,-1(a1)
    32ee:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    32f2:	fee79ae3          	bne	a5,a4,32e6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    32f6:	6422                	ld	s0,8(sp)
    32f8:	0141                	addi	sp,sp,16
    32fa:	8082                	ret
    dst += n;
    32fc:	00c50733          	add	a4,a0,a2
    src += n;
    3300:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    3302:	fec05ae3          	blez	a2,32f6 <memmove+0x28>
    3306:	fff6079b          	addiw	a5,a2,-1
    330a:	1782                	slli	a5,a5,0x20
    330c:	9381                	srli	a5,a5,0x20
    330e:	fff7c793          	not	a5,a5
    3312:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3314:	15fd                	addi	a1,a1,-1
    3316:	177d                	addi	a4,a4,-1
    3318:	0005c683          	lbu	a3,0(a1)
    331c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3320:	fee79ae3          	bne	a5,a4,3314 <memmove+0x46>
    3324:	bfc9                	j	32f6 <memmove+0x28>

0000000000003326 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    3326:	1141                	addi	sp,sp,-16
    3328:	e422                	sd	s0,8(sp)
    332a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    332c:	ca05                	beqz	a2,335c <memcmp+0x36>
    332e:	fff6069b          	addiw	a3,a2,-1
    3332:	1682                	slli	a3,a3,0x20
    3334:	9281                	srli	a3,a3,0x20
    3336:	0685                	addi	a3,a3,1
    3338:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    333a:	00054783          	lbu	a5,0(a0)
    333e:	0005c703          	lbu	a4,0(a1)
    3342:	00e79863          	bne	a5,a4,3352 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    3346:	0505                	addi	a0,a0,1
    p2++;
    3348:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    334a:	fed518e3          	bne	a0,a3,333a <memcmp+0x14>
  }
  return 0;
    334e:	4501                	li	a0,0
    3350:	a019                	j	3356 <memcmp+0x30>
      return *p1 - *p2;
    3352:	40e7853b          	subw	a0,a5,a4
}
    3356:	6422                	ld	s0,8(sp)
    3358:	0141                	addi	sp,sp,16
    335a:	8082                	ret
  return 0;
    335c:	4501                	li	a0,0
    335e:	bfe5                	j	3356 <memcmp+0x30>

0000000000003360 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    3360:	1141                	addi	sp,sp,-16
    3362:	e406                	sd	ra,8(sp)
    3364:	e022                	sd	s0,0(sp)
    3366:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    3368:	00000097          	auipc	ra,0x0
    336c:	f66080e7          	jalr	-154(ra) # 32ce <memmove>
}
    3370:	60a2                	ld	ra,8(sp)
    3372:	6402                	ld	s0,0(sp)
    3374:	0141                	addi	sp,sp,16
    3376:	8082                	ret

0000000000003378 <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    3378:	1141                	addi	sp,sp,-16
    337a:	e422                	sd	s0,8(sp)
    337c:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    337e:	00052023          	sw	zero,0(a0)
}  
    3382:	6422                	ld	s0,8(sp)
    3384:	0141                	addi	sp,sp,16
    3386:	8082                	ret

0000000000003388 <lock>:

void lock(struct spinlock * lk) 
{    
    3388:	1141                	addi	sp,sp,-16
    338a:	e422                	sd	s0,8(sp)
    338c:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    338e:	4705                	li	a4,1
    3390:	87ba                	mv	a5,a4
    3392:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    3396:	2781                	sext.w	a5,a5
    3398:	ffe5                	bnez	a5,3390 <lock+0x8>
}  
    339a:	6422                	ld	s0,8(sp)
    339c:	0141                	addi	sp,sp,16
    339e:	8082                	ret

00000000000033a0 <unlock>:

void unlock(struct spinlock * lk) 
{   
    33a0:	1141                	addi	sp,sp,-16
    33a2:	e422                	sd	s0,8(sp)
    33a4:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    33a6:	0f50000f          	fence	iorw,ow
    33aa:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    33ae:	6422                	ld	s0,8(sp)
    33b0:	0141                	addi	sp,sp,16
    33b2:	8082                	ret

00000000000033b4 <isDigit>:

unsigned int isDigit(char *c) {
    33b4:	1141                	addi	sp,sp,-16
    33b6:	e422                	sd	s0,8(sp)
    33b8:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    33ba:	00054503          	lbu	a0,0(a0)
    33be:	fd05051b          	addiw	a0,a0,-48
    33c2:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    33c6:	00a53513          	sltiu	a0,a0,10
    33ca:	6422                	ld	s0,8(sp)
    33cc:	0141                	addi	sp,sp,16
    33ce:	8082                	ret

00000000000033d0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    33d0:	4885                	li	a7,1
 ecall
    33d2:	00000073          	ecall
 ret
    33d6:	8082                	ret

00000000000033d8 <exit>:
.global exit
exit:
 li a7, SYS_exit
    33d8:	4889                	li	a7,2
 ecall
    33da:	00000073          	ecall
 ret
    33de:	8082                	ret

00000000000033e0 <wait>:
.global wait
wait:
 li a7, SYS_wait
    33e0:	488d                	li	a7,3
 ecall
    33e2:	00000073          	ecall
 ret
    33e6:	8082                	ret

00000000000033e8 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    33e8:	48e1                	li	a7,24
 ecall
    33ea:	00000073          	ecall
 ret
    33ee:	8082                	ret

00000000000033f0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    33f0:	4891                	li	a7,4
 ecall
    33f2:	00000073          	ecall
 ret
    33f6:	8082                	ret

00000000000033f8 <read>:
.global read
read:
 li a7, SYS_read
    33f8:	4895                	li	a7,5
 ecall
    33fa:	00000073          	ecall
 ret
    33fe:	8082                	ret

0000000000003400 <write>:
.global write
write:
 li a7, SYS_write
    3400:	48c1                	li	a7,16
 ecall
    3402:	00000073          	ecall
 ret
    3406:	8082                	ret

0000000000003408 <close>:
.global close
close:
 li a7, SYS_close
    3408:	48d5                	li	a7,21
 ecall
    340a:	00000073          	ecall
 ret
    340e:	8082                	ret

0000000000003410 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3410:	4899                	li	a7,6
 ecall
    3412:	00000073          	ecall
 ret
    3416:	8082                	ret

0000000000003418 <exec>:
.global exec
exec:
 li a7, SYS_exec
    3418:	489d                	li	a7,7
 ecall
    341a:	00000073          	ecall
 ret
    341e:	8082                	ret

0000000000003420 <open>:
.global open
open:
 li a7, SYS_open
    3420:	48bd                	li	a7,15
 ecall
    3422:	00000073          	ecall
 ret
    3426:	8082                	ret

0000000000003428 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    3428:	48c5                	li	a7,17
 ecall
    342a:	00000073          	ecall
 ret
    342e:	8082                	ret

0000000000003430 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3430:	48c9                	li	a7,18
 ecall
    3432:	00000073          	ecall
 ret
    3436:	8082                	ret

0000000000003438 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    3438:	48a1                	li	a7,8
 ecall
    343a:	00000073          	ecall
 ret
    343e:	8082                	ret

0000000000003440 <link>:
.global link
link:
 li a7, SYS_link
    3440:	48cd                	li	a7,19
 ecall
    3442:	00000073          	ecall
 ret
    3446:	8082                	ret

0000000000003448 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    3448:	48d1                	li	a7,20
 ecall
    344a:	00000073          	ecall
 ret
    344e:	8082                	ret

0000000000003450 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3450:	48a5                	li	a7,9
 ecall
    3452:	00000073          	ecall
 ret
    3456:	8082                	ret

0000000000003458 <dup>:
.global dup
dup:
 li a7, SYS_dup
    3458:	48a9                	li	a7,10
 ecall
    345a:	00000073          	ecall
 ret
    345e:	8082                	ret

0000000000003460 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    3460:	48ad                	li	a7,11
 ecall
    3462:	00000073          	ecall
 ret
    3466:	8082                	ret

0000000000003468 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    3468:	48b1                	li	a7,12
 ecall
    346a:	00000073          	ecall
 ret
    346e:	8082                	ret

0000000000003470 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    3470:	48b5                	li	a7,13
 ecall
    3472:	00000073          	ecall
 ret
    3476:	8082                	ret

0000000000003478 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    3478:	48b9                	li	a7,14
 ecall
    347a:	00000073          	ecall
 ret
    347e:	8082                	ret

0000000000003480 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    3480:	48d9                	li	a7,22
 ecall
    3482:	00000073          	ecall
 ret
    3486:	8082                	ret

0000000000003488 <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    3488:	48dd                	li	a7,23
 ecall
    348a:	00000073          	ecall
 ret
    348e:	8082                	ret

0000000000003490 <ps>:
.global ps
ps:
 li a7, SYS_ps
    3490:	48e5                	li	a7,25
 ecall
    3492:	00000073          	ecall
 ret
    3496:	8082                	ret

0000000000003498 <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    3498:	48e9                	li	a7,26
 ecall
    349a:	00000073          	ecall
 ret
    349e:	8082                	ret

00000000000034a0 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    34a0:	48ed                	li	a7,27
 ecall
    34a2:	00000073          	ecall
 ret
    34a6:	8082                	ret

00000000000034a8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    34a8:	1101                	addi	sp,sp,-32
    34aa:	ec06                	sd	ra,24(sp)
    34ac:	e822                	sd	s0,16(sp)
    34ae:	1000                	addi	s0,sp,32
    34b0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    34b4:	4605                	li	a2,1
    34b6:	fef40593          	addi	a1,s0,-17
    34ba:	00000097          	auipc	ra,0x0
    34be:	f46080e7          	jalr	-186(ra) # 3400 <write>
}
    34c2:	60e2                	ld	ra,24(sp)
    34c4:	6442                	ld	s0,16(sp)
    34c6:	6105                	addi	sp,sp,32
    34c8:	8082                	ret

00000000000034ca <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    34ca:	7139                	addi	sp,sp,-64
    34cc:	fc06                	sd	ra,56(sp)
    34ce:	f822                	sd	s0,48(sp)
    34d0:	f426                	sd	s1,40(sp)
    34d2:	f04a                	sd	s2,32(sp)
    34d4:	ec4e                	sd	s3,24(sp)
    34d6:	0080                	addi	s0,sp,64
    34d8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    34da:	c299                	beqz	a3,34e0 <printint+0x16>
    34dc:	0805c863          	bltz	a1,356c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    34e0:	2581                	sext.w	a1,a1
  neg = 0;
    34e2:	4881                	li	a7,0
    34e4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    34e8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    34ea:	2601                	sext.w	a2,a2
    34ec:	00000517          	auipc	a0,0x0
    34f0:	4c450513          	addi	a0,a0,1220 # 39b0 <digits>
    34f4:	883a                	mv	a6,a4
    34f6:	2705                	addiw	a4,a4,1
    34f8:	02c5f7bb          	remuw	a5,a1,a2
    34fc:	1782                	slli	a5,a5,0x20
    34fe:	9381                	srli	a5,a5,0x20
    3500:	97aa                	add	a5,a5,a0
    3502:	0007c783          	lbu	a5,0(a5)
    3506:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    350a:	0005879b          	sext.w	a5,a1
    350e:	02c5d5bb          	divuw	a1,a1,a2
    3512:	0685                	addi	a3,a3,1
    3514:	fec7f0e3          	bgeu	a5,a2,34f4 <printint+0x2a>
  if(neg)
    3518:	00088b63          	beqz	a7,352e <printint+0x64>
    buf[i++] = '-';
    351c:	fd040793          	addi	a5,s0,-48
    3520:	973e                	add	a4,a4,a5
    3522:	02d00793          	li	a5,45
    3526:	fef70823          	sb	a5,-16(a4)
    352a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    352e:	02e05863          	blez	a4,355e <printint+0x94>
    3532:	fc040793          	addi	a5,s0,-64
    3536:	00e78933          	add	s2,a5,a4
    353a:	fff78993          	addi	s3,a5,-1
    353e:	99ba                	add	s3,s3,a4
    3540:	377d                	addiw	a4,a4,-1
    3542:	1702                	slli	a4,a4,0x20
    3544:	9301                	srli	a4,a4,0x20
    3546:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    354a:	fff94583          	lbu	a1,-1(s2)
    354e:	8526                	mv	a0,s1
    3550:	00000097          	auipc	ra,0x0
    3554:	f58080e7          	jalr	-168(ra) # 34a8 <putc>
  while(--i >= 0)
    3558:	197d                	addi	s2,s2,-1
    355a:	ff3918e3          	bne	s2,s3,354a <printint+0x80>
}
    355e:	70e2                	ld	ra,56(sp)
    3560:	7442                	ld	s0,48(sp)
    3562:	74a2                	ld	s1,40(sp)
    3564:	7902                	ld	s2,32(sp)
    3566:	69e2                	ld	s3,24(sp)
    3568:	6121                	addi	sp,sp,64
    356a:	8082                	ret
    x = -xx;
    356c:	40b005bb          	negw	a1,a1
    neg = 1;
    3570:	4885                	li	a7,1
    x = -xx;
    3572:	bf8d                	j	34e4 <printint+0x1a>

0000000000003574 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    3574:	7119                	addi	sp,sp,-128
    3576:	fc86                	sd	ra,120(sp)
    3578:	f8a2                	sd	s0,112(sp)
    357a:	f4a6                	sd	s1,104(sp)
    357c:	f0ca                	sd	s2,96(sp)
    357e:	ecce                	sd	s3,88(sp)
    3580:	e8d2                	sd	s4,80(sp)
    3582:	e4d6                	sd	s5,72(sp)
    3584:	e0da                	sd	s6,64(sp)
    3586:	fc5e                	sd	s7,56(sp)
    3588:	f862                	sd	s8,48(sp)
    358a:	f466                	sd	s9,40(sp)
    358c:	f06a                	sd	s10,32(sp)
    358e:	ec6e                	sd	s11,24(sp)
    3590:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    3592:	0005c903          	lbu	s2,0(a1)
    3596:	18090f63          	beqz	s2,3734 <vprintf+0x1c0>
    359a:	8aaa                	mv	s5,a0
    359c:	8b32                	mv	s6,a2
    359e:	00158493          	addi	s1,a1,1
  state = 0;
    35a2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    35a4:	02500a13          	li	s4,37
      if(c == 'd'){
    35a8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    35ac:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    35b0:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    35b4:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    35b8:	00000b97          	auipc	s7,0x0
    35bc:	3f8b8b93          	addi	s7,s7,1016 # 39b0 <digits>
    35c0:	a839                	j	35de <vprintf+0x6a>
        putc(fd, c);
    35c2:	85ca                	mv	a1,s2
    35c4:	8556                	mv	a0,s5
    35c6:	00000097          	auipc	ra,0x0
    35ca:	ee2080e7          	jalr	-286(ra) # 34a8 <putc>
    35ce:	a019                	j	35d4 <vprintf+0x60>
    } else if(state == '%'){
    35d0:	01498f63          	beq	s3,s4,35ee <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    35d4:	0485                	addi	s1,s1,1
    35d6:	fff4c903          	lbu	s2,-1(s1)
    35da:	14090d63          	beqz	s2,3734 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    35de:	0009079b          	sext.w	a5,s2
    if(state == 0){
    35e2:	fe0997e3          	bnez	s3,35d0 <vprintf+0x5c>
      if(c == '%'){
    35e6:	fd479ee3          	bne	a5,s4,35c2 <vprintf+0x4e>
        state = '%';
    35ea:	89be                	mv	s3,a5
    35ec:	b7e5                	j	35d4 <vprintf+0x60>
      if(c == 'd'){
    35ee:	05878063          	beq	a5,s8,362e <vprintf+0xba>
      } else if(c == 'l') {
    35f2:	05978c63          	beq	a5,s9,364a <vprintf+0xd6>
      } else if(c == 'x') {
    35f6:	07a78863          	beq	a5,s10,3666 <vprintf+0xf2>
      } else if(c == 'p') {
    35fa:	09b78463          	beq	a5,s11,3682 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    35fe:	07300713          	li	a4,115
    3602:	0ce78663          	beq	a5,a4,36ce <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3606:	06300713          	li	a4,99
    360a:	0ee78e63          	beq	a5,a4,3706 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    360e:	11478863          	beq	a5,s4,371e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3612:	85d2                	mv	a1,s4
    3614:	8556                	mv	a0,s5
    3616:	00000097          	auipc	ra,0x0
    361a:	e92080e7          	jalr	-366(ra) # 34a8 <putc>
        putc(fd, c);
    361e:	85ca                	mv	a1,s2
    3620:	8556                	mv	a0,s5
    3622:	00000097          	auipc	ra,0x0
    3626:	e86080e7          	jalr	-378(ra) # 34a8 <putc>
      }
      state = 0;
    362a:	4981                	li	s3,0
    362c:	b765                	j	35d4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    362e:	008b0913          	addi	s2,s6,8
    3632:	4685                	li	a3,1
    3634:	4629                	li	a2,10
    3636:	000b2583          	lw	a1,0(s6)
    363a:	8556                	mv	a0,s5
    363c:	00000097          	auipc	ra,0x0
    3640:	e8e080e7          	jalr	-370(ra) # 34ca <printint>
    3644:	8b4a                	mv	s6,s2
      state = 0;
    3646:	4981                	li	s3,0
    3648:	b771                	j	35d4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    364a:	008b0913          	addi	s2,s6,8
    364e:	4681                	li	a3,0
    3650:	4629                	li	a2,10
    3652:	000b2583          	lw	a1,0(s6)
    3656:	8556                	mv	a0,s5
    3658:	00000097          	auipc	ra,0x0
    365c:	e72080e7          	jalr	-398(ra) # 34ca <printint>
    3660:	8b4a                	mv	s6,s2
      state = 0;
    3662:	4981                	li	s3,0
    3664:	bf85                	j	35d4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    3666:	008b0913          	addi	s2,s6,8
    366a:	4681                	li	a3,0
    366c:	4641                	li	a2,16
    366e:	000b2583          	lw	a1,0(s6)
    3672:	8556                	mv	a0,s5
    3674:	00000097          	auipc	ra,0x0
    3678:	e56080e7          	jalr	-426(ra) # 34ca <printint>
    367c:	8b4a                	mv	s6,s2
      state = 0;
    367e:	4981                	li	s3,0
    3680:	bf91                	j	35d4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    3682:	008b0793          	addi	a5,s6,8
    3686:	f8f43423          	sd	a5,-120(s0)
    368a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    368e:	03000593          	li	a1,48
    3692:	8556                	mv	a0,s5
    3694:	00000097          	auipc	ra,0x0
    3698:	e14080e7          	jalr	-492(ra) # 34a8 <putc>
  putc(fd, 'x');
    369c:	85ea                	mv	a1,s10
    369e:	8556                	mv	a0,s5
    36a0:	00000097          	auipc	ra,0x0
    36a4:	e08080e7          	jalr	-504(ra) # 34a8 <putc>
    36a8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    36aa:	03c9d793          	srli	a5,s3,0x3c
    36ae:	97de                	add	a5,a5,s7
    36b0:	0007c583          	lbu	a1,0(a5)
    36b4:	8556                	mv	a0,s5
    36b6:	00000097          	auipc	ra,0x0
    36ba:	df2080e7          	jalr	-526(ra) # 34a8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    36be:	0992                	slli	s3,s3,0x4
    36c0:	397d                	addiw	s2,s2,-1
    36c2:	fe0914e3          	bnez	s2,36aa <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    36c6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    36ca:	4981                	li	s3,0
    36cc:	b721                	j	35d4 <vprintf+0x60>
        s = va_arg(ap, char*);
    36ce:	008b0993          	addi	s3,s6,8
    36d2:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    36d6:	02090163          	beqz	s2,36f8 <vprintf+0x184>
        while(*s != 0){
    36da:	00094583          	lbu	a1,0(s2)
    36de:	c9a1                	beqz	a1,372e <vprintf+0x1ba>
          putc(fd, *s);
    36e0:	8556                	mv	a0,s5
    36e2:	00000097          	auipc	ra,0x0
    36e6:	dc6080e7          	jalr	-570(ra) # 34a8 <putc>
          s++;
    36ea:	0905                	addi	s2,s2,1
        while(*s != 0){
    36ec:	00094583          	lbu	a1,0(s2)
    36f0:	f9e5                	bnez	a1,36e0 <vprintf+0x16c>
        s = va_arg(ap, char*);
    36f2:	8b4e                	mv	s6,s3
      state = 0;
    36f4:	4981                	li	s3,0
    36f6:	bdf9                	j	35d4 <vprintf+0x60>
          s = "(null)";
    36f8:	00000917          	auipc	s2,0x0
    36fc:	2b090913          	addi	s2,s2,688 # 39a8 <malloc+0x16a>
        while(*s != 0){
    3700:	02800593          	li	a1,40
    3704:	bff1                	j	36e0 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    3706:	008b0913          	addi	s2,s6,8
    370a:	000b4583          	lbu	a1,0(s6)
    370e:	8556                	mv	a0,s5
    3710:	00000097          	auipc	ra,0x0
    3714:	d98080e7          	jalr	-616(ra) # 34a8 <putc>
    3718:	8b4a                	mv	s6,s2
      state = 0;
    371a:	4981                	li	s3,0
    371c:	bd65                	j	35d4 <vprintf+0x60>
        putc(fd, c);
    371e:	85d2                	mv	a1,s4
    3720:	8556                	mv	a0,s5
    3722:	00000097          	auipc	ra,0x0
    3726:	d86080e7          	jalr	-634(ra) # 34a8 <putc>
      state = 0;
    372a:	4981                	li	s3,0
    372c:	b565                	j	35d4 <vprintf+0x60>
        s = va_arg(ap, char*);
    372e:	8b4e                	mv	s6,s3
      state = 0;
    3730:	4981                	li	s3,0
    3732:	b54d                	j	35d4 <vprintf+0x60>
    }
  }
}
    3734:	70e6                	ld	ra,120(sp)
    3736:	7446                	ld	s0,112(sp)
    3738:	74a6                	ld	s1,104(sp)
    373a:	7906                	ld	s2,96(sp)
    373c:	69e6                	ld	s3,88(sp)
    373e:	6a46                	ld	s4,80(sp)
    3740:	6aa6                	ld	s5,72(sp)
    3742:	6b06                	ld	s6,64(sp)
    3744:	7be2                	ld	s7,56(sp)
    3746:	7c42                	ld	s8,48(sp)
    3748:	7ca2                	ld	s9,40(sp)
    374a:	7d02                	ld	s10,32(sp)
    374c:	6de2                	ld	s11,24(sp)
    374e:	6109                	addi	sp,sp,128
    3750:	8082                	ret

0000000000003752 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    3752:	715d                	addi	sp,sp,-80
    3754:	ec06                	sd	ra,24(sp)
    3756:	e822                	sd	s0,16(sp)
    3758:	1000                	addi	s0,sp,32
    375a:	e010                	sd	a2,0(s0)
    375c:	e414                	sd	a3,8(s0)
    375e:	e818                	sd	a4,16(s0)
    3760:	ec1c                	sd	a5,24(s0)
    3762:	03043023          	sd	a6,32(s0)
    3766:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    376a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    376e:	8622                	mv	a2,s0
    3770:	00000097          	auipc	ra,0x0
    3774:	e04080e7          	jalr	-508(ra) # 3574 <vprintf>
}
    3778:	60e2                	ld	ra,24(sp)
    377a:	6442                	ld	s0,16(sp)
    377c:	6161                	addi	sp,sp,80
    377e:	8082                	ret

0000000000003780 <printf>:

void
printf(const char *fmt, ...)
{
    3780:	711d                	addi	sp,sp,-96
    3782:	ec06                	sd	ra,24(sp)
    3784:	e822                	sd	s0,16(sp)
    3786:	1000                	addi	s0,sp,32
    3788:	e40c                	sd	a1,8(s0)
    378a:	e810                	sd	a2,16(s0)
    378c:	ec14                	sd	a3,24(s0)
    378e:	f018                	sd	a4,32(s0)
    3790:	f41c                	sd	a5,40(s0)
    3792:	03043823          	sd	a6,48(s0)
    3796:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    379a:	00840613          	addi	a2,s0,8
    379e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    37a2:	85aa                	mv	a1,a0
    37a4:	4505                	li	a0,1
    37a6:	00000097          	auipc	ra,0x0
    37aa:	dce080e7          	jalr	-562(ra) # 3574 <vprintf>
}
    37ae:	60e2                	ld	ra,24(sp)
    37b0:	6442                	ld	s0,16(sp)
    37b2:	6125                	addi	sp,sp,96
    37b4:	8082                	ret

00000000000037b6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    37b6:	1141                	addi	sp,sp,-16
    37b8:	e422                	sd	s0,8(sp)
    37ba:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    37bc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    37c0:	00001797          	auipc	a5,0x1
    37c4:	8507b783          	ld	a5,-1968(a5) # 4010 <freep>
    37c8:	a805                	j	37f8 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    37ca:	4618                	lw	a4,8(a2)
    37cc:	9db9                	addw	a1,a1,a4
    37ce:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    37d2:	6398                	ld	a4,0(a5)
    37d4:	6318                	ld	a4,0(a4)
    37d6:	fee53823          	sd	a4,-16(a0)
    37da:	a091                	j	381e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    37dc:	ff852703          	lw	a4,-8(a0)
    37e0:	9e39                	addw	a2,a2,a4
    37e2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    37e4:	ff053703          	ld	a4,-16(a0)
    37e8:	e398                	sd	a4,0(a5)
    37ea:	a099                	j	3830 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    37ec:	6398                	ld	a4,0(a5)
    37ee:	00e7e463          	bltu	a5,a4,37f6 <free+0x40>
    37f2:	00e6ea63          	bltu	a3,a4,3806 <free+0x50>
{
    37f6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    37f8:	fed7fae3          	bgeu	a5,a3,37ec <free+0x36>
    37fc:	6398                	ld	a4,0(a5)
    37fe:	00e6e463          	bltu	a3,a4,3806 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3802:	fee7eae3          	bltu	a5,a4,37f6 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    3806:	ff852583          	lw	a1,-8(a0)
    380a:	6390                	ld	a2,0(a5)
    380c:	02059713          	slli	a4,a1,0x20
    3810:	9301                	srli	a4,a4,0x20
    3812:	0712                	slli	a4,a4,0x4
    3814:	9736                	add	a4,a4,a3
    3816:	fae60ae3          	beq	a2,a4,37ca <free+0x14>
    bp->s.ptr = p->s.ptr;
    381a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    381e:	4790                	lw	a2,8(a5)
    3820:	02061713          	slli	a4,a2,0x20
    3824:	9301                	srli	a4,a4,0x20
    3826:	0712                	slli	a4,a4,0x4
    3828:	973e                	add	a4,a4,a5
    382a:	fae689e3          	beq	a3,a4,37dc <free+0x26>
  } else
    p->s.ptr = bp;
    382e:	e394                	sd	a3,0(a5)
  freep = p;
    3830:	00000717          	auipc	a4,0x0
    3834:	7ef73023          	sd	a5,2016(a4) # 4010 <freep>
}
    3838:	6422                	ld	s0,8(sp)
    383a:	0141                	addi	sp,sp,16
    383c:	8082                	ret

000000000000383e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    383e:	7139                	addi	sp,sp,-64
    3840:	fc06                	sd	ra,56(sp)
    3842:	f822                	sd	s0,48(sp)
    3844:	f426                	sd	s1,40(sp)
    3846:	f04a                	sd	s2,32(sp)
    3848:	ec4e                	sd	s3,24(sp)
    384a:	e852                	sd	s4,16(sp)
    384c:	e456                	sd	s5,8(sp)
    384e:	e05a                	sd	s6,0(sp)
    3850:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3852:	02051493          	slli	s1,a0,0x20
    3856:	9081                	srli	s1,s1,0x20
    3858:	04bd                	addi	s1,s1,15
    385a:	8091                	srli	s1,s1,0x4
    385c:	0014899b          	addiw	s3,s1,1
    3860:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    3862:	00000517          	auipc	a0,0x0
    3866:	7ae53503          	ld	a0,1966(a0) # 4010 <freep>
    386a:	c515                	beqz	a0,3896 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    386c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    386e:	4798                	lw	a4,8(a5)
    3870:	02977f63          	bgeu	a4,s1,38ae <malloc+0x70>
    3874:	8a4e                	mv	s4,s3
    3876:	0009871b          	sext.w	a4,s3
    387a:	6685                	lui	a3,0x1
    387c:	00d77363          	bgeu	a4,a3,3882 <malloc+0x44>
    3880:	6a05                	lui	s4,0x1
    3882:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    3886:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    388a:	00000917          	auipc	s2,0x0
    388e:	78690913          	addi	s2,s2,1926 # 4010 <freep>
  if(p == (char*)-1)
    3892:	5afd                	li	s5,-1
    3894:	a88d                	j	3906 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    3896:	00000797          	auipc	a5,0x0
    389a:	78a78793          	addi	a5,a5,1930 # 4020 <base>
    389e:	00000717          	auipc	a4,0x0
    38a2:	76f73923          	sd	a5,1906(a4) # 4010 <freep>
    38a6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    38a8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    38ac:	b7e1                	j	3874 <malloc+0x36>
      if(p->s.size == nunits)
    38ae:	02e48b63          	beq	s1,a4,38e4 <malloc+0xa6>
        p->s.size -= nunits;
    38b2:	4137073b          	subw	a4,a4,s3
    38b6:	c798                	sw	a4,8(a5)
        p += p->s.size;
    38b8:	1702                	slli	a4,a4,0x20
    38ba:	9301                	srli	a4,a4,0x20
    38bc:	0712                	slli	a4,a4,0x4
    38be:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    38c0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    38c4:	00000717          	auipc	a4,0x0
    38c8:	74a73623          	sd	a0,1868(a4) # 4010 <freep>
      return (void*)(p + 1);
    38cc:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    38d0:	70e2                	ld	ra,56(sp)
    38d2:	7442                	ld	s0,48(sp)
    38d4:	74a2                	ld	s1,40(sp)
    38d6:	7902                	ld	s2,32(sp)
    38d8:	69e2                	ld	s3,24(sp)
    38da:	6a42                	ld	s4,16(sp)
    38dc:	6aa2                	ld	s5,8(sp)
    38de:	6b02                	ld	s6,0(sp)
    38e0:	6121                	addi	sp,sp,64
    38e2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    38e4:	6398                	ld	a4,0(a5)
    38e6:	e118                	sd	a4,0(a0)
    38e8:	bff1                	j	38c4 <malloc+0x86>
  hp->s.size = nu;
    38ea:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    38ee:	0541                	addi	a0,a0,16
    38f0:	00000097          	auipc	ra,0x0
    38f4:	ec6080e7          	jalr	-314(ra) # 37b6 <free>
  return freep;
    38f8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    38fc:	d971                	beqz	a0,38d0 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    38fe:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3900:	4798                	lw	a4,8(a5)
    3902:	fa9776e3          	bgeu	a4,s1,38ae <malloc+0x70>
    if(p == freep)
    3906:	00093703          	ld	a4,0(s2)
    390a:	853e                	mv	a0,a5
    390c:	fef719e3          	bne	a4,a5,38fe <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3910:	8552                	mv	a0,s4
    3912:	00000097          	auipc	ra,0x0
    3916:	b56080e7          	jalr	-1194(ra) # 3468 <sbrk>
  if(p == (char*)-1)
    391a:	fd5518e3          	bne	a0,s5,38ea <malloc+0xac>
        return 0;
    391e:	4501                	li	a0,0
    3920:	bf45                	j	38d0 <malloc+0x92>
