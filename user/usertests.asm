
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
    3000:	1141                	addi	sp,sp,-16
    3002:	e406                	sd	ra,8(sp)
    3004:	e022                	sd	s0,0(sp)
    3006:	0800                	addi	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
    3008:	20100593          	li	a1,513
    300c:	4505                	li	a0,1
    300e:	057e                	slli	a0,a0,0x1f
    3010:	00006097          	auipc	ra,0x6
    3014:	c56080e7          	jalr	-938(ra) # 8c66 <open>
    if(fd >= 0){
    3018:	02055063          	bgez	a0,3038 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
    301c:	20100593          	li	a1,513
    3020:	557d                	li	a0,-1
    3022:	00006097          	auipc	ra,0x6
    3026:	c44080e7          	jalr	-956(ra) # 8c66 <open>
    uint64 addr = addrs[ai];
    302a:	55fd                	li	a1,-1
    if(fd >= 0){
    302c:	00055863          	bgez	a0,303c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
    3030:	60a2                	ld	ra,8(sp)
    3032:	6402                	ld	s0,0(sp)
    3034:	0141                	addi	sp,sp,16
    3036:	8082                	ret
    uint64 addr = addrs[ai];
    3038:	4585                	li	a1,1
    303a:	05fe                	slli	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
    303c:	862a                	mv	a2,a0
    303e:	00006517          	auipc	a0,0x6
    3042:	15250513          	addi	a0,a0,338 # 9190 <malloc+0x10c>
    3046:	00006097          	auipc	ra,0x6
    304a:	f80080e7          	jalr	-128(ra) # 8fc6 <printf>
      exit(1);
    304e:	4505                	li	a0,1
    3050:	00006097          	auipc	ra,0x6
    3054:	bce080e7          	jalr	-1074(ra) # 8c1e <exit>

0000000000003058 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
    3058:	0000a797          	auipc	a5,0xa
    305c:	51078793          	addi	a5,a5,1296 # d568 <uninit>
    3060:	0000d697          	auipc	a3,0xd
    3064:	c1868693          	addi	a3,a3,-1000 # fc78 <buf>
    if(uninit[i] != '\0'){
    3068:	0007c703          	lbu	a4,0(a5)
    306c:	e709                	bnez	a4,3076 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
    306e:	0785                	addi	a5,a5,1
    3070:	fed79ce3          	bne	a5,a3,3068 <bsstest+0x10>
    3074:	8082                	ret
{
    3076:	1141                	addi	sp,sp,-16
    3078:	e406                	sd	ra,8(sp)
    307a:	e022                	sd	s0,0(sp)
    307c:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
    307e:	85aa                	mv	a1,a0
    3080:	00006517          	auipc	a0,0x6
    3084:	13050513          	addi	a0,a0,304 # 91b0 <malloc+0x12c>
    3088:	00006097          	auipc	ra,0x6
    308c:	f3e080e7          	jalr	-194(ra) # 8fc6 <printf>
      exit(1);
    3090:	4505                	li	a0,1
    3092:	00006097          	auipc	ra,0x6
    3096:	b8c080e7          	jalr	-1140(ra) # 8c1e <exit>

000000000000309a <opentest>:
{
    309a:	1101                	addi	sp,sp,-32
    309c:	ec06                	sd	ra,24(sp)
    309e:	e822                	sd	s0,16(sp)
    30a0:	e426                	sd	s1,8(sp)
    30a2:	1000                	addi	s0,sp,32
    30a4:	84aa                	mv	s1,a0
  fd = open("echo", 0);
    30a6:	4581                	li	a1,0
    30a8:	00006517          	auipc	a0,0x6
    30ac:	12050513          	addi	a0,a0,288 # 91c8 <malloc+0x144>
    30b0:	00006097          	auipc	ra,0x6
    30b4:	bb6080e7          	jalr	-1098(ra) # 8c66 <open>
  if(fd < 0){
    30b8:	02054663          	bltz	a0,30e4 <opentest+0x4a>
  close(fd);
    30bc:	00006097          	auipc	ra,0x6
    30c0:	b92080e7          	jalr	-1134(ra) # 8c4e <close>
  fd = open("doesnotexist", 0);
    30c4:	4581                	li	a1,0
    30c6:	00006517          	auipc	a0,0x6
    30ca:	12250513          	addi	a0,a0,290 # 91e8 <malloc+0x164>
    30ce:	00006097          	auipc	ra,0x6
    30d2:	b98080e7          	jalr	-1128(ra) # 8c66 <open>
  if(fd >= 0){
    30d6:	02055563          	bgez	a0,3100 <opentest+0x66>
}
    30da:	60e2                	ld	ra,24(sp)
    30dc:	6442                	ld	s0,16(sp)
    30de:	64a2                	ld	s1,8(sp)
    30e0:	6105                	addi	sp,sp,32
    30e2:	8082                	ret
    printf("%s: open echo failed!\n", s);
    30e4:	85a6                	mv	a1,s1
    30e6:	00006517          	auipc	a0,0x6
    30ea:	0ea50513          	addi	a0,a0,234 # 91d0 <malloc+0x14c>
    30ee:	00006097          	auipc	ra,0x6
    30f2:	ed8080e7          	jalr	-296(ra) # 8fc6 <printf>
    exit(1);
    30f6:	4505                	li	a0,1
    30f8:	00006097          	auipc	ra,0x6
    30fc:	b26080e7          	jalr	-1242(ra) # 8c1e <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
    3100:	85a6                	mv	a1,s1
    3102:	00006517          	auipc	a0,0x6
    3106:	0f650513          	addi	a0,a0,246 # 91f8 <malloc+0x174>
    310a:	00006097          	auipc	ra,0x6
    310e:	ebc080e7          	jalr	-324(ra) # 8fc6 <printf>
    exit(1);
    3112:	4505                	li	a0,1
    3114:	00006097          	auipc	ra,0x6
    3118:	b0a080e7          	jalr	-1270(ra) # 8c1e <exit>

000000000000311c <truncate2>:
{
    311c:	7179                	addi	sp,sp,-48
    311e:	f406                	sd	ra,40(sp)
    3120:	f022                	sd	s0,32(sp)
    3122:	ec26                	sd	s1,24(sp)
    3124:	e84a                	sd	s2,16(sp)
    3126:	e44e                	sd	s3,8(sp)
    3128:	1800                	addi	s0,sp,48
    312a:	89aa                	mv	s3,a0
  unlink("truncfile");
    312c:	00006517          	auipc	a0,0x6
    3130:	0f450513          	addi	a0,a0,244 # 9220 <malloc+0x19c>
    3134:	00006097          	auipc	ra,0x6
    3138:	b42080e7          	jalr	-1214(ra) # 8c76 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
    313c:	60100593          	li	a1,1537
    3140:	00006517          	auipc	a0,0x6
    3144:	0e050513          	addi	a0,a0,224 # 9220 <malloc+0x19c>
    3148:	00006097          	auipc	ra,0x6
    314c:	b1e080e7          	jalr	-1250(ra) # 8c66 <open>
    3150:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
    3152:	4611                	li	a2,4
    3154:	00006597          	auipc	a1,0x6
    3158:	0dc58593          	addi	a1,a1,220 # 9230 <malloc+0x1ac>
    315c:	00006097          	auipc	ra,0x6
    3160:	aea080e7          	jalr	-1302(ra) # 8c46 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
    3164:	40100593          	li	a1,1025
    3168:	00006517          	auipc	a0,0x6
    316c:	0b850513          	addi	a0,a0,184 # 9220 <malloc+0x19c>
    3170:	00006097          	auipc	ra,0x6
    3174:	af6080e7          	jalr	-1290(ra) # 8c66 <open>
    3178:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
    317a:	4605                	li	a2,1
    317c:	00006597          	auipc	a1,0x6
    3180:	0bc58593          	addi	a1,a1,188 # 9238 <malloc+0x1b4>
    3184:	8526                	mv	a0,s1
    3186:	00006097          	auipc	ra,0x6
    318a:	ac0080e7          	jalr	-1344(ra) # 8c46 <write>
  if(n != -1){
    318e:	57fd                	li	a5,-1
    3190:	02f51b63          	bne	a0,a5,31c6 <truncate2+0xaa>
  unlink("truncfile");
    3194:	00006517          	auipc	a0,0x6
    3198:	08c50513          	addi	a0,a0,140 # 9220 <malloc+0x19c>
    319c:	00006097          	auipc	ra,0x6
    31a0:	ada080e7          	jalr	-1318(ra) # 8c76 <unlink>
  close(fd1);
    31a4:	8526                	mv	a0,s1
    31a6:	00006097          	auipc	ra,0x6
    31aa:	aa8080e7          	jalr	-1368(ra) # 8c4e <close>
  close(fd2);
    31ae:	854a                	mv	a0,s2
    31b0:	00006097          	auipc	ra,0x6
    31b4:	a9e080e7          	jalr	-1378(ra) # 8c4e <close>
}
    31b8:	70a2                	ld	ra,40(sp)
    31ba:	7402                	ld	s0,32(sp)
    31bc:	64e2                	ld	s1,24(sp)
    31be:	6942                	ld	s2,16(sp)
    31c0:	69a2                	ld	s3,8(sp)
    31c2:	6145                	addi	sp,sp,48
    31c4:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
    31c6:	862a                	mv	a2,a0
    31c8:	85ce                	mv	a1,s3
    31ca:	00006517          	auipc	a0,0x6
    31ce:	07650513          	addi	a0,a0,118 # 9240 <malloc+0x1bc>
    31d2:	00006097          	auipc	ra,0x6
    31d6:	df4080e7          	jalr	-524(ra) # 8fc6 <printf>
    exit(1);
    31da:	4505                	li	a0,1
    31dc:	00006097          	auipc	ra,0x6
    31e0:	a42080e7          	jalr	-1470(ra) # 8c1e <exit>

00000000000031e4 <createtest>:
{
    31e4:	7179                	addi	sp,sp,-48
    31e6:	f406                	sd	ra,40(sp)
    31e8:	f022                	sd	s0,32(sp)
    31ea:	ec26                	sd	s1,24(sp)
    31ec:	e84a                	sd	s2,16(sp)
    31ee:	1800                	addi	s0,sp,48
  name[0] = 'a';
    31f0:	06100793          	li	a5,97
    31f4:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
    31f8:	fc040d23          	sb	zero,-38(s0)
    31fc:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
    3200:	06400913          	li	s2,100
    name[1] = '0' + i;
    3204:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
    3208:	20200593          	li	a1,514
    320c:	fd840513          	addi	a0,s0,-40
    3210:	00006097          	auipc	ra,0x6
    3214:	a56080e7          	jalr	-1450(ra) # 8c66 <open>
    close(fd);
    3218:	00006097          	auipc	ra,0x6
    321c:	a36080e7          	jalr	-1482(ra) # 8c4e <close>
  for(i = 0; i < N; i++){
    3220:	2485                	addiw	s1,s1,1
    3222:	0ff4f493          	andi	s1,s1,255
    3226:	fd249fe3          	bne	s1,s2,3204 <createtest+0x20>
  name[0] = 'a';
    322a:	06100793          	li	a5,97
    322e:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
    3232:	fc040d23          	sb	zero,-38(s0)
    3236:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
    323a:	06400913          	li	s2,100
    name[1] = '0' + i;
    323e:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
    3242:	fd840513          	addi	a0,s0,-40
    3246:	00006097          	auipc	ra,0x6
    324a:	a30080e7          	jalr	-1488(ra) # 8c76 <unlink>
  for(i = 0; i < N; i++){
    324e:	2485                	addiw	s1,s1,1
    3250:	0ff4f493          	andi	s1,s1,255
    3254:	ff2495e3          	bne	s1,s2,323e <createtest+0x5a>
}
    3258:	70a2                	ld	ra,40(sp)
    325a:	7402                	ld	s0,32(sp)
    325c:	64e2                	ld	s1,24(sp)
    325e:	6942                	ld	s2,16(sp)
    3260:	6145                	addi	sp,sp,48
    3262:	8082                	ret

0000000000003264 <bigwrite>:
{
    3264:	715d                	addi	sp,sp,-80
    3266:	e486                	sd	ra,72(sp)
    3268:	e0a2                	sd	s0,64(sp)
    326a:	fc26                	sd	s1,56(sp)
    326c:	f84a                	sd	s2,48(sp)
    326e:	f44e                	sd	s3,40(sp)
    3270:	f052                	sd	s4,32(sp)
    3272:	ec56                	sd	s5,24(sp)
    3274:	e85a                	sd	s6,16(sp)
    3276:	e45e                	sd	s7,8(sp)
    3278:	0880                	addi	s0,sp,80
    327a:	8baa                	mv	s7,a0
  unlink("bigwrite");
    327c:	00006517          	auipc	a0,0x6
    3280:	fec50513          	addi	a0,a0,-20 # 9268 <malloc+0x1e4>
    3284:	00006097          	auipc	ra,0x6
    3288:	9f2080e7          	jalr	-1550(ra) # 8c76 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    328c:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
    3290:	00006a97          	auipc	s5,0x6
    3294:	fd8a8a93          	addi	s5,s5,-40 # 9268 <malloc+0x1e4>
      int cc = write(fd, buf, sz);
    3298:	0000da17          	auipc	s4,0xd
    329c:	9e0a0a13          	addi	s4,s4,-1568 # fc78 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    32a0:	6b0d                	lui	s6,0x3
    32a2:	1c9b0b13          	addi	s6,s6,457 # 31c9 <truncate2+0xad>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    32a6:	20200593          	li	a1,514
    32aa:	8556                	mv	a0,s5
    32ac:	00006097          	auipc	ra,0x6
    32b0:	9ba080e7          	jalr	-1606(ra) # 8c66 <open>
    32b4:	892a                	mv	s2,a0
    if(fd < 0){
    32b6:	04054d63          	bltz	a0,3310 <bigwrite+0xac>
      int cc = write(fd, buf, sz);
    32ba:	8626                	mv	a2,s1
    32bc:	85d2                	mv	a1,s4
    32be:	00006097          	auipc	ra,0x6
    32c2:	988080e7          	jalr	-1656(ra) # 8c46 <write>
    32c6:	89aa                	mv	s3,a0
      if(cc != sz){
    32c8:	06a49463          	bne	s1,a0,3330 <bigwrite+0xcc>
      int cc = write(fd, buf, sz);
    32cc:	8626                	mv	a2,s1
    32ce:	85d2                	mv	a1,s4
    32d0:	854a                	mv	a0,s2
    32d2:	00006097          	auipc	ra,0x6
    32d6:	974080e7          	jalr	-1676(ra) # 8c46 <write>
      if(cc != sz){
    32da:	04951963          	bne	a0,s1,332c <bigwrite+0xc8>
    close(fd);
    32de:	854a                	mv	a0,s2
    32e0:	00006097          	auipc	ra,0x6
    32e4:	96e080e7          	jalr	-1682(ra) # 8c4e <close>
    unlink("bigwrite");
    32e8:	8556                	mv	a0,s5
    32ea:	00006097          	auipc	ra,0x6
    32ee:	98c080e7          	jalr	-1652(ra) # 8c76 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
    32f2:	1d74849b          	addiw	s1,s1,471
    32f6:	fb6498e3          	bne	s1,s6,32a6 <bigwrite+0x42>
}
    32fa:	60a6                	ld	ra,72(sp)
    32fc:	6406                	ld	s0,64(sp)
    32fe:	74e2                	ld	s1,56(sp)
    3300:	7942                	ld	s2,48(sp)
    3302:	79a2                	ld	s3,40(sp)
    3304:	7a02                	ld	s4,32(sp)
    3306:	6ae2                	ld	s5,24(sp)
    3308:	6b42                	ld	s6,16(sp)
    330a:	6ba2                	ld	s7,8(sp)
    330c:	6161                	addi	sp,sp,80
    330e:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
    3310:	85de                	mv	a1,s7
    3312:	00006517          	auipc	a0,0x6
    3316:	f6650513          	addi	a0,a0,-154 # 9278 <malloc+0x1f4>
    331a:	00006097          	auipc	ra,0x6
    331e:	cac080e7          	jalr	-852(ra) # 8fc6 <printf>
      exit(1);
    3322:	4505                	li	a0,1
    3324:	00006097          	auipc	ra,0x6
    3328:	8fa080e7          	jalr	-1798(ra) # 8c1e <exit>
    332c:	84ce                	mv	s1,s3
      int cc = write(fd, buf, sz);
    332e:	89aa                	mv	s3,a0
        printf("%s: write(%d) ret %d\n", s, sz, cc);
    3330:	86ce                	mv	a3,s3
    3332:	8626                	mv	a2,s1
    3334:	85de                	mv	a1,s7
    3336:	00006517          	auipc	a0,0x6
    333a:	f6250513          	addi	a0,a0,-158 # 9298 <malloc+0x214>
    333e:	00006097          	auipc	ra,0x6
    3342:	c88080e7          	jalr	-888(ra) # 8fc6 <printf>
        exit(1);
    3346:	4505                	li	a0,1
    3348:	00006097          	auipc	ra,0x6
    334c:	8d6080e7          	jalr	-1834(ra) # 8c1e <exit>

0000000000003350 <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
    3350:	7179                	addi	sp,sp,-48
    3352:	f406                	sd	ra,40(sp)
    3354:	f022                	sd	s0,32(sp)
    3356:	ec26                	sd	s1,24(sp)
    3358:	e84a                	sd	s2,16(sp)
    335a:	e44e                	sd	s3,8(sp)
    335c:	e052                	sd	s4,0(sp)
    335e:	1800                	addi	s0,sp,48
  int assumed_free = 600;
  
  unlink("junk");
    3360:	00006517          	auipc	a0,0x6
    3364:	f5050513          	addi	a0,a0,-176 # 92b0 <malloc+0x22c>
    3368:	00006097          	auipc	ra,0x6
    336c:	90e080e7          	jalr	-1778(ra) # 8c76 <unlink>
    3370:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
    3374:	00006997          	auipc	s3,0x6
    3378:	f3c98993          	addi	s3,s3,-196 # 92b0 <malloc+0x22c>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
    337c:	5a7d                	li	s4,-1
    337e:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
    3382:	20100593          	li	a1,513
    3386:	854e                	mv	a0,s3
    3388:	00006097          	auipc	ra,0x6
    338c:	8de080e7          	jalr	-1826(ra) # 8c66 <open>
    3390:	84aa                	mv	s1,a0
    if(fd < 0){
    3392:	06054b63          	bltz	a0,3408 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
    3396:	4605                	li	a2,1
    3398:	85d2                	mv	a1,s4
    339a:	00006097          	auipc	ra,0x6
    339e:	8ac080e7          	jalr	-1876(ra) # 8c46 <write>
    close(fd);
    33a2:	8526                	mv	a0,s1
    33a4:	00006097          	auipc	ra,0x6
    33a8:	8aa080e7          	jalr	-1878(ra) # 8c4e <close>
    unlink("junk");
    33ac:	854e                	mv	a0,s3
    33ae:	00006097          	auipc	ra,0x6
    33b2:	8c8080e7          	jalr	-1848(ra) # 8c76 <unlink>
  for(int i = 0; i < assumed_free; i++){
    33b6:	397d                	addiw	s2,s2,-1
    33b8:	fc0915e3          	bnez	s2,3382 <badwrite+0x32>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
    33bc:	20100593          	li	a1,513
    33c0:	00006517          	auipc	a0,0x6
    33c4:	ef050513          	addi	a0,a0,-272 # 92b0 <malloc+0x22c>
    33c8:	00006097          	auipc	ra,0x6
    33cc:	89e080e7          	jalr	-1890(ra) # 8c66 <open>
    33d0:	84aa                	mv	s1,a0
  if(fd < 0){
    33d2:	04054863          	bltz	a0,3422 <badwrite+0xd2>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
    33d6:	4605                	li	a2,1
    33d8:	00006597          	auipc	a1,0x6
    33dc:	e6058593          	addi	a1,a1,-416 # 9238 <malloc+0x1b4>
    33e0:	00006097          	auipc	ra,0x6
    33e4:	866080e7          	jalr	-1946(ra) # 8c46 <write>
    33e8:	4785                	li	a5,1
    33ea:	04f50963          	beq	a0,a5,343c <badwrite+0xec>
    printf("write failed\n");
    33ee:	00006517          	auipc	a0,0x6
    33f2:	ee250513          	addi	a0,a0,-286 # 92d0 <malloc+0x24c>
    33f6:	00006097          	auipc	ra,0x6
    33fa:	bd0080e7          	jalr	-1072(ra) # 8fc6 <printf>
    exit(1);
    33fe:	4505                	li	a0,1
    3400:	00006097          	auipc	ra,0x6
    3404:	81e080e7          	jalr	-2018(ra) # 8c1e <exit>
      printf("open junk failed\n");
    3408:	00006517          	auipc	a0,0x6
    340c:	eb050513          	addi	a0,a0,-336 # 92b8 <malloc+0x234>
    3410:	00006097          	auipc	ra,0x6
    3414:	bb6080e7          	jalr	-1098(ra) # 8fc6 <printf>
      exit(1);
    3418:	4505                	li	a0,1
    341a:	00006097          	auipc	ra,0x6
    341e:	804080e7          	jalr	-2044(ra) # 8c1e <exit>
    printf("open junk failed\n");
    3422:	00006517          	auipc	a0,0x6
    3426:	e9650513          	addi	a0,a0,-362 # 92b8 <malloc+0x234>
    342a:	00006097          	auipc	ra,0x6
    342e:	b9c080e7          	jalr	-1124(ra) # 8fc6 <printf>
    exit(1);
    3432:	4505                	li	a0,1
    3434:	00005097          	auipc	ra,0x5
    3438:	7ea080e7          	jalr	2026(ra) # 8c1e <exit>
  }
  close(fd);
    343c:	8526                	mv	a0,s1
    343e:	00006097          	auipc	ra,0x6
    3442:	810080e7          	jalr	-2032(ra) # 8c4e <close>
  unlink("junk");
    3446:	00006517          	auipc	a0,0x6
    344a:	e6a50513          	addi	a0,a0,-406 # 92b0 <malloc+0x22c>
    344e:	00006097          	auipc	ra,0x6
    3452:	828080e7          	jalr	-2008(ra) # 8c76 <unlink>

  exit(0);
    3456:	4501                	li	a0,0
    3458:	00005097          	auipc	ra,0x5
    345c:	7c6080e7          	jalr	1990(ra) # 8c1e <exit>

0000000000003460 <outofinodes>:
  }
}

void
outofinodes(char *s)
{
    3460:	715d                	addi	sp,sp,-80
    3462:	e486                	sd	ra,72(sp)
    3464:	e0a2                	sd	s0,64(sp)
    3466:	fc26                	sd	s1,56(sp)
    3468:	f84a                	sd	s2,48(sp)
    346a:	f44e                	sd	s3,40(sp)
    346c:	0880                	addi	s0,sp,80
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
    346e:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
    3470:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    3474:	40000993          	li	s3,1024
    name[0] = 'z';
    3478:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
    347c:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
    3480:	41f4d79b          	sraiw	a5,s1,0x1f
    3484:	01b7d71b          	srliw	a4,a5,0x1b
    3488:	009707bb          	addw	a5,a4,s1
    348c:	4057d69b          	sraiw	a3,a5,0x5
    3490:	0306869b          	addiw	a3,a3,48
    3494:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
    3498:	8bfd                	andi	a5,a5,31
    349a:	9f99                	subw	a5,a5,a4
    349c:	0307879b          	addiw	a5,a5,48
    34a0:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
    34a4:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
    34a8:	fb040513          	addi	a0,s0,-80
    34ac:	00005097          	auipc	ra,0x5
    34b0:	7ca080e7          	jalr	1994(ra) # 8c76 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    34b4:	60200593          	li	a1,1538
    34b8:	fb040513          	addi	a0,s0,-80
    34bc:	00005097          	auipc	ra,0x5
    34c0:	7aa080e7          	jalr	1962(ra) # 8c66 <open>
    if(fd < 0){
    34c4:	00054963          	bltz	a0,34d6 <outofinodes+0x76>
      // failure is eventually expected.
      break;
    }
    close(fd);
    34c8:	00005097          	auipc	ra,0x5
    34cc:	786080e7          	jalr	1926(ra) # 8c4e <close>
  for(int i = 0; i < nzz; i++){
    34d0:	2485                	addiw	s1,s1,1
    34d2:	fb3493e3          	bne	s1,s3,3478 <outofinodes+0x18>
    34d6:	4481                	li	s1,0
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
    34d8:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    34dc:	40000993          	li	s3,1024
    name[0] = 'z';
    34e0:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
    34e4:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
    34e8:	41f4d79b          	sraiw	a5,s1,0x1f
    34ec:	01b7d71b          	srliw	a4,a5,0x1b
    34f0:	009707bb          	addw	a5,a4,s1
    34f4:	4057d69b          	sraiw	a3,a5,0x5
    34f8:	0306869b          	addiw	a3,a3,48
    34fc:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
    3500:	8bfd                	andi	a5,a5,31
    3502:	9f99                	subw	a5,a5,a4
    3504:	0307879b          	addiw	a5,a5,48
    3508:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
    350c:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
    3510:	fb040513          	addi	a0,s0,-80
    3514:	00005097          	auipc	ra,0x5
    3518:	762080e7          	jalr	1890(ra) # 8c76 <unlink>
  for(int i = 0; i < nzz; i++){
    351c:	2485                	addiw	s1,s1,1
    351e:	fd3491e3          	bne	s1,s3,34e0 <outofinodes+0x80>
  }
}
    3522:	60a6                	ld	ra,72(sp)
    3524:	6406                	ld	s0,64(sp)
    3526:	74e2                	ld	s1,56(sp)
    3528:	7942                	ld	s2,48(sp)
    352a:	79a2                	ld	s3,40(sp)
    352c:	6161                	addi	sp,sp,80
    352e:	8082                	ret

0000000000003530 <copyin>:
{
    3530:	715d                	addi	sp,sp,-80
    3532:	e486                	sd	ra,72(sp)
    3534:	e0a2                	sd	s0,64(sp)
    3536:	fc26                	sd	s1,56(sp)
    3538:	f84a                	sd	s2,48(sp)
    353a:	f44e                	sd	s3,40(sp)
    353c:	f052                	sd	s4,32(sp)
    353e:	0880                	addi	s0,sp,80
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
    3540:	4785                	li	a5,1
    3542:	07fe                	slli	a5,a5,0x1f
    3544:	fcf43023          	sd	a5,-64(s0)
    3548:	57fd                	li	a5,-1
    354a:	fcf43423          	sd	a5,-56(s0)
  for(int ai = 0; ai < 2; ai++){
    354e:	fc040913          	addi	s2,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
    3552:	00006a17          	auipc	s4,0x6
    3556:	d8ea0a13          	addi	s4,s4,-626 # 92e0 <malloc+0x25c>
    uint64 addr = addrs[ai];
    355a:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
    355e:	20100593          	li	a1,513
    3562:	8552                	mv	a0,s4
    3564:	00005097          	auipc	ra,0x5
    3568:	702080e7          	jalr	1794(ra) # 8c66 <open>
    356c:	84aa                	mv	s1,a0
    if(fd < 0){
    356e:	08054863          	bltz	a0,35fe <copyin+0xce>
    int n = write(fd, (void*)addr, 8192);
    3572:	6609                	lui	a2,0x2
    3574:	85ce                	mv	a1,s3
    3576:	00005097          	auipc	ra,0x5
    357a:	6d0080e7          	jalr	1744(ra) # 8c46 <write>
    if(n >= 0){
    357e:	08055d63          	bgez	a0,3618 <copyin+0xe8>
    close(fd);
    3582:	8526                	mv	a0,s1
    3584:	00005097          	auipc	ra,0x5
    3588:	6ca080e7          	jalr	1738(ra) # 8c4e <close>
    unlink("copyin1");
    358c:	8552                	mv	a0,s4
    358e:	00005097          	auipc	ra,0x5
    3592:	6e8080e7          	jalr	1768(ra) # 8c76 <unlink>
    n = write(1, (char*)addr, 8192);
    3596:	6609                	lui	a2,0x2
    3598:	85ce                	mv	a1,s3
    359a:	4505                	li	a0,1
    359c:	00005097          	auipc	ra,0x5
    35a0:	6aa080e7          	jalr	1706(ra) # 8c46 <write>
    if(n > 0){
    35a4:	08a04963          	bgtz	a0,3636 <copyin+0x106>
    if(pipe(fds) < 0){
    35a8:	fb840513          	addi	a0,s0,-72
    35ac:	00005097          	auipc	ra,0x5
    35b0:	68a080e7          	jalr	1674(ra) # 8c36 <pipe>
    35b4:	0a054063          	bltz	a0,3654 <copyin+0x124>
    n = write(fds[1], (char*)addr, 8192);
    35b8:	6609                	lui	a2,0x2
    35ba:	85ce                	mv	a1,s3
    35bc:	fbc42503          	lw	a0,-68(s0)
    35c0:	00005097          	auipc	ra,0x5
    35c4:	686080e7          	jalr	1670(ra) # 8c46 <write>
    if(n > 0){
    35c8:	0aa04363          	bgtz	a0,366e <copyin+0x13e>
    close(fds[0]);
    35cc:	fb842503          	lw	a0,-72(s0)
    35d0:	00005097          	auipc	ra,0x5
    35d4:	67e080e7          	jalr	1662(ra) # 8c4e <close>
    close(fds[1]);
    35d8:	fbc42503          	lw	a0,-68(s0)
    35dc:	00005097          	auipc	ra,0x5
    35e0:	672080e7          	jalr	1650(ra) # 8c4e <close>
  for(int ai = 0; ai < 2; ai++){
    35e4:	0921                	addi	s2,s2,8
    35e6:	fd040793          	addi	a5,s0,-48
    35ea:	f6f918e3          	bne	s2,a5,355a <copyin+0x2a>
}
    35ee:	60a6                	ld	ra,72(sp)
    35f0:	6406                	ld	s0,64(sp)
    35f2:	74e2                	ld	s1,56(sp)
    35f4:	7942                	ld	s2,48(sp)
    35f6:	79a2                	ld	s3,40(sp)
    35f8:	7a02                	ld	s4,32(sp)
    35fa:	6161                	addi	sp,sp,80
    35fc:	8082                	ret
      printf("open(copyin1) failed\n");
    35fe:	00006517          	auipc	a0,0x6
    3602:	cea50513          	addi	a0,a0,-790 # 92e8 <malloc+0x264>
    3606:	00006097          	auipc	ra,0x6
    360a:	9c0080e7          	jalr	-1600(ra) # 8fc6 <printf>
      exit(1);
    360e:	4505                	li	a0,1
    3610:	00005097          	auipc	ra,0x5
    3614:	60e080e7          	jalr	1550(ra) # 8c1e <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
    3618:	862a                	mv	a2,a0
    361a:	85ce                	mv	a1,s3
    361c:	00006517          	auipc	a0,0x6
    3620:	ce450513          	addi	a0,a0,-796 # 9300 <malloc+0x27c>
    3624:	00006097          	auipc	ra,0x6
    3628:	9a2080e7          	jalr	-1630(ra) # 8fc6 <printf>
      exit(1);
    362c:	4505                	li	a0,1
    362e:	00005097          	auipc	ra,0x5
    3632:	5f0080e7          	jalr	1520(ra) # 8c1e <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
    3636:	862a                	mv	a2,a0
    3638:	85ce                	mv	a1,s3
    363a:	00006517          	auipc	a0,0x6
    363e:	cf650513          	addi	a0,a0,-778 # 9330 <malloc+0x2ac>
    3642:	00006097          	auipc	ra,0x6
    3646:	984080e7          	jalr	-1660(ra) # 8fc6 <printf>
      exit(1);
    364a:	4505                	li	a0,1
    364c:	00005097          	auipc	ra,0x5
    3650:	5d2080e7          	jalr	1490(ra) # 8c1e <exit>
      printf("pipe() failed\n");
    3654:	00006517          	auipc	a0,0x6
    3658:	d0c50513          	addi	a0,a0,-756 # 9360 <malloc+0x2dc>
    365c:	00006097          	auipc	ra,0x6
    3660:	96a080e7          	jalr	-1686(ra) # 8fc6 <printf>
      exit(1);
    3664:	4505                	li	a0,1
    3666:	00005097          	auipc	ra,0x5
    366a:	5b8080e7          	jalr	1464(ra) # 8c1e <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
    366e:	862a                	mv	a2,a0
    3670:	85ce                	mv	a1,s3
    3672:	00006517          	auipc	a0,0x6
    3676:	cfe50513          	addi	a0,a0,-770 # 9370 <malloc+0x2ec>
    367a:	00006097          	auipc	ra,0x6
    367e:	94c080e7          	jalr	-1716(ra) # 8fc6 <printf>
      exit(1);
    3682:	4505                	li	a0,1
    3684:	00005097          	auipc	ra,0x5
    3688:	59a080e7          	jalr	1434(ra) # 8c1e <exit>

000000000000368c <copyout>:
{
    368c:	711d                	addi	sp,sp,-96
    368e:	ec86                	sd	ra,88(sp)
    3690:	e8a2                	sd	s0,80(sp)
    3692:	e4a6                	sd	s1,72(sp)
    3694:	e0ca                	sd	s2,64(sp)
    3696:	fc4e                	sd	s3,56(sp)
    3698:	f852                	sd	s4,48(sp)
    369a:	f456                	sd	s5,40(sp)
    369c:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
    369e:	4785                	li	a5,1
    36a0:	07fe                	slli	a5,a5,0x1f
    36a2:	faf43823          	sd	a5,-80(s0)
    36a6:	57fd                	li	a5,-1
    36a8:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
    36ac:	fb040913          	addi	s2,s0,-80
    int fd = open("README", 0);
    36b0:	00006a17          	auipc	s4,0x6
    36b4:	cf0a0a13          	addi	s4,s4,-784 # 93a0 <malloc+0x31c>
    n = write(fds[1], "x", 1);
    36b8:	00006a97          	auipc	s5,0x6
    36bc:	b80a8a93          	addi	s5,s5,-1152 # 9238 <malloc+0x1b4>
    uint64 addr = addrs[ai];
    36c0:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
    36c4:	4581                	li	a1,0
    36c6:	8552                	mv	a0,s4
    36c8:	00005097          	auipc	ra,0x5
    36cc:	59e080e7          	jalr	1438(ra) # 8c66 <open>
    36d0:	84aa                	mv	s1,a0
    if(fd < 0){
    36d2:	08054663          	bltz	a0,375e <copyout+0xd2>
    int n = read(fd, (void*)addr, 8192);
    36d6:	6609                	lui	a2,0x2
    36d8:	85ce                	mv	a1,s3
    36da:	00005097          	auipc	ra,0x5
    36de:	564080e7          	jalr	1380(ra) # 8c3e <read>
    if(n > 0){
    36e2:	08a04b63          	bgtz	a0,3778 <copyout+0xec>
    close(fd);
    36e6:	8526                	mv	a0,s1
    36e8:	00005097          	auipc	ra,0x5
    36ec:	566080e7          	jalr	1382(ra) # 8c4e <close>
    if(pipe(fds) < 0){
    36f0:	fa840513          	addi	a0,s0,-88
    36f4:	00005097          	auipc	ra,0x5
    36f8:	542080e7          	jalr	1346(ra) # 8c36 <pipe>
    36fc:	08054d63          	bltz	a0,3796 <copyout+0x10a>
    n = write(fds[1], "x", 1);
    3700:	4605                	li	a2,1
    3702:	85d6                	mv	a1,s5
    3704:	fac42503          	lw	a0,-84(s0)
    3708:	00005097          	auipc	ra,0x5
    370c:	53e080e7          	jalr	1342(ra) # 8c46 <write>
    if(n != 1){
    3710:	4785                	li	a5,1
    3712:	08f51f63          	bne	a0,a5,37b0 <copyout+0x124>
    n = read(fds[0], (void*)addr, 8192);
    3716:	6609                	lui	a2,0x2
    3718:	85ce                	mv	a1,s3
    371a:	fa842503          	lw	a0,-88(s0)
    371e:	00005097          	auipc	ra,0x5
    3722:	520080e7          	jalr	1312(ra) # 8c3e <read>
    if(n > 0){
    3726:	0aa04263          	bgtz	a0,37ca <copyout+0x13e>
    close(fds[0]);
    372a:	fa842503          	lw	a0,-88(s0)
    372e:	00005097          	auipc	ra,0x5
    3732:	520080e7          	jalr	1312(ra) # 8c4e <close>
    close(fds[1]);
    3736:	fac42503          	lw	a0,-84(s0)
    373a:	00005097          	auipc	ra,0x5
    373e:	514080e7          	jalr	1300(ra) # 8c4e <close>
  for(int ai = 0; ai < 2; ai++){
    3742:	0921                	addi	s2,s2,8
    3744:	fc040793          	addi	a5,s0,-64
    3748:	f6f91ce3          	bne	s2,a5,36c0 <copyout+0x34>
}
    374c:	60e6                	ld	ra,88(sp)
    374e:	6446                	ld	s0,80(sp)
    3750:	64a6                	ld	s1,72(sp)
    3752:	6906                	ld	s2,64(sp)
    3754:	79e2                	ld	s3,56(sp)
    3756:	7a42                	ld	s4,48(sp)
    3758:	7aa2                	ld	s5,40(sp)
    375a:	6125                	addi	sp,sp,96
    375c:	8082                	ret
      printf("open(README) failed\n");
    375e:	00006517          	auipc	a0,0x6
    3762:	c4a50513          	addi	a0,a0,-950 # 93a8 <malloc+0x324>
    3766:	00006097          	auipc	ra,0x6
    376a:	860080e7          	jalr	-1952(ra) # 8fc6 <printf>
      exit(1);
    376e:	4505                	li	a0,1
    3770:	00005097          	auipc	ra,0x5
    3774:	4ae080e7          	jalr	1198(ra) # 8c1e <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
    3778:	862a                	mv	a2,a0
    377a:	85ce                	mv	a1,s3
    377c:	00006517          	auipc	a0,0x6
    3780:	c4450513          	addi	a0,a0,-956 # 93c0 <malloc+0x33c>
    3784:	00006097          	auipc	ra,0x6
    3788:	842080e7          	jalr	-1982(ra) # 8fc6 <printf>
      exit(1);
    378c:	4505                	li	a0,1
    378e:	00005097          	auipc	ra,0x5
    3792:	490080e7          	jalr	1168(ra) # 8c1e <exit>
      printf("pipe() failed\n");
    3796:	00006517          	auipc	a0,0x6
    379a:	bca50513          	addi	a0,a0,-1078 # 9360 <malloc+0x2dc>
    379e:	00006097          	auipc	ra,0x6
    37a2:	828080e7          	jalr	-2008(ra) # 8fc6 <printf>
      exit(1);
    37a6:	4505                	li	a0,1
    37a8:	00005097          	auipc	ra,0x5
    37ac:	476080e7          	jalr	1142(ra) # 8c1e <exit>
      printf("pipe write failed\n");
    37b0:	00006517          	auipc	a0,0x6
    37b4:	c4050513          	addi	a0,a0,-960 # 93f0 <malloc+0x36c>
    37b8:	00006097          	auipc	ra,0x6
    37bc:	80e080e7          	jalr	-2034(ra) # 8fc6 <printf>
      exit(1);
    37c0:	4505                	li	a0,1
    37c2:	00005097          	auipc	ra,0x5
    37c6:	45c080e7          	jalr	1116(ra) # 8c1e <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
    37ca:	862a                	mv	a2,a0
    37cc:	85ce                	mv	a1,s3
    37ce:	00006517          	auipc	a0,0x6
    37d2:	c3a50513          	addi	a0,a0,-966 # 9408 <malloc+0x384>
    37d6:	00005097          	auipc	ra,0x5
    37da:	7f0080e7          	jalr	2032(ra) # 8fc6 <printf>
      exit(1);
    37de:	4505                	li	a0,1
    37e0:	00005097          	auipc	ra,0x5
    37e4:	43e080e7          	jalr	1086(ra) # 8c1e <exit>

00000000000037e8 <truncate1>:
{
    37e8:	711d                	addi	sp,sp,-96
    37ea:	ec86                	sd	ra,88(sp)
    37ec:	e8a2                	sd	s0,80(sp)
    37ee:	e4a6                	sd	s1,72(sp)
    37f0:	e0ca                	sd	s2,64(sp)
    37f2:	fc4e                	sd	s3,56(sp)
    37f4:	f852                	sd	s4,48(sp)
    37f6:	f456                	sd	s5,40(sp)
    37f8:	1080                	addi	s0,sp,96
    37fa:	8aaa                	mv	s5,a0
  unlink("truncfile");
    37fc:	00006517          	auipc	a0,0x6
    3800:	a2450513          	addi	a0,a0,-1500 # 9220 <malloc+0x19c>
    3804:	00005097          	auipc	ra,0x5
    3808:	472080e7          	jalr	1138(ra) # 8c76 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    380c:	60100593          	li	a1,1537
    3810:	00006517          	auipc	a0,0x6
    3814:	a1050513          	addi	a0,a0,-1520 # 9220 <malloc+0x19c>
    3818:	00005097          	auipc	ra,0x5
    381c:	44e080e7          	jalr	1102(ra) # 8c66 <open>
    3820:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
    3822:	4611                	li	a2,4
    3824:	00006597          	auipc	a1,0x6
    3828:	a0c58593          	addi	a1,a1,-1524 # 9230 <malloc+0x1ac>
    382c:	00005097          	auipc	ra,0x5
    3830:	41a080e7          	jalr	1050(ra) # 8c46 <write>
  close(fd1);
    3834:	8526                	mv	a0,s1
    3836:	00005097          	auipc	ra,0x5
    383a:	418080e7          	jalr	1048(ra) # 8c4e <close>
  int fd2 = open("truncfile", O_RDONLY);
    383e:	4581                	li	a1,0
    3840:	00006517          	auipc	a0,0x6
    3844:	9e050513          	addi	a0,a0,-1568 # 9220 <malloc+0x19c>
    3848:	00005097          	auipc	ra,0x5
    384c:	41e080e7          	jalr	1054(ra) # 8c66 <open>
    3850:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
    3852:	02000613          	li	a2,32
    3856:	fa040593          	addi	a1,s0,-96
    385a:	00005097          	auipc	ra,0x5
    385e:	3e4080e7          	jalr	996(ra) # 8c3e <read>
  if(n != 4){
    3862:	4791                	li	a5,4
    3864:	0cf51e63          	bne	a0,a5,3940 <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
    3868:	40100593          	li	a1,1025
    386c:	00006517          	auipc	a0,0x6
    3870:	9b450513          	addi	a0,a0,-1612 # 9220 <malloc+0x19c>
    3874:	00005097          	auipc	ra,0x5
    3878:	3f2080e7          	jalr	1010(ra) # 8c66 <open>
    387c:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
    387e:	4581                	li	a1,0
    3880:	00006517          	auipc	a0,0x6
    3884:	9a050513          	addi	a0,a0,-1632 # 9220 <malloc+0x19c>
    3888:	00005097          	auipc	ra,0x5
    388c:	3de080e7          	jalr	990(ra) # 8c66 <open>
    3890:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
    3892:	02000613          	li	a2,32
    3896:	fa040593          	addi	a1,s0,-96
    389a:	00005097          	auipc	ra,0x5
    389e:	3a4080e7          	jalr	932(ra) # 8c3e <read>
    38a2:	8a2a                	mv	s4,a0
  if(n != 0){
    38a4:	ed4d                	bnez	a0,395e <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
    38a6:	02000613          	li	a2,32
    38aa:	fa040593          	addi	a1,s0,-96
    38ae:	8526                	mv	a0,s1
    38b0:	00005097          	auipc	ra,0x5
    38b4:	38e080e7          	jalr	910(ra) # 8c3e <read>
    38b8:	8a2a                	mv	s4,a0
  if(n != 0){
    38ba:	e971                	bnez	a0,398e <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
    38bc:	4619                	li	a2,6
    38be:	00006597          	auipc	a1,0x6
    38c2:	bda58593          	addi	a1,a1,-1062 # 9498 <malloc+0x414>
    38c6:	854e                	mv	a0,s3
    38c8:	00005097          	auipc	ra,0x5
    38cc:	37e080e7          	jalr	894(ra) # 8c46 <write>
  n = read(fd3, buf, sizeof(buf));
    38d0:	02000613          	li	a2,32
    38d4:	fa040593          	addi	a1,s0,-96
    38d8:	854a                	mv	a0,s2
    38da:	00005097          	auipc	ra,0x5
    38de:	364080e7          	jalr	868(ra) # 8c3e <read>
  if(n != 6){
    38e2:	4799                	li	a5,6
    38e4:	0cf51d63          	bne	a0,a5,39be <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
    38e8:	02000613          	li	a2,32
    38ec:	fa040593          	addi	a1,s0,-96
    38f0:	8526                	mv	a0,s1
    38f2:	00005097          	auipc	ra,0x5
    38f6:	34c080e7          	jalr	844(ra) # 8c3e <read>
  if(n != 2){
    38fa:	4789                	li	a5,2
    38fc:	0ef51063          	bne	a0,a5,39dc <truncate1+0x1f4>
  unlink("truncfile");
    3900:	00006517          	auipc	a0,0x6
    3904:	92050513          	addi	a0,a0,-1760 # 9220 <malloc+0x19c>
    3908:	00005097          	auipc	ra,0x5
    390c:	36e080e7          	jalr	878(ra) # 8c76 <unlink>
  close(fd1);
    3910:	854e                	mv	a0,s3
    3912:	00005097          	auipc	ra,0x5
    3916:	33c080e7          	jalr	828(ra) # 8c4e <close>
  close(fd2);
    391a:	8526                	mv	a0,s1
    391c:	00005097          	auipc	ra,0x5
    3920:	332080e7          	jalr	818(ra) # 8c4e <close>
  close(fd3);
    3924:	854a                	mv	a0,s2
    3926:	00005097          	auipc	ra,0x5
    392a:	328080e7          	jalr	808(ra) # 8c4e <close>
}
    392e:	60e6                	ld	ra,88(sp)
    3930:	6446                	ld	s0,80(sp)
    3932:	64a6                	ld	s1,72(sp)
    3934:	6906                	ld	s2,64(sp)
    3936:	79e2                	ld	s3,56(sp)
    3938:	7a42                	ld	s4,48(sp)
    393a:	7aa2                	ld	s5,40(sp)
    393c:	6125                	addi	sp,sp,96
    393e:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
    3940:	862a                	mv	a2,a0
    3942:	85d6                	mv	a1,s5
    3944:	00006517          	auipc	a0,0x6
    3948:	af450513          	addi	a0,a0,-1292 # 9438 <malloc+0x3b4>
    394c:	00005097          	auipc	ra,0x5
    3950:	67a080e7          	jalr	1658(ra) # 8fc6 <printf>
    exit(1);
    3954:	4505                	li	a0,1
    3956:	00005097          	auipc	ra,0x5
    395a:	2c8080e7          	jalr	712(ra) # 8c1e <exit>
    printf("aaa fd3=%d\n", fd3);
    395e:	85ca                	mv	a1,s2
    3960:	00006517          	auipc	a0,0x6
    3964:	af850513          	addi	a0,a0,-1288 # 9458 <malloc+0x3d4>
    3968:	00005097          	auipc	ra,0x5
    396c:	65e080e7          	jalr	1630(ra) # 8fc6 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
    3970:	8652                	mv	a2,s4
    3972:	85d6                	mv	a1,s5
    3974:	00006517          	auipc	a0,0x6
    3978:	af450513          	addi	a0,a0,-1292 # 9468 <malloc+0x3e4>
    397c:	00005097          	auipc	ra,0x5
    3980:	64a080e7          	jalr	1610(ra) # 8fc6 <printf>
    exit(1);
    3984:	4505                	li	a0,1
    3986:	00005097          	auipc	ra,0x5
    398a:	298080e7          	jalr	664(ra) # 8c1e <exit>
    printf("bbb fd2=%d\n", fd2);
    398e:	85a6                	mv	a1,s1
    3990:	00006517          	auipc	a0,0x6
    3994:	af850513          	addi	a0,a0,-1288 # 9488 <malloc+0x404>
    3998:	00005097          	auipc	ra,0x5
    399c:	62e080e7          	jalr	1582(ra) # 8fc6 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
    39a0:	8652                	mv	a2,s4
    39a2:	85d6                	mv	a1,s5
    39a4:	00006517          	auipc	a0,0x6
    39a8:	ac450513          	addi	a0,a0,-1340 # 9468 <malloc+0x3e4>
    39ac:	00005097          	auipc	ra,0x5
    39b0:	61a080e7          	jalr	1562(ra) # 8fc6 <printf>
    exit(1);
    39b4:	4505                	li	a0,1
    39b6:	00005097          	auipc	ra,0x5
    39ba:	268080e7          	jalr	616(ra) # 8c1e <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
    39be:	862a                	mv	a2,a0
    39c0:	85d6                	mv	a1,s5
    39c2:	00006517          	auipc	a0,0x6
    39c6:	ade50513          	addi	a0,a0,-1314 # 94a0 <malloc+0x41c>
    39ca:	00005097          	auipc	ra,0x5
    39ce:	5fc080e7          	jalr	1532(ra) # 8fc6 <printf>
    exit(1);
    39d2:	4505                	li	a0,1
    39d4:	00005097          	auipc	ra,0x5
    39d8:	24a080e7          	jalr	586(ra) # 8c1e <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
    39dc:	862a                	mv	a2,a0
    39de:	85d6                	mv	a1,s5
    39e0:	00006517          	auipc	a0,0x6
    39e4:	ae050513          	addi	a0,a0,-1312 # 94c0 <malloc+0x43c>
    39e8:	00005097          	auipc	ra,0x5
    39ec:	5de080e7          	jalr	1502(ra) # 8fc6 <printf>
    exit(1);
    39f0:	4505                	li	a0,1
    39f2:	00005097          	auipc	ra,0x5
    39f6:	22c080e7          	jalr	556(ra) # 8c1e <exit>

00000000000039fa <writetest>:
{
    39fa:	7139                	addi	sp,sp,-64
    39fc:	fc06                	sd	ra,56(sp)
    39fe:	f822                	sd	s0,48(sp)
    3a00:	f426                	sd	s1,40(sp)
    3a02:	f04a                	sd	s2,32(sp)
    3a04:	ec4e                	sd	s3,24(sp)
    3a06:	e852                	sd	s4,16(sp)
    3a08:	e456                	sd	s5,8(sp)
    3a0a:	e05a                	sd	s6,0(sp)
    3a0c:	0080                	addi	s0,sp,64
    3a0e:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
    3a10:	20200593          	li	a1,514
    3a14:	00006517          	auipc	a0,0x6
    3a18:	acc50513          	addi	a0,a0,-1332 # 94e0 <malloc+0x45c>
    3a1c:	00005097          	auipc	ra,0x5
    3a20:	24a080e7          	jalr	586(ra) # 8c66 <open>
  if(fd < 0){
    3a24:	0a054d63          	bltz	a0,3ade <writetest+0xe4>
    3a28:	892a                	mv	s2,a0
    3a2a:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
    3a2c:	00006997          	auipc	s3,0x6
    3a30:	adc98993          	addi	s3,s3,-1316 # 9508 <malloc+0x484>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
    3a34:	00006a97          	auipc	s5,0x6
    3a38:	b0ca8a93          	addi	s5,s5,-1268 # 9540 <malloc+0x4bc>
  for(i = 0; i < N; i++){
    3a3c:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
    3a40:	4629                	li	a2,10
    3a42:	85ce                	mv	a1,s3
    3a44:	854a                	mv	a0,s2
    3a46:	00005097          	auipc	ra,0x5
    3a4a:	200080e7          	jalr	512(ra) # 8c46 <write>
    3a4e:	47a9                	li	a5,10
    3a50:	0af51563          	bne	a0,a5,3afa <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
    3a54:	4629                	li	a2,10
    3a56:	85d6                	mv	a1,s5
    3a58:	854a                	mv	a0,s2
    3a5a:	00005097          	auipc	ra,0x5
    3a5e:	1ec080e7          	jalr	492(ra) # 8c46 <write>
    3a62:	47a9                	li	a5,10
    3a64:	0af51a63          	bne	a0,a5,3b18 <writetest+0x11e>
  for(i = 0; i < N; i++){
    3a68:	2485                	addiw	s1,s1,1
    3a6a:	fd449be3          	bne	s1,s4,3a40 <writetest+0x46>
  close(fd);
    3a6e:	854a                	mv	a0,s2
    3a70:	00005097          	auipc	ra,0x5
    3a74:	1de080e7          	jalr	478(ra) # 8c4e <close>
  fd = open("small", O_RDONLY);
    3a78:	4581                	li	a1,0
    3a7a:	00006517          	auipc	a0,0x6
    3a7e:	a6650513          	addi	a0,a0,-1434 # 94e0 <malloc+0x45c>
    3a82:	00005097          	auipc	ra,0x5
    3a86:	1e4080e7          	jalr	484(ra) # 8c66 <open>
    3a8a:	84aa                	mv	s1,a0
  if(fd < 0){
    3a8c:	0a054563          	bltz	a0,3b36 <writetest+0x13c>
  i = read(fd, buf, N*SZ*2);
    3a90:	7d000613          	li	a2,2000
    3a94:	0000c597          	auipc	a1,0xc
    3a98:	1e458593          	addi	a1,a1,484 # fc78 <buf>
    3a9c:	00005097          	auipc	ra,0x5
    3aa0:	1a2080e7          	jalr	418(ra) # 8c3e <read>
  if(i != N*SZ*2){
    3aa4:	7d000793          	li	a5,2000
    3aa8:	0af51563          	bne	a0,a5,3b52 <writetest+0x158>
  close(fd);
    3aac:	8526                	mv	a0,s1
    3aae:	00005097          	auipc	ra,0x5
    3ab2:	1a0080e7          	jalr	416(ra) # 8c4e <close>
  if(unlink("small") < 0){
    3ab6:	00006517          	auipc	a0,0x6
    3aba:	a2a50513          	addi	a0,a0,-1494 # 94e0 <malloc+0x45c>
    3abe:	00005097          	auipc	ra,0x5
    3ac2:	1b8080e7          	jalr	440(ra) # 8c76 <unlink>
    3ac6:	0a054463          	bltz	a0,3b6e <writetest+0x174>
}
    3aca:	70e2                	ld	ra,56(sp)
    3acc:	7442                	ld	s0,48(sp)
    3ace:	74a2                	ld	s1,40(sp)
    3ad0:	7902                	ld	s2,32(sp)
    3ad2:	69e2                	ld	s3,24(sp)
    3ad4:	6a42                	ld	s4,16(sp)
    3ad6:	6aa2                	ld	s5,8(sp)
    3ad8:	6b02                	ld	s6,0(sp)
    3ada:	6121                	addi	sp,sp,64
    3adc:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
    3ade:	85da                	mv	a1,s6
    3ae0:	00006517          	auipc	a0,0x6
    3ae4:	a0850513          	addi	a0,a0,-1528 # 94e8 <malloc+0x464>
    3ae8:	00005097          	auipc	ra,0x5
    3aec:	4de080e7          	jalr	1246(ra) # 8fc6 <printf>
    exit(1);
    3af0:	4505                	li	a0,1
    3af2:	00005097          	auipc	ra,0x5
    3af6:	12c080e7          	jalr	300(ra) # 8c1e <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
    3afa:	8626                	mv	a2,s1
    3afc:	85da                	mv	a1,s6
    3afe:	00006517          	auipc	a0,0x6
    3b02:	a1a50513          	addi	a0,a0,-1510 # 9518 <malloc+0x494>
    3b06:	00005097          	auipc	ra,0x5
    3b0a:	4c0080e7          	jalr	1216(ra) # 8fc6 <printf>
      exit(1);
    3b0e:	4505                	li	a0,1
    3b10:	00005097          	auipc	ra,0x5
    3b14:	10e080e7          	jalr	270(ra) # 8c1e <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
    3b18:	8626                	mv	a2,s1
    3b1a:	85da                	mv	a1,s6
    3b1c:	00006517          	auipc	a0,0x6
    3b20:	a3450513          	addi	a0,a0,-1484 # 9550 <malloc+0x4cc>
    3b24:	00005097          	auipc	ra,0x5
    3b28:	4a2080e7          	jalr	1186(ra) # 8fc6 <printf>
      exit(1);
    3b2c:	4505                	li	a0,1
    3b2e:	00005097          	auipc	ra,0x5
    3b32:	0f0080e7          	jalr	240(ra) # 8c1e <exit>
    printf("%s: error: open small failed!\n", s);
    3b36:	85da                	mv	a1,s6
    3b38:	00006517          	auipc	a0,0x6
    3b3c:	a4050513          	addi	a0,a0,-1472 # 9578 <malloc+0x4f4>
    3b40:	00005097          	auipc	ra,0x5
    3b44:	486080e7          	jalr	1158(ra) # 8fc6 <printf>
    exit(1);
    3b48:	4505                	li	a0,1
    3b4a:	00005097          	auipc	ra,0x5
    3b4e:	0d4080e7          	jalr	212(ra) # 8c1e <exit>
    printf("%s: read failed\n", s);
    3b52:	85da                	mv	a1,s6
    3b54:	00006517          	auipc	a0,0x6
    3b58:	a4450513          	addi	a0,a0,-1468 # 9598 <malloc+0x514>
    3b5c:	00005097          	auipc	ra,0x5
    3b60:	46a080e7          	jalr	1130(ra) # 8fc6 <printf>
    exit(1);
    3b64:	4505                	li	a0,1
    3b66:	00005097          	auipc	ra,0x5
    3b6a:	0b8080e7          	jalr	184(ra) # 8c1e <exit>
    printf("%s: unlink small failed\n", s);
    3b6e:	85da                	mv	a1,s6
    3b70:	00006517          	auipc	a0,0x6
    3b74:	a4050513          	addi	a0,a0,-1472 # 95b0 <malloc+0x52c>
    3b78:	00005097          	auipc	ra,0x5
    3b7c:	44e080e7          	jalr	1102(ra) # 8fc6 <printf>
    exit(1);
    3b80:	4505                	li	a0,1
    3b82:	00005097          	auipc	ra,0x5
    3b86:	09c080e7          	jalr	156(ra) # 8c1e <exit>

0000000000003b8a <writebig>:
{
    3b8a:	7139                	addi	sp,sp,-64
    3b8c:	fc06                	sd	ra,56(sp)
    3b8e:	f822                	sd	s0,48(sp)
    3b90:	f426                	sd	s1,40(sp)
    3b92:	f04a                	sd	s2,32(sp)
    3b94:	ec4e                	sd	s3,24(sp)
    3b96:	e852                	sd	s4,16(sp)
    3b98:	e456                	sd	s5,8(sp)
    3b9a:	0080                	addi	s0,sp,64
    3b9c:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
    3b9e:	20200593          	li	a1,514
    3ba2:	00006517          	auipc	a0,0x6
    3ba6:	a2e50513          	addi	a0,a0,-1490 # 95d0 <malloc+0x54c>
    3baa:	00005097          	auipc	ra,0x5
    3bae:	0bc080e7          	jalr	188(ra) # 8c66 <open>
    3bb2:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
    3bb4:	4481                	li	s1,0
    ((int*)buf)[0] = i;
    3bb6:	0000c917          	auipc	s2,0xc
    3bba:	0c290913          	addi	s2,s2,194 # fc78 <buf>
  for(i = 0; i < MAXFILE; i++){
    3bbe:	10c00a13          	li	s4,268
  if(fd < 0){
    3bc2:	06054c63          	bltz	a0,3c3a <writebig+0xb0>
    ((int*)buf)[0] = i;
    3bc6:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
    3bca:	40000613          	li	a2,1024
    3bce:	85ca                	mv	a1,s2
    3bd0:	854e                	mv	a0,s3
    3bd2:	00005097          	auipc	ra,0x5
    3bd6:	074080e7          	jalr	116(ra) # 8c46 <write>
    3bda:	40000793          	li	a5,1024
    3bde:	06f51c63          	bne	a0,a5,3c56 <writebig+0xcc>
  for(i = 0; i < MAXFILE; i++){
    3be2:	2485                	addiw	s1,s1,1
    3be4:	ff4491e3          	bne	s1,s4,3bc6 <writebig+0x3c>
  close(fd);
    3be8:	854e                	mv	a0,s3
    3bea:	00005097          	auipc	ra,0x5
    3bee:	064080e7          	jalr	100(ra) # 8c4e <close>
  fd = open("big", O_RDONLY);
    3bf2:	4581                	li	a1,0
    3bf4:	00006517          	auipc	a0,0x6
    3bf8:	9dc50513          	addi	a0,a0,-1572 # 95d0 <malloc+0x54c>
    3bfc:	00005097          	auipc	ra,0x5
    3c00:	06a080e7          	jalr	106(ra) # 8c66 <open>
    3c04:	89aa                	mv	s3,a0
  n = 0;
    3c06:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
    3c08:	0000c917          	auipc	s2,0xc
    3c0c:	07090913          	addi	s2,s2,112 # fc78 <buf>
  if(fd < 0){
    3c10:	06054263          	bltz	a0,3c74 <writebig+0xea>
    i = read(fd, buf, BSIZE);
    3c14:	40000613          	li	a2,1024
    3c18:	85ca                	mv	a1,s2
    3c1a:	854e                	mv	a0,s3
    3c1c:	00005097          	auipc	ra,0x5
    3c20:	022080e7          	jalr	34(ra) # 8c3e <read>
    if(i == 0){
    3c24:	c535                	beqz	a0,3c90 <writebig+0x106>
    } else if(i != BSIZE){
    3c26:	40000793          	li	a5,1024
    3c2a:	0af51f63          	bne	a0,a5,3ce8 <writebig+0x15e>
    if(((int*)buf)[0] != n){
    3c2e:	00092683          	lw	a3,0(s2)
    3c32:	0c969a63          	bne	a3,s1,3d06 <writebig+0x17c>
    n++;
    3c36:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
    3c38:	bff1                	j	3c14 <writebig+0x8a>
    printf("%s: error: creat big failed!\n", s);
    3c3a:	85d6                	mv	a1,s5
    3c3c:	00006517          	auipc	a0,0x6
    3c40:	99c50513          	addi	a0,a0,-1636 # 95d8 <malloc+0x554>
    3c44:	00005097          	auipc	ra,0x5
    3c48:	382080e7          	jalr	898(ra) # 8fc6 <printf>
    exit(1);
    3c4c:	4505                	li	a0,1
    3c4e:	00005097          	auipc	ra,0x5
    3c52:	fd0080e7          	jalr	-48(ra) # 8c1e <exit>
      printf("%s: error: write big file failed\n", s, i);
    3c56:	8626                	mv	a2,s1
    3c58:	85d6                	mv	a1,s5
    3c5a:	00006517          	auipc	a0,0x6
    3c5e:	99e50513          	addi	a0,a0,-1634 # 95f8 <malloc+0x574>
    3c62:	00005097          	auipc	ra,0x5
    3c66:	364080e7          	jalr	868(ra) # 8fc6 <printf>
      exit(1);
    3c6a:	4505                	li	a0,1
    3c6c:	00005097          	auipc	ra,0x5
    3c70:	fb2080e7          	jalr	-78(ra) # 8c1e <exit>
    printf("%s: error: open big failed!\n", s);
    3c74:	85d6                	mv	a1,s5
    3c76:	00006517          	auipc	a0,0x6
    3c7a:	9aa50513          	addi	a0,a0,-1622 # 9620 <malloc+0x59c>
    3c7e:	00005097          	auipc	ra,0x5
    3c82:	348080e7          	jalr	840(ra) # 8fc6 <printf>
    exit(1);
    3c86:	4505                	li	a0,1
    3c88:	00005097          	auipc	ra,0x5
    3c8c:	f96080e7          	jalr	-106(ra) # 8c1e <exit>
      if(n == MAXFILE - 1){
    3c90:	10b00793          	li	a5,267
    3c94:	02f48a63          	beq	s1,a5,3cc8 <writebig+0x13e>
  close(fd);
    3c98:	854e                	mv	a0,s3
    3c9a:	00005097          	auipc	ra,0x5
    3c9e:	fb4080e7          	jalr	-76(ra) # 8c4e <close>
  if(unlink("big") < 0){
    3ca2:	00006517          	auipc	a0,0x6
    3ca6:	92e50513          	addi	a0,a0,-1746 # 95d0 <malloc+0x54c>
    3caa:	00005097          	auipc	ra,0x5
    3cae:	fcc080e7          	jalr	-52(ra) # 8c76 <unlink>
    3cb2:	06054963          	bltz	a0,3d24 <writebig+0x19a>
}
    3cb6:	70e2                	ld	ra,56(sp)
    3cb8:	7442                	ld	s0,48(sp)
    3cba:	74a2                	ld	s1,40(sp)
    3cbc:	7902                	ld	s2,32(sp)
    3cbe:	69e2                	ld	s3,24(sp)
    3cc0:	6a42                	ld	s4,16(sp)
    3cc2:	6aa2                	ld	s5,8(sp)
    3cc4:	6121                	addi	sp,sp,64
    3cc6:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
    3cc8:	10b00613          	li	a2,267
    3ccc:	85d6                	mv	a1,s5
    3cce:	00006517          	auipc	a0,0x6
    3cd2:	97250513          	addi	a0,a0,-1678 # 9640 <malloc+0x5bc>
    3cd6:	00005097          	auipc	ra,0x5
    3cda:	2f0080e7          	jalr	752(ra) # 8fc6 <printf>
        exit(1);
    3cde:	4505                	li	a0,1
    3ce0:	00005097          	auipc	ra,0x5
    3ce4:	f3e080e7          	jalr	-194(ra) # 8c1e <exit>
      printf("%s: read failed %d\n", s, i);
    3ce8:	862a                	mv	a2,a0
    3cea:	85d6                	mv	a1,s5
    3cec:	00006517          	auipc	a0,0x6
    3cf0:	97c50513          	addi	a0,a0,-1668 # 9668 <malloc+0x5e4>
    3cf4:	00005097          	auipc	ra,0x5
    3cf8:	2d2080e7          	jalr	722(ra) # 8fc6 <printf>
      exit(1);
    3cfc:	4505                	li	a0,1
    3cfe:	00005097          	auipc	ra,0x5
    3d02:	f20080e7          	jalr	-224(ra) # 8c1e <exit>
      printf("%s: read content of block %d is %d\n", s,
    3d06:	8626                	mv	a2,s1
    3d08:	85d6                	mv	a1,s5
    3d0a:	00006517          	auipc	a0,0x6
    3d0e:	97650513          	addi	a0,a0,-1674 # 9680 <malloc+0x5fc>
    3d12:	00005097          	auipc	ra,0x5
    3d16:	2b4080e7          	jalr	692(ra) # 8fc6 <printf>
      exit(1);
    3d1a:	4505                	li	a0,1
    3d1c:	00005097          	auipc	ra,0x5
    3d20:	f02080e7          	jalr	-254(ra) # 8c1e <exit>
    printf("%s: unlink big failed\n", s);
    3d24:	85d6                	mv	a1,s5
    3d26:	00006517          	auipc	a0,0x6
    3d2a:	98250513          	addi	a0,a0,-1662 # 96a8 <malloc+0x624>
    3d2e:	00005097          	auipc	ra,0x5
    3d32:	298080e7          	jalr	664(ra) # 8fc6 <printf>
    exit(1);
    3d36:	4505                	li	a0,1
    3d38:	00005097          	auipc	ra,0x5
    3d3c:	ee6080e7          	jalr	-282(ra) # 8c1e <exit>

0000000000003d40 <unlinkread>:
{
    3d40:	7179                	addi	sp,sp,-48
    3d42:	f406                	sd	ra,40(sp)
    3d44:	f022                	sd	s0,32(sp)
    3d46:	ec26                	sd	s1,24(sp)
    3d48:	e84a                	sd	s2,16(sp)
    3d4a:	e44e                	sd	s3,8(sp)
    3d4c:	1800                	addi	s0,sp,48
    3d4e:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
    3d50:	20200593          	li	a1,514
    3d54:	00006517          	auipc	a0,0x6
    3d58:	96c50513          	addi	a0,a0,-1684 # 96c0 <malloc+0x63c>
    3d5c:	00005097          	auipc	ra,0x5
    3d60:	f0a080e7          	jalr	-246(ra) # 8c66 <open>
  if(fd < 0){
    3d64:	0e054563          	bltz	a0,3e4e <unlinkread+0x10e>
    3d68:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
    3d6a:	4615                	li	a2,5
    3d6c:	00006597          	auipc	a1,0x6
    3d70:	98458593          	addi	a1,a1,-1660 # 96f0 <malloc+0x66c>
    3d74:	00005097          	auipc	ra,0x5
    3d78:	ed2080e7          	jalr	-302(ra) # 8c46 <write>
  close(fd);
    3d7c:	8526                	mv	a0,s1
    3d7e:	00005097          	auipc	ra,0x5
    3d82:	ed0080e7          	jalr	-304(ra) # 8c4e <close>
  fd = open("unlinkread", O_RDWR);
    3d86:	4589                	li	a1,2
    3d88:	00006517          	auipc	a0,0x6
    3d8c:	93850513          	addi	a0,a0,-1736 # 96c0 <malloc+0x63c>
    3d90:	00005097          	auipc	ra,0x5
    3d94:	ed6080e7          	jalr	-298(ra) # 8c66 <open>
    3d98:	84aa                	mv	s1,a0
  if(fd < 0){
    3d9a:	0c054863          	bltz	a0,3e6a <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
    3d9e:	00006517          	auipc	a0,0x6
    3da2:	92250513          	addi	a0,a0,-1758 # 96c0 <malloc+0x63c>
    3da6:	00005097          	auipc	ra,0x5
    3daa:	ed0080e7          	jalr	-304(ra) # 8c76 <unlink>
    3dae:	ed61                	bnez	a0,3e86 <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    3db0:	20200593          	li	a1,514
    3db4:	00006517          	auipc	a0,0x6
    3db8:	90c50513          	addi	a0,a0,-1780 # 96c0 <malloc+0x63c>
    3dbc:	00005097          	auipc	ra,0x5
    3dc0:	eaa080e7          	jalr	-342(ra) # 8c66 <open>
    3dc4:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
    3dc6:	460d                	li	a2,3
    3dc8:	00006597          	auipc	a1,0x6
    3dcc:	97058593          	addi	a1,a1,-1680 # 9738 <malloc+0x6b4>
    3dd0:	00005097          	auipc	ra,0x5
    3dd4:	e76080e7          	jalr	-394(ra) # 8c46 <write>
  close(fd1);
    3dd8:	854a                	mv	a0,s2
    3dda:	00005097          	auipc	ra,0x5
    3dde:	e74080e7          	jalr	-396(ra) # 8c4e <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
    3de2:	660d                	lui	a2,0x3
    3de4:	0000c597          	auipc	a1,0xc
    3de8:	e9458593          	addi	a1,a1,-364 # fc78 <buf>
    3dec:	8526                	mv	a0,s1
    3dee:	00005097          	auipc	ra,0x5
    3df2:	e50080e7          	jalr	-432(ra) # 8c3e <read>
    3df6:	4795                	li	a5,5
    3df8:	0af51563          	bne	a0,a5,3ea2 <unlinkread+0x162>
  if(buf[0] != 'h'){
    3dfc:	0000c717          	auipc	a4,0xc
    3e00:	e7c74703          	lbu	a4,-388(a4) # fc78 <buf>
    3e04:	06800793          	li	a5,104
    3e08:	0af71b63          	bne	a4,a5,3ebe <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
    3e0c:	4629                	li	a2,10
    3e0e:	0000c597          	auipc	a1,0xc
    3e12:	e6a58593          	addi	a1,a1,-406 # fc78 <buf>
    3e16:	8526                	mv	a0,s1
    3e18:	00005097          	auipc	ra,0x5
    3e1c:	e2e080e7          	jalr	-466(ra) # 8c46 <write>
    3e20:	47a9                	li	a5,10
    3e22:	0af51c63          	bne	a0,a5,3eda <unlinkread+0x19a>
  close(fd);
    3e26:	8526                	mv	a0,s1
    3e28:	00005097          	auipc	ra,0x5
    3e2c:	e26080e7          	jalr	-474(ra) # 8c4e <close>
  unlink("unlinkread");
    3e30:	00006517          	auipc	a0,0x6
    3e34:	89050513          	addi	a0,a0,-1904 # 96c0 <malloc+0x63c>
    3e38:	00005097          	auipc	ra,0x5
    3e3c:	e3e080e7          	jalr	-450(ra) # 8c76 <unlink>
}
    3e40:	70a2                	ld	ra,40(sp)
    3e42:	7402                	ld	s0,32(sp)
    3e44:	64e2                	ld	s1,24(sp)
    3e46:	6942                	ld	s2,16(sp)
    3e48:	69a2                	ld	s3,8(sp)
    3e4a:	6145                	addi	sp,sp,48
    3e4c:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
    3e4e:	85ce                	mv	a1,s3
    3e50:	00006517          	auipc	a0,0x6
    3e54:	88050513          	addi	a0,a0,-1920 # 96d0 <malloc+0x64c>
    3e58:	00005097          	auipc	ra,0x5
    3e5c:	16e080e7          	jalr	366(ra) # 8fc6 <printf>
    exit(1);
    3e60:	4505                	li	a0,1
    3e62:	00005097          	auipc	ra,0x5
    3e66:	dbc080e7          	jalr	-580(ra) # 8c1e <exit>
    printf("%s: open unlinkread failed\n", s);
    3e6a:	85ce                	mv	a1,s3
    3e6c:	00006517          	auipc	a0,0x6
    3e70:	88c50513          	addi	a0,a0,-1908 # 96f8 <malloc+0x674>
    3e74:	00005097          	auipc	ra,0x5
    3e78:	152080e7          	jalr	338(ra) # 8fc6 <printf>
    exit(1);
    3e7c:	4505                	li	a0,1
    3e7e:	00005097          	auipc	ra,0x5
    3e82:	da0080e7          	jalr	-608(ra) # 8c1e <exit>
    printf("%s: unlink unlinkread failed\n", s);
    3e86:	85ce                	mv	a1,s3
    3e88:	00006517          	auipc	a0,0x6
    3e8c:	89050513          	addi	a0,a0,-1904 # 9718 <malloc+0x694>
    3e90:	00005097          	auipc	ra,0x5
    3e94:	136080e7          	jalr	310(ra) # 8fc6 <printf>
    exit(1);
    3e98:	4505                	li	a0,1
    3e9a:	00005097          	auipc	ra,0x5
    3e9e:	d84080e7          	jalr	-636(ra) # 8c1e <exit>
    printf("%s: unlinkread read failed", s);
    3ea2:	85ce                	mv	a1,s3
    3ea4:	00006517          	auipc	a0,0x6
    3ea8:	89c50513          	addi	a0,a0,-1892 # 9740 <malloc+0x6bc>
    3eac:	00005097          	auipc	ra,0x5
    3eb0:	11a080e7          	jalr	282(ra) # 8fc6 <printf>
    exit(1);
    3eb4:	4505                	li	a0,1
    3eb6:	00005097          	auipc	ra,0x5
    3eba:	d68080e7          	jalr	-664(ra) # 8c1e <exit>
    printf("%s: unlinkread wrong data\n", s);
    3ebe:	85ce                	mv	a1,s3
    3ec0:	00006517          	auipc	a0,0x6
    3ec4:	8a050513          	addi	a0,a0,-1888 # 9760 <malloc+0x6dc>
    3ec8:	00005097          	auipc	ra,0x5
    3ecc:	0fe080e7          	jalr	254(ra) # 8fc6 <printf>
    exit(1);
    3ed0:	4505                	li	a0,1
    3ed2:	00005097          	auipc	ra,0x5
    3ed6:	d4c080e7          	jalr	-692(ra) # 8c1e <exit>
    printf("%s: unlinkread write failed\n", s);
    3eda:	85ce                	mv	a1,s3
    3edc:	00006517          	auipc	a0,0x6
    3ee0:	8a450513          	addi	a0,a0,-1884 # 9780 <malloc+0x6fc>
    3ee4:	00005097          	auipc	ra,0x5
    3ee8:	0e2080e7          	jalr	226(ra) # 8fc6 <printf>
    exit(1);
    3eec:	4505                	li	a0,1
    3eee:	00005097          	auipc	ra,0x5
    3ef2:	d30080e7          	jalr	-720(ra) # 8c1e <exit>

0000000000003ef6 <linktest>:
{
    3ef6:	1101                	addi	sp,sp,-32
    3ef8:	ec06                	sd	ra,24(sp)
    3efa:	e822                	sd	s0,16(sp)
    3efc:	e426                	sd	s1,8(sp)
    3efe:	e04a                	sd	s2,0(sp)
    3f00:	1000                	addi	s0,sp,32
    3f02:	892a                	mv	s2,a0
  unlink("lf1");
    3f04:	00006517          	auipc	a0,0x6
    3f08:	89c50513          	addi	a0,a0,-1892 # 97a0 <malloc+0x71c>
    3f0c:	00005097          	auipc	ra,0x5
    3f10:	d6a080e7          	jalr	-662(ra) # 8c76 <unlink>
  unlink("lf2");
    3f14:	00006517          	auipc	a0,0x6
    3f18:	89450513          	addi	a0,a0,-1900 # 97a8 <malloc+0x724>
    3f1c:	00005097          	auipc	ra,0x5
    3f20:	d5a080e7          	jalr	-678(ra) # 8c76 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    3f24:	20200593          	li	a1,514
    3f28:	00006517          	auipc	a0,0x6
    3f2c:	87850513          	addi	a0,a0,-1928 # 97a0 <malloc+0x71c>
    3f30:	00005097          	auipc	ra,0x5
    3f34:	d36080e7          	jalr	-714(ra) # 8c66 <open>
  if(fd < 0){
    3f38:	10054763          	bltz	a0,4046 <linktest+0x150>
    3f3c:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
    3f3e:	4615                	li	a2,5
    3f40:	00005597          	auipc	a1,0x5
    3f44:	7b058593          	addi	a1,a1,1968 # 96f0 <malloc+0x66c>
    3f48:	00005097          	auipc	ra,0x5
    3f4c:	cfe080e7          	jalr	-770(ra) # 8c46 <write>
    3f50:	4795                	li	a5,5
    3f52:	10f51863          	bne	a0,a5,4062 <linktest+0x16c>
  close(fd);
    3f56:	8526                	mv	a0,s1
    3f58:	00005097          	auipc	ra,0x5
    3f5c:	cf6080e7          	jalr	-778(ra) # 8c4e <close>
  if(link("lf1", "lf2") < 0){
    3f60:	00006597          	auipc	a1,0x6
    3f64:	84858593          	addi	a1,a1,-1976 # 97a8 <malloc+0x724>
    3f68:	00006517          	auipc	a0,0x6
    3f6c:	83850513          	addi	a0,a0,-1992 # 97a0 <malloc+0x71c>
    3f70:	00005097          	auipc	ra,0x5
    3f74:	d16080e7          	jalr	-746(ra) # 8c86 <link>
    3f78:	10054363          	bltz	a0,407e <linktest+0x188>
  unlink("lf1");
    3f7c:	00006517          	auipc	a0,0x6
    3f80:	82450513          	addi	a0,a0,-2012 # 97a0 <malloc+0x71c>
    3f84:	00005097          	auipc	ra,0x5
    3f88:	cf2080e7          	jalr	-782(ra) # 8c76 <unlink>
  if(open("lf1", 0) >= 0){
    3f8c:	4581                	li	a1,0
    3f8e:	00006517          	auipc	a0,0x6
    3f92:	81250513          	addi	a0,a0,-2030 # 97a0 <malloc+0x71c>
    3f96:	00005097          	auipc	ra,0x5
    3f9a:	cd0080e7          	jalr	-816(ra) # 8c66 <open>
    3f9e:	0e055e63          	bgez	a0,409a <linktest+0x1a4>
  fd = open("lf2", 0);
    3fa2:	4581                	li	a1,0
    3fa4:	00006517          	auipc	a0,0x6
    3fa8:	80450513          	addi	a0,a0,-2044 # 97a8 <malloc+0x724>
    3fac:	00005097          	auipc	ra,0x5
    3fb0:	cba080e7          	jalr	-838(ra) # 8c66 <open>
    3fb4:	84aa                	mv	s1,a0
  if(fd < 0){
    3fb6:	10054063          	bltz	a0,40b6 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
    3fba:	660d                	lui	a2,0x3
    3fbc:	0000c597          	auipc	a1,0xc
    3fc0:	cbc58593          	addi	a1,a1,-836 # fc78 <buf>
    3fc4:	00005097          	auipc	ra,0x5
    3fc8:	c7a080e7          	jalr	-902(ra) # 8c3e <read>
    3fcc:	4795                	li	a5,5
    3fce:	10f51263          	bne	a0,a5,40d2 <linktest+0x1dc>
  close(fd);
    3fd2:	8526                	mv	a0,s1
    3fd4:	00005097          	auipc	ra,0x5
    3fd8:	c7a080e7          	jalr	-902(ra) # 8c4e <close>
  if(link("lf2", "lf2") >= 0){
    3fdc:	00005597          	auipc	a1,0x5
    3fe0:	7cc58593          	addi	a1,a1,1996 # 97a8 <malloc+0x724>
    3fe4:	852e                	mv	a0,a1
    3fe6:	00005097          	auipc	ra,0x5
    3fea:	ca0080e7          	jalr	-864(ra) # 8c86 <link>
    3fee:	10055063          	bgez	a0,40ee <linktest+0x1f8>
  unlink("lf2");
    3ff2:	00005517          	auipc	a0,0x5
    3ff6:	7b650513          	addi	a0,a0,1974 # 97a8 <malloc+0x724>
    3ffa:	00005097          	auipc	ra,0x5
    3ffe:	c7c080e7          	jalr	-900(ra) # 8c76 <unlink>
  if(link("lf2", "lf1") >= 0){
    4002:	00005597          	auipc	a1,0x5
    4006:	79e58593          	addi	a1,a1,1950 # 97a0 <malloc+0x71c>
    400a:	00005517          	auipc	a0,0x5
    400e:	79e50513          	addi	a0,a0,1950 # 97a8 <malloc+0x724>
    4012:	00005097          	auipc	ra,0x5
    4016:	c74080e7          	jalr	-908(ra) # 8c86 <link>
    401a:	0e055863          	bgez	a0,410a <linktest+0x214>
  if(link(".", "lf1") >= 0){
    401e:	00005597          	auipc	a1,0x5
    4022:	78258593          	addi	a1,a1,1922 # 97a0 <malloc+0x71c>
    4026:	00006517          	auipc	a0,0x6
    402a:	88a50513          	addi	a0,a0,-1910 # 98b0 <malloc+0x82c>
    402e:	00005097          	auipc	ra,0x5
    4032:	c58080e7          	jalr	-936(ra) # 8c86 <link>
    4036:	0e055863          	bgez	a0,4126 <linktest+0x230>
}
    403a:	60e2                	ld	ra,24(sp)
    403c:	6442                	ld	s0,16(sp)
    403e:	64a2                	ld	s1,8(sp)
    4040:	6902                	ld	s2,0(sp)
    4042:	6105                	addi	sp,sp,32
    4044:	8082                	ret
    printf("%s: create lf1 failed\n", s);
    4046:	85ca                	mv	a1,s2
    4048:	00005517          	auipc	a0,0x5
    404c:	76850513          	addi	a0,a0,1896 # 97b0 <malloc+0x72c>
    4050:	00005097          	auipc	ra,0x5
    4054:	f76080e7          	jalr	-138(ra) # 8fc6 <printf>
    exit(1);
    4058:	4505                	li	a0,1
    405a:	00005097          	auipc	ra,0x5
    405e:	bc4080e7          	jalr	-1084(ra) # 8c1e <exit>
    printf("%s: write lf1 failed\n", s);
    4062:	85ca                	mv	a1,s2
    4064:	00005517          	auipc	a0,0x5
    4068:	76450513          	addi	a0,a0,1892 # 97c8 <malloc+0x744>
    406c:	00005097          	auipc	ra,0x5
    4070:	f5a080e7          	jalr	-166(ra) # 8fc6 <printf>
    exit(1);
    4074:	4505                	li	a0,1
    4076:	00005097          	auipc	ra,0x5
    407a:	ba8080e7          	jalr	-1112(ra) # 8c1e <exit>
    printf("%s: link lf1 lf2 failed\n", s);
    407e:	85ca                	mv	a1,s2
    4080:	00005517          	auipc	a0,0x5
    4084:	76050513          	addi	a0,a0,1888 # 97e0 <malloc+0x75c>
    4088:	00005097          	auipc	ra,0x5
    408c:	f3e080e7          	jalr	-194(ra) # 8fc6 <printf>
    exit(1);
    4090:	4505                	li	a0,1
    4092:	00005097          	auipc	ra,0x5
    4096:	b8c080e7          	jalr	-1140(ra) # 8c1e <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    409a:	85ca                	mv	a1,s2
    409c:	00005517          	auipc	a0,0x5
    40a0:	76450513          	addi	a0,a0,1892 # 9800 <malloc+0x77c>
    40a4:	00005097          	auipc	ra,0x5
    40a8:	f22080e7          	jalr	-222(ra) # 8fc6 <printf>
    exit(1);
    40ac:	4505                	li	a0,1
    40ae:	00005097          	auipc	ra,0x5
    40b2:	b70080e7          	jalr	-1168(ra) # 8c1e <exit>
    printf("%s: open lf2 failed\n", s);
    40b6:	85ca                	mv	a1,s2
    40b8:	00005517          	auipc	a0,0x5
    40bc:	77850513          	addi	a0,a0,1912 # 9830 <malloc+0x7ac>
    40c0:	00005097          	auipc	ra,0x5
    40c4:	f06080e7          	jalr	-250(ra) # 8fc6 <printf>
    exit(1);
    40c8:	4505                	li	a0,1
    40ca:	00005097          	auipc	ra,0x5
    40ce:	b54080e7          	jalr	-1196(ra) # 8c1e <exit>
    printf("%s: read lf2 failed\n", s);
    40d2:	85ca                	mv	a1,s2
    40d4:	00005517          	auipc	a0,0x5
    40d8:	77450513          	addi	a0,a0,1908 # 9848 <malloc+0x7c4>
    40dc:	00005097          	auipc	ra,0x5
    40e0:	eea080e7          	jalr	-278(ra) # 8fc6 <printf>
    exit(1);
    40e4:	4505                	li	a0,1
    40e6:	00005097          	auipc	ra,0x5
    40ea:	b38080e7          	jalr	-1224(ra) # 8c1e <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    40ee:	85ca                	mv	a1,s2
    40f0:	00005517          	auipc	a0,0x5
    40f4:	77050513          	addi	a0,a0,1904 # 9860 <malloc+0x7dc>
    40f8:	00005097          	auipc	ra,0x5
    40fc:	ece080e7          	jalr	-306(ra) # 8fc6 <printf>
    exit(1);
    4100:	4505                	li	a0,1
    4102:	00005097          	auipc	ra,0x5
    4106:	b1c080e7          	jalr	-1252(ra) # 8c1e <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
    410a:	85ca                	mv	a1,s2
    410c:	00005517          	auipc	a0,0x5
    4110:	77c50513          	addi	a0,a0,1916 # 9888 <malloc+0x804>
    4114:	00005097          	auipc	ra,0x5
    4118:	eb2080e7          	jalr	-334(ra) # 8fc6 <printf>
    exit(1);
    411c:	4505                	li	a0,1
    411e:	00005097          	auipc	ra,0x5
    4122:	b00080e7          	jalr	-1280(ra) # 8c1e <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
    4126:	85ca                	mv	a1,s2
    4128:	00005517          	auipc	a0,0x5
    412c:	79050513          	addi	a0,a0,1936 # 98b8 <malloc+0x834>
    4130:	00005097          	auipc	ra,0x5
    4134:	e96080e7          	jalr	-362(ra) # 8fc6 <printf>
    exit(1);
    4138:	4505                	li	a0,1
    413a:	00005097          	auipc	ra,0x5
    413e:	ae4080e7          	jalr	-1308(ra) # 8c1e <exit>

0000000000004142 <validatetest>:
{
    4142:	7139                	addi	sp,sp,-64
    4144:	fc06                	sd	ra,56(sp)
    4146:	f822                	sd	s0,48(sp)
    4148:	f426                	sd	s1,40(sp)
    414a:	f04a                	sd	s2,32(sp)
    414c:	ec4e                	sd	s3,24(sp)
    414e:	e852                	sd	s4,16(sp)
    4150:	e456                	sd	s5,8(sp)
    4152:	e05a                	sd	s6,0(sp)
    4154:	0080                	addi	s0,sp,64
    4156:	8b2a                	mv	s6,a0
  for(p = PGSIZE*3; p <= (uint)hi; p += PGSIZE){
    4158:	648d                	lui	s1,0x3
    if(link("nosuchfile", (char*)p) != -1){
    415a:	00005997          	auipc	s3,0x5
    415e:	77e98993          	addi	s3,s3,1918 # 98d8 <malloc+0x854>
    4162:	597d                	li	s2,-1
  for(p = PGSIZE*3; p <= (uint)hi; p += PGSIZE){
    4164:	6a85                	lui	s5,0x1
    4166:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    416a:	85a6                	mv	a1,s1
    416c:	854e                	mv	a0,s3
    416e:	00005097          	auipc	ra,0x5
    4172:	b18080e7          	jalr	-1256(ra) # 8c86 <link>
    4176:	01251f63          	bne	a0,s2,4194 <validatetest+0x52>
  for(p = PGSIZE*3; p <= (uint)hi; p += PGSIZE){
    417a:	94d6                	add	s1,s1,s5
    417c:	ff4497e3          	bne	s1,s4,416a <validatetest+0x28>
}
    4180:	70e2                	ld	ra,56(sp)
    4182:	7442                	ld	s0,48(sp)
    4184:	74a2                	ld	s1,40(sp)
    4186:	7902                	ld	s2,32(sp)
    4188:	69e2                	ld	s3,24(sp)
    418a:	6a42                	ld	s4,16(sp)
    418c:	6aa2                	ld	s5,8(sp)
    418e:	6b02                	ld	s6,0(sp)
    4190:	6121                	addi	sp,sp,64
    4192:	8082                	ret
      printf("%s: link should not succeed\n", s);
    4194:	85da                	mv	a1,s6
    4196:	00005517          	auipc	a0,0x5
    419a:	75250513          	addi	a0,a0,1874 # 98e8 <malloc+0x864>
    419e:	00005097          	auipc	ra,0x5
    41a2:	e28080e7          	jalr	-472(ra) # 8fc6 <printf>
      exit(1);
    41a6:	4505                	li	a0,1
    41a8:	00005097          	auipc	ra,0x5
    41ac:	a76080e7          	jalr	-1418(ra) # 8c1e <exit>

00000000000041b0 <bigdir>:
{
    41b0:	715d                	addi	sp,sp,-80
    41b2:	e486                	sd	ra,72(sp)
    41b4:	e0a2                	sd	s0,64(sp)
    41b6:	fc26                	sd	s1,56(sp)
    41b8:	f84a                	sd	s2,48(sp)
    41ba:	f44e                	sd	s3,40(sp)
    41bc:	f052                	sd	s4,32(sp)
    41be:	ec56                	sd	s5,24(sp)
    41c0:	e85a                	sd	s6,16(sp)
    41c2:	0880                	addi	s0,sp,80
    41c4:	89aa                	mv	s3,a0
  unlink("bd");
    41c6:	00005517          	auipc	a0,0x5
    41ca:	74250513          	addi	a0,a0,1858 # 9908 <malloc+0x884>
    41ce:	00005097          	auipc	ra,0x5
    41d2:	aa8080e7          	jalr	-1368(ra) # 8c76 <unlink>
  fd = open("bd", O_CREATE);
    41d6:	20000593          	li	a1,512
    41da:	00005517          	auipc	a0,0x5
    41de:	72e50513          	addi	a0,a0,1838 # 9908 <malloc+0x884>
    41e2:	00005097          	auipc	ra,0x5
    41e6:	a84080e7          	jalr	-1404(ra) # 8c66 <open>
  if(fd < 0){
    41ea:	0c054963          	bltz	a0,42bc <bigdir+0x10c>
  close(fd);
    41ee:	00005097          	auipc	ra,0x5
    41f2:	a60080e7          	jalr	-1440(ra) # 8c4e <close>
  for(i = 0; i < N; i++){
    41f6:	4901                	li	s2,0
    name[0] = 'x';
    41f8:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
    41fc:	00005a17          	auipc	s4,0x5
    4200:	70ca0a13          	addi	s4,s4,1804 # 9908 <malloc+0x884>
  for(i = 0; i < N; i++){
    4204:	1f400b13          	li	s6,500
    name[0] = 'x';
    4208:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
    420c:	41f9579b          	sraiw	a5,s2,0x1f
    4210:	01a7d71b          	srliw	a4,a5,0x1a
    4214:	012707bb          	addw	a5,a4,s2
    4218:	4067d69b          	sraiw	a3,a5,0x6
    421c:	0306869b          	addiw	a3,a3,48
    4220:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    4224:	03f7f793          	andi	a5,a5,63
    4228:	9f99                	subw	a5,a5,a4
    422a:	0307879b          	addiw	a5,a5,48
    422e:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    4232:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
    4236:	fb040593          	addi	a1,s0,-80
    423a:	8552                	mv	a0,s4
    423c:	00005097          	auipc	ra,0x5
    4240:	a4a080e7          	jalr	-1462(ra) # 8c86 <link>
    4244:	84aa                	mv	s1,a0
    4246:	e949                	bnez	a0,42d8 <bigdir+0x128>
  for(i = 0; i < N; i++){
    4248:	2905                	addiw	s2,s2,1
    424a:	fb691fe3          	bne	s2,s6,4208 <bigdir+0x58>
  unlink("bd");
    424e:	00005517          	auipc	a0,0x5
    4252:	6ba50513          	addi	a0,a0,1722 # 9908 <malloc+0x884>
    4256:	00005097          	auipc	ra,0x5
    425a:	a20080e7          	jalr	-1504(ra) # 8c76 <unlink>
    name[0] = 'x';
    425e:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    4262:	1f400a13          	li	s4,500
    name[0] = 'x';
    4266:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    426a:	41f4d79b          	sraiw	a5,s1,0x1f
    426e:	01a7d71b          	srliw	a4,a5,0x1a
    4272:	009707bb          	addw	a5,a4,s1
    4276:	4067d69b          	sraiw	a3,a5,0x6
    427a:	0306869b          	addiw	a3,a3,48
    427e:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    4282:	03f7f793          	andi	a5,a5,63
    4286:	9f99                	subw	a5,a5,a4
    4288:	0307879b          	addiw	a5,a5,48
    428c:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    4290:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    4294:	fb040513          	addi	a0,s0,-80
    4298:	00005097          	auipc	ra,0x5
    429c:	9de080e7          	jalr	-1570(ra) # 8c76 <unlink>
    42a0:	ed21                	bnez	a0,42f8 <bigdir+0x148>
  for(i = 0; i < N; i++){
    42a2:	2485                	addiw	s1,s1,1
    42a4:	fd4491e3          	bne	s1,s4,4266 <bigdir+0xb6>
}
    42a8:	60a6                	ld	ra,72(sp)
    42aa:	6406                	ld	s0,64(sp)
    42ac:	74e2                	ld	s1,56(sp)
    42ae:	7942                	ld	s2,48(sp)
    42b0:	79a2                	ld	s3,40(sp)
    42b2:	7a02                	ld	s4,32(sp)
    42b4:	6ae2                	ld	s5,24(sp)
    42b6:	6b42                	ld	s6,16(sp)
    42b8:	6161                	addi	sp,sp,80
    42ba:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    42bc:	85ce                	mv	a1,s3
    42be:	00005517          	auipc	a0,0x5
    42c2:	65250513          	addi	a0,a0,1618 # 9910 <malloc+0x88c>
    42c6:	00005097          	auipc	ra,0x5
    42ca:	d00080e7          	jalr	-768(ra) # 8fc6 <printf>
    exit(1);
    42ce:	4505                	li	a0,1
    42d0:	00005097          	auipc	ra,0x5
    42d4:	94e080e7          	jalr	-1714(ra) # 8c1e <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    42d8:	fb040613          	addi	a2,s0,-80
    42dc:	85ce                	mv	a1,s3
    42de:	00005517          	auipc	a0,0x5
    42e2:	65250513          	addi	a0,a0,1618 # 9930 <malloc+0x8ac>
    42e6:	00005097          	auipc	ra,0x5
    42ea:	ce0080e7          	jalr	-800(ra) # 8fc6 <printf>
      exit(1);
    42ee:	4505                	li	a0,1
    42f0:	00005097          	auipc	ra,0x5
    42f4:	92e080e7          	jalr	-1746(ra) # 8c1e <exit>
      printf("%s: bigdir unlink failed", s);
    42f8:	85ce                	mv	a1,s3
    42fa:	00005517          	auipc	a0,0x5
    42fe:	65650513          	addi	a0,a0,1622 # 9950 <malloc+0x8cc>
    4302:	00005097          	auipc	ra,0x5
    4306:	cc4080e7          	jalr	-828(ra) # 8fc6 <printf>
      exit(1);
    430a:	4505                	li	a0,1
    430c:	00005097          	auipc	ra,0x5
    4310:	912080e7          	jalr	-1774(ra) # 8c1e <exit>

0000000000004314 <pgbug>:
{
    4314:	7179                	addi	sp,sp,-48
    4316:	f406                	sd	ra,40(sp)
    4318:	f022                	sd	s0,32(sp)
    431a:	ec26                	sd	s1,24(sp)
    431c:	1800                	addi	s0,sp,48
  argv[0] = 0;
    431e:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    4322:	00008497          	auipc	s1,0x8
    4326:	cde48493          	addi	s1,s1,-802 # c000 <big>
    432a:	fd840593          	addi	a1,s0,-40
    432e:	6088                	ld	a0,0(s1)
    4330:	00005097          	auipc	ra,0x5
    4334:	92e080e7          	jalr	-1746(ra) # 8c5e <exec>
  pipe(big);
    4338:	6088                	ld	a0,0(s1)
    433a:	00005097          	auipc	ra,0x5
    433e:	8fc080e7          	jalr	-1796(ra) # 8c36 <pipe>
  exit(0);
    4342:	4501                	li	a0,0
    4344:	00005097          	auipc	ra,0x5
    4348:	8da080e7          	jalr	-1830(ra) # 8c1e <exit>

000000000000434c <badarg>:
{
    434c:	7139                	addi	sp,sp,-64
    434e:	fc06                	sd	ra,56(sp)
    4350:	f822                	sd	s0,48(sp)
    4352:	f426                	sd	s1,40(sp)
    4354:	f04a                	sd	s2,32(sp)
    4356:	ec4e                	sd	s3,24(sp)
    4358:	0080                	addi	s0,sp,64
    435a:	64b1                	lui	s1,0xc
    435c:	35048493          	addi	s1,s1,848 # c350 <quicktests+0x340>
    argv[0] = (char*)0xffffffff;
    4360:	597d                	li	s2,-1
    4362:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    4366:	00005997          	auipc	s3,0x5
    436a:	e6298993          	addi	s3,s3,-414 # 91c8 <malloc+0x144>
    argv[0] = (char*)0xffffffff;
    436e:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    4372:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    4376:	fc040593          	addi	a1,s0,-64
    437a:	854e                	mv	a0,s3
    437c:	00005097          	auipc	ra,0x5
    4380:	8e2080e7          	jalr	-1822(ra) # 8c5e <exec>
  for(int i = 0; i < 50000; i++){
    4384:	34fd                	addiw	s1,s1,-1
    4386:	f4e5                	bnez	s1,436e <badarg+0x22>
  exit(0);
    4388:	4501                	li	a0,0
    438a:	00005097          	auipc	ra,0x5
    438e:	894080e7          	jalr	-1900(ra) # 8c1e <exit>

0000000000004392 <copyinstr2>:
{
    4392:	7155                	addi	sp,sp,-208
    4394:	e586                	sd	ra,200(sp)
    4396:	e1a2                	sd	s0,192(sp)
    4398:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    439a:	f6840793          	addi	a5,s0,-152
    439e:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    43a2:	07800713          	li	a4,120
    43a6:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    43aa:	0785                	addi	a5,a5,1
    43ac:	fed79de3          	bne	a5,a3,43a6 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    43b0:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    43b4:	f6840513          	addi	a0,s0,-152
    43b8:	00005097          	auipc	ra,0x5
    43bc:	8be080e7          	jalr	-1858(ra) # 8c76 <unlink>
  if(ret != -1){
    43c0:	57fd                	li	a5,-1
    43c2:	0ef51063          	bne	a0,a5,44a2 <copyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    43c6:	20100593          	li	a1,513
    43ca:	f6840513          	addi	a0,s0,-152
    43ce:	00005097          	auipc	ra,0x5
    43d2:	898080e7          	jalr	-1896(ra) # 8c66 <open>
  if(fd != -1){
    43d6:	57fd                	li	a5,-1
    43d8:	0ef51563          	bne	a0,a5,44c2 <copyinstr2+0x130>
  ret = link(b, b);
    43dc:	f6840593          	addi	a1,s0,-152
    43e0:	852e                	mv	a0,a1
    43e2:	00005097          	auipc	ra,0x5
    43e6:	8a4080e7          	jalr	-1884(ra) # 8c86 <link>
  if(ret != -1){
    43ea:	57fd                	li	a5,-1
    43ec:	0ef51b63          	bne	a0,a5,44e2 <copyinstr2+0x150>
  char *args[] = { "xx", 0 };
    43f0:	00006797          	auipc	a5,0x6
    43f4:	7b878793          	addi	a5,a5,1976 # aba8 <malloc+0x1b24>
    43f8:	f4f43c23          	sd	a5,-168(s0)
    43fc:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    4400:	f5840593          	addi	a1,s0,-168
    4404:	f6840513          	addi	a0,s0,-152
    4408:	00005097          	auipc	ra,0x5
    440c:	856080e7          	jalr	-1962(ra) # 8c5e <exec>
  if(ret != -1){
    4410:	57fd                	li	a5,-1
    4412:	0ef51963          	bne	a0,a5,4504 <copyinstr2+0x172>
  int pid = fork();
    4416:	00005097          	auipc	ra,0x5
    441a:	800080e7          	jalr	-2048(ra) # 8c16 <fork>
  if(pid < 0){
    441e:	10054363          	bltz	a0,4524 <copyinstr2+0x192>
  if(pid == 0){
    4422:	12051463          	bnez	a0,454a <copyinstr2+0x1b8>
    4426:	00008797          	auipc	a5,0x8
    442a:	13a78793          	addi	a5,a5,314 # c560 <big.0>
    442e:	00009697          	auipc	a3,0x9
    4432:	13268693          	addi	a3,a3,306 # d560 <big.0+0x1000>
      big[i] = 'x';
    4436:	07800713          	li	a4,120
    443a:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    443e:	0785                	addi	a5,a5,1
    4440:	fed79de3          	bne	a5,a3,443a <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    4444:	00009797          	auipc	a5,0x9
    4448:	10078e23          	sb	zero,284(a5) # d560 <big.0+0x1000>
    char *args2[] = { big, big, big, 0 };
    444c:	00007797          	auipc	a5,0x7
    4450:	17c78793          	addi	a5,a5,380 # b5c8 <malloc+0x2544>
    4454:	6390                	ld	a2,0(a5)
    4456:	6794                	ld	a3,8(a5)
    4458:	6b98                	ld	a4,16(a5)
    445a:	6f9c                	ld	a5,24(a5)
    445c:	f2c43823          	sd	a2,-208(s0)
    4460:	f2d43c23          	sd	a3,-200(s0)
    4464:	f4e43023          	sd	a4,-192(s0)
    4468:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    446c:	f3040593          	addi	a1,s0,-208
    4470:	00005517          	auipc	a0,0x5
    4474:	d5850513          	addi	a0,a0,-680 # 91c8 <malloc+0x144>
    4478:	00004097          	auipc	ra,0x4
    447c:	7e6080e7          	jalr	2022(ra) # 8c5e <exec>
    if(ret != -1){
    4480:	57fd                	li	a5,-1
    4482:	0af50e63          	beq	a0,a5,453e <copyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    4486:	55fd                	li	a1,-1
    4488:	00005517          	auipc	a0,0x5
    448c:	57050513          	addi	a0,a0,1392 # 99f8 <malloc+0x974>
    4490:	00005097          	auipc	ra,0x5
    4494:	b36080e7          	jalr	-1226(ra) # 8fc6 <printf>
      exit(1);
    4498:	4505                	li	a0,1
    449a:	00004097          	auipc	ra,0x4
    449e:	784080e7          	jalr	1924(ra) # 8c1e <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    44a2:	862a                	mv	a2,a0
    44a4:	f6840593          	addi	a1,s0,-152
    44a8:	00005517          	auipc	a0,0x5
    44ac:	4c850513          	addi	a0,a0,1224 # 9970 <malloc+0x8ec>
    44b0:	00005097          	auipc	ra,0x5
    44b4:	b16080e7          	jalr	-1258(ra) # 8fc6 <printf>
    exit(1);
    44b8:	4505                	li	a0,1
    44ba:	00004097          	auipc	ra,0x4
    44be:	764080e7          	jalr	1892(ra) # 8c1e <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    44c2:	862a                	mv	a2,a0
    44c4:	f6840593          	addi	a1,s0,-152
    44c8:	00005517          	auipc	a0,0x5
    44cc:	4c850513          	addi	a0,a0,1224 # 9990 <malloc+0x90c>
    44d0:	00005097          	auipc	ra,0x5
    44d4:	af6080e7          	jalr	-1290(ra) # 8fc6 <printf>
    exit(1);
    44d8:	4505                	li	a0,1
    44da:	00004097          	auipc	ra,0x4
    44de:	744080e7          	jalr	1860(ra) # 8c1e <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    44e2:	86aa                	mv	a3,a0
    44e4:	f6840613          	addi	a2,s0,-152
    44e8:	85b2                	mv	a1,a2
    44ea:	00005517          	auipc	a0,0x5
    44ee:	4c650513          	addi	a0,a0,1222 # 99b0 <malloc+0x92c>
    44f2:	00005097          	auipc	ra,0x5
    44f6:	ad4080e7          	jalr	-1324(ra) # 8fc6 <printf>
    exit(1);
    44fa:	4505                	li	a0,1
    44fc:	00004097          	auipc	ra,0x4
    4500:	722080e7          	jalr	1826(ra) # 8c1e <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    4504:	567d                	li	a2,-1
    4506:	f6840593          	addi	a1,s0,-152
    450a:	00005517          	auipc	a0,0x5
    450e:	4ce50513          	addi	a0,a0,1230 # 99d8 <malloc+0x954>
    4512:	00005097          	auipc	ra,0x5
    4516:	ab4080e7          	jalr	-1356(ra) # 8fc6 <printf>
    exit(1);
    451a:	4505                	li	a0,1
    451c:	00004097          	auipc	ra,0x4
    4520:	702080e7          	jalr	1794(ra) # 8c1e <exit>
    printf("fork failed\n");
    4524:	00006517          	auipc	a0,0x6
    4528:	93450513          	addi	a0,a0,-1740 # 9e58 <malloc+0xdd4>
    452c:	00005097          	auipc	ra,0x5
    4530:	a9a080e7          	jalr	-1382(ra) # 8fc6 <printf>
    exit(1);
    4534:	4505                	li	a0,1
    4536:	00004097          	auipc	ra,0x4
    453a:	6e8080e7          	jalr	1768(ra) # 8c1e <exit>
    exit(747); // OK
    453e:	2eb00513          	li	a0,747
    4542:	00004097          	auipc	ra,0x4
    4546:	6dc080e7          	jalr	1756(ra) # 8c1e <exit>
  int st = 0;
    454a:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    454e:	f5440513          	addi	a0,s0,-172
    4552:	00004097          	auipc	ra,0x4
    4556:	6d4080e7          	jalr	1748(ra) # 8c26 <wait>
  if(st != 747){
    455a:	f5442703          	lw	a4,-172(s0)
    455e:	2eb00793          	li	a5,747
    4562:	00f71663          	bne	a4,a5,456e <copyinstr2+0x1dc>
}
    4566:	60ae                	ld	ra,200(sp)
    4568:	640e                	ld	s0,192(sp)
    456a:	6169                	addi	sp,sp,208
    456c:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    456e:	00005517          	auipc	a0,0x5
    4572:	4b250513          	addi	a0,a0,1202 # 9a20 <malloc+0x99c>
    4576:	00005097          	auipc	ra,0x5
    457a:	a50080e7          	jalr	-1456(ra) # 8fc6 <printf>
    exit(1);
    457e:	4505                	li	a0,1
    4580:	00004097          	auipc	ra,0x4
    4584:	69e080e7          	jalr	1694(ra) # 8c1e <exit>

0000000000004588 <truncate3>:
{
    4588:	7159                	addi	sp,sp,-112
    458a:	f486                	sd	ra,104(sp)
    458c:	f0a2                	sd	s0,96(sp)
    458e:	eca6                	sd	s1,88(sp)
    4590:	e8ca                	sd	s2,80(sp)
    4592:	e4ce                	sd	s3,72(sp)
    4594:	e0d2                	sd	s4,64(sp)
    4596:	fc56                	sd	s5,56(sp)
    4598:	1880                	addi	s0,sp,112
    459a:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    459c:	60100593          	li	a1,1537
    45a0:	00005517          	auipc	a0,0x5
    45a4:	c8050513          	addi	a0,a0,-896 # 9220 <malloc+0x19c>
    45a8:	00004097          	auipc	ra,0x4
    45ac:	6be080e7          	jalr	1726(ra) # 8c66 <open>
    45b0:	00004097          	auipc	ra,0x4
    45b4:	69e080e7          	jalr	1694(ra) # 8c4e <close>
  pid = fork();
    45b8:	00004097          	auipc	ra,0x4
    45bc:	65e080e7          	jalr	1630(ra) # 8c16 <fork>
  if(pid < 0){
    45c0:	08054063          	bltz	a0,4640 <truncate3+0xb8>
  if(pid == 0){
    45c4:	e969                	bnez	a0,4696 <truncate3+0x10e>
    45c6:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    45ca:	00005a17          	auipc	s4,0x5
    45ce:	c56a0a13          	addi	s4,s4,-938 # 9220 <malloc+0x19c>
      int n = write(fd, "1234567890", 10);
    45d2:	00005a97          	auipc	s5,0x5
    45d6:	4aea8a93          	addi	s5,s5,1198 # 9a80 <malloc+0x9fc>
      int fd = open("truncfile", O_WRONLY);
    45da:	4585                	li	a1,1
    45dc:	8552                	mv	a0,s4
    45de:	00004097          	auipc	ra,0x4
    45e2:	688080e7          	jalr	1672(ra) # 8c66 <open>
    45e6:	84aa                	mv	s1,a0
      if(fd < 0){
    45e8:	06054a63          	bltz	a0,465c <truncate3+0xd4>
      int n = write(fd, "1234567890", 10);
    45ec:	4629                	li	a2,10
    45ee:	85d6                	mv	a1,s5
    45f0:	00004097          	auipc	ra,0x4
    45f4:	656080e7          	jalr	1622(ra) # 8c46 <write>
      if(n != 10){
    45f8:	47a9                	li	a5,10
    45fa:	06f51f63          	bne	a0,a5,4678 <truncate3+0xf0>
      close(fd);
    45fe:	8526                	mv	a0,s1
    4600:	00004097          	auipc	ra,0x4
    4604:	64e080e7          	jalr	1614(ra) # 8c4e <close>
      fd = open("truncfile", O_RDONLY);
    4608:	4581                	li	a1,0
    460a:	8552                	mv	a0,s4
    460c:	00004097          	auipc	ra,0x4
    4610:	65a080e7          	jalr	1626(ra) # 8c66 <open>
    4614:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    4616:	02000613          	li	a2,32
    461a:	f9840593          	addi	a1,s0,-104
    461e:	00004097          	auipc	ra,0x4
    4622:	620080e7          	jalr	1568(ra) # 8c3e <read>
      close(fd);
    4626:	8526                	mv	a0,s1
    4628:	00004097          	auipc	ra,0x4
    462c:	626080e7          	jalr	1574(ra) # 8c4e <close>
    for(int i = 0; i < 100; i++){
    4630:	39fd                	addiw	s3,s3,-1
    4632:	fa0994e3          	bnez	s3,45da <truncate3+0x52>
    exit(0);
    4636:	4501                	li	a0,0
    4638:	00004097          	auipc	ra,0x4
    463c:	5e6080e7          	jalr	1510(ra) # 8c1e <exit>
    printf("%s: fork failed\n", s);
    4640:	85ca                	mv	a1,s2
    4642:	00005517          	auipc	a0,0x5
    4646:	40e50513          	addi	a0,a0,1038 # 9a50 <malloc+0x9cc>
    464a:	00005097          	auipc	ra,0x5
    464e:	97c080e7          	jalr	-1668(ra) # 8fc6 <printf>
    exit(1);
    4652:	4505                	li	a0,1
    4654:	00004097          	auipc	ra,0x4
    4658:	5ca080e7          	jalr	1482(ra) # 8c1e <exit>
        printf("%s: open failed\n", s);
    465c:	85ca                	mv	a1,s2
    465e:	00005517          	auipc	a0,0x5
    4662:	40a50513          	addi	a0,a0,1034 # 9a68 <malloc+0x9e4>
    4666:	00005097          	auipc	ra,0x5
    466a:	960080e7          	jalr	-1696(ra) # 8fc6 <printf>
        exit(1);
    466e:	4505                	li	a0,1
    4670:	00004097          	auipc	ra,0x4
    4674:	5ae080e7          	jalr	1454(ra) # 8c1e <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    4678:	862a                	mv	a2,a0
    467a:	85ca                	mv	a1,s2
    467c:	00005517          	auipc	a0,0x5
    4680:	41450513          	addi	a0,a0,1044 # 9a90 <malloc+0xa0c>
    4684:	00005097          	auipc	ra,0x5
    4688:	942080e7          	jalr	-1726(ra) # 8fc6 <printf>
        exit(1);
    468c:	4505                	li	a0,1
    468e:	00004097          	auipc	ra,0x4
    4692:	590080e7          	jalr	1424(ra) # 8c1e <exit>
    4696:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    469a:	00005a17          	auipc	s4,0x5
    469e:	b86a0a13          	addi	s4,s4,-1146 # 9220 <malloc+0x19c>
    int n = write(fd, "xxx", 3);
    46a2:	00005a97          	auipc	s5,0x5
    46a6:	40ea8a93          	addi	s5,s5,1038 # 9ab0 <malloc+0xa2c>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    46aa:	60100593          	li	a1,1537
    46ae:	8552                	mv	a0,s4
    46b0:	00004097          	auipc	ra,0x4
    46b4:	5b6080e7          	jalr	1462(ra) # 8c66 <open>
    46b8:	84aa                	mv	s1,a0
    if(fd < 0){
    46ba:	04054763          	bltz	a0,4708 <truncate3+0x180>
    int n = write(fd, "xxx", 3);
    46be:	460d                	li	a2,3
    46c0:	85d6                	mv	a1,s5
    46c2:	00004097          	auipc	ra,0x4
    46c6:	584080e7          	jalr	1412(ra) # 8c46 <write>
    if(n != 3){
    46ca:	478d                	li	a5,3
    46cc:	04f51c63          	bne	a0,a5,4724 <truncate3+0x19c>
    close(fd);
    46d0:	8526                	mv	a0,s1
    46d2:	00004097          	auipc	ra,0x4
    46d6:	57c080e7          	jalr	1404(ra) # 8c4e <close>
  for(int i = 0; i < 150; i++){
    46da:	39fd                	addiw	s3,s3,-1
    46dc:	fc0997e3          	bnez	s3,46aa <truncate3+0x122>
  wait(&xstatus);
    46e0:	fbc40513          	addi	a0,s0,-68
    46e4:	00004097          	auipc	ra,0x4
    46e8:	542080e7          	jalr	1346(ra) # 8c26 <wait>
  unlink("truncfile");
    46ec:	00005517          	auipc	a0,0x5
    46f0:	b3450513          	addi	a0,a0,-1228 # 9220 <malloc+0x19c>
    46f4:	00004097          	auipc	ra,0x4
    46f8:	582080e7          	jalr	1410(ra) # 8c76 <unlink>
  exit(xstatus);
    46fc:	fbc42503          	lw	a0,-68(s0)
    4700:	00004097          	auipc	ra,0x4
    4704:	51e080e7          	jalr	1310(ra) # 8c1e <exit>
      printf("%s: open failed\n", s);
    4708:	85ca                	mv	a1,s2
    470a:	00005517          	auipc	a0,0x5
    470e:	35e50513          	addi	a0,a0,862 # 9a68 <malloc+0x9e4>
    4712:	00005097          	auipc	ra,0x5
    4716:	8b4080e7          	jalr	-1868(ra) # 8fc6 <printf>
      exit(1);
    471a:	4505                	li	a0,1
    471c:	00004097          	auipc	ra,0x4
    4720:	502080e7          	jalr	1282(ra) # 8c1e <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    4724:	862a                	mv	a2,a0
    4726:	85ca                	mv	a1,s2
    4728:	00005517          	auipc	a0,0x5
    472c:	39050513          	addi	a0,a0,912 # 9ab8 <malloc+0xa34>
    4730:	00005097          	auipc	ra,0x5
    4734:	896080e7          	jalr	-1898(ra) # 8fc6 <printf>
      exit(1);
    4738:	4505                	li	a0,1
    473a:	00004097          	auipc	ra,0x4
    473e:	4e4080e7          	jalr	1252(ra) # 8c1e <exit>

0000000000004742 <exectest>:
{
    4742:	715d                	addi	sp,sp,-80
    4744:	e486                	sd	ra,72(sp)
    4746:	e0a2                	sd	s0,64(sp)
    4748:	fc26                	sd	s1,56(sp)
    474a:	f84a                	sd	s2,48(sp)
    474c:	0880                	addi	s0,sp,80
    474e:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    4750:	00005797          	auipc	a5,0x5
    4754:	a7878793          	addi	a5,a5,-1416 # 91c8 <malloc+0x144>
    4758:	fcf43023          	sd	a5,-64(s0)
    475c:	00005797          	auipc	a5,0x5
    4760:	37c78793          	addi	a5,a5,892 # 9ad8 <malloc+0xa54>
    4764:	fcf43423          	sd	a5,-56(s0)
    4768:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    476c:	00005517          	auipc	a0,0x5
    4770:	37450513          	addi	a0,a0,884 # 9ae0 <malloc+0xa5c>
    4774:	00004097          	auipc	ra,0x4
    4778:	502080e7          	jalr	1282(ra) # 8c76 <unlink>
  pid = fork();
    477c:	00004097          	auipc	ra,0x4
    4780:	49a080e7          	jalr	1178(ra) # 8c16 <fork>
  if(pid < 0) {
    4784:	04054663          	bltz	a0,47d0 <exectest+0x8e>
    4788:	84aa                	mv	s1,a0
  if(pid == 0) {
    478a:	e959                	bnez	a0,4820 <exectest+0xde>
    close(1);
    478c:	4505                	li	a0,1
    478e:	00004097          	auipc	ra,0x4
    4792:	4c0080e7          	jalr	1216(ra) # 8c4e <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    4796:	20100593          	li	a1,513
    479a:	00005517          	auipc	a0,0x5
    479e:	34650513          	addi	a0,a0,838 # 9ae0 <malloc+0xa5c>
    47a2:	00004097          	auipc	ra,0x4
    47a6:	4c4080e7          	jalr	1220(ra) # 8c66 <open>
    if(fd < 0) {
    47aa:	04054163          	bltz	a0,47ec <exectest+0xaa>
    if(fd != 1) {
    47ae:	4785                	li	a5,1
    47b0:	04f50c63          	beq	a0,a5,4808 <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    47b4:	85ca                	mv	a1,s2
    47b6:	00005517          	auipc	a0,0x5
    47ba:	34a50513          	addi	a0,a0,842 # 9b00 <malloc+0xa7c>
    47be:	00005097          	auipc	ra,0x5
    47c2:	808080e7          	jalr	-2040(ra) # 8fc6 <printf>
      exit(1);
    47c6:	4505                	li	a0,1
    47c8:	00004097          	auipc	ra,0x4
    47cc:	456080e7          	jalr	1110(ra) # 8c1e <exit>
     printf("%s: fork failed\n", s);
    47d0:	85ca                	mv	a1,s2
    47d2:	00005517          	auipc	a0,0x5
    47d6:	27e50513          	addi	a0,a0,638 # 9a50 <malloc+0x9cc>
    47da:	00004097          	auipc	ra,0x4
    47de:	7ec080e7          	jalr	2028(ra) # 8fc6 <printf>
     exit(1);
    47e2:	4505                	li	a0,1
    47e4:	00004097          	auipc	ra,0x4
    47e8:	43a080e7          	jalr	1082(ra) # 8c1e <exit>
      printf("%s: create failed\n", s);
    47ec:	85ca                	mv	a1,s2
    47ee:	00005517          	auipc	a0,0x5
    47f2:	2fa50513          	addi	a0,a0,762 # 9ae8 <malloc+0xa64>
    47f6:	00004097          	auipc	ra,0x4
    47fa:	7d0080e7          	jalr	2000(ra) # 8fc6 <printf>
      exit(1);
    47fe:	4505                	li	a0,1
    4800:	00004097          	auipc	ra,0x4
    4804:	41e080e7          	jalr	1054(ra) # 8c1e <exit>
    if(exec("echo", echoargv) < 0){
    4808:	fc040593          	addi	a1,s0,-64
    480c:	00005517          	auipc	a0,0x5
    4810:	9bc50513          	addi	a0,a0,-1604 # 91c8 <malloc+0x144>
    4814:	00004097          	auipc	ra,0x4
    4818:	44a080e7          	jalr	1098(ra) # 8c5e <exec>
    481c:	02054163          	bltz	a0,483e <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    4820:	fdc40513          	addi	a0,s0,-36
    4824:	00004097          	auipc	ra,0x4
    4828:	402080e7          	jalr	1026(ra) # 8c26 <wait>
    482c:	02951763          	bne	a0,s1,485a <exectest+0x118>
  if(xstatus != 0)
    4830:	fdc42503          	lw	a0,-36(s0)
    4834:	cd0d                	beqz	a0,486e <exectest+0x12c>
    exit(xstatus);
    4836:	00004097          	auipc	ra,0x4
    483a:	3e8080e7          	jalr	1000(ra) # 8c1e <exit>
      printf("%s: exec echo failed\n", s);
    483e:	85ca                	mv	a1,s2
    4840:	00005517          	auipc	a0,0x5
    4844:	2d050513          	addi	a0,a0,720 # 9b10 <malloc+0xa8c>
    4848:	00004097          	auipc	ra,0x4
    484c:	77e080e7          	jalr	1918(ra) # 8fc6 <printf>
      exit(1);
    4850:	4505                	li	a0,1
    4852:	00004097          	auipc	ra,0x4
    4856:	3cc080e7          	jalr	972(ra) # 8c1e <exit>
    printf("%s: wait failed!\n", s);
    485a:	85ca                	mv	a1,s2
    485c:	00005517          	auipc	a0,0x5
    4860:	2cc50513          	addi	a0,a0,716 # 9b28 <malloc+0xaa4>
    4864:	00004097          	auipc	ra,0x4
    4868:	762080e7          	jalr	1890(ra) # 8fc6 <printf>
    486c:	b7d1                	j	4830 <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    486e:	4581                	li	a1,0
    4870:	00005517          	auipc	a0,0x5
    4874:	27050513          	addi	a0,a0,624 # 9ae0 <malloc+0xa5c>
    4878:	00004097          	auipc	ra,0x4
    487c:	3ee080e7          	jalr	1006(ra) # 8c66 <open>
  if(fd < 0) {
    4880:	02054a63          	bltz	a0,48b4 <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    4884:	4609                	li	a2,2
    4886:	fb840593          	addi	a1,s0,-72
    488a:	00004097          	auipc	ra,0x4
    488e:	3b4080e7          	jalr	948(ra) # 8c3e <read>
    4892:	4789                	li	a5,2
    4894:	02f50e63          	beq	a0,a5,48d0 <exectest+0x18e>
    printf("%s: read failed\n", s);
    4898:	85ca                	mv	a1,s2
    489a:	00005517          	auipc	a0,0x5
    489e:	cfe50513          	addi	a0,a0,-770 # 9598 <malloc+0x514>
    48a2:	00004097          	auipc	ra,0x4
    48a6:	724080e7          	jalr	1828(ra) # 8fc6 <printf>
    exit(1);
    48aa:	4505                	li	a0,1
    48ac:	00004097          	auipc	ra,0x4
    48b0:	372080e7          	jalr	882(ra) # 8c1e <exit>
    printf("%s: open failed\n", s);
    48b4:	85ca                	mv	a1,s2
    48b6:	00005517          	auipc	a0,0x5
    48ba:	1b250513          	addi	a0,a0,434 # 9a68 <malloc+0x9e4>
    48be:	00004097          	auipc	ra,0x4
    48c2:	708080e7          	jalr	1800(ra) # 8fc6 <printf>
    exit(1);
    48c6:	4505                	li	a0,1
    48c8:	00004097          	auipc	ra,0x4
    48cc:	356080e7          	jalr	854(ra) # 8c1e <exit>
  unlink("echo-ok");
    48d0:	00005517          	auipc	a0,0x5
    48d4:	21050513          	addi	a0,a0,528 # 9ae0 <malloc+0xa5c>
    48d8:	00004097          	auipc	ra,0x4
    48dc:	39e080e7          	jalr	926(ra) # 8c76 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    48e0:	fb844703          	lbu	a4,-72(s0)
    48e4:	04f00793          	li	a5,79
    48e8:	00f71863          	bne	a4,a5,48f8 <exectest+0x1b6>
    48ec:	fb944703          	lbu	a4,-71(s0)
    48f0:	04b00793          	li	a5,75
    48f4:	02f70063          	beq	a4,a5,4914 <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    48f8:	85ca                	mv	a1,s2
    48fa:	00005517          	auipc	a0,0x5
    48fe:	24650513          	addi	a0,a0,582 # 9b40 <malloc+0xabc>
    4902:	00004097          	auipc	ra,0x4
    4906:	6c4080e7          	jalr	1732(ra) # 8fc6 <printf>
    exit(1);
    490a:	4505                	li	a0,1
    490c:	00004097          	auipc	ra,0x4
    4910:	312080e7          	jalr	786(ra) # 8c1e <exit>
    exit(0);
    4914:	4501                	li	a0,0
    4916:	00004097          	auipc	ra,0x4
    491a:	308080e7          	jalr	776(ra) # 8c1e <exit>

000000000000491e <pipe1>:
{
    491e:	711d                	addi	sp,sp,-96
    4920:	ec86                	sd	ra,88(sp)
    4922:	e8a2                	sd	s0,80(sp)
    4924:	e4a6                	sd	s1,72(sp)
    4926:	e0ca                	sd	s2,64(sp)
    4928:	fc4e                	sd	s3,56(sp)
    492a:	f852                	sd	s4,48(sp)
    492c:	f456                	sd	s5,40(sp)
    492e:	f05a                	sd	s6,32(sp)
    4930:	ec5e                	sd	s7,24(sp)
    4932:	1080                	addi	s0,sp,96
    4934:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    4936:	fa840513          	addi	a0,s0,-88
    493a:	00004097          	auipc	ra,0x4
    493e:	2fc080e7          	jalr	764(ra) # 8c36 <pipe>
    4942:	ed25                	bnez	a0,49ba <pipe1+0x9c>
    4944:	84aa                	mv	s1,a0
  pid = fork();
    4946:	00004097          	auipc	ra,0x4
    494a:	2d0080e7          	jalr	720(ra) # 8c16 <fork>
    494e:	8a2a                	mv	s4,a0
  if(pid == 0){
    4950:	c159                	beqz	a0,49d6 <pipe1+0xb8>
  } else if(pid > 0){
    4952:	16a05e63          	blez	a0,4ace <pipe1+0x1b0>
    close(fds[1]);
    4956:	fac42503          	lw	a0,-84(s0)
    495a:	00004097          	auipc	ra,0x4
    495e:	2f4080e7          	jalr	756(ra) # 8c4e <close>
    total = 0;
    4962:	8a26                	mv	s4,s1
    cc = 1;
    4964:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    4966:	0000ba97          	auipc	s5,0xb
    496a:	312a8a93          	addi	s5,s5,786 # fc78 <buf>
      if(cc > sizeof(buf))
    496e:	6b0d                	lui	s6,0x3
    while((n = read(fds[0], buf, cc)) > 0){
    4970:	864e                	mv	a2,s3
    4972:	85d6                	mv	a1,s5
    4974:	fa842503          	lw	a0,-88(s0)
    4978:	00004097          	auipc	ra,0x4
    497c:	2c6080e7          	jalr	710(ra) # 8c3e <read>
    4980:	10a05263          	blez	a0,4a84 <pipe1+0x166>
      for(i = 0; i < n; i++){
    4984:	0000b717          	auipc	a4,0xb
    4988:	2f470713          	addi	a4,a4,756 # fc78 <buf>
    498c:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    4990:	00074683          	lbu	a3,0(a4)
    4994:	0ff4f793          	andi	a5,s1,255
    4998:	2485                	addiw	s1,s1,1
    499a:	0cf69163          	bne	a3,a5,4a5c <pipe1+0x13e>
      for(i = 0; i < n; i++){
    499e:	0705                	addi	a4,a4,1
    49a0:	fec498e3          	bne	s1,a2,4990 <pipe1+0x72>
      total += n;
    49a4:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    49a8:	0019979b          	slliw	a5,s3,0x1
    49ac:	0007899b          	sext.w	s3,a5
      if(cc > sizeof(buf))
    49b0:	013b7363          	bgeu	s6,s3,49b6 <pipe1+0x98>
        cc = sizeof(buf);
    49b4:	89da                	mv	s3,s6
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    49b6:	84b2                	mv	s1,a2
    49b8:	bf65                	j	4970 <pipe1+0x52>
    printf("%s: pipe() failed\n", s);
    49ba:	85ca                	mv	a1,s2
    49bc:	00005517          	auipc	a0,0x5
    49c0:	19c50513          	addi	a0,a0,412 # 9b58 <malloc+0xad4>
    49c4:	00004097          	auipc	ra,0x4
    49c8:	602080e7          	jalr	1538(ra) # 8fc6 <printf>
    exit(1);
    49cc:	4505                	li	a0,1
    49ce:	00004097          	auipc	ra,0x4
    49d2:	250080e7          	jalr	592(ra) # 8c1e <exit>
    close(fds[0]);
    49d6:	fa842503          	lw	a0,-88(s0)
    49da:	00004097          	auipc	ra,0x4
    49de:	274080e7          	jalr	628(ra) # 8c4e <close>
    for(n = 0; n < N; n++){
    49e2:	0000bb17          	auipc	s6,0xb
    49e6:	296b0b13          	addi	s6,s6,662 # fc78 <buf>
    49ea:	416004bb          	negw	s1,s6
    49ee:	0ff4f493          	andi	s1,s1,255
    49f2:	409b0993          	addi	s3,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    49f6:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    49f8:	6a85                	lui	s5,0x1
    49fa:	42da8a93          	addi	s5,s5,1069 # 142d <copyinstr1-0x1bd3>
{
    49fe:	87da                	mv	a5,s6
        buf[i] = seq++;
    4a00:	0097873b          	addw	a4,a5,s1
    4a04:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    4a08:	0785                	addi	a5,a5,1
    4a0a:	fef99be3          	bne	s3,a5,4a00 <pipe1+0xe2>
        buf[i] = seq++;
    4a0e:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    4a12:	40900613          	li	a2,1033
    4a16:	85de                	mv	a1,s7
    4a18:	fac42503          	lw	a0,-84(s0)
    4a1c:	00004097          	auipc	ra,0x4
    4a20:	22a080e7          	jalr	554(ra) # 8c46 <write>
    4a24:	40900793          	li	a5,1033
    4a28:	00f51c63          	bne	a0,a5,4a40 <pipe1+0x122>
    for(n = 0; n < N; n++){
    4a2c:	24a5                	addiw	s1,s1,9
    4a2e:	0ff4f493          	andi	s1,s1,255
    4a32:	fd5a16e3          	bne	s4,s5,49fe <pipe1+0xe0>
    exit(0);
    4a36:	4501                	li	a0,0
    4a38:	00004097          	auipc	ra,0x4
    4a3c:	1e6080e7          	jalr	486(ra) # 8c1e <exit>
        printf("%s: pipe1 oops 1\n", s);
    4a40:	85ca                	mv	a1,s2
    4a42:	00005517          	auipc	a0,0x5
    4a46:	12e50513          	addi	a0,a0,302 # 9b70 <malloc+0xaec>
    4a4a:	00004097          	auipc	ra,0x4
    4a4e:	57c080e7          	jalr	1404(ra) # 8fc6 <printf>
        exit(1);
    4a52:	4505                	li	a0,1
    4a54:	00004097          	auipc	ra,0x4
    4a58:	1ca080e7          	jalr	458(ra) # 8c1e <exit>
          printf("%s: pipe1 oops 2\n", s);
    4a5c:	85ca                	mv	a1,s2
    4a5e:	00005517          	auipc	a0,0x5
    4a62:	12a50513          	addi	a0,a0,298 # 9b88 <malloc+0xb04>
    4a66:	00004097          	auipc	ra,0x4
    4a6a:	560080e7          	jalr	1376(ra) # 8fc6 <printf>
}
    4a6e:	60e6                	ld	ra,88(sp)
    4a70:	6446                	ld	s0,80(sp)
    4a72:	64a6                	ld	s1,72(sp)
    4a74:	6906                	ld	s2,64(sp)
    4a76:	79e2                	ld	s3,56(sp)
    4a78:	7a42                	ld	s4,48(sp)
    4a7a:	7aa2                	ld	s5,40(sp)
    4a7c:	7b02                	ld	s6,32(sp)
    4a7e:	6be2                	ld	s7,24(sp)
    4a80:	6125                	addi	sp,sp,96
    4a82:	8082                	ret
    if(total != N * SZ){
    4a84:	6785                	lui	a5,0x1
    4a86:	42d78793          	addi	a5,a5,1069 # 142d <copyinstr1-0x1bd3>
    4a8a:	02fa0063          	beq	s4,a5,4aaa <pipe1+0x18c>
      printf("%s: pipe1 oops 3 total %d\n", total);
    4a8e:	85d2                	mv	a1,s4
    4a90:	00005517          	auipc	a0,0x5
    4a94:	11050513          	addi	a0,a0,272 # 9ba0 <malloc+0xb1c>
    4a98:	00004097          	auipc	ra,0x4
    4a9c:	52e080e7          	jalr	1326(ra) # 8fc6 <printf>
      exit(1);
    4aa0:	4505                	li	a0,1
    4aa2:	00004097          	auipc	ra,0x4
    4aa6:	17c080e7          	jalr	380(ra) # 8c1e <exit>
    close(fds[0]);
    4aaa:	fa842503          	lw	a0,-88(s0)
    4aae:	00004097          	auipc	ra,0x4
    4ab2:	1a0080e7          	jalr	416(ra) # 8c4e <close>
    wait(&xstatus);
    4ab6:	fa440513          	addi	a0,s0,-92
    4aba:	00004097          	auipc	ra,0x4
    4abe:	16c080e7          	jalr	364(ra) # 8c26 <wait>
    exit(xstatus);
    4ac2:	fa442503          	lw	a0,-92(s0)
    4ac6:	00004097          	auipc	ra,0x4
    4aca:	158080e7          	jalr	344(ra) # 8c1e <exit>
    printf("%s: fork() failed\n", s);
    4ace:	85ca                	mv	a1,s2
    4ad0:	00005517          	auipc	a0,0x5
    4ad4:	0f050513          	addi	a0,a0,240 # 9bc0 <malloc+0xb3c>
    4ad8:	00004097          	auipc	ra,0x4
    4adc:	4ee080e7          	jalr	1262(ra) # 8fc6 <printf>
    exit(1);
    4ae0:	4505                	li	a0,1
    4ae2:	00004097          	auipc	ra,0x4
    4ae6:	13c080e7          	jalr	316(ra) # 8c1e <exit>

0000000000004aea <exitwait>:
{
    4aea:	7139                	addi	sp,sp,-64
    4aec:	fc06                	sd	ra,56(sp)
    4aee:	f822                	sd	s0,48(sp)
    4af0:	f426                	sd	s1,40(sp)
    4af2:	f04a                	sd	s2,32(sp)
    4af4:	ec4e                	sd	s3,24(sp)
    4af6:	e852                	sd	s4,16(sp)
    4af8:	0080                	addi	s0,sp,64
    4afa:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    4afc:	4901                	li	s2,0
    4afe:	06400993          	li	s3,100
    pid = fork();
    4b02:	00004097          	auipc	ra,0x4
    4b06:	114080e7          	jalr	276(ra) # 8c16 <fork>
    4b0a:	84aa                	mv	s1,a0
    if(pid < 0){
    4b0c:	02054a63          	bltz	a0,4b40 <exitwait+0x56>
    if(pid){
    4b10:	c151                	beqz	a0,4b94 <exitwait+0xaa>
      if(wait(&xstate) != pid){
    4b12:	fcc40513          	addi	a0,s0,-52
    4b16:	00004097          	auipc	ra,0x4
    4b1a:	110080e7          	jalr	272(ra) # 8c26 <wait>
    4b1e:	02951f63          	bne	a0,s1,4b5c <exitwait+0x72>
      if(i != xstate) {
    4b22:	fcc42783          	lw	a5,-52(s0)
    4b26:	05279963          	bne	a5,s2,4b78 <exitwait+0x8e>
  for(i = 0; i < 100; i++){
    4b2a:	2905                	addiw	s2,s2,1
    4b2c:	fd391be3          	bne	s2,s3,4b02 <exitwait+0x18>
}
    4b30:	70e2                	ld	ra,56(sp)
    4b32:	7442                	ld	s0,48(sp)
    4b34:	74a2                	ld	s1,40(sp)
    4b36:	7902                	ld	s2,32(sp)
    4b38:	69e2                	ld	s3,24(sp)
    4b3a:	6a42                	ld	s4,16(sp)
    4b3c:	6121                	addi	sp,sp,64
    4b3e:	8082                	ret
      printf("%s: fork failed\n", s);
    4b40:	85d2                	mv	a1,s4
    4b42:	00005517          	auipc	a0,0x5
    4b46:	f0e50513          	addi	a0,a0,-242 # 9a50 <malloc+0x9cc>
    4b4a:	00004097          	auipc	ra,0x4
    4b4e:	47c080e7          	jalr	1148(ra) # 8fc6 <printf>
      exit(1);
    4b52:	4505                	li	a0,1
    4b54:	00004097          	auipc	ra,0x4
    4b58:	0ca080e7          	jalr	202(ra) # 8c1e <exit>
        printf("%s: wait wrong pid\n", s);
    4b5c:	85d2                	mv	a1,s4
    4b5e:	00005517          	auipc	a0,0x5
    4b62:	07a50513          	addi	a0,a0,122 # 9bd8 <malloc+0xb54>
    4b66:	00004097          	auipc	ra,0x4
    4b6a:	460080e7          	jalr	1120(ra) # 8fc6 <printf>
        exit(1);
    4b6e:	4505                	li	a0,1
    4b70:	00004097          	auipc	ra,0x4
    4b74:	0ae080e7          	jalr	174(ra) # 8c1e <exit>
        printf("%s: wait wrong exit status\n", s);
    4b78:	85d2                	mv	a1,s4
    4b7a:	00005517          	auipc	a0,0x5
    4b7e:	07650513          	addi	a0,a0,118 # 9bf0 <malloc+0xb6c>
    4b82:	00004097          	auipc	ra,0x4
    4b86:	444080e7          	jalr	1092(ra) # 8fc6 <printf>
        exit(1);
    4b8a:	4505                	li	a0,1
    4b8c:	00004097          	auipc	ra,0x4
    4b90:	092080e7          	jalr	146(ra) # 8c1e <exit>
      exit(i);
    4b94:	854a                	mv	a0,s2
    4b96:	00004097          	auipc	ra,0x4
    4b9a:	088080e7          	jalr	136(ra) # 8c1e <exit>

0000000000004b9e <twochildren>:
{
    4b9e:	1101                	addi	sp,sp,-32
    4ba0:	ec06                	sd	ra,24(sp)
    4ba2:	e822                	sd	s0,16(sp)
    4ba4:	e426                	sd	s1,8(sp)
    4ba6:	e04a                	sd	s2,0(sp)
    4ba8:	1000                	addi	s0,sp,32
    4baa:	892a                	mv	s2,a0
    4bac:	3e800493          	li	s1,1000
    int pid1 = fork();
    4bb0:	00004097          	auipc	ra,0x4
    4bb4:	066080e7          	jalr	102(ra) # 8c16 <fork>
    if(pid1 < 0){
    4bb8:	02054c63          	bltz	a0,4bf0 <twochildren+0x52>
    if(pid1 == 0){
    4bbc:	c921                	beqz	a0,4c0c <twochildren+0x6e>
      int pid2 = fork();
    4bbe:	00004097          	auipc	ra,0x4
    4bc2:	058080e7          	jalr	88(ra) # 8c16 <fork>
      if(pid2 < 0){
    4bc6:	04054763          	bltz	a0,4c14 <twochildren+0x76>
      if(pid2 == 0){
    4bca:	c13d                	beqz	a0,4c30 <twochildren+0x92>
        wait(0);
    4bcc:	4501                	li	a0,0
    4bce:	00004097          	auipc	ra,0x4
    4bd2:	058080e7          	jalr	88(ra) # 8c26 <wait>
        wait(0);
    4bd6:	4501                	li	a0,0
    4bd8:	00004097          	auipc	ra,0x4
    4bdc:	04e080e7          	jalr	78(ra) # 8c26 <wait>
  for(int i = 0; i < 1000; i++){
    4be0:	34fd                	addiw	s1,s1,-1
    4be2:	f4f9                	bnez	s1,4bb0 <twochildren+0x12>
}
    4be4:	60e2                	ld	ra,24(sp)
    4be6:	6442                	ld	s0,16(sp)
    4be8:	64a2                	ld	s1,8(sp)
    4bea:	6902                	ld	s2,0(sp)
    4bec:	6105                	addi	sp,sp,32
    4bee:	8082                	ret
      printf("%s: fork failed\n", s);
    4bf0:	85ca                	mv	a1,s2
    4bf2:	00005517          	auipc	a0,0x5
    4bf6:	e5e50513          	addi	a0,a0,-418 # 9a50 <malloc+0x9cc>
    4bfa:	00004097          	auipc	ra,0x4
    4bfe:	3cc080e7          	jalr	972(ra) # 8fc6 <printf>
      exit(1);
    4c02:	4505                	li	a0,1
    4c04:	00004097          	auipc	ra,0x4
    4c08:	01a080e7          	jalr	26(ra) # 8c1e <exit>
      exit(0);
    4c0c:	00004097          	auipc	ra,0x4
    4c10:	012080e7          	jalr	18(ra) # 8c1e <exit>
        printf("%s: fork failed\n", s);
    4c14:	85ca                	mv	a1,s2
    4c16:	00005517          	auipc	a0,0x5
    4c1a:	e3a50513          	addi	a0,a0,-454 # 9a50 <malloc+0x9cc>
    4c1e:	00004097          	auipc	ra,0x4
    4c22:	3a8080e7          	jalr	936(ra) # 8fc6 <printf>
        exit(1);
    4c26:	4505                	li	a0,1
    4c28:	00004097          	auipc	ra,0x4
    4c2c:	ff6080e7          	jalr	-10(ra) # 8c1e <exit>
        exit(0);
    4c30:	00004097          	auipc	ra,0x4
    4c34:	fee080e7          	jalr	-18(ra) # 8c1e <exit>

0000000000004c38 <forkfork>:
{
    4c38:	7179                	addi	sp,sp,-48
    4c3a:	f406                	sd	ra,40(sp)
    4c3c:	f022                	sd	s0,32(sp)
    4c3e:	ec26                	sd	s1,24(sp)
    4c40:	1800                	addi	s0,sp,48
    4c42:	84aa                	mv	s1,a0
    int pid = fork();
    4c44:	00004097          	auipc	ra,0x4
    4c48:	fd2080e7          	jalr	-46(ra) # 8c16 <fork>
    if(pid < 0){
    4c4c:	04054163          	bltz	a0,4c8e <forkfork+0x56>
    if(pid == 0){
    4c50:	cd29                	beqz	a0,4caa <forkfork+0x72>
    int pid = fork();
    4c52:	00004097          	auipc	ra,0x4
    4c56:	fc4080e7          	jalr	-60(ra) # 8c16 <fork>
    if(pid < 0){
    4c5a:	02054a63          	bltz	a0,4c8e <forkfork+0x56>
    if(pid == 0){
    4c5e:	c531                	beqz	a0,4caa <forkfork+0x72>
    wait(&xstatus);
    4c60:	fdc40513          	addi	a0,s0,-36
    4c64:	00004097          	auipc	ra,0x4
    4c68:	fc2080e7          	jalr	-62(ra) # 8c26 <wait>
    if(xstatus != 0) {
    4c6c:	fdc42783          	lw	a5,-36(s0)
    4c70:	ebbd                	bnez	a5,4ce6 <forkfork+0xae>
    wait(&xstatus);
    4c72:	fdc40513          	addi	a0,s0,-36
    4c76:	00004097          	auipc	ra,0x4
    4c7a:	fb0080e7          	jalr	-80(ra) # 8c26 <wait>
    if(xstatus != 0) {
    4c7e:	fdc42783          	lw	a5,-36(s0)
    4c82:	e3b5                	bnez	a5,4ce6 <forkfork+0xae>
}
    4c84:	70a2                	ld	ra,40(sp)
    4c86:	7402                	ld	s0,32(sp)
    4c88:	64e2                	ld	s1,24(sp)
    4c8a:	6145                	addi	sp,sp,48
    4c8c:	8082                	ret
      printf("%s: fork failed", s);
    4c8e:	85a6                	mv	a1,s1
    4c90:	00005517          	auipc	a0,0x5
    4c94:	f8050513          	addi	a0,a0,-128 # 9c10 <malloc+0xb8c>
    4c98:	00004097          	auipc	ra,0x4
    4c9c:	32e080e7          	jalr	814(ra) # 8fc6 <printf>
      exit(1);
    4ca0:	4505                	li	a0,1
    4ca2:	00004097          	auipc	ra,0x4
    4ca6:	f7c080e7          	jalr	-132(ra) # 8c1e <exit>
{
    4caa:	0c800493          	li	s1,200
        int pid1 = fork();
    4cae:	00004097          	auipc	ra,0x4
    4cb2:	f68080e7          	jalr	-152(ra) # 8c16 <fork>
        if(pid1 < 0){
    4cb6:	00054f63          	bltz	a0,4cd4 <forkfork+0x9c>
        if(pid1 == 0){
    4cba:	c115                	beqz	a0,4cde <forkfork+0xa6>
        wait(0);
    4cbc:	4501                	li	a0,0
    4cbe:	00004097          	auipc	ra,0x4
    4cc2:	f68080e7          	jalr	-152(ra) # 8c26 <wait>
      for(int j = 0; j < 200; j++){
    4cc6:	34fd                	addiw	s1,s1,-1
    4cc8:	f0fd                	bnez	s1,4cae <forkfork+0x76>
      exit(0);
    4cca:	4501                	li	a0,0
    4ccc:	00004097          	auipc	ra,0x4
    4cd0:	f52080e7          	jalr	-174(ra) # 8c1e <exit>
          exit(1);
    4cd4:	4505                	li	a0,1
    4cd6:	00004097          	auipc	ra,0x4
    4cda:	f48080e7          	jalr	-184(ra) # 8c1e <exit>
          exit(0);
    4cde:	00004097          	auipc	ra,0x4
    4ce2:	f40080e7          	jalr	-192(ra) # 8c1e <exit>
      printf("%s: fork in child failed", s);
    4ce6:	85a6                	mv	a1,s1
    4ce8:	00005517          	auipc	a0,0x5
    4cec:	f3850513          	addi	a0,a0,-200 # 9c20 <malloc+0xb9c>
    4cf0:	00004097          	auipc	ra,0x4
    4cf4:	2d6080e7          	jalr	726(ra) # 8fc6 <printf>
      exit(1);
    4cf8:	4505                	li	a0,1
    4cfa:	00004097          	auipc	ra,0x4
    4cfe:	f24080e7          	jalr	-220(ra) # 8c1e <exit>

0000000000004d02 <reparent2>:
{
    4d02:	1101                	addi	sp,sp,-32
    4d04:	ec06                	sd	ra,24(sp)
    4d06:	e822                	sd	s0,16(sp)
    4d08:	e426                	sd	s1,8(sp)
    4d0a:	1000                	addi	s0,sp,32
    4d0c:	32000493          	li	s1,800
    int pid1 = fork();
    4d10:	00004097          	auipc	ra,0x4
    4d14:	f06080e7          	jalr	-250(ra) # 8c16 <fork>
    if(pid1 < 0){
    4d18:	00054f63          	bltz	a0,4d36 <reparent2+0x34>
    if(pid1 == 0){
    4d1c:	c915                	beqz	a0,4d50 <reparent2+0x4e>
    wait(0);
    4d1e:	4501                	li	a0,0
    4d20:	00004097          	auipc	ra,0x4
    4d24:	f06080e7          	jalr	-250(ra) # 8c26 <wait>
  for(int i = 0; i < 800; i++){
    4d28:	34fd                	addiw	s1,s1,-1
    4d2a:	f0fd                	bnez	s1,4d10 <reparent2+0xe>
  exit(0);
    4d2c:	4501                	li	a0,0
    4d2e:	00004097          	auipc	ra,0x4
    4d32:	ef0080e7          	jalr	-272(ra) # 8c1e <exit>
      printf("fork failed\n");
    4d36:	00005517          	auipc	a0,0x5
    4d3a:	12250513          	addi	a0,a0,290 # 9e58 <malloc+0xdd4>
    4d3e:	00004097          	auipc	ra,0x4
    4d42:	288080e7          	jalr	648(ra) # 8fc6 <printf>
      exit(1);
    4d46:	4505                	li	a0,1
    4d48:	00004097          	auipc	ra,0x4
    4d4c:	ed6080e7          	jalr	-298(ra) # 8c1e <exit>
      fork();
    4d50:	00004097          	auipc	ra,0x4
    4d54:	ec6080e7          	jalr	-314(ra) # 8c16 <fork>
      fork();
    4d58:	00004097          	auipc	ra,0x4
    4d5c:	ebe080e7          	jalr	-322(ra) # 8c16 <fork>
      exit(0);
    4d60:	4501                	li	a0,0
    4d62:	00004097          	auipc	ra,0x4
    4d66:	ebc080e7          	jalr	-324(ra) # 8c1e <exit>

0000000000004d6a <createdelete>:
{
    4d6a:	7175                	addi	sp,sp,-144
    4d6c:	e506                	sd	ra,136(sp)
    4d6e:	e122                	sd	s0,128(sp)
    4d70:	fca6                	sd	s1,120(sp)
    4d72:	f8ca                	sd	s2,112(sp)
    4d74:	f4ce                	sd	s3,104(sp)
    4d76:	f0d2                	sd	s4,96(sp)
    4d78:	ecd6                	sd	s5,88(sp)
    4d7a:	e8da                	sd	s6,80(sp)
    4d7c:	e4de                	sd	s7,72(sp)
    4d7e:	e0e2                	sd	s8,64(sp)
    4d80:	fc66                	sd	s9,56(sp)
    4d82:	0900                	addi	s0,sp,144
    4d84:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    4d86:	4901                	li	s2,0
    4d88:	4991                	li	s3,4
    pid = fork();
    4d8a:	00004097          	auipc	ra,0x4
    4d8e:	e8c080e7          	jalr	-372(ra) # 8c16 <fork>
    4d92:	84aa                	mv	s1,a0
    if(pid < 0){
    4d94:	02054f63          	bltz	a0,4dd2 <createdelete+0x68>
    if(pid == 0){
    4d98:	c939                	beqz	a0,4dee <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
    4d9a:	2905                	addiw	s2,s2,1
    4d9c:	ff3917e3          	bne	s2,s3,4d8a <createdelete+0x20>
    4da0:	4491                	li	s1,4
    wait(&xstatus);
    4da2:	f7c40513          	addi	a0,s0,-132
    4da6:	00004097          	auipc	ra,0x4
    4daa:	e80080e7          	jalr	-384(ra) # 8c26 <wait>
    if(xstatus != 0)
    4dae:	f7c42903          	lw	s2,-132(s0)
    4db2:	0e091263          	bnez	s2,4e96 <createdelete+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
    4db6:	34fd                	addiw	s1,s1,-1
    4db8:	f4ed                	bnez	s1,4da2 <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    4dba:	f8040123          	sb	zero,-126(s0)
    4dbe:	03000993          	li	s3,48
    4dc2:	5a7d                	li	s4,-1
    4dc4:	07000c13          	li	s8,112
      } else if((i >= 1 && i < N/2) && fd >= 0){
    4dc8:	4b21                	li	s6,8
      if((i == 0 || i >= N/2) && fd < 0){
    4dca:	4ba5                	li	s7,9
    for(pi = 0; pi < NCHILD; pi++){
    4dcc:	07400a93          	li	s5,116
    4dd0:	a29d                	j	4f36 <createdelete+0x1cc>
      printf("fork failed\n", s);
    4dd2:	85e6                	mv	a1,s9
    4dd4:	00005517          	auipc	a0,0x5
    4dd8:	08450513          	addi	a0,a0,132 # 9e58 <malloc+0xdd4>
    4ddc:	00004097          	auipc	ra,0x4
    4de0:	1ea080e7          	jalr	490(ra) # 8fc6 <printf>
      exit(1);
    4de4:	4505                	li	a0,1
    4de6:	00004097          	auipc	ra,0x4
    4dea:	e38080e7          	jalr	-456(ra) # 8c1e <exit>
      name[0] = 'p' + pi;
    4dee:	0709091b          	addiw	s2,s2,112
    4df2:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    4df6:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    4dfa:	4951                	li	s2,20
    4dfc:	a015                	j	4e20 <createdelete+0xb6>
          printf("%s: create failed\n", s);
    4dfe:	85e6                	mv	a1,s9
    4e00:	00005517          	auipc	a0,0x5
    4e04:	ce850513          	addi	a0,a0,-792 # 9ae8 <malloc+0xa64>
    4e08:	00004097          	auipc	ra,0x4
    4e0c:	1be080e7          	jalr	446(ra) # 8fc6 <printf>
          exit(1);
    4e10:	4505                	li	a0,1
    4e12:	00004097          	auipc	ra,0x4
    4e16:	e0c080e7          	jalr	-500(ra) # 8c1e <exit>
      for(i = 0; i < N; i++){
    4e1a:	2485                	addiw	s1,s1,1
    4e1c:	07248863          	beq	s1,s2,4e8c <createdelete+0x122>
        name[1] = '0' + i;
    4e20:	0304879b          	addiw	a5,s1,48
    4e24:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    4e28:	20200593          	li	a1,514
    4e2c:	f8040513          	addi	a0,s0,-128
    4e30:	00004097          	auipc	ra,0x4
    4e34:	e36080e7          	jalr	-458(ra) # 8c66 <open>
        if(fd < 0){
    4e38:	fc0543e3          	bltz	a0,4dfe <createdelete+0x94>
        close(fd);
    4e3c:	00004097          	auipc	ra,0x4
    4e40:	e12080e7          	jalr	-494(ra) # 8c4e <close>
        if(i > 0 && (i % 2 ) == 0){
    4e44:	fc905be3          	blez	s1,4e1a <createdelete+0xb0>
    4e48:	0014f793          	andi	a5,s1,1
    4e4c:	f7f9                	bnez	a5,4e1a <createdelete+0xb0>
          name[1] = '0' + (i / 2);
    4e4e:	01f4d79b          	srliw	a5,s1,0x1f
    4e52:	9fa5                	addw	a5,a5,s1
    4e54:	4017d79b          	sraiw	a5,a5,0x1
    4e58:	0307879b          	addiw	a5,a5,48
    4e5c:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    4e60:	f8040513          	addi	a0,s0,-128
    4e64:	00004097          	auipc	ra,0x4
    4e68:	e12080e7          	jalr	-494(ra) # 8c76 <unlink>
    4e6c:	fa0557e3          	bgez	a0,4e1a <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
    4e70:	85e6                	mv	a1,s9
    4e72:	00005517          	auipc	a0,0x5
    4e76:	dce50513          	addi	a0,a0,-562 # 9c40 <malloc+0xbbc>
    4e7a:	00004097          	auipc	ra,0x4
    4e7e:	14c080e7          	jalr	332(ra) # 8fc6 <printf>
            exit(1);
    4e82:	4505                	li	a0,1
    4e84:	00004097          	auipc	ra,0x4
    4e88:	d9a080e7          	jalr	-614(ra) # 8c1e <exit>
      exit(0);
    4e8c:	4501                	li	a0,0
    4e8e:	00004097          	auipc	ra,0x4
    4e92:	d90080e7          	jalr	-624(ra) # 8c1e <exit>
      exit(1);
    4e96:	4505                	li	a0,1
    4e98:	00004097          	auipc	ra,0x4
    4e9c:	d86080e7          	jalr	-634(ra) # 8c1e <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    4ea0:	f8040613          	addi	a2,s0,-128
    4ea4:	85e6                	mv	a1,s9
    4ea6:	00005517          	auipc	a0,0x5
    4eaa:	db250513          	addi	a0,a0,-590 # 9c58 <malloc+0xbd4>
    4eae:	00004097          	auipc	ra,0x4
    4eb2:	118080e7          	jalr	280(ra) # 8fc6 <printf>
        exit(1);
    4eb6:	4505                	li	a0,1
    4eb8:	00004097          	auipc	ra,0x4
    4ebc:	d66080e7          	jalr	-666(ra) # 8c1e <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    4ec0:	054b7163          	bgeu	s6,s4,4f02 <createdelete+0x198>
      if(fd >= 0)
    4ec4:	02055a63          	bgez	a0,4ef8 <createdelete+0x18e>
    for(pi = 0; pi < NCHILD; pi++){
    4ec8:	2485                	addiw	s1,s1,1
    4eca:	0ff4f493          	andi	s1,s1,255
    4ece:	05548c63          	beq	s1,s5,4f26 <createdelete+0x1bc>
      name[0] = 'p' + pi;
    4ed2:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    4ed6:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    4eda:	4581                	li	a1,0
    4edc:	f8040513          	addi	a0,s0,-128
    4ee0:	00004097          	auipc	ra,0x4
    4ee4:	d86080e7          	jalr	-634(ra) # 8c66 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    4ee8:	00090463          	beqz	s2,4ef0 <createdelete+0x186>
    4eec:	fd2bdae3          	bge	s7,s2,4ec0 <createdelete+0x156>
    4ef0:	fa0548e3          	bltz	a0,4ea0 <createdelete+0x136>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    4ef4:	014b7963          	bgeu	s6,s4,4f06 <createdelete+0x19c>
        close(fd);
    4ef8:	00004097          	auipc	ra,0x4
    4efc:	d56080e7          	jalr	-682(ra) # 8c4e <close>
    4f00:	b7e1                	j	4ec8 <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    4f02:	fc0543e3          	bltz	a0,4ec8 <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    4f06:	f8040613          	addi	a2,s0,-128
    4f0a:	85e6                	mv	a1,s9
    4f0c:	00005517          	auipc	a0,0x5
    4f10:	d7450513          	addi	a0,a0,-652 # 9c80 <malloc+0xbfc>
    4f14:	00004097          	auipc	ra,0x4
    4f18:	0b2080e7          	jalr	178(ra) # 8fc6 <printf>
        exit(1);
    4f1c:	4505                	li	a0,1
    4f1e:	00004097          	auipc	ra,0x4
    4f22:	d00080e7          	jalr	-768(ra) # 8c1e <exit>
  for(i = 0; i < N; i++){
    4f26:	2905                	addiw	s2,s2,1
    4f28:	2a05                	addiw	s4,s4,1
    4f2a:	2985                	addiw	s3,s3,1
    4f2c:	0ff9f993          	andi	s3,s3,255
    4f30:	47d1                	li	a5,20
    4f32:	02f90a63          	beq	s2,a5,4f66 <createdelete+0x1fc>
    for(pi = 0; pi < NCHILD; pi++){
    4f36:	84e2                	mv	s1,s8
    4f38:	bf69                	j	4ed2 <createdelete+0x168>
  for(i = 0; i < N; i++){
    4f3a:	2905                	addiw	s2,s2,1
    4f3c:	0ff97913          	andi	s2,s2,255
    4f40:	2985                	addiw	s3,s3,1
    4f42:	0ff9f993          	andi	s3,s3,255
    4f46:	03490863          	beq	s2,s4,4f76 <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
    4f4a:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    4f4c:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    4f50:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    4f54:	f8040513          	addi	a0,s0,-128
    4f58:	00004097          	auipc	ra,0x4
    4f5c:	d1e080e7          	jalr	-738(ra) # 8c76 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    4f60:	34fd                	addiw	s1,s1,-1
    4f62:	f4ed                	bnez	s1,4f4c <createdelete+0x1e2>
    4f64:	bfd9                	j	4f3a <createdelete+0x1d0>
    4f66:	03000993          	li	s3,48
    4f6a:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    4f6e:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
    4f70:	08400a13          	li	s4,132
    4f74:	bfd9                	j	4f4a <createdelete+0x1e0>
}
    4f76:	60aa                	ld	ra,136(sp)
    4f78:	640a                	ld	s0,128(sp)
    4f7a:	74e6                	ld	s1,120(sp)
    4f7c:	7946                	ld	s2,112(sp)
    4f7e:	79a6                	ld	s3,104(sp)
    4f80:	7a06                	ld	s4,96(sp)
    4f82:	6ae6                	ld	s5,88(sp)
    4f84:	6b46                	ld	s6,80(sp)
    4f86:	6ba6                	ld	s7,72(sp)
    4f88:	6c06                	ld	s8,64(sp)
    4f8a:	7ce2                	ld	s9,56(sp)
    4f8c:	6149                	addi	sp,sp,144
    4f8e:	8082                	ret

0000000000004f90 <linkunlink>:
{
    4f90:	711d                	addi	sp,sp,-96
    4f92:	ec86                	sd	ra,88(sp)
    4f94:	e8a2                	sd	s0,80(sp)
    4f96:	e4a6                	sd	s1,72(sp)
    4f98:	e0ca                	sd	s2,64(sp)
    4f9a:	fc4e                	sd	s3,56(sp)
    4f9c:	f852                	sd	s4,48(sp)
    4f9e:	f456                	sd	s5,40(sp)
    4fa0:	f05a                	sd	s6,32(sp)
    4fa2:	ec5e                	sd	s7,24(sp)
    4fa4:	e862                	sd	s8,16(sp)
    4fa6:	e466                	sd	s9,8(sp)
    4fa8:	1080                	addi	s0,sp,96
    4faa:	84aa                	mv	s1,a0
  unlink("x");
    4fac:	00004517          	auipc	a0,0x4
    4fb0:	28c50513          	addi	a0,a0,652 # 9238 <malloc+0x1b4>
    4fb4:	00004097          	auipc	ra,0x4
    4fb8:	cc2080e7          	jalr	-830(ra) # 8c76 <unlink>
  pid = fork();
    4fbc:	00004097          	auipc	ra,0x4
    4fc0:	c5a080e7          	jalr	-934(ra) # 8c16 <fork>
  if(pid < 0){
    4fc4:	02054b63          	bltz	a0,4ffa <linkunlink+0x6a>
    4fc8:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    4fca:	4c85                	li	s9,1
    4fcc:	e119                	bnez	a0,4fd2 <linkunlink+0x42>
    4fce:	06100c93          	li	s9,97
    4fd2:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    4fd6:	41c659b7          	lui	s3,0x41c65
    4fda:	e6d9899b          	addiw	s3,s3,-403
    4fde:	690d                	lui	s2,0x3
    4fe0:	0399091b          	addiw	s2,s2,57
    if((x % 3) == 0){
    4fe4:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    4fe6:	4b05                	li	s6,1
      unlink("x");
    4fe8:	00004a97          	auipc	s5,0x4
    4fec:	250a8a93          	addi	s5,s5,592 # 9238 <malloc+0x1b4>
      link("cat", "x");
    4ff0:	00005b97          	auipc	s7,0x5
    4ff4:	cb8b8b93          	addi	s7,s7,-840 # 9ca8 <malloc+0xc24>
    4ff8:	a825                	j	5030 <linkunlink+0xa0>
    printf("%s: fork failed\n", s);
    4ffa:	85a6                	mv	a1,s1
    4ffc:	00005517          	auipc	a0,0x5
    5000:	a5450513          	addi	a0,a0,-1452 # 9a50 <malloc+0x9cc>
    5004:	00004097          	auipc	ra,0x4
    5008:	fc2080e7          	jalr	-62(ra) # 8fc6 <printf>
    exit(1);
    500c:	4505                	li	a0,1
    500e:	00004097          	auipc	ra,0x4
    5012:	c10080e7          	jalr	-1008(ra) # 8c1e <exit>
      close(open("x", O_RDWR | O_CREATE));
    5016:	20200593          	li	a1,514
    501a:	8556                	mv	a0,s5
    501c:	00004097          	auipc	ra,0x4
    5020:	c4a080e7          	jalr	-950(ra) # 8c66 <open>
    5024:	00004097          	auipc	ra,0x4
    5028:	c2a080e7          	jalr	-982(ra) # 8c4e <close>
  for(i = 0; i < 100; i++){
    502c:	34fd                	addiw	s1,s1,-1
    502e:	c88d                	beqz	s1,5060 <linkunlink+0xd0>
    x = x * 1103515245 + 12345;
    5030:	033c87bb          	mulw	a5,s9,s3
    5034:	012787bb          	addw	a5,a5,s2
    5038:	00078c9b          	sext.w	s9,a5
    if((x % 3) == 0){
    503c:	0347f7bb          	remuw	a5,a5,s4
    5040:	dbf9                	beqz	a5,5016 <linkunlink+0x86>
    } else if((x % 3) == 1){
    5042:	01678863          	beq	a5,s6,5052 <linkunlink+0xc2>
      unlink("x");
    5046:	8556                	mv	a0,s5
    5048:	00004097          	auipc	ra,0x4
    504c:	c2e080e7          	jalr	-978(ra) # 8c76 <unlink>
    5050:	bff1                	j	502c <linkunlink+0x9c>
      link("cat", "x");
    5052:	85d6                	mv	a1,s5
    5054:	855e                	mv	a0,s7
    5056:	00004097          	auipc	ra,0x4
    505a:	c30080e7          	jalr	-976(ra) # 8c86 <link>
    505e:	b7f9                	j	502c <linkunlink+0x9c>
  if(pid)
    5060:	020c0463          	beqz	s8,5088 <linkunlink+0xf8>
    wait(0);
    5064:	4501                	li	a0,0
    5066:	00004097          	auipc	ra,0x4
    506a:	bc0080e7          	jalr	-1088(ra) # 8c26 <wait>
}
    506e:	60e6                	ld	ra,88(sp)
    5070:	6446                	ld	s0,80(sp)
    5072:	64a6                	ld	s1,72(sp)
    5074:	6906                	ld	s2,64(sp)
    5076:	79e2                	ld	s3,56(sp)
    5078:	7a42                	ld	s4,48(sp)
    507a:	7aa2                	ld	s5,40(sp)
    507c:	7b02                	ld	s6,32(sp)
    507e:	6be2                	ld	s7,24(sp)
    5080:	6c42                	ld	s8,16(sp)
    5082:	6ca2                	ld	s9,8(sp)
    5084:	6125                	addi	sp,sp,96
    5086:	8082                	ret
    exit(0);
    5088:	4501                	li	a0,0
    508a:	00004097          	auipc	ra,0x4
    508e:	b94080e7          	jalr	-1132(ra) # 8c1e <exit>

0000000000005092 <forktest>:
{
    5092:	7179                	addi	sp,sp,-48
    5094:	f406                	sd	ra,40(sp)
    5096:	f022                	sd	s0,32(sp)
    5098:	ec26                	sd	s1,24(sp)
    509a:	e84a                	sd	s2,16(sp)
    509c:	e44e                	sd	s3,8(sp)
    509e:	1800                	addi	s0,sp,48
    50a0:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    50a2:	4481                	li	s1,0
    50a4:	3e800913          	li	s2,1000
    pid = fork();
    50a8:	00004097          	auipc	ra,0x4
    50ac:	b6e080e7          	jalr	-1170(ra) # 8c16 <fork>
    if(pid < 0)
    50b0:	02054863          	bltz	a0,50e0 <forktest+0x4e>
    if(pid == 0)
    50b4:	c115                	beqz	a0,50d8 <forktest+0x46>
  for(n=0; n<N; n++){
    50b6:	2485                	addiw	s1,s1,1
    50b8:	ff2498e3          	bne	s1,s2,50a8 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    50bc:	85ce                	mv	a1,s3
    50be:	00005517          	auipc	a0,0x5
    50c2:	c0a50513          	addi	a0,a0,-1014 # 9cc8 <malloc+0xc44>
    50c6:	00004097          	auipc	ra,0x4
    50ca:	f00080e7          	jalr	-256(ra) # 8fc6 <printf>
    exit(1);
    50ce:	4505                	li	a0,1
    50d0:	00004097          	auipc	ra,0x4
    50d4:	b4e080e7          	jalr	-1202(ra) # 8c1e <exit>
      exit(0);
    50d8:	00004097          	auipc	ra,0x4
    50dc:	b46080e7          	jalr	-1210(ra) # 8c1e <exit>
  if (n == 0) {
    50e0:	cc9d                	beqz	s1,511e <forktest+0x8c>
  if(n == N){
    50e2:	3e800793          	li	a5,1000
    50e6:	fcf48be3          	beq	s1,a5,50bc <forktest+0x2a>
  for(; n > 0; n--){
    50ea:	00905b63          	blez	s1,5100 <forktest+0x6e>
    if(wait(0) < 0){
    50ee:	4501                	li	a0,0
    50f0:	00004097          	auipc	ra,0x4
    50f4:	b36080e7          	jalr	-1226(ra) # 8c26 <wait>
    50f8:	04054163          	bltz	a0,513a <forktest+0xa8>
  for(; n > 0; n--){
    50fc:	34fd                	addiw	s1,s1,-1
    50fe:	f8e5                	bnez	s1,50ee <forktest+0x5c>
  if(wait(0) != -1){
    5100:	4501                	li	a0,0
    5102:	00004097          	auipc	ra,0x4
    5106:	b24080e7          	jalr	-1244(ra) # 8c26 <wait>
    510a:	57fd                	li	a5,-1
    510c:	04f51563          	bne	a0,a5,5156 <forktest+0xc4>
}
    5110:	70a2                	ld	ra,40(sp)
    5112:	7402                	ld	s0,32(sp)
    5114:	64e2                	ld	s1,24(sp)
    5116:	6942                	ld	s2,16(sp)
    5118:	69a2                	ld	s3,8(sp)
    511a:	6145                	addi	sp,sp,48
    511c:	8082                	ret
    printf("%s: no fork at all!\n", s);
    511e:	85ce                	mv	a1,s3
    5120:	00005517          	auipc	a0,0x5
    5124:	b9050513          	addi	a0,a0,-1136 # 9cb0 <malloc+0xc2c>
    5128:	00004097          	auipc	ra,0x4
    512c:	e9e080e7          	jalr	-354(ra) # 8fc6 <printf>
    exit(1);
    5130:	4505                	li	a0,1
    5132:	00004097          	auipc	ra,0x4
    5136:	aec080e7          	jalr	-1300(ra) # 8c1e <exit>
      printf("%s: wait stopped early\n", s);
    513a:	85ce                	mv	a1,s3
    513c:	00005517          	auipc	a0,0x5
    5140:	bb450513          	addi	a0,a0,-1100 # 9cf0 <malloc+0xc6c>
    5144:	00004097          	auipc	ra,0x4
    5148:	e82080e7          	jalr	-382(ra) # 8fc6 <printf>
      exit(1);
    514c:	4505                	li	a0,1
    514e:	00004097          	auipc	ra,0x4
    5152:	ad0080e7          	jalr	-1328(ra) # 8c1e <exit>
    printf("%s: wait got too many\n", s);
    5156:	85ce                	mv	a1,s3
    5158:	00005517          	auipc	a0,0x5
    515c:	bb050513          	addi	a0,a0,-1104 # 9d08 <malloc+0xc84>
    5160:	00004097          	auipc	ra,0x4
    5164:	e66080e7          	jalr	-410(ra) # 8fc6 <printf>
    exit(1);
    5168:	4505                	li	a0,1
    516a:	00004097          	auipc	ra,0x4
    516e:	ab4080e7          	jalr	-1356(ra) # 8c1e <exit>

0000000000005172 <kernmem>:
{
    5172:	715d                	addi	sp,sp,-80
    5174:	e486                	sd	ra,72(sp)
    5176:	e0a2                	sd	s0,64(sp)
    5178:	fc26                	sd	s1,56(sp)
    517a:	f84a                	sd	s2,48(sp)
    517c:	f44e                	sd	s3,40(sp)
    517e:	f052                	sd	s4,32(sp)
    5180:	ec56                	sd	s5,24(sp)
    5182:	0880                	addi	s0,sp,80
    5184:	8a2a                	mv	s4,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    5186:	4485                	li	s1,1
    5188:	04fe                	slli	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    518a:	5afd                	li	s5,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    518c:	69b1                	lui	s3,0xc
    518e:	35098993          	addi	s3,s3,848 # c350 <quicktests+0x340>
    5192:	1003d937          	lui	s2,0x1003d
    5196:	090e                	slli	s2,s2,0x3
    5198:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002a808>
    pid = fork();
    519c:	00004097          	auipc	ra,0x4
    51a0:	a7a080e7          	jalr	-1414(ra) # 8c16 <fork>
    if(pid < 0){
    51a4:	02054963          	bltz	a0,51d6 <kernmem+0x64>
    if(pid == 0){
    51a8:	c529                	beqz	a0,51f2 <kernmem+0x80>
    wait(&xstatus);
    51aa:	fbc40513          	addi	a0,s0,-68
    51ae:	00004097          	auipc	ra,0x4
    51b2:	a78080e7          	jalr	-1416(ra) # 8c26 <wait>
    if(xstatus != -1)  // did kernel kill child?
    51b6:	fbc42783          	lw	a5,-68(s0)
    51ba:	05579d63          	bne	a5,s5,5214 <kernmem+0xa2>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    51be:	94ce                	add	s1,s1,s3
    51c0:	fd249ee3          	bne	s1,s2,519c <kernmem+0x2a>
}
    51c4:	60a6                	ld	ra,72(sp)
    51c6:	6406                	ld	s0,64(sp)
    51c8:	74e2                	ld	s1,56(sp)
    51ca:	7942                	ld	s2,48(sp)
    51cc:	79a2                	ld	s3,40(sp)
    51ce:	7a02                	ld	s4,32(sp)
    51d0:	6ae2                	ld	s5,24(sp)
    51d2:	6161                	addi	sp,sp,80
    51d4:	8082                	ret
      printf("%s: fork failed\n", s);
    51d6:	85d2                	mv	a1,s4
    51d8:	00005517          	auipc	a0,0x5
    51dc:	87850513          	addi	a0,a0,-1928 # 9a50 <malloc+0x9cc>
    51e0:	00004097          	auipc	ra,0x4
    51e4:	de6080e7          	jalr	-538(ra) # 8fc6 <printf>
      exit(1);
    51e8:	4505                	li	a0,1
    51ea:	00004097          	auipc	ra,0x4
    51ee:	a34080e7          	jalr	-1484(ra) # 8c1e <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    51f2:	0004c683          	lbu	a3,0(s1)
    51f6:	8626                	mv	a2,s1
    51f8:	85d2                	mv	a1,s4
    51fa:	00005517          	auipc	a0,0x5
    51fe:	b2650513          	addi	a0,a0,-1242 # 9d20 <malloc+0xc9c>
    5202:	00004097          	auipc	ra,0x4
    5206:	dc4080e7          	jalr	-572(ra) # 8fc6 <printf>
      exit(1);
    520a:	4505                	li	a0,1
    520c:	00004097          	auipc	ra,0x4
    5210:	a12080e7          	jalr	-1518(ra) # 8c1e <exit>
      exit(1);
    5214:	4505                	li	a0,1
    5216:	00004097          	auipc	ra,0x4
    521a:	a08080e7          	jalr	-1528(ra) # 8c1e <exit>

000000000000521e <MAXVAplus>:
{
    521e:	7179                	addi	sp,sp,-48
    5220:	f406                	sd	ra,40(sp)
    5222:	f022                	sd	s0,32(sp)
    5224:	ec26                	sd	s1,24(sp)
    5226:	e84a                	sd	s2,16(sp)
    5228:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    522a:	4785                	li	a5,1
    522c:	179a                	slli	a5,a5,0x26
    522e:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    5232:	fd843783          	ld	a5,-40(s0)
    5236:	cf85                	beqz	a5,526e <MAXVAplus+0x50>
    5238:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    523a:	54fd                	li	s1,-1
    pid = fork();
    523c:	00004097          	auipc	ra,0x4
    5240:	9da080e7          	jalr	-1574(ra) # 8c16 <fork>
    if(pid < 0){
    5244:	02054b63          	bltz	a0,527a <MAXVAplus+0x5c>
    if(pid == 0){
    5248:	c539                	beqz	a0,5296 <MAXVAplus+0x78>
    wait(&xstatus);
    524a:	fd440513          	addi	a0,s0,-44
    524e:	00004097          	auipc	ra,0x4
    5252:	9d8080e7          	jalr	-1576(ra) # 8c26 <wait>
    if(xstatus != -1)  // did kernel kill child?
    5256:	fd442783          	lw	a5,-44(s0)
    525a:	06979463          	bne	a5,s1,52c2 <MAXVAplus+0xa4>
  for( ; a != 0; a <<= 1){
    525e:	fd843783          	ld	a5,-40(s0)
    5262:	0786                	slli	a5,a5,0x1
    5264:	fcf43c23          	sd	a5,-40(s0)
    5268:	fd843783          	ld	a5,-40(s0)
    526c:	fbe1                	bnez	a5,523c <MAXVAplus+0x1e>
}
    526e:	70a2                	ld	ra,40(sp)
    5270:	7402                	ld	s0,32(sp)
    5272:	64e2                	ld	s1,24(sp)
    5274:	6942                	ld	s2,16(sp)
    5276:	6145                	addi	sp,sp,48
    5278:	8082                	ret
      printf("%s: fork failed\n", s);
    527a:	85ca                	mv	a1,s2
    527c:	00004517          	auipc	a0,0x4
    5280:	7d450513          	addi	a0,a0,2004 # 9a50 <malloc+0x9cc>
    5284:	00004097          	auipc	ra,0x4
    5288:	d42080e7          	jalr	-702(ra) # 8fc6 <printf>
      exit(1);
    528c:	4505                	li	a0,1
    528e:	00004097          	auipc	ra,0x4
    5292:	990080e7          	jalr	-1648(ra) # 8c1e <exit>
      *(char*)a = 99;
    5296:	fd843783          	ld	a5,-40(s0)
    529a:	06300713          	li	a4,99
    529e:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %x\n", s, a);
    52a2:	fd843603          	ld	a2,-40(s0)
    52a6:	85ca                	mv	a1,s2
    52a8:	00005517          	auipc	a0,0x5
    52ac:	a9850513          	addi	a0,a0,-1384 # 9d40 <malloc+0xcbc>
    52b0:	00004097          	auipc	ra,0x4
    52b4:	d16080e7          	jalr	-746(ra) # 8fc6 <printf>
      exit(1);
    52b8:	4505                	li	a0,1
    52ba:	00004097          	auipc	ra,0x4
    52be:	964080e7          	jalr	-1692(ra) # 8c1e <exit>
      exit(1);
    52c2:	4505                	li	a0,1
    52c4:	00004097          	auipc	ra,0x4
    52c8:	95a080e7          	jalr	-1702(ra) # 8c1e <exit>

00000000000052cc <bigargtest>:
{
    52cc:	7179                	addi	sp,sp,-48
    52ce:	f406                	sd	ra,40(sp)
    52d0:	f022                	sd	s0,32(sp)
    52d2:	ec26                	sd	s1,24(sp)
    52d4:	1800                	addi	s0,sp,48
    52d6:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    52d8:	00005517          	auipc	a0,0x5
    52dc:	a8050513          	addi	a0,a0,-1408 # 9d58 <malloc+0xcd4>
    52e0:	00004097          	auipc	ra,0x4
    52e4:	996080e7          	jalr	-1642(ra) # 8c76 <unlink>
  pid = fork();
    52e8:	00004097          	auipc	ra,0x4
    52ec:	92e080e7          	jalr	-1746(ra) # 8c16 <fork>
  if(pid == 0){
    52f0:	c121                	beqz	a0,5330 <bigargtest+0x64>
  } else if(pid < 0){
    52f2:	0a054063          	bltz	a0,5392 <bigargtest+0xc6>
  wait(&xstatus);
    52f6:	fdc40513          	addi	a0,s0,-36
    52fa:	00004097          	auipc	ra,0x4
    52fe:	92c080e7          	jalr	-1748(ra) # 8c26 <wait>
  if(xstatus != 0)
    5302:	fdc42503          	lw	a0,-36(s0)
    5306:	e545                	bnez	a0,53ae <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    5308:	4581                	li	a1,0
    530a:	00005517          	auipc	a0,0x5
    530e:	a4e50513          	addi	a0,a0,-1458 # 9d58 <malloc+0xcd4>
    5312:	00004097          	auipc	ra,0x4
    5316:	954080e7          	jalr	-1708(ra) # 8c66 <open>
  if(fd < 0){
    531a:	08054e63          	bltz	a0,53b6 <bigargtest+0xea>
  close(fd);
    531e:	00004097          	auipc	ra,0x4
    5322:	930080e7          	jalr	-1744(ra) # 8c4e <close>
}
    5326:	70a2                	ld	ra,40(sp)
    5328:	7402                	ld	s0,32(sp)
    532a:	64e2                	ld	s1,24(sp)
    532c:	6145                	addi	sp,sp,48
    532e:	8082                	ret
    5330:	00007797          	auipc	a5,0x7
    5334:	13078793          	addi	a5,a5,304 # c460 <args.1>
    5338:	00007697          	auipc	a3,0x7
    533c:	22068693          	addi	a3,a3,544 # c558 <args.1+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    5340:	00005717          	auipc	a4,0x5
    5344:	a2870713          	addi	a4,a4,-1496 # 9d68 <malloc+0xce4>
    5348:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    534a:	07a1                	addi	a5,a5,8
    534c:	fed79ee3          	bne	a5,a3,5348 <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    5350:	00007597          	auipc	a1,0x7
    5354:	11058593          	addi	a1,a1,272 # c460 <args.1>
    5358:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    535c:	00004517          	auipc	a0,0x4
    5360:	e6c50513          	addi	a0,a0,-404 # 91c8 <malloc+0x144>
    5364:	00004097          	auipc	ra,0x4
    5368:	8fa080e7          	jalr	-1798(ra) # 8c5e <exec>
    fd = open("bigarg-ok", O_CREATE);
    536c:	20000593          	li	a1,512
    5370:	00005517          	auipc	a0,0x5
    5374:	9e850513          	addi	a0,a0,-1560 # 9d58 <malloc+0xcd4>
    5378:	00004097          	auipc	ra,0x4
    537c:	8ee080e7          	jalr	-1810(ra) # 8c66 <open>
    close(fd);
    5380:	00004097          	auipc	ra,0x4
    5384:	8ce080e7          	jalr	-1842(ra) # 8c4e <close>
    exit(0);
    5388:	4501                	li	a0,0
    538a:	00004097          	auipc	ra,0x4
    538e:	894080e7          	jalr	-1900(ra) # 8c1e <exit>
    printf("%s: bigargtest: fork failed\n", s);
    5392:	85a6                	mv	a1,s1
    5394:	00005517          	auipc	a0,0x5
    5398:	ab450513          	addi	a0,a0,-1356 # 9e48 <malloc+0xdc4>
    539c:	00004097          	auipc	ra,0x4
    53a0:	c2a080e7          	jalr	-982(ra) # 8fc6 <printf>
    exit(1);
    53a4:	4505                	li	a0,1
    53a6:	00004097          	auipc	ra,0x4
    53aa:	878080e7          	jalr	-1928(ra) # 8c1e <exit>
    exit(xstatus);
    53ae:	00004097          	auipc	ra,0x4
    53b2:	870080e7          	jalr	-1936(ra) # 8c1e <exit>
    printf("%s: bigarg test failed!\n", s);
    53b6:	85a6                	mv	a1,s1
    53b8:	00005517          	auipc	a0,0x5
    53bc:	ab050513          	addi	a0,a0,-1360 # 9e68 <malloc+0xde4>
    53c0:	00004097          	auipc	ra,0x4
    53c4:	c06080e7          	jalr	-1018(ra) # 8fc6 <printf>
    exit(1);
    53c8:	4505                	li	a0,1
    53ca:	00004097          	auipc	ra,0x4
    53ce:	854080e7          	jalr	-1964(ra) # 8c1e <exit>

00000000000053d2 <stacktest>:
{
    53d2:	7179                	addi	sp,sp,-48
    53d4:	f406                	sd	ra,40(sp)
    53d6:	f022                	sd	s0,32(sp)
    53d8:	ec26                	sd	s1,24(sp)
    53da:	1800                	addi	s0,sp,48
    53dc:	84aa                	mv	s1,a0
  pid = fork();
    53de:	00004097          	auipc	ra,0x4
    53e2:	838080e7          	jalr	-1992(ra) # 8c16 <fork>
  if(pid == 0) {
    53e6:	c115                	beqz	a0,540a <stacktest+0x38>
  } else if(pid < 0){
    53e8:	04054463          	bltz	a0,5430 <stacktest+0x5e>
  wait(&xstatus);
    53ec:	fdc40513          	addi	a0,s0,-36
    53f0:	00004097          	auipc	ra,0x4
    53f4:	836080e7          	jalr	-1994(ra) # 8c26 <wait>
  if(xstatus == -1)  // kernel killed child?
    53f8:	fdc42503          	lw	a0,-36(s0)
    53fc:	57fd                	li	a5,-1
    53fe:	04f50763          	beq	a0,a5,544c <stacktest+0x7a>
    exit(xstatus);
    5402:	00004097          	auipc	ra,0x4
    5406:	81c080e7          	jalr	-2020(ra) # 8c1e <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    540a:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    540c:	77fd                	lui	a5,0xfffff
    540e:	97ba                	add	a5,a5,a4
    5410:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffec388>
    5414:	85a6                	mv	a1,s1
    5416:	00005517          	auipc	a0,0x5
    541a:	a7250513          	addi	a0,a0,-1422 # 9e88 <malloc+0xe04>
    541e:	00004097          	auipc	ra,0x4
    5422:	ba8080e7          	jalr	-1112(ra) # 8fc6 <printf>
    exit(1);
    5426:	4505                	li	a0,1
    5428:	00003097          	auipc	ra,0x3
    542c:	7f6080e7          	jalr	2038(ra) # 8c1e <exit>
    printf("%s: fork failed\n", s);
    5430:	85a6                	mv	a1,s1
    5432:	00004517          	auipc	a0,0x4
    5436:	61e50513          	addi	a0,a0,1566 # 9a50 <malloc+0x9cc>
    543a:	00004097          	auipc	ra,0x4
    543e:	b8c080e7          	jalr	-1140(ra) # 8fc6 <printf>
    exit(1);
    5442:	4505                	li	a0,1
    5444:	00003097          	auipc	ra,0x3
    5448:	7da080e7          	jalr	2010(ra) # 8c1e <exit>
    exit(0);
    544c:	4501                	li	a0,0
    544e:	00003097          	auipc	ra,0x3
    5452:	7d0080e7          	jalr	2000(ra) # 8c1e <exit>

0000000000005456 <textwrite>:
{
    5456:	7179                	addi	sp,sp,-48
    5458:	f406                	sd	ra,40(sp)
    545a:	f022                	sd	s0,32(sp)
    545c:	ec26                	sd	s1,24(sp)
    545e:	1800                	addi	s0,sp,48
    5460:	84aa                	mv	s1,a0
  pid = fork();
    5462:	00003097          	auipc	ra,0x3
    5466:	7b4080e7          	jalr	1972(ra) # 8c16 <fork>
  if(pid == 0) {
    546a:	c115                	beqz	a0,548e <textwrite+0x38>
  } else if(pid < 0){
    546c:	02054963          	bltz	a0,549e <textwrite+0x48>
  wait(&xstatus);
    5470:	fdc40513          	addi	a0,s0,-36
    5474:	00003097          	auipc	ra,0x3
    5478:	7b2080e7          	jalr	1970(ra) # 8c26 <wait>
  if(xstatus == -1)  // kernel killed child?
    547c:	fdc42503          	lw	a0,-36(s0)
    5480:	57fd                	li	a5,-1
    5482:	02f50c63          	beq	a0,a5,54ba <textwrite+0x64>
    exit(xstatus);
    5486:	00003097          	auipc	ra,0x3
    548a:	798080e7          	jalr	1944(ra) # 8c1e <exit>
    *addr = 10;
    548e:	47a9                	li	a5,10
    5490:	00f02023          	sw	a5,0(zero) # 0 <copyinstr1-0x3000>
    exit(1);
    5494:	4505                	li	a0,1
    5496:	00003097          	auipc	ra,0x3
    549a:	788080e7          	jalr	1928(ra) # 8c1e <exit>
    printf("%s: fork failed\n", s);
    549e:	85a6                	mv	a1,s1
    54a0:	00004517          	auipc	a0,0x4
    54a4:	5b050513          	addi	a0,a0,1456 # 9a50 <malloc+0x9cc>
    54a8:	00004097          	auipc	ra,0x4
    54ac:	b1e080e7          	jalr	-1250(ra) # 8fc6 <printf>
    exit(1);
    54b0:	4505                	li	a0,1
    54b2:	00003097          	auipc	ra,0x3
    54b6:	76c080e7          	jalr	1900(ra) # 8c1e <exit>
    exit(0);
    54ba:	4501                	li	a0,0
    54bc:	00003097          	auipc	ra,0x3
    54c0:	762080e7          	jalr	1890(ra) # 8c1e <exit>

00000000000054c4 <manywrites>:
{
    54c4:	711d                	addi	sp,sp,-96
    54c6:	ec86                	sd	ra,88(sp)
    54c8:	e8a2                	sd	s0,80(sp)
    54ca:	e4a6                	sd	s1,72(sp)
    54cc:	e0ca                	sd	s2,64(sp)
    54ce:	fc4e                	sd	s3,56(sp)
    54d0:	f852                	sd	s4,48(sp)
    54d2:	f456                	sd	s5,40(sp)
    54d4:	f05a                	sd	s6,32(sp)
    54d6:	ec5e                	sd	s7,24(sp)
    54d8:	1080                	addi	s0,sp,96
    54da:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    54dc:	4981                	li	s3,0
    54de:	4911                	li	s2,4
    int pid = fork();
    54e0:	00003097          	auipc	ra,0x3
    54e4:	736080e7          	jalr	1846(ra) # 8c16 <fork>
    54e8:	84aa                	mv	s1,a0
    if(pid < 0){
    54ea:	02054963          	bltz	a0,551c <manywrites+0x58>
    if(pid == 0){
    54ee:	c521                	beqz	a0,5536 <manywrites+0x72>
  for(int ci = 0; ci < nchildren; ci++){
    54f0:	2985                	addiw	s3,s3,1
    54f2:	ff2997e3          	bne	s3,s2,54e0 <manywrites+0x1c>
    54f6:	4491                	li	s1,4
    int st = 0;
    54f8:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    54fc:	fa840513          	addi	a0,s0,-88
    5500:	00003097          	auipc	ra,0x3
    5504:	726080e7          	jalr	1830(ra) # 8c26 <wait>
    if(st != 0)
    5508:	fa842503          	lw	a0,-88(s0)
    550c:	ed6d                	bnez	a0,5606 <manywrites+0x142>
  for(int ci = 0; ci < nchildren; ci++){
    550e:	34fd                	addiw	s1,s1,-1
    5510:	f4e5                	bnez	s1,54f8 <manywrites+0x34>
  exit(0);
    5512:	4501                	li	a0,0
    5514:	00003097          	auipc	ra,0x3
    5518:	70a080e7          	jalr	1802(ra) # 8c1e <exit>
      printf("fork failed\n");
    551c:	00005517          	auipc	a0,0x5
    5520:	93c50513          	addi	a0,a0,-1732 # 9e58 <malloc+0xdd4>
    5524:	00004097          	auipc	ra,0x4
    5528:	aa2080e7          	jalr	-1374(ra) # 8fc6 <printf>
      exit(1);
    552c:	4505                	li	a0,1
    552e:	00003097          	auipc	ra,0x3
    5532:	6f0080e7          	jalr	1776(ra) # 8c1e <exit>
      name[0] = 'b';
    5536:	06200793          	li	a5,98
    553a:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    553e:	0619879b          	addiw	a5,s3,97
    5542:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    5546:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    554a:	fa840513          	addi	a0,s0,-88
    554e:	00003097          	auipc	ra,0x3
    5552:	728080e7          	jalr	1832(ra) # 8c76 <unlink>
    5556:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    5558:	0000ab17          	auipc	s6,0xa
    555c:	720b0b13          	addi	s6,s6,1824 # fc78 <buf>
        for(int i = 0; i < ci+1; i++){
    5560:	8a26                	mv	s4,s1
    5562:	0209ce63          	bltz	s3,559e <manywrites+0xda>
          int fd = open(name, O_CREATE | O_RDWR);
    5566:	20200593          	li	a1,514
    556a:	fa840513          	addi	a0,s0,-88
    556e:	00003097          	auipc	ra,0x3
    5572:	6f8080e7          	jalr	1784(ra) # 8c66 <open>
    5576:	892a                	mv	s2,a0
          if(fd < 0){
    5578:	04054763          	bltz	a0,55c6 <manywrites+0x102>
          int cc = write(fd, buf, sz);
    557c:	660d                	lui	a2,0x3
    557e:	85da                	mv	a1,s6
    5580:	00003097          	auipc	ra,0x3
    5584:	6c6080e7          	jalr	1734(ra) # 8c46 <write>
          if(cc != sz){
    5588:	678d                	lui	a5,0x3
    558a:	04f51e63          	bne	a0,a5,55e6 <manywrites+0x122>
          close(fd);
    558e:	854a                	mv	a0,s2
    5590:	00003097          	auipc	ra,0x3
    5594:	6be080e7          	jalr	1726(ra) # 8c4e <close>
        for(int i = 0; i < ci+1; i++){
    5598:	2a05                	addiw	s4,s4,1
    559a:	fd49d6e3          	bge	s3,s4,5566 <manywrites+0xa2>
        unlink(name);
    559e:	fa840513          	addi	a0,s0,-88
    55a2:	00003097          	auipc	ra,0x3
    55a6:	6d4080e7          	jalr	1748(ra) # 8c76 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    55aa:	3bfd                	addiw	s7,s7,-1
    55ac:	fa0b9ae3          	bnez	s7,5560 <manywrites+0x9c>
      unlink(name);
    55b0:	fa840513          	addi	a0,s0,-88
    55b4:	00003097          	auipc	ra,0x3
    55b8:	6c2080e7          	jalr	1730(ra) # 8c76 <unlink>
      exit(0);
    55bc:	4501                	li	a0,0
    55be:	00003097          	auipc	ra,0x3
    55c2:	660080e7          	jalr	1632(ra) # 8c1e <exit>
            printf("%s: cannot create %s\n", s, name);
    55c6:	fa840613          	addi	a2,s0,-88
    55ca:	85d6                	mv	a1,s5
    55cc:	00005517          	auipc	a0,0x5
    55d0:	8e450513          	addi	a0,a0,-1820 # 9eb0 <malloc+0xe2c>
    55d4:	00004097          	auipc	ra,0x4
    55d8:	9f2080e7          	jalr	-1550(ra) # 8fc6 <printf>
            exit(1);
    55dc:	4505                	li	a0,1
    55de:	00003097          	auipc	ra,0x3
    55e2:	640080e7          	jalr	1600(ra) # 8c1e <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    55e6:	86aa                	mv	a3,a0
    55e8:	660d                	lui	a2,0x3
    55ea:	85d6                	mv	a1,s5
    55ec:	00004517          	auipc	a0,0x4
    55f0:	cac50513          	addi	a0,a0,-852 # 9298 <malloc+0x214>
    55f4:	00004097          	auipc	ra,0x4
    55f8:	9d2080e7          	jalr	-1582(ra) # 8fc6 <printf>
            exit(1);
    55fc:	4505                	li	a0,1
    55fe:	00003097          	auipc	ra,0x3
    5602:	620080e7          	jalr	1568(ra) # 8c1e <exit>
      exit(st);
    5606:	00003097          	auipc	ra,0x3
    560a:	618080e7          	jalr	1560(ra) # 8c1e <exit>

000000000000560e <copyinstr3>:
{
    560e:	7179                	addi	sp,sp,-48
    5610:	f406                	sd	ra,40(sp)
    5612:	f022                	sd	s0,32(sp)
    5614:	ec26                	sd	s1,24(sp)
    5616:	1800                	addi	s0,sp,48
  sbrk(8192);
    5618:	6509                	lui	a0,0x2
    561a:	00003097          	auipc	ra,0x3
    561e:	694080e7          	jalr	1684(ra) # 8cae <sbrk>
  uint64 top = (uint64) sbrk(0);
    5622:	4501                	li	a0,0
    5624:	00003097          	auipc	ra,0x3
    5628:	68a080e7          	jalr	1674(ra) # 8cae <sbrk>
  if((top % PGSIZE) != 0){
    562c:	03451793          	slli	a5,a0,0x34
    5630:	e3c9                	bnez	a5,56b2 <copyinstr3+0xa4>
  top = (uint64) sbrk(0);
    5632:	4501                	li	a0,0
    5634:	00003097          	auipc	ra,0x3
    5638:	67a080e7          	jalr	1658(ra) # 8cae <sbrk>
  if(top % PGSIZE){
    563c:	03451793          	slli	a5,a0,0x34
    5640:	e3d9                	bnez	a5,56c6 <copyinstr3+0xb8>
  char *b = (char *) (top - 1);
    5642:	fff50493          	addi	s1,a0,-1 # 1fff <copyinstr1-0x1001>
  *b = 'x';
    5646:	07800793          	li	a5,120
    564a:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    564e:	8526                	mv	a0,s1
    5650:	00003097          	auipc	ra,0x3
    5654:	626080e7          	jalr	1574(ra) # 8c76 <unlink>
  if(ret != -1){
    5658:	57fd                	li	a5,-1
    565a:	08f51363          	bne	a0,a5,56e0 <copyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    565e:	20100593          	li	a1,513
    5662:	8526                	mv	a0,s1
    5664:	00003097          	auipc	ra,0x3
    5668:	602080e7          	jalr	1538(ra) # 8c66 <open>
  if(fd != -1){
    566c:	57fd                	li	a5,-1
    566e:	08f51863          	bne	a0,a5,56fe <copyinstr3+0xf0>
  ret = link(b, b);
    5672:	85a6                	mv	a1,s1
    5674:	8526                	mv	a0,s1
    5676:	00003097          	auipc	ra,0x3
    567a:	610080e7          	jalr	1552(ra) # 8c86 <link>
  if(ret != -1){
    567e:	57fd                	li	a5,-1
    5680:	08f51e63          	bne	a0,a5,571c <copyinstr3+0x10e>
  char *args[] = { "xx", 0 };
    5684:	00005797          	auipc	a5,0x5
    5688:	52478793          	addi	a5,a5,1316 # aba8 <malloc+0x1b24>
    568c:	fcf43823          	sd	a5,-48(s0)
    5690:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    5694:	fd040593          	addi	a1,s0,-48
    5698:	8526                	mv	a0,s1
    569a:	00003097          	auipc	ra,0x3
    569e:	5c4080e7          	jalr	1476(ra) # 8c5e <exec>
  if(ret != -1){
    56a2:	57fd                	li	a5,-1
    56a4:	08f51c63          	bne	a0,a5,573c <copyinstr3+0x12e>
}
    56a8:	70a2                	ld	ra,40(sp)
    56aa:	7402                	ld	s0,32(sp)
    56ac:	64e2                	ld	s1,24(sp)
    56ae:	6145                	addi	sp,sp,48
    56b0:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    56b2:	0347d513          	srli	a0,a5,0x34
    56b6:	6785                	lui	a5,0x1
    56b8:	40a7853b          	subw	a0,a5,a0
    56bc:	00003097          	auipc	ra,0x3
    56c0:	5f2080e7          	jalr	1522(ra) # 8cae <sbrk>
    56c4:	b7bd                	j	5632 <copyinstr3+0x24>
    printf("oops\n");
    56c6:	00005517          	auipc	a0,0x5
    56ca:	80250513          	addi	a0,a0,-2046 # 9ec8 <malloc+0xe44>
    56ce:	00004097          	auipc	ra,0x4
    56d2:	8f8080e7          	jalr	-1800(ra) # 8fc6 <printf>
    exit(1);
    56d6:	4505                	li	a0,1
    56d8:	00003097          	auipc	ra,0x3
    56dc:	546080e7          	jalr	1350(ra) # 8c1e <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    56e0:	862a                	mv	a2,a0
    56e2:	85a6                	mv	a1,s1
    56e4:	00004517          	auipc	a0,0x4
    56e8:	28c50513          	addi	a0,a0,652 # 9970 <malloc+0x8ec>
    56ec:	00004097          	auipc	ra,0x4
    56f0:	8da080e7          	jalr	-1830(ra) # 8fc6 <printf>
    exit(1);
    56f4:	4505                	li	a0,1
    56f6:	00003097          	auipc	ra,0x3
    56fa:	528080e7          	jalr	1320(ra) # 8c1e <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    56fe:	862a                	mv	a2,a0
    5700:	85a6                	mv	a1,s1
    5702:	00004517          	auipc	a0,0x4
    5706:	28e50513          	addi	a0,a0,654 # 9990 <malloc+0x90c>
    570a:	00004097          	auipc	ra,0x4
    570e:	8bc080e7          	jalr	-1860(ra) # 8fc6 <printf>
    exit(1);
    5712:	4505                	li	a0,1
    5714:	00003097          	auipc	ra,0x3
    5718:	50a080e7          	jalr	1290(ra) # 8c1e <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    571c:	86aa                	mv	a3,a0
    571e:	8626                	mv	a2,s1
    5720:	85a6                	mv	a1,s1
    5722:	00004517          	auipc	a0,0x4
    5726:	28e50513          	addi	a0,a0,654 # 99b0 <malloc+0x92c>
    572a:	00004097          	auipc	ra,0x4
    572e:	89c080e7          	jalr	-1892(ra) # 8fc6 <printf>
    exit(1);
    5732:	4505                	li	a0,1
    5734:	00003097          	auipc	ra,0x3
    5738:	4ea080e7          	jalr	1258(ra) # 8c1e <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    573c:	567d                	li	a2,-1
    573e:	85a6                	mv	a1,s1
    5740:	00004517          	auipc	a0,0x4
    5744:	29850513          	addi	a0,a0,664 # 99d8 <malloc+0x954>
    5748:	00004097          	auipc	ra,0x4
    574c:	87e080e7          	jalr	-1922(ra) # 8fc6 <printf>
    exit(1);
    5750:	4505                	li	a0,1
    5752:	00003097          	auipc	ra,0x3
    5756:	4cc080e7          	jalr	1228(ra) # 8c1e <exit>

000000000000575a <rwsbrk>:
{
    575a:	1101                	addi	sp,sp,-32
    575c:	ec06                	sd	ra,24(sp)
    575e:	e822                	sd	s0,16(sp)
    5760:	e426                	sd	s1,8(sp)
    5762:	e04a                	sd	s2,0(sp)
    5764:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    5766:	6509                	lui	a0,0x2
    5768:	00003097          	auipc	ra,0x3
    576c:	546080e7          	jalr	1350(ra) # 8cae <sbrk>
  if(a == 0xffffffffffffffffLL) {
    5770:	57fd                	li	a5,-1
    5772:	06f50363          	beq	a0,a5,57d8 <rwsbrk+0x7e>
    5776:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    5778:	7579                	lui	a0,0xffffe
    577a:	00003097          	auipc	ra,0x3
    577e:	534080e7          	jalr	1332(ra) # 8cae <sbrk>
    5782:	57fd                	li	a5,-1
    5784:	06f50763          	beq	a0,a5,57f2 <rwsbrk+0x98>
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    5788:	20100593          	li	a1,513
    578c:	00004517          	auipc	a0,0x4
    5790:	77c50513          	addi	a0,a0,1916 # 9f08 <malloc+0xe84>
    5794:	00003097          	auipc	ra,0x3
    5798:	4d2080e7          	jalr	1234(ra) # 8c66 <open>
    579c:	892a                	mv	s2,a0
  if(fd < 0){
    579e:	06054763          	bltz	a0,580c <rwsbrk+0xb2>
  n = write(fd, (void*)(a+4096), 1024);
    57a2:	6505                	lui	a0,0x1
    57a4:	94aa                	add	s1,s1,a0
    57a6:	40000613          	li	a2,1024
    57aa:	85a6                	mv	a1,s1
    57ac:	854a                	mv	a0,s2
    57ae:	00003097          	auipc	ra,0x3
    57b2:	498080e7          	jalr	1176(ra) # 8c46 <write>
    57b6:	862a                	mv	a2,a0
  if(n >= 0){
    57b8:	06054763          	bltz	a0,5826 <rwsbrk+0xcc>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    57bc:	85a6                	mv	a1,s1
    57be:	00004517          	auipc	a0,0x4
    57c2:	76a50513          	addi	a0,a0,1898 # 9f28 <malloc+0xea4>
    57c6:	00004097          	auipc	ra,0x4
    57ca:	800080e7          	jalr	-2048(ra) # 8fc6 <printf>
    exit(1);
    57ce:	4505                	li	a0,1
    57d0:	00003097          	auipc	ra,0x3
    57d4:	44e080e7          	jalr	1102(ra) # 8c1e <exit>
    printf("sbrk(rwsbrk) failed\n");
    57d8:	00004517          	auipc	a0,0x4
    57dc:	6f850513          	addi	a0,a0,1784 # 9ed0 <malloc+0xe4c>
    57e0:	00003097          	auipc	ra,0x3
    57e4:	7e6080e7          	jalr	2022(ra) # 8fc6 <printf>
    exit(1);
    57e8:	4505                	li	a0,1
    57ea:	00003097          	auipc	ra,0x3
    57ee:	434080e7          	jalr	1076(ra) # 8c1e <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    57f2:	00004517          	auipc	a0,0x4
    57f6:	6f650513          	addi	a0,a0,1782 # 9ee8 <malloc+0xe64>
    57fa:	00003097          	auipc	ra,0x3
    57fe:	7cc080e7          	jalr	1996(ra) # 8fc6 <printf>
    exit(1);
    5802:	4505                	li	a0,1
    5804:	00003097          	auipc	ra,0x3
    5808:	41a080e7          	jalr	1050(ra) # 8c1e <exit>
    printf("open(rwsbrk) failed\n");
    580c:	00004517          	auipc	a0,0x4
    5810:	70450513          	addi	a0,a0,1796 # 9f10 <malloc+0xe8c>
    5814:	00003097          	auipc	ra,0x3
    5818:	7b2080e7          	jalr	1970(ra) # 8fc6 <printf>
    exit(1);
    581c:	4505                	li	a0,1
    581e:	00003097          	auipc	ra,0x3
    5822:	400080e7          	jalr	1024(ra) # 8c1e <exit>
  close(fd);
    5826:	854a                	mv	a0,s2
    5828:	00003097          	auipc	ra,0x3
    582c:	426080e7          	jalr	1062(ra) # 8c4e <close>
  unlink("rwsbrk");
    5830:	00004517          	auipc	a0,0x4
    5834:	6d850513          	addi	a0,a0,1752 # 9f08 <malloc+0xe84>
    5838:	00003097          	auipc	ra,0x3
    583c:	43e080e7          	jalr	1086(ra) # 8c76 <unlink>
  fd = open("README", O_RDONLY);
    5840:	4581                	li	a1,0
    5842:	00004517          	auipc	a0,0x4
    5846:	b5e50513          	addi	a0,a0,-1186 # 93a0 <malloc+0x31c>
    584a:	00003097          	auipc	ra,0x3
    584e:	41c080e7          	jalr	1052(ra) # 8c66 <open>
    5852:	892a                	mv	s2,a0
  if(fd < 0){
    5854:	02054963          	bltz	a0,5886 <rwsbrk+0x12c>
  n = read(fd, (void*)(a+4096), 10);
    5858:	4629                	li	a2,10
    585a:	85a6                	mv	a1,s1
    585c:	00003097          	auipc	ra,0x3
    5860:	3e2080e7          	jalr	994(ra) # 8c3e <read>
    5864:	862a                	mv	a2,a0
  if(n >= 0){
    5866:	02054d63          	bltz	a0,58a0 <rwsbrk+0x146>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    586a:	85a6                	mv	a1,s1
    586c:	00004517          	auipc	a0,0x4
    5870:	6ec50513          	addi	a0,a0,1772 # 9f58 <malloc+0xed4>
    5874:	00003097          	auipc	ra,0x3
    5878:	752080e7          	jalr	1874(ra) # 8fc6 <printf>
    exit(1);
    587c:	4505                	li	a0,1
    587e:	00003097          	auipc	ra,0x3
    5882:	3a0080e7          	jalr	928(ra) # 8c1e <exit>
    printf("open(rwsbrk) failed\n");
    5886:	00004517          	auipc	a0,0x4
    588a:	68a50513          	addi	a0,a0,1674 # 9f10 <malloc+0xe8c>
    588e:	00003097          	auipc	ra,0x3
    5892:	738080e7          	jalr	1848(ra) # 8fc6 <printf>
    exit(1);
    5896:	4505                	li	a0,1
    5898:	00003097          	auipc	ra,0x3
    589c:	386080e7          	jalr	902(ra) # 8c1e <exit>
  close(fd);
    58a0:	854a                	mv	a0,s2
    58a2:	00003097          	auipc	ra,0x3
    58a6:	3ac080e7          	jalr	940(ra) # 8c4e <close>
  exit(0);
    58aa:	4501                	li	a0,0
    58ac:	00003097          	auipc	ra,0x3
    58b0:	372080e7          	jalr	882(ra) # 8c1e <exit>

00000000000058b4 <sbrkbasic>:
{
    58b4:	7139                	addi	sp,sp,-64
    58b6:	fc06                	sd	ra,56(sp)
    58b8:	f822                	sd	s0,48(sp)
    58ba:	f426                	sd	s1,40(sp)
    58bc:	f04a                	sd	s2,32(sp)
    58be:	ec4e                	sd	s3,24(sp)
    58c0:	e852                	sd	s4,16(sp)
    58c2:	0080                	addi	s0,sp,64
    58c4:	8a2a                	mv	s4,a0
  pid = fork();
    58c6:	00003097          	auipc	ra,0x3
    58ca:	350080e7          	jalr	848(ra) # 8c16 <fork>
  if(pid < 0){
    58ce:	02054c63          	bltz	a0,5906 <sbrkbasic+0x52>
  if(pid == 0){
    58d2:	ed21                	bnez	a0,592a <sbrkbasic+0x76>
    a = sbrk(TOOMUCH);
    58d4:	40000537          	lui	a0,0x40000
    58d8:	00003097          	auipc	ra,0x3
    58dc:	3d6080e7          	jalr	982(ra) # 8cae <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    58e0:	57fd                	li	a5,-1
    58e2:	02f50f63          	beq	a0,a5,5920 <sbrkbasic+0x6c>
    for(b = a; b < a+TOOMUCH; b += 4096){
    58e6:	400007b7          	lui	a5,0x40000
    58ea:	97aa                	add	a5,a5,a0
      *b = 99;
    58ec:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    58f0:	6705                	lui	a4,0x1
      *b = 99;
    58f2:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3ffed388>
    for(b = a; b < a+TOOMUCH; b += 4096){
    58f6:	953a                	add	a0,a0,a4
    58f8:	fef51de3          	bne	a0,a5,58f2 <sbrkbasic+0x3e>
    exit(1);
    58fc:	4505                	li	a0,1
    58fe:	00003097          	auipc	ra,0x3
    5902:	320080e7          	jalr	800(ra) # 8c1e <exit>
    printf("fork failed in sbrkbasic\n");
    5906:	00004517          	auipc	a0,0x4
    590a:	67a50513          	addi	a0,a0,1658 # 9f80 <malloc+0xefc>
    590e:	00003097          	auipc	ra,0x3
    5912:	6b8080e7          	jalr	1720(ra) # 8fc6 <printf>
    exit(1);
    5916:	4505                	li	a0,1
    5918:	00003097          	auipc	ra,0x3
    591c:	306080e7          	jalr	774(ra) # 8c1e <exit>
      exit(0);
    5920:	4501                	li	a0,0
    5922:	00003097          	auipc	ra,0x3
    5926:	2fc080e7          	jalr	764(ra) # 8c1e <exit>
  wait(&xstatus);
    592a:	fcc40513          	addi	a0,s0,-52
    592e:	00003097          	auipc	ra,0x3
    5932:	2f8080e7          	jalr	760(ra) # 8c26 <wait>
  if(xstatus == 1){
    5936:	fcc42703          	lw	a4,-52(s0)
    593a:	4785                	li	a5,1
    593c:	00f70d63          	beq	a4,a5,5956 <sbrkbasic+0xa2>
  a = sbrk(0);
    5940:	4501                	li	a0,0
    5942:	00003097          	auipc	ra,0x3
    5946:	36c080e7          	jalr	876(ra) # 8cae <sbrk>
    594a:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    594c:	4901                	li	s2,0
    594e:	6985                	lui	s3,0x1
    5950:	38898993          	addi	s3,s3,904 # 1388 <copyinstr1-0x1c78>
    5954:	a005                	j	5974 <sbrkbasic+0xc0>
    printf("%s: too much memory allocated!\n", s);
    5956:	85d2                	mv	a1,s4
    5958:	00004517          	auipc	a0,0x4
    595c:	64850513          	addi	a0,a0,1608 # 9fa0 <malloc+0xf1c>
    5960:	00003097          	auipc	ra,0x3
    5964:	666080e7          	jalr	1638(ra) # 8fc6 <printf>
    exit(1);
    5968:	4505                	li	a0,1
    596a:	00003097          	auipc	ra,0x3
    596e:	2b4080e7          	jalr	692(ra) # 8c1e <exit>
    a = b + 1;
    5972:	84be                	mv	s1,a5
    b = sbrk(1);
    5974:	4505                	li	a0,1
    5976:	00003097          	auipc	ra,0x3
    597a:	338080e7          	jalr	824(ra) # 8cae <sbrk>
    if(b != a){
    597e:	04951c63          	bne	a0,s1,59d6 <sbrkbasic+0x122>
    *b = 1;
    5982:	4785                	li	a5,1
    5984:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    5988:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    598c:	2905                	addiw	s2,s2,1
    598e:	ff3912e3          	bne	s2,s3,5972 <sbrkbasic+0xbe>
  pid = fork();
    5992:	00003097          	auipc	ra,0x3
    5996:	284080e7          	jalr	644(ra) # 8c16 <fork>
    599a:	892a                	mv	s2,a0
  if(pid < 0){
    599c:	04054e63          	bltz	a0,59f8 <sbrkbasic+0x144>
  c = sbrk(1);
    59a0:	4505                	li	a0,1
    59a2:	00003097          	auipc	ra,0x3
    59a6:	30c080e7          	jalr	780(ra) # 8cae <sbrk>
  c = sbrk(1);
    59aa:	4505                	li	a0,1
    59ac:	00003097          	auipc	ra,0x3
    59b0:	302080e7          	jalr	770(ra) # 8cae <sbrk>
  if(c != a + 1){
    59b4:	0489                	addi	s1,s1,2
    59b6:	04a48f63          	beq	s1,a0,5a14 <sbrkbasic+0x160>
    printf("%s: sbrk test failed post-fork\n", s);
    59ba:	85d2                	mv	a1,s4
    59bc:	00004517          	auipc	a0,0x4
    59c0:	64450513          	addi	a0,a0,1604 # a000 <malloc+0xf7c>
    59c4:	00003097          	auipc	ra,0x3
    59c8:	602080e7          	jalr	1538(ra) # 8fc6 <printf>
    exit(1);
    59cc:	4505                	li	a0,1
    59ce:	00003097          	auipc	ra,0x3
    59d2:	250080e7          	jalr	592(ra) # 8c1e <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    59d6:	872a                	mv	a4,a0
    59d8:	86a6                	mv	a3,s1
    59da:	864a                	mv	a2,s2
    59dc:	85d2                	mv	a1,s4
    59de:	00004517          	auipc	a0,0x4
    59e2:	5e250513          	addi	a0,a0,1506 # 9fc0 <malloc+0xf3c>
    59e6:	00003097          	auipc	ra,0x3
    59ea:	5e0080e7          	jalr	1504(ra) # 8fc6 <printf>
      exit(1);
    59ee:	4505                	li	a0,1
    59f0:	00003097          	auipc	ra,0x3
    59f4:	22e080e7          	jalr	558(ra) # 8c1e <exit>
    printf("%s: sbrk test fork failed\n", s);
    59f8:	85d2                	mv	a1,s4
    59fa:	00004517          	auipc	a0,0x4
    59fe:	5e650513          	addi	a0,a0,1510 # 9fe0 <malloc+0xf5c>
    5a02:	00003097          	auipc	ra,0x3
    5a06:	5c4080e7          	jalr	1476(ra) # 8fc6 <printf>
    exit(1);
    5a0a:	4505                	li	a0,1
    5a0c:	00003097          	auipc	ra,0x3
    5a10:	212080e7          	jalr	530(ra) # 8c1e <exit>
  if(pid == 0)
    5a14:	00091763          	bnez	s2,5a22 <sbrkbasic+0x16e>
    exit(0);
    5a18:	4501                	li	a0,0
    5a1a:	00003097          	auipc	ra,0x3
    5a1e:	204080e7          	jalr	516(ra) # 8c1e <exit>
  wait(&xstatus);
    5a22:	fcc40513          	addi	a0,s0,-52
    5a26:	00003097          	auipc	ra,0x3
    5a2a:	200080e7          	jalr	512(ra) # 8c26 <wait>
  exit(xstatus);
    5a2e:	fcc42503          	lw	a0,-52(s0)
    5a32:	00003097          	auipc	ra,0x3
    5a36:	1ec080e7          	jalr	492(ra) # 8c1e <exit>

0000000000005a3a <sbrkmuch>:
{
    5a3a:	7179                	addi	sp,sp,-48
    5a3c:	f406                	sd	ra,40(sp)
    5a3e:	f022                	sd	s0,32(sp)
    5a40:	ec26                	sd	s1,24(sp)
    5a42:	e84a                	sd	s2,16(sp)
    5a44:	e44e                	sd	s3,8(sp)
    5a46:	e052                	sd	s4,0(sp)
    5a48:	1800                	addi	s0,sp,48
    5a4a:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    5a4c:	4501                	li	a0,0
    5a4e:	00003097          	auipc	ra,0x3
    5a52:	260080e7          	jalr	608(ra) # 8cae <sbrk>
    5a56:	892a                	mv	s2,a0
  a = sbrk(0);
    5a58:	4501                	li	a0,0
    5a5a:	00003097          	auipc	ra,0x3
    5a5e:	254080e7          	jalr	596(ra) # 8cae <sbrk>
    5a62:	84aa                	mv	s1,a0
  p = sbrk(amt);
    5a64:	06400537          	lui	a0,0x6400
    5a68:	9d05                	subw	a0,a0,s1
    5a6a:	00003097          	auipc	ra,0x3
    5a6e:	244080e7          	jalr	580(ra) # 8cae <sbrk>
  if (p != a) {
    5a72:	0ca49863          	bne	s1,a0,5b42 <sbrkmuch+0x108>
  char *eee = sbrk(0);
    5a76:	4501                	li	a0,0
    5a78:	00003097          	auipc	ra,0x3
    5a7c:	236080e7          	jalr	566(ra) # 8cae <sbrk>
    5a80:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    5a82:	00a4f963          	bgeu	s1,a0,5a94 <sbrkmuch+0x5a>
    *pp = 1;
    5a86:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    5a88:	6705                	lui	a4,0x1
    *pp = 1;
    5a8a:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    5a8e:	94ba                	add	s1,s1,a4
    5a90:	fef4ede3          	bltu	s1,a5,5a8a <sbrkmuch+0x50>
  *lastaddr = 99;
    5a94:	064007b7          	lui	a5,0x6400
    5a98:	06300713          	li	a4,99
    5a9c:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63ed387>
  a = sbrk(0);
    5aa0:	4501                	li	a0,0
    5aa2:	00003097          	auipc	ra,0x3
    5aa6:	20c080e7          	jalr	524(ra) # 8cae <sbrk>
    5aaa:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    5aac:	757d                	lui	a0,0xfffff
    5aae:	00003097          	auipc	ra,0x3
    5ab2:	200080e7          	jalr	512(ra) # 8cae <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    5ab6:	57fd                	li	a5,-1
    5ab8:	0af50363          	beq	a0,a5,5b5e <sbrkmuch+0x124>
  c = sbrk(0);
    5abc:	4501                	li	a0,0
    5abe:	00003097          	auipc	ra,0x3
    5ac2:	1f0080e7          	jalr	496(ra) # 8cae <sbrk>
  if(c != a - PGSIZE){
    5ac6:	77fd                	lui	a5,0xfffff
    5ac8:	97a6                	add	a5,a5,s1
    5aca:	0af51863          	bne	a0,a5,5b7a <sbrkmuch+0x140>
  a = sbrk(0);
    5ace:	4501                	li	a0,0
    5ad0:	00003097          	auipc	ra,0x3
    5ad4:	1de080e7          	jalr	478(ra) # 8cae <sbrk>
    5ad8:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    5ada:	6505                	lui	a0,0x1
    5adc:	00003097          	auipc	ra,0x3
    5ae0:	1d2080e7          	jalr	466(ra) # 8cae <sbrk>
    5ae4:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    5ae6:	0aa49a63          	bne	s1,a0,5b9a <sbrkmuch+0x160>
    5aea:	4501                	li	a0,0
    5aec:	00003097          	auipc	ra,0x3
    5af0:	1c2080e7          	jalr	450(ra) # 8cae <sbrk>
    5af4:	6785                	lui	a5,0x1
    5af6:	97a6                	add	a5,a5,s1
    5af8:	0af51163          	bne	a0,a5,5b9a <sbrkmuch+0x160>
  if(*lastaddr == 99){
    5afc:	064007b7          	lui	a5,0x6400
    5b00:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63ed387>
    5b04:	06300793          	li	a5,99
    5b08:	0af70963          	beq	a4,a5,5bba <sbrkmuch+0x180>
  a = sbrk(0);
    5b0c:	4501                	li	a0,0
    5b0e:	00003097          	auipc	ra,0x3
    5b12:	1a0080e7          	jalr	416(ra) # 8cae <sbrk>
    5b16:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    5b18:	4501                	li	a0,0
    5b1a:	00003097          	auipc	ra,0x3
    5b1e:	194080e7          	jalr	404(ra) # 8cae <sbrk>
    5b22:	40a9053b          	subw	a0,s2,a0
    5b26:	00003097          	auipc	ra,0x3
    5b2a:	188080e7          	jalr	392(ra) # 8cae <sbrk>
  if(c != a){
    5b2e:	0aa49463          	bne	s1,a0,5bd6 <sbrkmuch+0x19c>
}
    5b32:	70a2                	ld	ra,40(sp)
    5b34:	7402                	ld	s0,32(sp)
    5b36:	64e2                	ld	s1,24(sp)
    5b38:	6942                	ld	s2,16(sp)
    5b3a:	69a2                	ld	s3,8(sp)
    5b3c:	6a02                	ld	s4,0(sp)
    5b3e:	6145                	addi	sp,sp,48
    5b40:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    5b42:	85ce                	mv	a1,s3
    5b44:	00004517          	auipc	a0,0x4
    5b48:	4dc50513          	addi	a0,a0,1244 # a020 <malloc+0xf9c>
    5b4c:	00003097          	auipc	ra,0x3
    5b50:	47a080e7          	jalr	1146(ra) # 8fc6 <printf>
    exit(1);
    5b54:	4505                	li	a0,1
    5b56:	00003097          	auipc	ra,0x3
    5b5a:	0c8080e7          	jalr	200(ra) # 8c1e <exit>
    printf("%s: sbrk could not deallocate\n", s);
    5b5e:	85ce                	mv	a1,s3
    5b60:	00004517          	auipc	a0,0x4
    5b64:	50850513          	addi	a0,a0,1288 # a068 <malloc+0xfe4>
    5b68:	00003097          	auipc	ra,0x3
    5b6c:	45e080e7          	jalr	1118(ra) # 8fc6 <printf>
    exit(1);
    5b70:	4505                	li	a0,1
    5b72:	00003097          	auipc	ra,0x3
    5b76:	0ac080e7          	jalr	172(ra) # 8c1e <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    5b7a:	86aa                	mv	a3,a0
    5b7c:	8626                	mv	a2,s1
    5b7e:	85ce                	mv	a1,s3
    5b80:	00004517          	auipc	a0,0x4
    5b84:	50850513          	addi	a0,a0,1288 # a088 <malloc+0x1004>
    5b88:	00003097          	auipc	ra,0x3
    5b8c:	43e080e7          	jalr	1086(ra) # 8fc6 <printf>
    exit(1);
    5b90:	4505                	li	a0,1
    5b92:	00003097          	auipc	ra,0x3
    5b96:	08c080e7          	jalr	140(ra) # 8c1e <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    5b9a:	86d2                	mv	a3,s4
    5b9c:	8626                	mv	a2,s1
    5b9e:	85ce                	mv	a1,s3
    5ba0:	00004517          	auipc	a0,0x4
    5ba4:	52850513          	addi	a0,a0,1320 # a0c8 <malloc+0x1044>
    5ba8:	00003097          	auipc	ra,0x3
    5bac:	41e080e7          	jalr	1054(ra) # 8fc6 <printf>
    exit(1);
    5bb0:	4505                	li	a0,1
    5bb2:	00003097          	auipc	ra,0x3
    5bb6:	06c080e7          	jalr	108(ra) # 8c1e <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    5bba:	85ce                	mv	a1,s3
    5bbc:	00004517          	auipc	a0,0x4
    5bc0:	53c50513          	addi	a0,a0,1340 # a0f8 <malloc+0x1074>
    5bc4:	00003097          	auipc	ra,0x3
    5bc8:	402080e7          	jalr	1026(ra) # 8fc6 <printf>
    exit(1);
    5bcc:	4505                	li	a0,1
    5bce:	00003097          	auipc	ra,0x3
    5bd2:	050080e7          	jalr	80(ra) # 8c1e <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    5bd6:	86aa                	mv	a3,a0
    5bd8:	8626                	mv	a2,s1
    5bda:	85ce                	mv	a1,s3
    5bdc:	00004517          	auipc	a0,0x4
    5be0:	55450513          	addi	a0,a0,1364 # a130 <malloc+0x10ac>
    5be4:	00003097          	auipc	ra,0x3
    5be8:	3e2080e7          	jalr	994(ra) # 8fc6 <printf>
    exit(1);
    5bec:	4505                	li	a0,1
    5bee:	00003097          	auipc	ra,0x3
    5bf2:	030080e7          	jalr	48(ra) # 8c1e <exit>

0000000000005bf6 <sbrkarg>:
{
    5bf6:	7179                	addi	sp,sp,-48
    5bf8:	f406                	sd	ra,40(sp)
    5bfa:	f022                	sd	s0,32(sp)
    5bfc:	ec26                	sd	s1,24(sp)
    5bfe:	e84a                	sd	s2,16(sp)
    5c00:	e44e                	sd	s3,8(sp)
    5c02:	1800                	addi	s0,sp,48
    5c04:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    5c06:	6505                	lui	a0,0x1
    5c08:	00003097          	auipc	ra,0x3
    5c0c:	0a6080e7          	jalr	166(ra) # 8cae <sbrk>
    5c10:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    5c12:	20100593          	li	a1,513
    5c16:	00004517          	auipc	a0,0x4
    5c1a:	54250513          	addi	a0,a0,1346 # a158 <malloc+0x10d4>
    5c1e:	00003097          	auipc	ra,0x3
    5c22:	048080e7          	jalr	72(ra) # 8c66 <open>
    5c26:	84aa                	mv	s1,a0
  unlink("sbrk");
    5c28:	00004517          	auipc	a0,0x4
    5c2c:	53050513          	addi	a0,a0,1328 # a158 <malloc+0x10d4>
    5c30:	00003097          	auipc	ra,0x3
    5c34:	046080e7          	jalr	70(ra) # 8c76 <unlink>
  if(fd < 0)  {
    5c38:	0404c163          	bltz	s1,5c7a <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    5c3c:	6605                	lui	a2,0x1
    5c3e:	85ca                	mv	a1,s2
    5c40:	8526                	mv	a0,s1
    5c42:	00003097          	auipc	ra,0x3
    5c46:	004080e7          	jalr	4(ra) # 8c46 <write>
    5c4a:	04054663          	bltz	a0,5c96 <sbrkarg+0xa0>
  close(fd);
    5c4e:	8526                	mv	a0,s1
    5c50:	00003097          	auipc	ra,0x3
    5c54:	ffe080e7          	jalr	-2(ra) # 8c4e <close>
  a = sbrk(PGSIZE);
    5c58:	6505                	lui	a0,0x1
    5c5a:	00003097          	auipc	ra,0x3
    5c5e:	054080e7          	jalr	84(ra) # 8cae <sbrk>
  if(pipe((int *) a) != 0){
    5c62:	00003097          	auipc	ra,0x3
    5c66:	fd4080e7          	jalr	-44(ra) # 8c36 <pipe>
    5c6a:	e521                	bnez	a0,5cb2 <sbrkarg+0xbc>
}
    5c6c:	70a2                	ld	ra,40(sp)
    5c6e:	7402                	ld	s0,32(sp)
    5c70:	64e2                	ld	s1,24(sp)
    5c72:	6942                	ld	s2,16(sp)
    5c74:	69a2                	ld	s3,8(sp)
    5c76:	6145                	addi	sp,sp,48
    5c78:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    5c7a:	85ce                	mv	a1,s3
    5c7c:	00004517          	auipc	a0,0x4
    5c80:	4e450513          	addi	a0,a0,1252 # a160 <malloc+0x10dc>
    5c84:	00003097          	auipc	ra,0x3
    5c88:	342080e7          	jalr	834(ra) # 8fc6 <printf>
    exit(1);
    5c8c:	4505                	li	a0,1
    5c8e:	00003097          	auipc	ra,0x3
    5c92:	f90080e7          	jalr	-112(ra) # 8c1e <exit>
    printf("%s: write sbrk failed\n", s);
    5c96:	85ce                	mv	a1,s3
    5c98:	00004517          	auipc	a0,0x4
    5c9c:	4e050513          	addi	a0,a0,1248 # a178 <malloc+0x10f4>
    5ca0:	00003097          	auipc	ra,0x3
    5ca4:	326080e7          	jalr	806(ra) # 8fc6 <printf>
    exit(1);
    5ca8:	4505                	li	a0,1
    5caa:	00003097          	auipc	ra,0x3
    5cae:	f74080e7          	jalr	-140(ra) # 8c1e <exit>
    printf("%s: pipe() failed\n", s);
    5cb2:	85ce                	mv	a1,s3
    5cb4:	00004517          	auipc	a0,0x4
    5cb8:	ea450513          	addi	a0,a0,-348 # 9b58 <malloc+0xad4>
    5cbc:	00003097          	auipc	ra,0x3
    5cc0:	30a080e7          	jalr	778(ra) # 8fc6 <printf>
    exit(1);
    5cc4:	4505                	li	a0,1
    5cc6:	00003097          	auipc	ra,0x3
    5cca:	f58080e7          	jalr	-168(ra) # 8c1e <exit>

0000000000005cce <argptest>:
{
    5cce:	1101                	addi	sp,sp,-32
    5cd0:	ec06                	sd	ra,24(sp)
    5cd2:	e822                	sd	s0,16(sp)
    5cd4:	e426                	sd	s1,8(sp)
    5cd6:	e04a                	sd	s2,0(sp)
    5cd8:	1000                	addi	s0,sp,32
    5cda:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    5cdc:	4581                	li	a1,0
    5cde:	00004517          	auipc	a0,0x4
    5ce2:	4b250513          	addi	a0,a0,1202 # a190 <malloc+0x110c>
    5ce6:	00003097          	auipc	ra,0x3
    5cea:	f80080e7          	jalr	-128(ra) # 8c66 <open>
  if (fd < 0) {
    5cee:	02054b63          	bltz	a0,5d24 <argptest+0x56>
    5cf2:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    5cf4:	4501                	li	a0,0
    5cf6:	00003097          	auipc	ra,0x3
    5cfa:	fb8080e7          	jalr	-72(ra) # 8cae <sbrk>
    5cfe:	567d                	li	a2,-1
    5d00:	fff50593          	addi	a1,a0,-1
    5d04:	8526                	mv	a0,s1
    5d06:	00003097          	auipc	ra,0x3
    5d0a:	f38080e7          	jalr	-200(ra) # 8c3e <read>
  close(fd);
    5d0e:	8526                	mv	a0,s1
    5d10:	00003097          	auipc	ra,0x3
    5d14:	f3e080e7          	jalr	-194(ra) # 8c4e <close>
}
    5d18:	60e2                	ld	ra,24(sp)
    5d1a:	6442                	ld	s0,16(sp)
    5d1c:	64a2                	ld	s1,8(sp)
    5d1e:	6902                	ld	s2,0(sp)
    5d20:	6105                	addi	sp,sp,32
    5d22:	8082                	ret
    printf("%s: open failed\n", s);
    5d24:	85ca                	mv	a1,s2
    5d26:	00004517          	auipc	a0,0x4
    5d2a:	d4250513          	addi	a0,a0,-702 # 9a68 <malloc+0x9e4>
    5d2e:	00003097          	auipc	ra,0x3
    5d32:	298080e7          	jalr	664(ra) # 8fc6 <printf>
    exit(1);
    5d36:	4505                	li	a0,1
    5d38:	00003097          	auipc	ra,0x3
    5d3c:	ee6080e7          	jalr	-282(ra) # 8c1e <exit>

0000000000005d40 <sbrkbugs>:
{
    5d40:	1141                	addi	sp,sp,-16
    5d42:	e406                	sd	ra,8(sp)
    5d44:	e022                	sd	s0,0(sp)
    5d46:	0800                	addi	s0,sp,16
  int pid = fork();
    5d48:	00003097          	auipc	ra,0x3
    5d4c:	ece080e7          	jalr	-306(ra) # 8c16 <fork>
  if(pid < 0){
    5d50:	02054263          	bltz	a0,5d74 <sbrkbugs+0x34>
  if(pid == 0){
    5d54:	ed0d                	bnez	a0,5d8e <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    5d56:	00003097          	auipc	ra,0x3
    5d5a:	f58080e7          	jalr	-168(ra) # 8cae <sbrk>
    sbrk(-sz);
    5d5e:	40a0053b          	negw	a0,a0
    5d62:	00003097          	auipc	ra,0x3
    5d66:	f4c080e7          	jalr	-180(ra) # 8cae <sbrk>
    exit(0);
    5d6a:	4501                	li	a0,0
    5d6c:	00003097          	auipc	ra,0x3
    5d70:	eb2080e7          	jalr	-334(ra) # 8c1e <exit>
    printf("fork failed\n");
    5d74:	00004517          	auipc	a0,0x4
    5d78:	0e450513          	addi	a0,a0,228 # 9e58 <malloc+0xdd4>
    5d7c:	00003097          	auipc	ra,0x3
    5d80:	24a080e7          	jalr	586(ra) # 8fc6 <printf>
    exit(1);
    5d84:	4505                	li	a0,1
    5d86:	00003097          	auipc	ra,0x3
    5d8a:	e98080e7          	jalr	-360(ra) # 8c1e <exit>
  wait(0);
    5d8e:	4501                	li	a0,0
    5d90:	00003097          	auipc	ra,0x3
    5d94:	e96080e7          	jalr	-362(ra) # 8c26 <wait>
  pid = fork();
    5d98:	00003097          	auipc	ra,0x3
    5d9c:	e7e080e7          	jalr	-386(ra) # 8c16 <fork>
  if(pid < 0){
    5da0:	02054563          	bltz	a0,5dca <sbrkbugs+0x8a>
  if(pid == 0){
    5da4:	e121                	bnez	a0,5de4 <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    5da6:	00003097          	auipc	ra,0x3
    5daa:	f08080e7          	jalr	-248(ra) # 8cae <sbrk>
    sbrk(-(sz - 3500));
    5dae:	6785                	lui	a5,0x1
    5db0:	dac7879b          	addiw	a5,a5,-596
    5db4:	40a7853b          	subw	a0,a5,a0
    5db8:	00003097          	auipc	ra,0x3
    5dbc:	ef6080e7          	jalr	-266(ra) # 8cae <sbrk>
    exit(0);
    5dc0:	4501                	li	a0,0
    5dc2:	00003097          	auipc	ra,0x3
    5dc6:	e5c080e7          	jalr	-420(ra) # 8c1e <exit>
    printf("fork failed\n");
    5dca:	00004517          	auipc	a0,0x4
    5dce:	08e50513          	addi	a0,a0,142 # 9e58 <malloc+0xdd4>
    5dd2:	00003097          	auipc	ra,0x3
    5dd6:	1f4080e7          	jalr	500(ra) # 8fc6 <printf>
    exit(1);
    5dda:	4505                	li	a0,1
    5ddc:	00003097          	auipc	ra,0x3
    5de0:	e42080e7          	jalr	-446(ra) # 8c1e <exit>
  wait(0);
    5de4:	4501                	li	a0,0
    5de6:	00003097          	auipc	ra,0x3
    5dea:	e40080e7          	jalr	-448(ra) # 8c26 <wait>
  pid = fork();
    5dee:	00003097          	auipc	ra,0x3
    5df2:	e28080e7          	jalr	-472(ra) # 8c16 <fork>
  if(pid < 0){
    5df6:	02054a63          	bltz	a0,5e2a <sbrkbugs+0xea>
  if(pid == 0){
    5dfa:	e529                	bnez	a0,5e44 <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    5dfc:	00003097          	auipc	ra,0x3
    5e00:	eb2080e7          	jalr	-334(ra) # 8cae <sbrk>
    5e04:	67ad                	lui	a5,0xb
    5e06:	8007879b          	addiw	a5,a5,-2048
    5e0a:	40a7853b          	subw	a0,a5,a0
    5e0e:	00003097          	auipc	ra,0x3
    5e12:	ea0080e7          	jalr	-352(ra) # 8cae <sbrk>
    sbrk(-10);
    5e16:	5559                	li	a0,-10
    5e18:	00003097          	auipc	ra,0x3
    5e1c:	e96080e7          	jalr	-362(ra) # 8cae <sbrk>
    exit(0);
    5e20:	4501                	li	a0,0
    5e22:	00003097          	auipc	ra,0x3
    5e26:	dfc080e7          	jalr	-516(ra) # 8c1e <exit>
    printf("fork failed\n");
    5e2a:	00004517          	auipc	a0,0x4
    5e2e:	02e50513          	addi	a0,a0,46 # 9e58 <malloc+0xdd4>
    5e32:	00003097          	auipc	ra,0x3
    5e36:	194080e7          	jalr	404(ra) # 8fc6 <printf>
    exit(1);
    5e3a:	4505                	li	a0,1
    5e3c:	00003097          	auipc	ra,0x3
    5e40:	de2080e7          	jalr	-542(ra) # 8c1e <exit>
  wait(0);
    5e44:	4501                	li	a0,0
    5e46:	00003097          	auipc	ra,0x3
    5e4a:	de0080e7          	jalr	-544(ra) # 8c26 <wait>
  exit(0);
    5e4e:	4501                	li	a0,0
    5e50:	00003097          	auipc	ra,0x3
    5e54:	dce080e7          	jalr	-562(ra) # 8c1e <exit>

0000000000005e58 <sbrklast>:
{
    5e58:	7179                	addi	sp,sp,-48
    5e5a:	f406                	sd	ra,40(sp)
    5e5c:	f022                	sd	s0,32(sp)
    5e5e:	ec26                	sd	s1,24(sp)
    5e60:	e84a                	sd	s2,16(sp)
    5e62:	e44e                	sd	s3,8(sp)
    5e64:	e052                	sd	s4,0(sp)
    5e66:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    5e68:	4501                	li	a0,0
    5e6a:	00003097          	auipc	ra,0x3
    5e6e:	e44080e7          	jalr	-444(ra) # 8cae <sbrk>
  if((top % 4096) != 0)
    5e72:	03451793          	slli	a5,a0,0x34
    5e76:	ebd9                	bnez	a5,5f0c <sbrklast+0xb4>
  sbrk(4096);
    5e78:	6505                	lui	a0,0x1
    5e7a:	00003097          	auipc	ra,0x3
    5e7e:	e34080e7          	jalr	-460(ra) # 8cae <sbrk>
  sbrk(10);
    5e82:	4529                	li	a0,10
    5e84:	00003097          	auipc	ra,0x3
    5e88:	e2a080e7          	jalr	-470(ra) # 8cae <sbrk>
  sbrk(-20);
    5e8c:	5531                	li	a0,-20
    5e8e:	00003097          	auipc	ra,0x3
    5e92:	e20080e7          	jalr	-480(ra) # 8cae <sbrk>
  top = (uint64) sbrk(0);
    5e96:	4501                	li	a0,0
    5e98:	00003097          	auipc	ra,0x3
    5e9c:	e16080e7          	jalr	-490(ra) # 8cae <sbrk>
    5ea0:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    5ea2:	fc050913          	addi	s2,a0,-64 # fc0 <copyinstr1-0x2040>
  p[0] = 'x';
    5ea6:	07800a13          	li	s4,120
    5eaa:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    5eae:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    5eb2:	20200593          	li	a1,514
    5eb6:	854a                	mv	a0,s2
    5eb8:	00003097          	auipc	ra,0x3
    5ebc:	dae080e7          	jalr	-594(ra) # 8c66 <open>
    5ec0:	89aa                	mv	s3,a0
  write(fd, p, 1);
    5ec2:	4605                	li	a2,1
    5ec4:	85ca                	mv	a1,s2
    5ec6:	00003097          	auipc	ra,0x3
    5eca:	d80080e7          	jalr	-640(ra) # 8c46 <write>
  close(fd);
    5ece:	854e                	mv	a0,s3
    5ed0:	00003097          	auipc	ra,0x3
    5ed4:	d7e080e7          	jalr	-642(ra) # 8c4e <close>
  fd = open(p, O_RDWR);
    5ed8:	4589                	li	a1,2
    5eda:	854a                	mv	a0,s2
    5edc:	00003097          	auipc	ra,0x3
    5ee0:	d8a080e7          	jalr	-630(ra) # 8c66 <open>
  p[0] = '\0';
    5ee4:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    5ee8:	4605                	li	a2,1
    5eea:	85ca                	mv	a1,s2
    5eec:	00003097          	auipc	ra,0x3
    5ef0:	d52080e7          	jalr	-686(ra) # 8c3e <read>
  if(p[0] != 'x')
    5ef4:	fc04c783          	lbu	a5,-64(s1)
    5ef8:	03479463          	bne	a5,s4,5f20 <sbrklast+0xc8>
}
    5efc:	70a2                	ld	ra,40(sp)
    5efe:	7402                	ld	s0,32(sp)
    5f00:	64e2                	ld	s1,24(sp)
    5f02:	6942                	ld	s2,16(sp)
    5f04:	69a2                	ld	s3,8(sp)
    5f06:	6a02                	ld	s4,0(sp)
    5f08:	6145                	addi	sp,sp,48
    5f0a:	8082                	ret
    sbrk(4096 - (top % 4096));
    5f0c:	0347d513          	srli	a0,a5,0x34
    5f10:	6785                	lui	a5,0x1
    5f12:	40a7853b          	subw	a0,a5,a0
    5f16:	00003097          	auipc	ra,0x3
    5f1a:	d98080e7          	jalr	-616(ra) # 8cae <sbrk>
    5f1e:	bfa9                	j	5e78 <sbrklast+0x20>
    exit(1);
    5f20:	4505                	li	a0,1
    5f22:	00003097          	auipc	ra,0x3
    5f26:	cfc080e7          	jalr	-772(ra) # 8c1e <exit>

0000000000005f2a <sbrk8000>:
{
    5f2a:	1141                	addi	sp,sp,-16
    5f2c:	e406                	sd	ra,8(sp)
    5f2e:	e022                	sd	s0,0(sp)
    5f30:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    5f32:	80000537          	lui	a0,0x80000
    5f36:	0511                	addi	a0,a0,4
    5f38:	00003097          	auipc	ra,0x3
    5f3c:	d76080e7          	jalr	-650(ra) # 8cae <sbrk>
  volatile char *top = sbrk(0);
    5f40:	4501                	li	a0,0
    5f42:	00003097          	auipc	ra,0x3
    5f46:	d6c080e7          	jalr	-660(ra) # 8cae <sbrk>
  *(top-1) = *(top-1) + 1;
    5f4a:	fff54783          	lbu	a5,-1(a0) # ffffffff7fffffff <base+0xffffffff7ffed387>
    5f4e:	0785                	addi	a5,a5,1
    5f50:	0ff7f793          	andi	a5,a5,255
    5f54:	fef50fa3          	sb	a5,-1(a0)
}
    5f58:	60a2                	ld	ra,8(sp)
    5f5a:	6402                	ld	s0,0(sp)
    5f5c:	0141                	addi	sp,sp,16
    5f5e:	8082                	ret

0000000000005f60 <execout>:
{
    5f60:	715d                	addi	sp,sp,-80
    5f62:	e486                	sd	ra,72(sp)
    5f64:	e0a2                	sd	s0,64(sp)
    5f66:	fc26                	sd	s1,56(sp)
    5f68:	f84a                	sd	s2,48(sp)
    5f6a:	f44e                	sd	s3,40(sp)
    5f6c:	f052                	sd	s4,32(sp)
    5f6e:	0880                	addi	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    5f70:	4901                	li	s2,0
    5f72:	49bd                	li	s3,15
    int pid = fork();
    5f74:	00003097          	auipc	ra,0x3
    5f78:	ca2080e7          	jalr	-862(ra) # 8c16 <fork>
    5f7c:	84aa                	mv	s1,a0
    if(pid < 0){
    5f7e:	02054063          	bltz	a0,5f9e <execout+0x3e>
    } else if(pid == 0){
    5f82:	c91d                	beqz	a0,5fb8 <execout+0x58>
      wait((int*)0);
    5f84:	4501                	li	a0,0
    5f86:	00003097          	auipc	ra,0x3
    5f8a:	ca0080e7          	jalr	-864(ra) # 8c26 <wait>
  for(int avail = 0; avail < 15; avail++){
    5f8e:	2905                	addiw	s2,s2,1
    5f90:	ff3912e3          	bne	s2,s3,5f74 <execout+0x14>
  exit(0);
    5f94:	4501                	li	a0,0
    5f96:	00003097          	auipc	ra,0x3
    5f9a:	c88080e7          	jalr	-888(ra) # 8c1e <exit>
      printf("fork failed\n");
    5f9e:	00004517          	auipc	a0,0x4
    5fa2:	eba50513          	addi	a0,a0,-326 # 9e58 <malloc+0xdd4>
    5fa6:	00003097          	auipc	ra,0x3
    5faa:	020080e7          	jalr	32(ra) # 8fc6 <printf>
      exit(1);
    5fae:	4505                	li	a0,1
    5fb0:	00003097          	auipc	ra,0x3
    5fb4:	c6e080e7          	jalr	-914(ra) # 8c1e <exit>
        if(a == 0xffffffffffffffffLL)
    5fb8:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    5fba:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    5fbc:	6505                	lui	a0,0x1
    5fbe:	00003097          	auipc	ra,0x3
    5fc2:	cf0080e7          	jalr	-784(ra) # 8cae <sbrk>
        if(a == 0xffffffffffffffffLL)
    5fc6:	01350763          	beq	a0,s3,5fd4 <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    5fca:	6785                	lui	a5,0x1
    5fcc:	953e                	add	a0,a0,a5
    5fce:	ff450fa3          	sb	s4,-1(a0) # fff <copyinstr1-0x2001>
      while(1){
    5fd2:	b7ed                	j	5fbc <execout+0x5c>
      for(int i = 0; i < avail; i++)
    5fd4:	01205a63          	blez	s2,5fe8 <execout+0x88>
        sbrk(-4096);
    5fd8:	757d                	lui	a0,0xfffff
    5fda:	00003097          	auipc	ra,0x3
    5fde:	cd4080e7          	jalr	-812(ra) # 8cae <sbrk>
      for(int i = 0; i < avail; i++)
    5fe2:	2485                	addiw	s1,s1,1
    5fe4:	ff249ae3          	bne	s1,s2,5fd8 <execout+0x78>
      close(1);
    5fe8:	4505                	li	a0,1
    5fea:	00003097          	auipc	ra,0x3
    5fee:	c64080e7          	jalr	-924(ra) # 8c4e <close>
      char *args[] = { "echo", "x", 0 };
    5ff2:	00003517          	auipc	a0,0x3
    5ff6:	1d650513          	addi	a0,a0,470 # 91c8 <malloc+0x144>
    5ffa:	faa43c23          	sd	a0,-72(s0)
    5ffe:	00003797          	auipc	a5,0x3
    6002:	23a78793          	addi	a5,a5,570 # 9238 <malloc+0x1b4>
    6006:	fcf43023          	sd	a5,-64(s0)
    600a:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    600e:	fb840593          	addi	a1,s0,-72
    6012:	00003097          	auipc	ra,0x3
    6016:	c4c080e7          	jalr	-948(ra) # 8c5e <exec>
      exit(0);
    601a:	4501                	li	a0,0
    601c:	00003097          	auipc	ra,0x3
    6020:	c02080e7          	jalr	-1022(ra) # 8c1e <exit>

0000000000006024 <fourteen>:
{
    6024:	1101                	addi	sp,sp,-32
    6026:	ec06                	sd	ra,24(sp)
    6028:	e822                	sd	s0,16(sp)
    602a:	e426                	sd	s1,8(sp)
    602c:	1000                	addi	s0,sp,32
    602e:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    6030:	00004517          	auipc	a0,0x4
    6034:	33850513          	addi	a0,a0,824 # a368 <malloc+0x12e4>
    6038:	00003097          	auipc	ra,0x3
    603c:	c56080e7          	jalr	-938(ra) # 8c8e <mkdir>
    6040:	e165                	bnez	a0,6120 <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    6042:	00004517          	auipc	a0,0x4
    6046:	17e50513          	addi	a0,a0,382 # a1c0 <malloc+0x113c>
    604a:	00003097          	auipc	ra,0x3
    604e:	c44080e7          	jalr	-956(ra) # 8c8e <mkdir>
    6052:	e56d                	bnez	a0,613c <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    6054:	20000593          	li	a1,512
    6058:	00004517          	auipc	a0,0x4
    605c:	1c050513          	addi	a0,a0,448 # a218 <malloc+0x1194>
    6060:	00003097          	auipc	ra,0x3
    6064:	c06080e7          	jalr	-1018(ra) # 8c66 <open>
  if(fd < 0){
    6068:	0e054863          	bltz	a0,6158 <fourteen+0x134>
  close(fd);
    606c:	00003097          	auipc	ra,0x3
    6070:	be2080e7          	jalr	-1054(ra) # 8c4e <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    6074:	4581                	li	a1,0
    6076:	00004517          	auipc	a0,0x4
    607a:	21a50513          	addi	a0,a0,538 # a290 <malloc+0x120c>
    607e:	00003097          	auipc	ra,0x3
    6082:	be8080e7          	jalr	-1048(ra) # 8c66 <open>
  if(fd < 0){
    6086:	0e054763          	bltz	a0,6174 <fourteen+0x150>
  close(fd);
    608a:	00003097          	auipc	ra,0x3
    608e:	bc4080e7          	jalr	-1084(ra) # 8c4e <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    6092:	00004517          	auipc	a0,0x4
    6096:	26e50513          	addi	a0,a0,622 # a300 <malloc+0x127c>
    609a:	00003097          	auipc	ra,0x3
    609e:	bf4080e7          	jalr	-1036(ra) # 8c8e <mkdir>
    60a2:	c57d                	beqz	a0,6190 <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    60a4:	00004517          	auipc	a0,0x4
    60a8:	2b450513          	addi	a0,a0,692 # a358 <malloc+0x12d4>
    60ac:	00003097          	auipc	ra,0x3
    60b0:	be2080e7          	jalr	-1054(ra) # 8c8e <mkdir>
    60b4:	cd65                	beqz	a0,61ac <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    60b6:	00004517          	auipc	a0,0x4
    60ba:	2a250513          	addi	a0,a0,674 # a358 <malloc+0x12d4>
    60be:	00003097          	auipc	ra,0x3
    60c2:	bb8080e7          	jalr	-1096(ra) # 8c76 <unlink>
  unlink("12345678901234/12345678901234");
    60c6:	00004517          	auipc	a0,0x4
    60ca:	23a50513          	addi	a0,a0,570 # a300 <malloc+0x127c>
    60ce:	00003097          	auipc	ra,0x3
    60d2:	ba8080e7          	jalr	-1112(ra) # 8c76 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    60d6:	00004517          	auipc	a0,0x4
    60da:	1ba50513          	addi	a0,a0,442 # a290 <malloc+0x120c>
    60de:	00003097          	auipc	ra,0x3
    60e2:	b98080e7          	jalr	-1128(ra) # 8c76 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    60e6:	00004517          	auipc	a0,0x4
    60ea:	13250513          	addi	a0,a0,306 # a218 <malloc+0x1194>
    60ee:	00003097          	auipc	ra,0x3
    60f2:	b88080e7          	jalr	-1144(ra) # 8c76 <unlink>
  unlink("12345678901234/123456789012345");
    60f6:	00004517          	auipc	a0,0x4
    60fa:	0ca50513          	addi	a0,a0,202 # a1c0 <malloc+0x113c>
    60fe:	00003097          	auipc	ra,0x3
    6102:	b78080e7          	jalr	-1160(ra) # 8c76 <unlink>
  unlink("12345678901234");
    6106:	00004517          	auipc	a0,0x4
    610a:	26250513          	addi	a0,a0,610 # a368 <malloc+0x12e4>
    610e:	00003097          	auipc	ra,0x3
    6112:	b68080e7          	jalr	-1176(ra) # 8c76 <unlink>
}
    6116:	60e2                	ld	ra,24(sp)
    6118:	6442                	ld	s0,16(sp)
    611a:	64a2                	ld	s1,8(sp)
    611c:	6105                	addi	sp,sp,32
    611e:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    6120:	85a6                	mv	a1,s1
    6122:	00004517          	auipc	a0,0x4
    6126:	07650513          	addi	a0,a0,118 # a198 <malloc+0x1114>
    612a:	00003097          	auipc	ra,0x3
    612e:	e9c080e7          	jalr	-356(ra) # 8fc6 <printf>
    exit(1);
    6132:	4505                	li	a0,1
    6134:	00003097          	auipc	ra,0x3
    6138:	aea080e7          	jalr	-1302(ra) # 8c1e <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    613c:	85a6                	mv	a1,s1
    613e:	00004517          	auipc	a0,0x4
    6142:	0a250513          	addi	a0,a0,162 # a1e0 <malloc+0x115c>
    6146:	00003097          	auipc	ra,0x3
    614a:	e80080e7          	jalr	-384(ra) # 8fc6 <printf>
    exit(1);
    614e:	4505                	li	a0,1
    6150:	00003097          	auipc	ra,0x3
    6154:	ace080e7          	jalr	-1330(ra) # 8c1e <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    6158:	85a6                	mv	a1,s1
    615a:	00004517          	auipc	a0,0x4
    615e:	0ee50513          	addi	a0,a0,238 # a248 <malloc+0x11c4>
    6162:	00003097          	auipc	ra,0x3
    6166:	e64080e7          	jalr	-412(ra) # 8fc6 <printf>
    exit(1);
    616a:	4505                	li	a0,1
    616c:	00003097          	auipc	ra,0x3
    6170:	ab2080e7          	jalr	-1358(ra) # 8c1e <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    6174:	85a6                	mv	a1,s1
    6176:	00004517          	auipc	a0,0x4
    617a:	14a50513          	addi	a0,a0,330 # a2c0 <malloc+0x123c>
    617e:	00003097          	auipc	ra,0x3
    6182:	e48080e7          	jalr	-440(ra) # 8fc6 <printf>
    exit(1);
    6186:	4505                	li	a0,1
    6188:	00003097          	auipc	ra,0x3
    618c:	a96080e7          	jalr	-1386(ra) # 8c1e <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    6190:	85a6                	mv	a1,s1
    6192:	00004517          	auipc	a0,0x4
    6196:	18e50513          	addi	a0,a0,398 # a320 <malloc+0x129c>
    619a:	00003097          	auipc	ra,0x3
    619e:	e2c080e7          	jalr	-468(ra) # 8fc6 <printf>
    exit(1);
    61a2:	4505                	li	a0,1
    61a4:	00003097          	auipc	ra,0x3
    61a8:	a7a080e7          	jalr	-1414(ra) # 8c1e <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    61ac:	85a6                	mv	a1,s1
    61ae:	00004517          	auipc	a0,0x4
    61b2:	1ca50513          	addi	a0,a0,458 # a378 <malloc+0x12f4>
    61b6:	00003097          	auipc	ra,0x3
    61ba:	e10080e7          	jalr	-496(ra) # 8fc6 <printf>
    exit(1);
    61be:	4505                	li	a0,1
    61c0:	00003097          	auipc	ra,0x3
    61c4:	a5e080e7          	jalr	-1442(ra) # 8c1e <exit>

00000000000061c8 <diskfull>:
{
    61c8:	b9010113          	addi	sp,sp,-1136
    61cc:	46113423          	sd	ra,1128(sp)
    61d0:	46813023          	sd	s0,1120(sp)
    61d4:	44913c23          	sd	s1,1112(sp)
    61d8:	45213823          	sd	s2,1104(sp)
    61dc:	45313423          	sd	s3,1096(sp)
    61e0:	45413023          	sd	s4,1088(sp)
    61e4:	43513c23          	sd	s5,1080(sp)
    61e8:	43613823          	sd	s6,1072(sp)
    61ec:	43713423          	sd	s7,1064(sp)
    61f0:	43813023          	sd	s8,1056(sp)
    61f4:	47010413          	addi	s0,sp,1136
    61f8:	8c2a                	mv	s8,a0
  unlink("diskfulldir");
    61fa:	00004517          	auipc	a0,0x4
    61fe:	1b650513          	addi	a0,a0,438 # a3b0 <malloc+0x132c>
    6202:	00003097          	auipc	ra,0x3
    6206:	a74080e7          	jalr	-1420(ra) # 8c76 <unlink>
  for(fi = 0; done == 0; fi++){
    620a:	4a01                	li	s4,0
    name[0] = 'b';
    620c:	06200b13          	li	s6,98
    name[1] = 'i';
    6210:	06900a93          	li	s5,105
    name[2] = 'g';
    6214:	06700993          	li	s3,103
    6218:	10c00b93          	li	s7,268
    621c:	aabd                	j	639a <diskfull+0x1d2>
      printf("%s: could not create file %s\n", s, name);
    621e:	b9040613          	addi	a2,s0,-1136
    6222:	85e2                	mv	a1,s8
    6224:	00004517          	auipc	a0,0x4
    6228:	19c50513          	addi	a0,a0,412 # a3c0 <malloc+0x133c>
    622c:	00003097          	auipc	ra,0x3
    6230:	d9a080e7          	jalr	-614(ra) # 8fc6 <printf>
      break;
    6234:	a821                	j	624c <diskfull+0x84>
        close(fd);
    6236:	854a                	mv	a0,s2
    6238:	00003097          	auipc	ra,0x3
    623c:	a16080e7          	jalr	-1514(ra) # 8c4e <close>
    close(fd);
    6240:	854a                	mv	a0,s2
    6242:	00003097          	auipc	ra,0x3
    6246:	a0c080e7          	jalr	-1524(ra) # 8c4e <close>
  for(fi = 0; done == 0; fi++){
    624a:	2a05                	addiw	s4,s4,1
  for(int i = 0; i < nzz; i++){
    624c:	4481                	li	s1,0
    name[0] = 'z';
    624e:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    6252:	08000993          	li	s3,128
    name[0] = 'z';
    6256:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    625a:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    625e:	41f4d79b          	sraiw	a5,s1,0x1f
    6262:	01b7d71b          	srliw	a4,a5,0x1b
    6266:	009707bb          	addw	a5,a4,s1
    626a:	4057d69b          	sraiw	a3,a5,0x5
    626e:	0306869b          	addiw	a3,a3,48
    6272:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    6276:	8bfd                	andi	a5,a5,31
    6278:	9f99                	subw	a5,a5,a4
    627a:	0307879b          	addiw	a5,a5,48
    627e:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    6282:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    6286:	bb040513          	addi	a0,s0,-1104
    628a:	00003097          	auipc	ra,0x3
    628e:	9ec080e7          	jalr	-1556(ra) # 8c76 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    6292:	60200593          	li	a1,1538
    6296:	bb040513          	addi	a0,s0,-1104
    629a:	00003097          	auipc	ra,0x3
    629e:	9cc080e7          	jalr	-1588(ra) # 8c66 <open>
    if(fd < 0)
    62a2:	00054963          	bltz	a0,62b4 <diskfull+0xec>
    close(fd);
    62a6:	00003097          	auipc	ra,0x3
    62aa:	9a8080e7          	jalr	-1624(ra) # 8c4e <close>
  for(int i = 0; i < nzz; i++){
    62ae:	2485                	addiw	s1,s1,1
    62b0:	fb3493e3          	bne	s1,s3,6256 <diskfull+0x8e>
  if(mkdir("diskfulldir") == 0)
    62b4:	00004517          	auipc	a0,0x4
    62b8:	0fc50513          	addi	a0,a0,252 # a3b0 <malloc+0x132c>
    62bc:	00003097          	auipc	ra,0x3
    62c0:	9d2080e7          	jalr	-1582(ra) # 8c8e <mkdir>
    62c4:	12050963          	beqz	a0,63f6 <diskfull+0x22e>
  unlink("diskfulldir");
    62c8:	00004517          	auipc	a0,0x4
    62cc:	0e850513          	addi	a0,a0,232 # a3b0 <malloc+0x132c>
    62d0:	00003097          	auipc	ra,0x3
    62d4:	9a6080e7          	jalr	-1626(ra) # 8c76 <unlink>
  for(int i = 0; i < nzz; i++){
    62d8:	4481                	li	s1,0
    name[0] = 'z';
    62da:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    62de:	08000993          	li	s3,128
    name[0] = 'z';
    62e2:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    62e6:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    62ea:	41f4d79b          	sraiw	a5,s1,0x1f
    62ee:	01b7d71b          	srliw	a4,a5,0x1b
    62f2:	009707bb          	addw	a5,a4,s1
    62f6:	4057d69b          	sraiw	a3,a5,0x5
    62fa:	0306869b          	addiw	a3,a3,48
    62fe:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    6302:	8bfd                	andi	a5,a5,31
    6304:	9f99                	subw	a5,a5,a4
    6306:	0307879b          	addiw	a5,a5,48
    630a:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    630e:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    6312:	bb040513          	addi	a0,s0,-1104
    6316:	00003097          	auipc	ra,0x3
    631a:	960080e7          	jalr	-1696(ra) # 8c76 <unlink>
  for(int i = 0; i < nzz; i++){
    631e:	2485                	addiw	s1,s1,1
    6320:	fd3491e3          	bne	s1,s3,62e2 <diskfull+0x11a>
  for(int i = 0; i < fi; i++){
    6324:	03405e63          	blez	s4,6360 <diskfull+0x198>
    6328:	4481                	li	s1,0
    name[0] = 'b';
    632a:	06200a93          	li	s5,98
    name[1] = 'i';
    632e:	06900993          	li	s3,105
    name[2] = 'g';
    6332:	06700913          	li	s2,103
    name[0] = 'b';
    6336:	bb540823          	sb	s5,-1104(s0)
    name[1] = 'i';
    633a:	bb3408a3          	sb	s3,-1103(s0)
    name[2] = 'g';
    633e:	bb240923          	sb	s2,-1102(s0)
    name[3] = '0' + i;
    6342:	0304879b          	addiw	a5,s1,48
    6346:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    634a:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    634e:	bb040513          	addi	a0,s0,-1104
    6352:	00003097          	auipc	ra,0x3
    6356:	924080e7          	jalr	-1756(ra) # 8c76 <unlink>
  for(int i = 0; i < fi; i++){
    635a:	2485                	addiw	s1,s1,1
    635c:	fd449de3          	bne	s1,s4,6336 <diskfull+0x16e>
}
    6360:	46813083          	ld	ra,1128(sp)
    6364:	46013403          	ld	s0,1120(sp)
    6368:	45813483          	ld	s1,1112(sp)
    636c:	45013903          	ld	s2,1104(sp)
    6370:	44813983          	ld	s3,1096(sp)
    6374:	44013a03          	ld	s4,1088(sp)
    6378:	43813a83          	ld	s5,1080(sp)
    637c:	43013b03          	ld	s6,1072(sp)
    6380:	42813b83          	ld	s7,1064(sp)
    6384:	42013c03          	ld	s8,1056(sp)
    6388:	47010113          	addi	sp,sp,1136
    638c:	8082                	ret
    close(fd);
    638e:	854a                	mv	a0,s2
    6390:	00003097          	auipc	ra,0x3
    6394:	8be080e7          	jalr	-1858(ra) # 8c4e <close>
  for(fi = 0; done == 0; fi++){
    6398:	2a05                	addiw	s4,s4,1
    name[0] = 'b';
    639a:	b9640823          	sb	s6,-1136(s0)
    name[1] = 'i';
    639e:	b95408a3          	sb	s5,-1135(s0)
    name[2] = 'g';
    63a2:	b9340923          	sb	s3,-1134(s0)
    name[3] = '0' + fi;
    63a6:	030a079b          	addiw	a5,s4,48
    63aa:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    63ae:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    63b2:	b9040513          	addi	a0,s0,-1136
    63b6:	00003097          	auipc	ra,0x3
    63ba:	8c0080e7          	jalr	-1856(ra) # 8c76 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    63be:	60200593          	li	a1,1538
    63c2:	b9040513          	addi	a0,s0,-1136
    63c6:	00003097          	auipc	ra,0x3
    63ca:	8a0080e7          	jalr	-1888(ra) # 8c66 <open>
    63ce:	892a                	mv	s2,a0
    if(fd < 0){
    63d0:	e40547e3          	bltz	a0,621e <diskfull+0x56>
    63d4:	84de                	mv	s1,s7
      if(write(fd, buf, BSIZE) != BSIZE){
    63d6:	40000613          	li	a2,1024
    63da:	bb040593          	addi	a1,s0,-1104
    63de:	854a                	mv	a0,s2
    63e0:	00003097          	auipc	ra,0x3
    63e4:	866080e7          	jalr	-1946(ra) # 8c46 <write>
    63e8:	40000793          	li	a5,1024
    63ec:	e4f515e3          	bne	a0,a5,6236 <diskfull+0x6e>
    for(int i = 0; i < MAXFILE; i++){
    63f0:	34fd                	addiw	s1,s1,-1
    63f2:	f0f5                	bnez	s1,63d6 <diskfull+0x20e>
    63f4:	bf69                	j	638e <diskfull+0x1c6>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n");
    63f6:	00004517          	auipc	a0,0x4
    63fa:	fea50513          	addi	a0,a0,-22 # a3e0 <malloc+0x135c>
    63fe:	00003097          	auipc	ra,0x3
    6402:	bc8080e7          	jalr	-1080(ra) # 8fc6 <printf>
    6406:	b5c9                	j	62c8 <diskfull+0x100>

0000000000006408 <iputtest>:
{
    6408:	1101                	addi	sp,sp,-32
    640a:	ec06                	sd	ra,24(sp)
    640c:	e822                	sd	s0,16(sp)
    640e:	e426                	sd	s1,8(sp)
    6410:	1000                	addi	s0,sp,32
    6412:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    6414:	00004517          	auipc	a0,0x4
    6418:	ffc50513          	addi	a0,a0,-4 # a410 <malloc+0x138c>
    641c:	00003097          	auipc	ra,0x3
    6420:	872080e7          	jalr	-1934(ra) # 8c8e <mkdir>
    6424:	04054563          	bltz	a0,646e <iputtest+0x66>
  if(chdir("iputdir") < 0){
    6428:	00004517          	auipc	a0,0x4
    642c:	fe850513          	addi	a0,a0,-24 # a410 <malloc+0x138c>
    6430:	00003097          	auipc	ra,0x3
    6434:	866080e7          	jalr	-1946(ra) # 8c96 <chdir>
    6438:	04054963          	bltz	a0,648a <iputtest+0x82>
  if(unlink("../iputdir") < 0){
    643c:	00004517          	auipc	a0,0x4
    6440:	01450513          	addi	a0,a0,20 # a450 <malloc+0x13cc>
    6444:	00003097          	auipc	ra,0x3
    6448:	832080e7          	jalr	-1998(ra) # 8c76 <unlink>
    644c:	04054d63          	bltz	a0,64a6 <iputtest+0x9e>
  if(chdir("/") < 0){
    6450:	00004517          	auipc	a0,0x4
    6454:	03050513          	addi	a0,a0,48 # a480 <malloc+0x13fc>
    6458:	00003097          	auipc	ra,0x3
    645c:	83e080e7          	jalr	-1986(ra) # 8c96 <chdir>
    6460:	06054163          	bltz	a0,64c2 <iputtest+0xba>
}
    6464:	60e2                	ld	ra,24(sp)
    6466:	6442                	ld	s0,16(sp)
    6468:	64a2                	ld	s1,8(sp)
    646a:	6105                	addi	sp,sp,32
    646c:	8082                	ret
    printf("%s: mkdir failed\n", s);
    646e:	85a6                	mv	a1,s1
    6470:	00004517          	auipc	a0,0x4
    6474:	fa850513          	addi	a0,a0,-88 # a418 <malloc+0x1394>
    6478:	00003097          	auipc	ra,0x3
    647c:	b4e080e7          	jalr	-1202(ra) # 8fc6 <printf>
    exit(1);
    6480:	4505                	li	a0,1
    6482:	00002097          	auipc	ra,0x2
    6486:	79c080e7          	jalr	1948(ra) # 8c1e <exit>
    printf("%s: chdir iputdir failed\n", s);
    648a:	85a6                	mv	a1,s1
    648c:	00004517          	auipc	a0,0x4
    6490:	fa450513          	addi	a0,a0,-92 # a430 <malloc+0x13ac>
    6494:	00003097          	auipc	ra,0x3
    6498:	b32080e7          	jalr	-1230(ra) # 8fc6 <printf>
    exit(1);
    649c:	4505                	li	a0,1
    649e:	00002097          	auipc	ra,0x2
    64a2:	780080e7          	jalr	1920(ra) # 8c1e <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    64a6:	85a6                	mv	a1,s1
    64a8:	00004517          	auipc	a0,0x4
    64ac:	fb850513          	addi	a0,a0,-72 # a460 <malloc+0x13dc>
    64b0:	00003097          	auipc	ra,0x3
    64b4:	b16080e7          	jalr	-1258(ra) # 8fc6 <printf>
    exit(1);
    64b8:	4505                	li	a0,1
    64ba:	00002097          	auipc	ra,0x2
    64be:	764080e7          	jalr	1892(ra) # 8c1e <exit>
    printf("%s: chdir / failed\n", s);
    64c2:	85a6                	mv	a1,s1
    64c4:	00004517          	auipc	a0,0x4
    64c8:	fc450513          	addi	a0,a0,-60 # a488 <malloc+0x1404>
    64cc:	00003097          	auipc	ra,0x3
    64d0:	afa080e7          	jalr	-1286(ra) # 8fc6 <printf>
    exit(1);
    64d4:	4505                	li	a0,1
    64d6:	00002097          	auipc	ra,0x2
    64da:	748080e7          	jalr	1864(ra) # 8c1e <exit>

00000000000064de <exitiputtest>:
{
    64de:	7179                	addi	sp,sp,-48
    64e0:	f406                	sd	ra,40(sp)
    64e2:	f022                	sd	s0,32(sp)
    64e4:	ec26                	sd	s1,24(sp)
    64e6:	1800                	addi	s0,sp,48
    64e8:	84aa                	mv	s1,a0
  pid = fork();
    64ea:	00002097          	auipc	ra,0x2
    64ee:	72c080e7          	jalr	1836(ra) # 8c16 <fork>
  if(pid < 0){
    64f2:	04054663          	bltz	a0,653e <exitiputtest+0x60>
  if(pid == 0){
    64f6:	ed45                	bnez	a0,65ae <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    64f8:	00004517          	auipc	a0,0x4
    64fc:	f1850513          	addi	a0,a0,-232 # a410 <malloc+0x138c>
    6500:	00002097          	auipc	ra,0x2
    6504:	78e080e7          	jalr	1934(ra) # 8c8e <mkdir>
    6508:	04054963          	bltz	a0,655a <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    650c:	00004517          	auipc	a0,0x4
    6510:	f0450513          	addi	a0,a0,-252 # a410 <malloc+0x138c>
    6514:	00002097          	auipc	ra,0x2
    6518:	782080e7          	jalr	1922(ra) # 8c96 <chdir>
    651c:	04054d63          	bltz	a0,6576 <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
    6520:	00004517          	auipc	a0,0x4
    6524:	f3050513          	addi	a0,a0,-208 # a450 <malloc+0x13cc>
    6528:	00002097          	auipc	ra,0x2
    652c:	74e080e7          	jalr	1870(ra) # 8c76 <unlink>
    6530:	06054163          	bltz	a0,6592 <exitiputtest+0xb4>
    exit(0);
    6534:	4501                	li	a0,0
    6536:	00002097          	auipc	ra,0x2
    653a:	6e8080e7          	jalr	1768(ra) # 8c1e <exit>
    printf("%s: fork failed\n", s);
    653e:	85a6                	mv	a1,s1
    6540:	00003517          	auipc	a0,0x3
    6544:	51050513          	addi	a0,a0,1296 # 9a50 <malloc+0x9cc>
    6548:	00003097          	auipc	ra,0x3
    654c:	a7e080e7          	jalr	-1410(ra) # 8fc6 <printf>
    exit(1);
    6550:	4505                	li	a0,1
    6552:	00002097          	auipc	ra,0x2
    6556:	6cc080e7          	jalr	1740(ra) # 8c1e <exit>
      printf("%s: mkdir failed\n", s);
    655a:	85a6                	mv	a1,s1
    655c:	00004517          	auipc	a0,0x4
    6560:	ebc50513          	addi	a0,a0,-324 # a418 <malloc+0x1394>
    6564:	00003097          	auipc	ra,0x3
    6568:	a62080e7          	jalr	-1438(ra) # 8fc6 <printf>
      exit(1);
    656c:	4505                	li	a0,1
    656e:	00002097          	auipc	ra,0x2
    6572:	6b0080e7          	jalr	1712(ra) # 8c1e <exit>
      printf("%s: child chdir failed\n", s);
    6576:	85a6                	mv	a1,s1
    6578:	00004517          	auipc	a0,0x4
    657c:	f2850513          	addi	a0,a0,-216 # a4a0 <malloc+0x141c>
    6580:	00003097          	auipc	ra,0x3
    6584:	a46080e7          	jalr	-1466(ra) # 8fc6 <printf>
      exit(1);
    6588:	4505                	li	a0,1
    658a:	00002097          	auipc	ra,0x2
    658e:	694080e7          	jalr	1684(ra) # 8c1e <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    6592:	85a6                	mv	a1,s1
    6594:	00004517          	auipc	a0,0x4
    6598:	ecc50513          	addi	a0,a0,-308 # a460 <malloc+0x13dc>
    659c:	00003097          	auipc	ra,0x3
    65a0:	a2a080e7          	jalr	-1494(ra) # 8fc6 <printf>
      exit(1);
    65a4:	4505                	li	a0,1
    65a6:	00002097          	auipc	ra,0x2
    65aa:	678080e7          	jalr	1656(ra) # 8c1e <exit>
  wait(&xstatus);
    65ae:	fdc40513          	addi	a0,s0,-36
    65b2:	00002097          	auipc	ra,0x2
    65b6:	674080e7          	jalr	1652(ra) # 8c26 <wait>
  exit(xstatus);
    65ba:	fdc42503          	lw	a0,-36(s0)
    65be:	00002097          	auipc	ra,0x2
    65c2:	660080e7          	jalr	1632(ra) # 8c1e <exit>

00000000000065c6 <dirtest>:
{
    65c6:	1101                	addi	sp,sp,-32
    65c8:	ec06                	sd	ra,24(sp)
    65ca:	e822                	sd	s0,16(sp)
    65cc:	e426                	sd	s1,8(sp)
    65ce:	1000                	addi	s0,sp,32
    65d0:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    65d2:	00004517          	auipc	a0,0x4
    65d6:	ee650513          	addi	a0,a0,-282 # a4b8 <malloc+0x1434>
    65da:	00002097          	auipc	ra,0x2
    65de:	6b4080e7          	jalr	1716(ra) # 8c8e <mkdir>
    65e2:	04054563          	bltz	a0,662c <dirtest+0x66>
  if(chdir("dir0") < 0){
    65e6:	00004517          	auipc	a0,0x4
    65ea:	ed250513          	addi	a0,a0,-302 # a4b8 <malloc+0x1434>
    65ee:	00002097          	auipc	ra,0x2
    65f2:	6a8080e7          	jalr	1704(ra) # 8c96 <chdir>
    65f6:	04054963          	bltz	a0,6648 <dirtest+0x82>
  if(chdir("..") < 0){
    65fa:	00004517          	auipc	a0,0x4
    65fe:	ede50513          	addi	a0,a0,-290 # a4d8 <malloc+0x1454>
    6602:	00002097          	auipc	ra,0x2
    6606:	694080e7          	jalr	1684(ra) # 8c96 <chdir>
    660a:	04054d63          	bltz	a0,6664 <dirtest+0x9e>
  if(unlink("dir0") < 0){
    660e:	00004517          	auipc	a0,0x4
    6612:	eaa50513          	addi	a0,a0,-342 # a4b8 <malloc+0x1434>
    6616:	00002097          	auipc	ra,0x2
    661a:	660080e7          	jalr	1632(ra) # 8c76 <unlink>
    661e:	06054163          	bltz	a0,6680 <dirtest+0xba>
}
    6622:	60e2                	ld	ra,24(sp)
    6624:	6442                	ld	s0,16(sp)
    6626:	64a2                	ld	s1,8(sp)
    6628:	6105                	addi	sp,sp,32
    662a:	8082                	ret
    printf("%s: mkdir failed\n", s);
    662c:	85a6                	mv	a1,s1
    662e:	00004517          	auipc	a0,0x4
    6632:	dea50513          	addi	a0,a0,-534 # a418 <malloc+0x1394>
    6636:	00003097          	auipc	ra,0x3
    663a:	990080e7          	jalr	-1648(ra) # 8fc6 <printf>
    exit(1);
    663e:	4505                	li	a0,1
    6640:	00002097          	auipc	ra,0x2
    6644:	5de080e7          	jalr	1502(ra) # 8c1e <exit>
    printf("%s: chdir dir0 failed\n", s);
    6648:	85a6                	mv	a1,s1
    664a:	00004517          	auipc	a0,0x4
    664e:	e7650513          	addi	a0,a0,-394 # a4c0 <malloc+0x143c>
    6652:	00003097          	auipc	ra,0x3
    6656:	974080e7          	jalr	-1676(ra) # 8fc6 <printf>
    exit(1);
    665a:	4505                	li	a0,1
    665c:	00002097          	auipc	ra,0x2
    6660:	5c2080e7          	jalr	1474(ra) # 8c1e <exit>
    printf("%s: chdir .. failed\n", s);
    6664:	85a6                	mv	a1,s1
    6666:	00004517          	auipc	a0,0x4
    666a:	e7a50513          	addi	a0,a0,-390 # a4e0 <malloc+0x145c>
    666e:	00003097          	auipc	ra,0x3
    6672:	958080e7          	jalr	-1704(ra) # 8fc6 <printf>
    exit(1);
    6676:	4505                	li	a0,1
    6678:	00002097          	auipc	ra,0x2
    667c:	5a6080e7          	jalr	1446(ra) # 8c1e <exit>
    printf("%s: unlink dir0 failed\n", s);
    6680:	85a6                	mv	a1,s1
    6682:	00004517          	auipc	a0,0x4
    6686:	e7650513          	addi	a0,a0,-394 # a4f8 <malloc+0x1474>
    668a:	00003097          	auipc	ra,0x3
    668e:	93c080e7          	jalr	-1732(ra) # 8fc6 <printf>
    exit(1);
    6692:	4505                	li	a0,1
    6694:	00002097          	auipc	ra,0x2
    6698:	58a080e7          	jalr	1418(ra) # 8c1e <exit>

000000000000669c <subdir>:
{
    669c:	1101                	addi	sp,sp,-32
    669e:	ec06                	sd	ra,24(sp)
    66a0:	e822                	sd	s0,16(sp)
    66a2:	e426                	sd	s1,8(sp)
    66a4:	e04a                	sd	s2,0(sp)
    66a6:	1000                	addi	s0,sp,32
    66a8:	892a                	mv	s2,a0
  unlink("ff");
    66aa:	00004517          	auipc	a0,0x4
    66ae:	f9650513          	addi	a0,a0,-106 # a640 <malloc+0x15bc>
    66b2:	00002097          	auipc	ra,0x2
    66b6:	5c4080e7          	jalr	1476(ra) # 8c76 <unlink>
  if(mkdir("dd") != 0){
    66ba:	00004517          	auipc	a0,0x4
    66be:	e5650513          	addi	a0,a0,-426 # a510 <malloc+0x148c>
    66c2:	00002097          	auipc	ra,0x2
    66c6:	5cc080e7          	jalr	1484(ra) # 8c8e <mkdir>
    66ca:	38051663          	bnez	a0,6a56 <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    66ce:	20200593          	li	a1,514
    66d2:	00004517          	auipc	a0,0x4
    66d6:	e5e50513          	addi	a0,a0,-418 # a530 <malloc+0x14ac>
    66da:	00002097          	auipc	ra,0x2
    66de:	58c080e7          	jalr	1420(ra) # 8c66 <open>
    66e2:	84aa                	mv	s1,a0
  if(fd < 0){
    66e4:	38054763          	bltz	a0,6a72 <subdir+0x3d6>
  write(fd, "ff", 2);
    66e8:	4609                	li	a2,2
    66ea:	00004597          	auipc	a1,0x4
    66ee:	f5658593          	addi	a1,a1,-170 # a640 <malloc+0x15bc>
    66f2:	00002097          	auipc	ra,0x2
    66f6:	554080e7          	jalr	1364(ra) # 8c46 <write>
  close(fd);
    66fa:	8526                	mv	a0,s1
    66fc:	00002097          	auipc	ra,0x2
    6700:	552080e7          	jalr	1362(ra) # 8c4e <close>
  if(unlink("dd") >= 0){
    6704:	00004517          	auipc	a0,0x4
    6708:	e0c50513          	addi	a0,a0,-500 # a510 <malloc+0x148c>
    670c:	00002097          	auipc	ra,0x2
    6710:	56a080e7          	jalr	1386(ra) # 8c76 <unlink>
    6714:	36055d63          	bgez	a0,6a8e <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    6718:	00004517          	auipc	a0,0x4
    671c:	e7050513          	addi	a0,a0,-400 # a588 <malloc+0x1504>
    6720:	00002097          	auipc	ra,0x2
    6724:	56e080e7          	jalr	1390(ra) # 8c8e <mkdir>
    6728:	38051163          	bnez	a0,6aaa <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    672c:	20200593          	li	a1,514
    6730:	00004517          	auipc	a0,0x4
    6734:	e8050513          	addi	a0,a0,-384 # a5b0 <malloc+0x152c>
    6738:	00002097          	auipc	ra,0x2
    673c:	52e080e7          	jalr	1326(ra) # 8c66 <open>
    6740:	84aa                	mv	s1,a0
  if(fd < 0){
    6742:	38054263          	bltz	a0,6ac6 <subdir+0x42a>
  write(fd, "FF", 2);
    6746:	4609                	li	a2,2
    6748:	00004597          	auipc	a1,0x4
    674c:	e9858593          	addi	a1,a1,-360 # a5e0 <malloc+0x155c>
    6750:	00002097          	auipc	ra,0x2
    6754:	4f6080e7          	jalr	1270(ra) # 8c46 <write>
  close(fd);
    6758:	8526                	mv	a0,s1
    675a:	00002097          	auipc	ra,0x2
    675e:	4f4080e7          	jalr	1268(ra) # 8c4e <close>
  fd = open("dd/dd/../ff", 0);
    6762:	4581                	li	a1,0
    6764:	00004517          	auipc	a0,0x4
    6768:	e8450513          	addi	a0,a0,-380 # a5e8 <malloc+0x1564>
    676c:	00002097          	auipc	ra,0x2
    6770:	4fa080e7          	jalr	1274(ra) # 8c66 <open>
    6774:	84aa                	mv	s1,a0
  if(fd < 0){
    6776:	36054663          	bltz	a0,6ae2 <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    677a:	660d                	lui	a2,0x3
    677c:	00009597          	auipc	a1,0x9
    6780:	4fc58593          	addi	a1,a1,1276 # fc78 <buf>
    6784:	00002097          	auipc	ra,0x2
    6788:	4ba080e7          	jalr	1210(ra) # 8c3e <read>
  if(cc != 2 || buf[0] != 'f'){
    678c:	4789                	li	a5,2
    678e:	36f51863          	bne	a0,a5,6afe <subdir+0x462>
    6792:	00009717          	auipc	a4,0x9
    6796:	4e674703          	lbu	a4,1254(a4) # fc78 <buf>
    679a:	06600793          	li	a5,102
    679e:	36f71063          	bne	a4,a5,6afe <subdir+0x462>
  close(fd);
    67a2:	8526                	mv	a0,s1
    67a4:	00002097          	auipc	ra,0x2
    67a8:	4aa080e7          	jalr	1194(ra) # 8c4e <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    67ac:	00004597          	auipc	a1,0x4
    67b0:	e8c58593          	addi	a1,a1,-372 # a638 <malloc+0x15b4>
    67b4:	00004517          	auipc	a0,0x4
    67b8:	dfc50513          	addi	a0,a0,-516 # a5b0 <malloc+0x152c>
    67bc:	00002097          	auipc	ra,0x2
    67c0:	4ca080e7          	jalr	1226(ra) # 8c86 <link>
    67c4:	34051b63          	bnez	a0,6b1a <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    67c8:	00004517          	auipc	a0,0x4
    67cc:	de850513          	addi	a0,a0,-536 # a5b0 <malloc+0x152c>
    67d0:	00002097          	auipc	ra,0x2
    67d4:	4a6080e7          	jalr	1190(ra) # 8c76 <unlink>
    67d8:	34051f63          	bnez	a0,6b36 <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    67dc:	4581                	li	a1,0
    67de:	00004517          	auipc	a0,0x4
    67e2:	dd250513          	addi	a0,a0,-558 # a5b0 <malloc+0x152c>
    67e6:	00002097          	auipc	ra,0x2
    67ea:	480080e7          	jalr	1152(ra) # 8c66 <open>
    67ee:	36055263          	bgez	a0,6b52 <subdir+0x4b6>
  if(chdir("dd") != 0){
    67f2:	00004517          	auipc	a0,0x4
    67f6:	d1e50513          	addi	a0,a0,-738 # a510 <malloc+0x148c>
    67fa:	00002097          	auipc	ra,0x2
    67fe:	49c080e7          	jalr	1180(ra) # 8c96 <chdir>
    6802:	36051663          	bnez	a0,6b6e <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    6806:	00004517          	auipc	a0,0x4
    680a:	eca50513          	addi	a0,a0,-310 # a6d0 <malloc+0x164c>
    680e:	00002097          	auipc	ra,0x2
    6812:	488080e7          	jalr	1160(ra) # 8c96 <chdir>
    6816:	36051a63          	bnez	a0,6b8a <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    681a:	00004517          	auipc	a0,0x4
    681e:	ee650513          	addi	a0,a0,-282 # a700 <malloc+0x167c>
    6822:	00002097          	auipc	ra,0x2
    6826:	474080e7          	jalr	1140(ra) # 8c96 <chdir>
    682a:	36051e63          	bnez	a0,6ba6 <subdir+0x50a>
  if(chdir("./..") != 0){
    682e:	00004517          	auipc	a0,0x4
    6832:	f0250513          	addi	a0,a0,-254 # a730 <malloc+0x16ac>
    6836:	00002097          	auipc	ra,0x2
    683a:	460080e7          	jalr	1120(ra) # 8c96 <chdir>
    683e:	38051263          	bnez	a0,6bc2 <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    6842:	4581                	li	a1,0
    6844:	00004517          	auipc	a0,0x4
    6848:	df450513          	addi	a0,a0,-524 # a638 <malloc+0x15b4>
    684c:	00002097          	auipc	ra,0x2
    6850:	41a080e7          	jalr	1050(ra) # 8c66 <open>
    6854:	84aa                	mv	s1,a0
  if(fd < 0){
    6856:	38054463          	bltz	a0,6bde <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    685a:	660d                	lui	a2,0x3
    685c:	00009597          	auipc	a1,0x9
    6860:	41c58593          	addi	a1,a1,1052 # fc78 <buf>
    6864:	00002097          	auipc	ra,0x2
    6868:	3da080e7          	jalr	986(ra) # 8c3e <read>
    686c:	4789                	li	a5,2
    686e:	38f51663          	bne	a0,a5,6bfa <subdir+0x55e>
  close(fd);
    6872:	8526                	mv	a0,s1
    6874:	00002097          	auipc	ra,0x2
    6878:	3da080e7          	jalr	986(ra) # 8c4e <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    687c:	4581                	li	a1,0
    687e:	00004517          	auipc	a0,0x4
    6882:	d3250513          	addi	a0,a0,-718 # a5b0 <malloc+0x152c>
    6886:	00002097          	auipc	ra,0x2
    688a:	3e0080e7          	jalr	992(ra) # 8c66 <open>
    688e:	38055463          	bgez	a0,6c16 <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    6892:	20200593          	li	a1,514
    6896:	00004517          	auipc	a0,0x4
    689a:	f2a50513          	addi	a0,a0,-214 # a7c0 <malloc+0x173c>
    689e:	00002097          	auipc	ra,0x2
    68a2:	3c8080e7          	jalr	968(ra) # 8c66 <open>
    68a6:	38055663          	bgez	a0,6c32 <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    68aa:	20200593          	li	a1,514
    68ae:	00004517          	auipc	a0,0x4
    68b2:	f4250513          	addi	a0,a0,-190 # a7f0 <malloc+0x176c>
    68b6:	00002097          	auipc	ra,0x2
    68ba:	3b0080e7          	jalr	944(ra) # 8c66 <open>
    68be:	38055863          	bgez	a0,6c4e <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    68c2:	20000593          	li	a1,512
    68c6:	00004517          	auipc	a0,0x4
    68ca:	c4a50513          	addi	a0,a0,-950 # a510 <malloc+0x148c>
    68ce:	00002097          	auipc	ra,0x2
    68d2:	398080e7          	jalr	920(ra) # 8c66 <open>
    68d6:	38055a63          	bgez	a0,6c6a <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    68da:	4589                	li	a1,2
    68dc:	00004517          	auipc	a0,0x4
    68e0:	c3450513          	addi	a0,a0,-972 # a510 <malloc+0x148c>
    68e4:	00002097          	auipc	ra,0x2
    68e8:	382080e7          	jalr	898(ra) # 8c66 <open>
    68ec:	38055d63          	bgez	a0,6c86 <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    68f0:	4585                	li	a1,1
    68f2:	00004517          	auipc	a0,0x4
    68f6:	c1e50513          	addi	a0,a0,-994 # a510 <malloc+0x148c>
    68fa:	00002097          	auipc	ra,0x2
    68fe:	36c080e7          	jalr	876(ra) # 8c66 <open>
    6902:	3a055063          	bgez	a0,6ca2 <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    6906:	00004597          	auipc	a1,0x4
    690a:	f7a58593          	addi	a1,a1,-134 # a880 <malloc+0x17fc>
    690e:	00004517          	auipc	a0,0x4
    6912:	eb250513          	addi	a0,a0,-334 # a7c0 <malloc+0x173c>
    6916:	00002097          	auipc	ra,0x2
    691a:	370080e7          	jalr	880(ra) # 8c86 <link>
    691e:	3a050063          	beqz	a0,6cbe <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    6922:	00004597          	auipc	a1,0x4
    6926:	f5e58593          	addi	a1,a1,-162 # a880 <malloc+0x17fc>
    692a:	00004517          	auipc	a0,0x4
    692e:	ec650513          	addi	a0,a0,-314 # a7f0 <malloc+0x176c>
    6932:	00002097          	auipc	ra,0x2
    6936:	354080e7          	jalr	852(ra) # 8c86 <link>
    693a:	3a050063          	beqz	a0,6cda <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    693e:	00004597          	auipc	a1,0x4
    6942:	cfa58593          	addi	a1,a1,-774 # a638 <malloc+0x15b4>
    6946:	00004517          	auipc	a0,0x4
    694a:	bea50513          	addi	a0,a0,-1046 # a530 <malloc+0x14ac>
    694e:	00002097          	auipc	ra,0x2
    6952:	338080e7          	jalr	824(ra) # 8c86 <link>
    6956:	3a050063          	beqz	a0,6cf6 <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    695a:	00004517          	auipc	a0,0x4
    695e:	e6650513          	addi	a0,a0,-410 # a7c0 <malloc+0x173c>
    6962:	00002097          	auipc	ra,0x2
    6966:	32c080e7          	jalr	812(ra) # 8c8e <mkdir>
    696a:	3a050463          	beqz	a0,6d12 <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    696e:	00004517          	auipc	a0,0x4
    6972:	e8250513          	addi	a0,a0,-382 # a7f0 <malloc+0x176c>
    6976:	00002097          	auipc	ra,0x2
    697a:	318080e7          	jalr	792(ra) # 8c8e <mkdir>
    697e:	3a050863          	beqz	a0,6d2e <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    6982:	00004517          	auipc	a0,0x4
    6986:	cb650513          	addi	a0,a0,-842 # a638 <malloc+0x15b4>
    698a:	00002097          	auipc	ra,0x2
    698e:	304080e7          	jalr	772(ra) # 8c8e <mkdir>
    6992:	3a050c63          	beqz	a0,6d4a <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    6996:	00004517          	auipc	a0,0x4
    699a:	e5a50513          	addi	a0,a0,-422 # a7f0 <malloc+0x176c>
    699e:	00002097          	auipc	ra,0x2
    69a2:	2d8080e7          	jalr	728(ra) # 8c76 <unlink>
    69a6:	3c050063          	beqz	a0,6d66 <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    69aa:	00004517          	auipc	a0,0x4
    69ae:	e1650513          	addi	a0,a0,-490 # a7c0 <malloc+0x173c>
    69b2:	00002097          	auipc	ra,0x2
    69b6:	2c4080e7          	jalr	708(ra) # 8c76 <unlink>
    69ba:	3c050463          	beqz	a0,6d82 <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    69be:	00004517          	auipc	a0,0x4
    69c2:	b7250513          	addi	a0,a0,-1166 # a530 <malloc+0x14ac>
    69c6:	00002097          	auipc	ra,0x2
    69ca:	2d0080e7          	jalr	720(ra) # 8c96 <chdir>
    69ce:	3c050863          	beqz	a0,6d9e <subdir+0x702>
  if(chdir("dd/xx") == 0){
    69d2:	00004517          	auipc	a0,0x4
    69d6:	ffe50513          	addi	a0,a0,-2 # a9d0 <malloc+0x194c>
    69da:	00002097          	auipc	ra,0x2
    69de:	2bc080e7          	jalr	700(ra) # 8c96 <chdir>
    69e2:	3c050c63          	beqz	a0,6dba <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    69e6:	00004517          	auipc	a0,0x4
    69ea:	c5250513          	addi	a0,a0,-942 # a638 <malloc+0x15b4>
    69ee:	00002097          	auipc	ra,0x2
    69f2:	288080e7          	jalr	648(ra) # 8c76 <unlink>
    69f6:	3e051063          	bnez	a0,6dd6 <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    69fa:	00004517          	auipc	a0,0x4
    69fe:	b3650513          	addi	a0,a0,-1226 # a530 <malloc+0x14ac>
    6a02:	00002097          	auipc	ra,0x2
    6a06:	274080e7          	jalr	628(ra) # 8c76 <unlink>
    6a0a:	3e051463          	bnez	a0,6df2 <subdir+0x756>
  if(unlink("dd") == 0){
    6a0e:	00004517          	auipc	a0,0x4
    6a12:	b0250513          	addi	a0,a0,-1278 # a510 <malloc+0x148c>
    6a16:	00002097          	auipc	ra,0x2
    6a1a:	260080e7          	jalr	608(ra) # 8c76 <unlink>
    6a1e:	3e050863          	beqz	a0,6e0e <subdir+0x772>
  if(unlink("dd/dd") < 0){
    6a22:	00004517          	auipc	a0,0x4
    6a26:	01e50513          	addi	a0,a0,30 # aa40 <malloc+0x19bc>
    6a2a:	00002097          	auipc	ra,0x2
    6a2e:	24c080e7          	jalr	588(ra) # 8c76 <unlink>
    6a32:	3e054c63          	bltz	a0,6e2a <subdir+0x78e>
  if(unlink("dd") < 0){
    6a36:	00004517          	auipc	a0,0x4
    6a3a:	ada50513          	addi	a0,a0,-1318 # a510 <malloc+0x148c>
    6a3e:	00002097          	auipc	ra,0x2
    6a42:	238080e7          	jalr	568(ra) # 8c76 <unlink>
    6a46:	40054063          	bltz	a0,6e46 <subdir+0x7aa>
}
    6a4a:	60e2                	ld	ra,24(sp)
    6a4c:	6442                	ld	s0,16(sp)
    6a4e:	64a2                	ld	s1,8(sp)
    6a50:	6902                	ld	s2,0(sp)
    6a52:	6105                	addi	sp,sp,32
    6a54:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    6a56:	85ca                	mv	a1,s2
    6a58:	00004517          	auipc	a0,0x4
    6a5c:	ac050513          	addi	a0,a0,-1344 # a518 <malloc+0x1494>
    6a60:	00002097          	auipc	ra,0x2
    6a64:	566080e7          	jalr	1382(ra) # 8fc6 <printf>
    exit(1);
    6a68:	4505                	li	a0,1
    6a6a:	00002097          	auipc	ra,0x2
    6a6e:	1b4080e7          	jalr	436(ra) # 8c1e <exit>
    printf("%s: create dd/ff failed\n", s);
    6a72:	85ca                	mv	a1,s2
    6a74:	00004517          	auipc	a0,0x4
    6a78:	ac450513          	addi	a0,a0,-1340 # a538 <malloc+0x14b4>
    6a7c:	00002097          	auipc	ra,0x2
    6a80:	54a080e7          	jalr	1354(ra) # 8fc6 <printf>
    exit(1);
    6a84:	4505                	li	a0,1
    6a86:	00002097          	auipc	ra,0x2
    6a8a:	198080e7          	jalr	408(ra) # 8c1e <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    6a8e:	85ca                	mv	a1,s2
    6a90:	00004517          	auipc	a0,0x4
    6a94:	ac850513          	addi	a0,a0,-1336 # a558 <malloc+0x14d4>
    6a98:	00002097          	auipc	ra,0x2
    6a9c:	52e080e7          	jalr	1326(ra) # 8fc6 <printf>
    exit(1);
    6aa0:	4505                	li	a0,1
    6aa2:	00002097          	auipc	ra,0x2
    6aa6:	17c080e7          	jalr	380(ra) # 8c1e <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    6aaa:	85ca                	mv	a1,s2
    6aac:	00004517          	auipc	a0,0x4
    6ab0:	ae450513          	addi	a0,a0,-1308 # a590 <malloc+0x150c>
    6ab4:	00002097          	auipc	ra,0x2
    6ab8:	512080e7          	jalr	1298(ra) # 8fc6 <printf>
    exit(1);
    6abc:	4505                	li	a0,1
    6abe:	00002097          	auipc	ra,0x2
    6ac2:	160080e7          	jalr	352(ra) # 8c1e <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    6ac6:	85ca                	mv	a1,s2
    6ac8:	00004517          	auipc	a0,0x4
    6acc:	af850513          	addi	a0,a0,-1288 # a5c0 <malloc+0x153c>
    6ad0:	00002097          	auipc	ra,0x2
    6ad4:	4f6080e7          	jalr	1270(ra) # 8fc6 <printf>
    exit(1);
    6ad8:	4505                	li	a0,1
    6ada:	00002097          	auipc	ra,0x2
    6ade:	144080e7          	jalr	324(ra) # 8c1e <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    6ae2:	85ca                	mv	a1,s2
    6ae4:	00004517          	auipc	a0,0x4
    6ae8:	b1450513          	addi	a0,a0,-1260 # a5f8 <malloc+0x1574>
    6aec:	00002097          	auipc	ra,0x2
    6af0:	4da080e7          	jalr	1242(ra) # 8fc6 <printf>
    exit(1);
    6af4:	4505                	li	a0,1
    6af6:	00002097          	auipc	ra,0x2
    6afa:	128080e7          	jalr	296(ra) # 8c1e <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    6afe:	85ca                	mv	a1,s2
    6b00:	00004517          	auipc	a0,0x4
    6b04:	b1850513          	addi	a0,a0,-1256 # a618 <malloc+0x1594>
    6b08:	00002097          	auipc	ra,0x2
    6b0c:	4be080e7          	jalr	1214(ra) # 8fc6 <printf>
    exit(1);
    6b10:	4505                	li	a0,1
    6b12:	00002097          	auipc	ra,0x2
    6b16:	10c080e7          	jalr	268(ra) # 8c1e <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    6b1a:	85ca                	mv	a1,s2
    6b1c:	00004517          	auipc	a0,0x4
    6b20:	b2c50513          	addi	a0,a0,-1236 # a648 <malloc+0x15c4>
    6b24:	00002097          	auipc	ra,0x2
    6b28:	4a2080e7          	jalr	1186(ra) # 8fc6 <printf>
    exit(1);
    6b2c:	4505                	li	a0,1
    6b2e:	00002097          	auipc	ra,0x2
    6b32:	0f0080e7          	jalr	240(ra) # 8c1e <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    6b36:	85ca                	mv	a1,s2
    6b38:	00004517          	auipc	a0,0x4
    6b3c:	b3850513          	addi	a0,a0,-1224 # a670 <malloc+0x15ec>
    6b40:	00002097          	auipc	ra,0x2
    6b44:	486080e7          	jalr	1158(ra) # 8fc6 <printf>
    exit(1);
    6b48:	4505                	li	a0,1
    6b4a:	00002097          	auipc	ra,0x2
    6b4e:	0d4080e7          	jalr	212(ra) # 8c1e <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    6b52:	85ca                	mv	a1,s2
    6b54:	00004517          	auipc	a0,0x4
    6b58:	b3c50513          	addi	a0,a0,-1220 # a690 <malloc+0x160c>
    6b5c:	00002097          	auipc	ra,0x2
    6b60:	46a080e7          	jalr	1130(ra) # 8fc6 <printf>
    exit(1);
    6b64:	4505                	li	a0,1
    6b66:	00002097          	auipc	ra,0x2
    6b6a:	0b8080e7          	jalr	184(ra) # 8c1e <exit>
    printf("%s: chdir dd failed\n", s);
    6b6e:	85ca                	mv	a1,s2
    6b70:	00004517          	auipc	a0,0x4
    6b74:	b4850513          	addi	a0,a0,-1208 # a6b8 <malloc+0x1634>
    6b78:	00002097          	auipc	ra,0x2
    6b7c:	44e080e7          	jalr	1102(ra) # 8fc6 <printf>
    exit(1);
    6b80:	4505                	li	a0,1
    6b82:	00002097          	auipc	ra,0x2
    6b86:	09c080e7          	jalr	156(ra) # 8c1e <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    6b8a:	85ca                	mv	a1,s2
    6b8c:	00004517          	auipc	a0,0x4
    6b90:	b5450513          	addi	a0,a0,-1196 # a6e0 <malloc+0x165c>
    6b94:	00002097          	auipc	ra,0x2
    6b98:	432080e7          	jalr	1074(ra) # 8fc6 <printf>
    exit(1);
    6b9c:	4505                	li	a0,1
    6b9e:	00002097          	auipc	ra,0x2
    6ba2:	080080e7          	jalr	128(ra) # 8c1e <exit>
    printf("chdir dd/../../dd failed\n", s);
    6ba6:	85ca                	mv	a1,s2
    6ba8:	00004517          	auipc	a0,0x4
    6bac:	b6850513          	addi	a0,a0,-1176 # a710 <malloc+0x168c>
    6bb0:	00002097          	auipc	ra,0x2
    6bb4:	416080e7          	jalr	1046(ra) # 8fc6 <printf>
    exit(1);
    6bb8:	4505                	li	a0,1
    6bba:	00002097          	auipc	ra,0x2
    6bbe:	064080e7          	jalr	100(ra) # 8c1e <exit>
    printf("%s: chdir ./.. failed\n", s);
    6bc2:	85ca                	mv	a1,s2
    6bc4:	00004517          	auipc	a0,0x4
    6bc8:	b7450513          	addi	a0,a0,-1164 # a738 <malloc+0x16b4>
    6bcc:	00002097          	auipc	ra,0x2
    6bd0:	3fa080e7          	jalr	1018(ra) # 8fc6 <printf>
    exit(1);
    6bd4:	4505                	li	a0,1
    6bd6:	00002097          	auipc	ra,0x2
    6bda:	048080e7          	jalr	72(ra) # 8c1e <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    6bde:	85ca                	mv	a1,s2
    6be0:	00004517          	auipc	a0,0x4
    6be4:	b7050513          	addi	a0,a0,-1168 # a750 <malloc+0x16cc>
    6be8:	00002097          	auipc	ra,0x2
    6bec:	3de080e7          	jalr	990(ra) # 8fc6 <printf>
    exit(1);
    6bf0:	4505                	li	a0,1
    6bf2:	00002097          	auipc	ra,0x2
    6bf6:	02c080e7          	jalr	44(ra) # 8c1e <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    6bfa:	85ca                	mv	a1,s2
    6bfc:	00004517          	auipc	a0,0x4
    6c00:	b7450513          	addi	a0,a0,-1164 # a770 <malloc+0x16ec>
    6c04:	00002097          	auipc	ra,0x2
    6c08:	3c2080e7          	jalr	962(ra) # 8fc6 <printf>
    exit(1);
    6c0c:	4505                	li	a0,1
    6c0e:	00002097          	auipc	ra,0x2
    6c12:	010080e7          	jalr	16(ra) # 8c1e <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    6c16:	85ca                	mv	a1,s2
    6c18:	00004517          	auipc	a0,0x4
    6c1c:	b7850513          	addi	a0,a0,-1160 # a790 <malloc+0x170c>
    6c20:	00002097          	auipc	ra,0x2
    6c24:	3a6080e7          	jalr	934(ra) # 8fc6 <printf>
    exit(1);
    6c28:	4505                	li	a0,1
    6c2a:	00002097          	auipc	ra,0x2
    6c2e:	ff4080e7          	jalr	-12(ra) # 8c1e <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    6c32:	85ca                	mv	a1,s2
    6c34:	00004517          	auipc	a0,0x4
    6c38:	b9c50513          	addi	a0,a0,-1124 # a7d0 <malloc+0x174c>
    6c3c:	00002097          	auipc	ra,0x2
    6c40:	38a080e7          	jalr	906(ra) # 8fc6 <printf>
    exit(1);
    6c44:	4505                	li	a0,1
    6c46:	00002097          	auipc	ra,0x2
    6c4a:	fd8080e7          	jalr	-40(ra) # 8c1e <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    6c4e:	85ca                	mv	a1,s2
    6c50:	00004517          	auipc	a0,0x4
    6c54:	bb050513          	addi	a0,a0,-1104 # a800 <malloc+0x177c>
    6c58:	00002097          	auipc	ra,0x2
    6c5c:	36e080e7          	jalr	878(ra) # 8fc6 <printf>
    exit(1);
    6c60:	4505                	li	a0,1
    6c62:	00002097          	auipc	ra,0x2
    6c66:	fbc080e7          	jalr	-68(ra) # 8c1e <exit>
    printf("%s: create dd succeeded!\n", s);
    6c6a:	85ca                	mv	a1,s2
    6c6c:	00004517          	auipc	a0,0x4
    6c70:	bb450513          	addi	a0,a0,-1100 # a820 <malloc+0x179c>
    6c74:	00002097          	auipc	ra,0x2
    6c78:	352080e7          	jalr	850(ra) # 8fc6 <printf>
    exit(1);
    6c7c:	4505                	li	a0,1
    6c7e:	00002097          	auipc	ra,0x2
    6c82:	fa0080e7          	jalr	-96(ra) # 8c1e <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    6c86:	85ca                	mv	a1,s2
    6c88:	00004517          	auipc	a0,0x4
    6c8c:	bb850513          	addi	a0,a0,-1096 # a840 <malloc+0x17bc>
    6c90:	00002097          	auipc	ra,0x2
    6c94:	336080e7          	jalr	822(ra) # 8fc6 <printf>
    exit(1);
    6c98:	4505                	li	a0,1
    6c9a:	00002097          	auipc	ra,0x2
    6c9e:	f84080e7          	jalr	-124(ra) # 8c1e <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    6ca2:	85ca                	mv	a1,s2
    6ca4:	00004517          	auipc	a0,0x4
    6ca8:	bbc50513          	addi	a0,a0,-1092 # a860 <malloc+0x17dc>
    6cac:	00002097          	auipc	ra,0x2
    6cb0:	31a080e7          	jalr	794(ra) # 8fc6 <printf>
    exit(1);
    6cb4:	4505                	li	a0,1
    6cb6:	00002097          	auipc	ra,0x2
    6cba:	f68080e7          	jalr	-152(ra) # 8c1e <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    6cbe:	85ca                	mv	a1,s2
    6cc0:	00004517          	auipc	a0,0x4
    6cc4:	bd050513          	addi	a0,a0,-1072 # a890 <malloc+0x180c>
    6cc8:	00002097          	auipc	ra,0x2
    6ccc:	2fe080e7          	jalr	766(ra) # 8fc6 <printf>
    exit(1);
    6cd0:	4505                	li	a0,1
    6cd2:	00002097          	auipc	ra,0x2
    6cd6:	f4c080e7          	jalr	-180(ra) # 8c1e <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    6cda:	85ca                	mv	a1,s2
    6cdc:	00004517          	auipc	a0,0x4
    6ce0:	bdc50513          	addi	a0,a0,-1060 # a8b8 <malloc+0x1834>
    6ce4:	00002097          	auipc	ra,0x2
    6ce8:	2e2080e7          	jalr	738(ra) # 8fc6 <printf>
    exit(1);
    6cec:	4505                	li	a0,1
    6cee:	00002097          	auipc	ra,0x2
    6cf2:	f30080e7          	jalr	-208(ra) # 8c1e <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    6cf6:	85ca                	mv	a1,s2
    6cf8:	00004517          	auipc	a0,0x4
    6cfc:	be850513          	addi	a0,a0,-1048 # a8e0 <malloc+0x185c>
    6d00:	00002097          	auipc	ra,0x2
    6d04:	2c6080e7          	jalr	710(ra) # 8fc6 <printf>
    exit(1);
    6d08:	4505                	li	a0,1
    6d0a:	00002097          	auipc	ra,0x2
    6d0e:	f14080e7          	jalr	-236(ra) # 8c1e <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    6d12:	85ca                	mv	a1,s2
    6d14:	00004517          	auipc	a0,0x4
    6d18:	bf450513          	addi	a0,a0,-1036 # a908 <malloc+0x1884>
    6d1c:	00002097          	auipc	ra,0x2
    6d20:	2aa080e7          	jalr	682(ra) # 8fc6 <printf>
    exit(1);
    6d24:	4505                	li	a0,1
    6d26:	00002097          	auipc	ra,0x2
    6d2a:	ef8080e7          	jalr	-264(ra) # 8c1e <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    6d2e:	85ca                	mv	a1,s2
    6d30:	00004517          	auipc	a0,0x4
    6d34:	bf850513          	addi	a0,a0,-1032 # a928 <malloc+0x18a4>
    6d38:	00002097          	auipc	ra,0x2
    6d3c:	28e080e7          	jalr	654(ra) # 8fc6 <printf>
    exit(1);
    6d40:	4505                	li	a0,1
    6d42:	00002097          	auipc	ra,0x2
    6d46:	edc080e7          	jalr	-292(ra) # 8c1e <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    6d4a:	85ca                	mv	a1,s2
    6d4c:	00004517          	auipc	a0,0x4
    6d50:	bfc50513          	addi	a0,a0,-1028 # a948 <malloc+0x18c4>
    6d54:	00002097          	auipc	ra,0x2
    6d58:	272080e7          	jalr	626(ra) # 8fc6 <printf>
    exit(1);
    6d5c:	4505                	li	a0,1
    6d5e:	00002097          	auipc	ra,0x2
    6d62:	ec0080e7          	jalr	-320(ra) # 8c1e <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    6d66:	85ca                	mv	a1,s2
    6d68:	00004517          	auipc	a0,0x4
    6d6c:	c0850513          	addi	a0,a0,-1016 # a970 <malloc+0x18ec>
    6d70:	00002097          	auipc	ra,0x2
    6d74:	256080e7          	jalr	598(ra) # 8fc6 <printf>
    exit(1);
    6d78:	4505                	li	a0,1
    6d7a:	00002097          	auipc	ra,0x2
    6d7e:	ea4080e7          	jalr	-348(ra) # 8c1e <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    6d82:	85ca                	mv	a1,s2
    6d84:	00004517          	auipc	a0,0x4
    6d88:	c0c50513          	addi	a0,a0,-1012 # a990 <malloc+0x190c>
    6d8c:	00002097          	auipc	ra,0x2
    6d90:	23a080e7          	jalr	570(ra) # 8fc6 <printf>
    exit(1);
    6d94:	4505                	li	a0,1
    6d96:	00002097          	auipc	ra,0x2
    6d9a:	e88080e7          	jalr	-376(ra) # 8c1e <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    6d9e:	85ca                	mv	a1,s2
    6da0:	00004517          	auipc	a0,0x4
    6da4:	c1050513          	addi	a0,a0,-1008 # a9b0 <malloc+0x192c>
    6da8:	00002097          	auipc	ra,0x2
    6dac:	21e080e7          	jalr	542(ra) # 8fc6 <printf>
    exit(1);
    6db0:	4505                	li	a0,1
    6db2:	00002097          	auipc	ra,0x2
    6db6:	e6c080e7          	jalr	-404(ra) # 8c1e <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    6dba:	85ca                	mv	a1,s2
    6dbc:	00004517          	auipc	a0,0x4
    6dc0:	c1c50513          	addi	a0,a0,-996 # a9d8 <malloc+0x1954>
    6dc4:	00002097          	auipc	ra,0x2
    6dc8:	202080e7          	jalr	514(ra) # 8fc6 <printf>
    exit(1);
    6dcc:	4505                	li	a0,1
    6dce:	00002097          	auipc	ra,0x2
    6dd2:	e50080e7          	jalr	-432(ra) # 8c1e <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    6dd6:	85ca                	mv	a1,s2
    6dd8:	00004517          	auipc	a0,0x4
    6ddc:	89850513          	addi	a0,a0,-1896 # a670 <malloc+0x15ec>
    6de0:	00002097          	auipc	ra,0x2
    6de4:	1e6080e7          	jalr	486(ra) # 8fc6 <printf>
    exit(1);
    6de8:	4505                	li	a0,1
    6dea:	00002097          	auipc	ra,0x2
    6dee:	e34080e7          	jalr	-460(ra) # 8c1e <exit>
    printf("%s: unlink dd/ff failed\n", s);
    6df2:	85ca                	mv	a1,s2
    6df4:	00004517          	auipc	a0,0x4
    6df8:	c0450513          	addi	a0,a0,-1020 # a9f8 <malloc+0x1974>
    6dfc:	00002097          	auipc	ra,0x2
    6e00:	1ca080e7          	jalr	458(ra) # 8fc6 <printf>
    exit(1);
    6e04:	4505                	li	a0,1
    6e06:	00002097          	auipc	ra,0x2
    6e0a:	e18080e7          	jalr	-488(ra) # 8c1e <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    6e0e:	85ca                	mv	a1,s2
    6e10:	00004517          	auipc	a0,0x4
    6e14:	c0850513          	addi	a0,a0,-1016 # aa18 <malloc+0x1994>
    6e18:	00002097          	auipc	ra,0x2
    6e1c:	1ae080e7          	jalr	430(ra) # 8fc6 <printf>
    exit(1);
    6e20:	4505                	li	a0,1
    6e22:	00002097          	auipc	ra,0x2
    6e26:	dfc080e7          	jalr	-516(ra) # 8c1e <exit>
    printf("%s: unlink dd/dd failed\n", s);
    6e2a:	85ca                	mv	a1,s2
    6e2c:	00004517          	auipc	a0,0x4
    6e30:	c1c50513          	addi	a0,a0,-996 # aa48 <malloc+0x19c4>
    6e34:	00002097          	auipc	ra,0x2
    6e38:	192080e7          	jalr	402(ra) # 8fc6 <printf>
    exit(1);
    6e3c:	4505                	li	a0,1
    6e3e:	00002097          	auipc	ra,0x2
    6e42:	de0080e7          	jalr	-544(ra) # 8c1e <exit>
    printf("%s: unlink dd failed\n", s);
    6e46:	85ca                	mv	a1,s2
    6e48:	00004517          	auipc	a0,0x4
    6e4c:	c2050513          	addi	a0,a0,-992 # aa68 <malloc+0x19e4>
    6e50:	00002097          	auipc	ra,0x2
    6e54:	176080e7          	jalr	374(ra) # 8fc6 <printf>
    exit(1);
    6e58:	4505                	li	a0,1
    6e5a:	00002097          	auipc	ra,0x2
    6e5e:	dc4080e7          	jalr	-572(ra) # 8c1e <exit>

0000000000006e62 <rmdot>:
{
    6e62:	1101                	addi	sp,sp,-32
    6e64:	ec06                	sd	ra,24(sp)
    6e66:	e822                	sd	s0,16(sp)
    6e68:	e426                	sd	s1,8(sp)
    6e6a:	1000                	addi	s0,sp,32
    6e6c:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    6e6e:	00004517          	auipc	a0,0x4
    6e72:	c1250513          	addi	a0,a0,-1006 # aa80 <malloc+0x19fc>
    6e76:	00002097          	auipc	ra,0x2
    6e7a:	e18080e7          	jalr	-488(ra) # 8c8e <mkdir>
    6e7e:	e549                	bnez	a0,6f08 <rmdot+0xa6>
  if(chdir("dots") != 0){
    6e80:	00004517          	auipc	a0,0x4
    6e84:	c0050513          	addi	a0,a0,-1024 # aa80 <malloc+0x19fc>
    6e88:	00002097          	auipc	ra,0x2
    6e8c:	e0e080e7          	jalr	-498(ra) # 8c96 <chdir>
    6e90:	e951                	bnez	a0,6f24 <rmdot+0xc2>
  if(unlink(".") == 0){
    6e92:	00003517          	auipc	a0,0x3
    6e96:	a1e50513          	addi	a0,a0,-1506 # 98b0 <malloc+0x82c>
    6e9a:	00002097          	auipc	ra,0x2
    6e9e:	ddc080e7          	jalr	-548(ra) # 8c76 <unlink>
    6ea2:	cd59                	beqz	a0,6f40 <rmdot+0xde>
  if(unlink("..") == 0){
    6ea4:	00003517          	auipc	a0,0x3
    6ea8:	63450513          	addi	a0,a0,1588 # a4d8 <malloc+0x1454>
    6eac:	00002097          	auipc	ra,0x2
    6eb0:	dca080e7          	jalr	-566(ra) # 8c76 <unlink>
    6eb4:	c545                	beqz	a0,6f5c <rmdot+0xfa>
  if(chdir("/") != 0){
    6eb6:	00003517          	auipc	a0,0x3
    6eba:	5ca50513          	addi	a0,a0,1482 # a480 <malloc+0x13fc>
    6ebe:	00002097          	auipc	ra,0x2
    6ec2:	dd8080e7          	jalr	-552(ra) # 8c96 <chdir>
    6ec6:	e94d                	bnez	a0,6f78 <rmdot+0x116>
  if(unlink("dots/.") == 0){
    6ec8:	00004517          	auipc	a0,0x4
    6ecc:	c2050513          	addi	a0,a0,-992 # aae8 <malloc+0x1a64>
    6ed0:	00002097          	auipc	ra,0x2
    6ed4:	da6080e7          	jalr	-602(ra) # 8c76 <unlink>
    6ed8:	cd55                	beqz	a0,6f94 <rmdot+0x132>
  if(unlink("dots/..") == 0){
    6eda:	00004517          	auipc	a0,0x4
    6ede:	c3650513          	addi	a0,a0,-970 # ab10 <malloc+0x1a8c>
    6ee2:	00002097          	auipc	ra,0x2
    6ee6:	d94080e7          	jalr	-620(ra) # 8c76 <unlink>
    6eea:	c179                	beqz	a0,6fb0 <rmdot+0x14e>
  if(unlink("dots") != 0){
    6eec:	00004517          	auipc	a0,0x4
    6ef0:	b9450513          	addi	a0,a0,-1132 # aa80 <malloc+0x19fc>
    6ef4:	00002097          	auipc	ra,0x2
    6ef8:	d82080e7          	jalr	-638(ra) # 8c76 <unlink>
    6efc:	e961                	bnez	a0,6fcc <rmdot+0x16a>
}
    6efe:	60e2                	ld	ra,24(sp)
    6f00:	6442                	ld	s0,16(sp)
    6f02:	64a2                	ld	s1,8(sp)
    6f04:	6105                	addi	sp,sp,32
    6f06:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    6f08:	85a6                	mv	a1,s1
    6f0a:	00004517          	auipc	a0,0x4
    6f0e:	b7e50513          	addi	a0,a0,-1154 # aa88 <malloc+0x1a04>
    6f12:	00002097          	auipc	ra,0x2
    6f16:	0b4080e7          	jalr	180(ra) # 8fc6 <printf>
    exit(1);
    6f1a:	4505                	li	a0,1
    6f1c:	00002097          	auipc	ra,0x2
    6f20:	d02080e7          	jalr	-766(ra) # 8c1e <exit>
    printf("%s: chdir dots failed\n", s);
    6f24:	85a6                	mv	a1,s1
    6f26:	00004517          	auipc	a0,0x4
    6f2a:	b7a50513          	addi	a0,a0,-1158 # aaa0 <malloc+0x1a1c>
    6f2e:	00002097          	auipc	ra,0x2
    6f32:	098080e7          	jalr	152(ra) # 8fc6 <printf>
    exit(1);
    6f36:	4505                	li	a0,1
    6f38:	00002097          	auipc	ra,0x2
    6f3c:	ce6080e7          	jalr	-794(ra) # 8c1e <exit>
    printf("%s: rm . worked!\n", s);
    6f40:	85a6                	mv	a1,s1
    6f42:	00004517          	auipc	a0,0x4
    6f46:	b7650513          	addi	a0,a0,-1162 # aab8 <malloc+0x1a34>
    6f4a:	00002097          	auipc	ra,0x2
    6f4e:	07c080e7          	jalr	124(ra) # 8fc6 <printf>
    exit(1);
    6f52:	4505                	li	a0,1
    6f54:	00002097          	auipc	ra,0x2
    6f58:	cca080e7          	jalr	-822(ra) # 8c1e <exit>
    printf("%s: rm .. worked!\n", s);
    6f5c:	85a6                	mv	a1,s1
    6f5e:	00004517          	auipc	a0,0x4
    6f62:	b7250513          	addi	a0,a0,-1166 # aad0 <malloc+0x1a4c>
    6f66:	00002097          	auipc	ra,0x2
    6f6a:	060080e7          	jalr	96(ra) # 8fc6 <printf>
    exit(1);
    6f6e:	4505                	li	a0,1
    6f70:	00002097          	auipc	ra,0x2
    6f74:	cae080e7          	jalr	-850(ra) # 8c1e <exit>
    printf("%s: chdir / failed\n", s);
    6f78:	85a6                	mv	a1,s1
    6f7a:	00003517          	auipc	a0,0x3
    6f7e:	50e50513          	addi	a0,a0,1294 # a488 <malloc+0x1404>
    6f82:	00002097          	auipc	ra,0x2
    6f86:	044080e7          	jalr	68(ra) # 8fc6 <printf>
    exit(1);
    6f8a:	4505                	li	a0,1
    6f8c:	00002097          	auipc	ra,0x2
    6f90:	c92080e7          	jalr	-878(ra) # 8c1e <exit>
    printf("%s: unlink dots/. worked!\n", s);
    6f94:	85a6                	mv	a1,s1
    6f96:	00004517          	auipc	a0,0x4
    6f9a:	b5a50513          	addi	a0,a0,-1190 # aaf0 <malloc+0x1a6c>
    6f9e:	00002097          	auipc	ra,0x2
    6fa2:	028080e7          	jalr	40(ra) # 8fc6 <printf>
    exit(1);
    6fa6:	4505                	li	a0,1
    6fa8:	00002097          	auipc	ra,0x2
    6fac:	c76080e7          	jalr	-906(ra) # 8c1e <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    6fb0:	85a6                	mv	a1,s1
    6fb2:	00004517          	auipc	a0,0x4
    6fb6:	b6650513          	addi	a0,a0,-1178 # ab18 <malloc+0x1a94>
    6fba:	00002097          	auipc	ra,0x2
    6fbe:	00c080e7          	jalr	12(ra) # 8fc6 <printf>
    exit(1);
    6fc2:	4505                	li	a0,1
    6fc4:	00002097          	auipc	ra,0x2
    6fc8:	c5a080e7          	jalr	-934(ra) # 8c1e <exit>
    printf("%s: unlink dots failed!\n", s);
    6fcc:	85a6                	mv	a1,s1
    6fce:	00004517          	auipc	a0,0x4
    6fd2:	b6a50513          	addi	a0,a0,-1174 # ab38 <malloc+0x1ab4>
    6fd6:	00002097          	auipc	ra,0x2
    6fda:	ff0080e7          	jalr	-16(ra) # 8fc6 <printf>
    exit(1);
    6fde:	4505                	li	a0,1
    6fe0:	00002097          	auipc	ra,0x2
    6fe4:	c3e080e7          	jalr	-962(ra) # 8c1e <exit>

0000000000006fe8 <dirfile>:
{
    6fe8:	1101                	addi	sp,sp,-32
    6fea:	ec06                	sd	ra,24(sp)
    6fec:	e822                	sd	s0,16(sp)
    6fee:	e426                	sd	s1,8(sp)
    6ff0:	e04a                	sd	s2,0(sp)
    6ff2:	1000                	addi	s0,sp,32
    6ff4:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    6ff6:	20000593          	li	a1,512
    6ffa:	00004517          	auipc	a0,0x4
    6ffe:	b5e50513          	addi	a0,a0,-1186 # ab58 <malloc+0x1ad4>
    7002:	00002097          	auipc	ra,0x2
    7006:	c64080e7          	jalr	-924(ra) # 8c66 <open>
  if(fd < 0){
    700a:	0e054d63          	bltz	a0,7104 <dirfile+0x11c>
  close(fd);
    700e:	00002097          	auipc	ra,0x2
    7012:	c40080e7          	jalr	-960(ra) # 8c4e <close>
  if(chdir("dirfile") == 0){
    7016:	00004517          	auipc	a0,0x4
    701a:	b4250513          	addi	a0,a0,-1214 # ab58 <malloc+0x1ad4>
    701e:	00002097          	auipc	ra,0x2
    7022:	c78080e7          	jalr	-904(ra) # 8c96 <chdir>
    7026:	cd6d                	beqz	a0,7120 <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    7028:	4581                	li	a1,0
    702a:	00004517          	auipc	a0,0x4
    702e:	b7650513          	addi	a0,a0,-1162 # aba0 <malloc+0x1b1c>
    7032:	00002097          	auipc	ra,0x2
    7036:	c34080e7          	jalr	-972(ra) # 8c66 <open>
  if(fd >= 0){
    703a:	10055163          	bgez	a0,713c <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    703e:	20000593          	li	a1,512
    7042:	00004517          	auipc	a0,0x4
    7046:	b5e50513          	addi	a0,a0,-1186 # aba0 <malloc+0x1b1c>
    704a:	00002097          	auipc	ra,0x2
    704e:	c1c080e7          	jalr	-996(ra) # 8c66 <open>
  if(fd >= 0){
    7052:	10055363          	bgez	a0,7158 <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    7056:	00004517          	auipc	a0,0x4
    705a:	b4a50513          	addi	a0,a0,-1206 # aba0 <malloc+0x1b1c>
    705e:	00002097          	auipc	ra,0x2
    7062:	c30080e7          	jalr	-976(ra) # 8c8e <mkdir>
    7066:	10050763          	beqz	a0,7174 <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    706a:	00004517          	auipc	a0,0x4
    706e:	b3650513          	addi	a0,a0,-1226 # aba0 <malloc+0x1b1c>
    7072:	00002097          	auipc	ra,0x2
    7076:	c04080e7          	jalr	-1020(ra) # 8c76 <unlink>
    707a:	10050b63          	beqz	a0,7190 <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    707e:	00004597          	auipc	a1,0x4
    7082:	b2258593          	addi	a1,a1,-1246 # aba0 <malloc+0x1b1c>
    7086:	00002517          	auipc	a0,0x2
    708a:	31a50513          	addi	a0,a0,794 # 93a0 <malloc+0x31c>
    708e:	00002097          	auipc	ra,0x2
    7092:	bf8080e7          	jalr	-1032(ra) # 8c86 <link>
    7096:	10050b63          	beqz	a0,71ac <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    709a:	00004517          	auipc	a0,0x4
    709e:	abe50513          	addi	a0,a0,-1346 # ab58 <malloc+0x1ad4>
    70a2:	00002097          	auipc	ra,0x2
    70a6:	bd4080e7          	jalr	-1068(ra) # 8c76 <unlink>
    70aa:	10051f63          	bnez	a0,71c8 <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    70ae:	4589                	li	a1,2
    70b0:	00003517          	auipc	a0,0x3
    70b4:	80050513          	addi	a0,a0,-2048 # 98b0 <malloc+0x82c>
    70b8:	00002097          	auipc	ra,0x2
    70bc:	bae080e7          	jalr	-1106(ra) # 8c66 <open>
  if(fd >= 0){
    70c0:	12055263          	bgez	a0,71e4 <dirfile+0x1fc>
  fd = open(".", 0);
    70c4:	4581                	li	a1,0
    70c6:	00002517          	auipc	a0,0x2
    70ca:	7ea50513          	addi	a0,a0,2026 # 98b0 <malloc+0x82c>
    70ce:	00002097          	auipc	ra,0x2
    70d2:	b98080e7          	jalr	-1128(ra) # 8c66 <open>
    70d6:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    70d8:	4605                	li	a2,1
    70da:	00002597          	auipc	a1,0x2
    70de:	15e58593          	addi	a1,a1,350 # 9238 <malloc+0x1b4>
    70e2:	00002097          	auipc	ra,0x2
    70e6:	b64080e7          	jalr	-1180(ra) # 8c46 <write>
    70ea:	10a04b63          	bgtz	a0,7200 <dirfile+0x218>
  close(fd);
    70ee:	8526                	mv	a0,s1
    70f0:	00002097          	auipc	ra,0x2
    70f4:	b5e080e7          	jalr	-1186(ra) # 8c4e <close>
}
    70f8:	60e2                	ld	ra,24(sp)
    70fa:	6442                	ld	s0,16(sp)
    70fc:	64a2                	ld	s1,8(sp)
    70fe:	6902                	ld	s2,0(sp)
    7100:	6105                	addi	sp,sp,32
    7102:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    7104:	85ca                	mv	a1,s2
    7106:	00004517          	auipc	a0,0x4
    710a:	a5a50513          	addi	a0,a0,-1446 # ab60 <malloc+0x1adc>
    710e:	00002097          	auipc	ra,0x2
    7112:	eb8080e7          	jalr	-328(ra) # 8fc6 <printf>
    exit(1);
    7116:	4505                	li	a0,1
    7118:	00002097          	auipc	ra,0x2
    711c:	b06080e7          	jalr	-1274(ra) # 8c1e <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    7120:	85ca                	mv	a1,s2
    7122:	00004517          	auipc	a0,0x4
    7126:	a5e50513          	addi	a0,a0,-1442 # ab80 <malloc+0x1afc>
    712a:	00002097          	auipc	ra,0x2
    712e:	e9c080e7          	jalr	-356(ra) # 8fc6 <printf>
    exit(1);
    7132:	4505                	li	a0,1
    7134:	00002097          	auipc	ra,0x2
    7138:	aea080e7          	jalr	-1302(ra) # 8c1e <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    713c:	85ca                	mv	a1,s2
    713e:	00004517          	auipc	a0,0x4
    7142:	a7250513          	addi	a0,a0,-1422 # abb0 <malloc+0x1b2c>
    7146:	00002097          	auipc	ra,0x2
    714a:	e80080e7          	jalr	-384(ra) # 8fc6 <printf>
    exit(1);
    714e:	4505                	li	a0,1
    7150:	00002097          	auipc	ra,0x2
    7154:	ace080e7          	jalr	-1330(ra) # 8c1e <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    7158:	85ca                	mv	a1,s2
    715a:	00004517          	auipc	a0,0x4
    715e:	a5650513          	addi	a0,a0,-1450 # abb0 <malloc+0x1b2c>
    7162:	00002097          	auipc	ra,0x2
    7166:	e64080e7          	jalr	-412(ra) # 8fc6 <printf>
    exit(1);
    716a:	4505                	li	a0,1
    716c:	00002097          	auipc	ra,0x2
    7170:	ab2080e7          	jalr	-1358(ra) # 8c1e <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    7174:	85ca                	mv	a1,s2
    7176:	00004517          	auipc	a0,0x4
    717a:	a6250513          	addi	a0,a0,-1438 # abd8 <malloc+0x1b54>
    717e:	00002097          	auipc	ra,0x2
    7182:	e48080e7          	jalr	-440(ra) # 8fc6 <printf>
    exit(1);
    7186:	4505                	li	a0,1
    7188:	00002097          	auipc	ra,0x2
    718c:	a96080e7          	jalr	-1386(ra) # 8c1e <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    7190:	85ca                	mv	a1,s2
    7192:	00004517          	auipc	a0,0x4
    7196:	a6e50513          	addi	a0,a0,-1426 # ac00 <malloc+0x1b7c>
    719a:	00002097          	auipc	ra,0x2
    719e:	e2c080e7          	jalr	-468(ra) # 8fc6 <printf>
    exit(1);
    71a2:	4505                	li	a0,1
    71a4:	00002097          	auipc	ra,0x2
    71a8:	a7a080e7          	jalr	-1414(ra) # 8c1e <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    71ac:	85ca                	mv	a1,s2
    71ae:	00004517          	auipc	a0,0x4
    71b2:	a7a50513          	addi	a0,a0,-1414 # ac28 <malloc+0x1ba4>
    71b6:	00002097          	auipc	ra,0x2
    71ba:	e10080e7          	jalr	-496(ra) # 8fc6 <printf>
    exit(1);
    71be:	4505                	li	a0,1
    71c0:	00002097          	auipc	ra,0x2
    71c4:	a5e080e7          	jalr	-1442(ra) # 8c1e <exit>
    printf("%s: unlink dirfile failed!\n", s);
    71c8:	85ca                	mv	a1,s2
    71ca:	00004517          	auipc	a0,0x4
    71ce:	a8650513          	addi	a0,a0,-1402 # ac50 <malloc+0x1bcc>
    71d2:	00002097          	auipc	ra,0x2
    71d6:	df4080e7          	jalr	-524(ra) # 8fc6 <printf>
    exit(1);
    71da:	4505                	li	a0,1
    71dc:	00002097          	auipc	ra,0x2
    71e0:	a42080e7          	jalr	-1470(ra) # 8c1e <exit>
    printf("%s: open . for writing succeeded!\n", s);
    71e4:	85ca                	mv	a1,s2
    71e6:	00004517          	auipc	a0,0x4
    71ea:	a8a50513          	addi	a0,a0,-1398 # ac70 <malloc+0x1bec>
    71ee:	00002097          	auipc	ra,0x2
    71f2:	dd8080e7          	jalr	-552(ra) # 8fc6 <printf>
    exit(1);
    71f6:	4505                	li	a0,1
    71f8:	00002097          	auipc	ra,0x2
    71fc:	a26080e7          	jalr	-1498(ra) # 8c1e <exit>
    printf("%s: write . succeeded!\n", s);
    7200:	85ca                	mv	a1,s2
    7202:	00004517          	auipc	a0,0x4
    7206:	a9650513          	addi	a0,a0,-1386 # ac98 <malloc+0x1c14>
    720a:	00002097          	auipc	ra,0x2
    720e:	dbc080e7          	jalr	-580(ra) # 8fc6 <printf>
    exit(1);
    7212:	4505                	li	a0,1
    7214:	00002097          	auipc	ra,0x2
    7218:	a0a080e7          	jalr	-1526(ra) # 8c1e <exit>

000000000000721c <iref>:
{
    721c:	7139                	addi	sp,sp,-64
    721e:	fc06                	sd	ra,56(sp)
    7220:	f822                	sd	s0,48(sp)
    7222:	f426                	sd	s1,40(sp)
    7224:	f04a                	sd	s2,32(sp)
    7226:	ec4e                	sd	s3,24(sp)
    7228:	e852                	sd	s4,16(sp)
    722a:	e456                	sd	s5,8(sp)
    722c:	e05a                	sd	s6,0(sp)
    722e:	0080                	addi	s0,sp,64
    7230:	8b2a                	mv	s6,a0
    7232:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    7236:	00004a17          	auipc	s4,0x4
    723a:	a7aa0a13          	addi	s4,s4,-1414 # acb0 <malloc+0x1c2c>
    mkdir("");
    723e:	00003497          	auipc	s1,0x3
    7242:	57a48493          	addi	s1,s1,1402 # a7b8 <malloc+0x1734>
    link("README", "");
    7246:	00002a97          	auipc	s5,0x2
    724a:	15aa8a93          	addi	s5,s5,346 # 93a0 <malloc+0x31c>
    fd = open("xx", O_CREATE);
    724e:	00004997          	auipc	s3,0x4
    7252:	95a98993          	addi	s3,s3,-1702 # aba8 <malloc+0x1b24>
    7256:	a891                	j	72aa <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    7258:	85da                	mv	a1,s6
    725a:	00004517          	auipc	a0,0x4
    725e:	a5e50513          	addi	a0,a0,-1442 # acb8 <malloc+0x1c34>
    7262:	00002097          	auipc	ra,0x2
    7266:	d64080e7          	jalr	-668(ra) # 8fc6 <printf>
      exit(1);
    726a:	4505                	li	a0,1
    726c:	00002097          	auipc	ra,0x2
    7270:	9b2080e7          	jalr	-1614(ra) # 8c1e <exit>
      printf("%s: chdir irefd failed\n", s);
    7274:	85da                	mv	a1,s6
    7276:	00004517          	auipc	a0,0x4
    727a:	a5a50513          	addi	a0,a0,-1446 # acd0 <malloc+0x1c4c>
    727e:	00002097          	auipc	ra,0x2
    7282:	d48080e7          	jalr	-696(ra) # 8fc6 <printf>
      exit(1);
    7286:	4505                	li	a0,1
    7288:	00002097          	auipc	ra,0x2
    728c:	996080e7          	jalr	-1642(ra) # 8c1e <exit>
      close(fd);
    7290:	00002097          	auipc	ra,0x2
    7294:	9be080e7          	jalr	-1602(ra) # 8c4e <close>
    7298:	a889                	j	72ea <iref+0xce>
    unlink("xx");
    729a:	854e                	mv	a0,s3
    729c:	00002097          	auipc	ra,0x2
    72a0:	9da080e7          	jalr	-1574(ra) # 8c76 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    72a4:	397d                	addiw	s2,s2,-1
    72a6:	06090063          	beqz	s2,7306 <iref+0xea>
    if(mkdir("irefd") != 0){
    72aa:	8552                	mv	a0,s4
    72ac:	00002097          	auipc	ra,0x2
    72b0:	9e2080e7          	jalr	-1566(ra) # 8c8e <mkdir>
    72b4:	f155                	bnez	a0,7258 <iref+0x3c>
    if(chdir("irefd") != 0){
    72b6:	8552                	mv	a0,s4
    72b8:	00002097          	auipc	ra,0x2
    72bc:	9de080e7          	jalr	-1570(ra) # 8c96 <chdir>
    72c0:	f955                	bnez	a0,7274 <iref+0x58>
    mkdir("");
    72c2:	8526                	mv	a0,s1
    72c4:	00002097          	auipc	ra,0x2
    72c8:	9ca080e7          	jalr	-1590(ra) # 8c8e <mkdir>
    link("README", "");
    72cc:	85a6                	mv	a1,s1
    72ce:	8556                	mv	a0,s5
    72d0:	00002097          	auipc	ra,0x2
    72d4:	9b6080e7          	jalr	-1610(ra) # 8c86 <link>
    fd = open("", O_CREATE);
    72d8:	20000593          	li	a1,512
    72dc:	8526                	mv	a0,s1
    72de:	00002097          	auipc	ra,0x2
    72e2:	988080e7          	jalr	-1656(ra) # 8c66 <open>
    if(fd >= 0)
    72e6:	fa0555e3          	bgez	a0,7290 <iref+0x74>
    fd = open("xx", O_CREATE);
    72ea:	20000593          	li	a1,512
    72ee:	854e                	mv	a0,s3
    72f0:	00002097          	auipc	ra,0x2
    72f4:	976080e7          	jalr	-1674(ra) # 8c66 <open>
    if(fd >= 0)
    72f8:	fa0541e3          	bltz	a0,729a <iref+0x7e>
      close(fd);
    72fc:	00002097          	auipc	ra,0x2
    7300:	952080e7          	jalr	-1710(ra) # 8c4e <close>
    7304:	bf59                	j	729a <iref+0x7e>
    7306:	03300493          	li	s1,51
    chdir("..");
    730a:	00003997          	auipc	s3,0x3
    730e:	1ce98993          	addi	s3,s3,462 # a4d8 <malloc+0x1454>
    unlink("irefd");
    7312:	00004917          	auipc	s2,0x4
    7316:	99e90913          	addi	s2,s2,-1634 # acb0 <malloc+0x1c2c>
    chdir("..");
    731a:	854e                	mv	a0,s3
    731c:	00002097          	auipc	ra,0x2
    7320:	97a080e7          	jalr	-1670(ra) # 8c96 <chdir>
    unlink("irefd");
    7324:	854a                	mv	a0,s2
    7326:	00002097          	auipc	ra,0x2
    732a:	950080e7          	jalr	-1712(ra) # 8c76 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    732e:	34fd                	addiw	s1,s1,-1
    7330:	f4ed                	bnez	s1,731a <iref+0xfe>
  chdir("/");
    7332:	00003517          	auipc	a0,0x3
    7336:	14e50513          	addi	a0,a0,334 # a480 <malloc+0x13fc>
    733a:	00002097          	auipc	ra,0x2
    733e:	95c080e7          	jalr	-1700(ra) # 8c96 <chdir>
}
    7342:	70e2                	ld	ra,56(sp)
    7344:	7442                	ld	s0,48(sp)
    7346:	74a2                	ld	s1,40(sp)
    7348:	7902                	ld	s2,32(sp)
    734a:	69e2                	ld	s3,24(sp)
    734c:	6a42                	ld	s4,16(sp)
    734e:	6aa2                	ld	s5,8(sp)
    7350:	6b02                	ld	s6,0(sp)
    7352:	6121                	addi	sp,sp,64
    7354:	8082                	ret

0000000000007356 <openiputtest>:
{
    7356:	7179                	addi	sp,sp,-48
    7358:	f406                	sd	ra,40(sp)
    735a:	f022                	sd	s0,32(sp)
    735c:	ec26                	sd	s1,24(sp)
    735e:	1800                	addi	s0,sp,48
    7360:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    7362:	00004517          	auipc	a0,0x4
    7366:	98650513          	addi	a0,a0,-1658 # ace8 <malloc+0x1c64>
    736a:	00002097          	auipc	ra,0x2
    736e:	924080e7          	jalr	-1756(ra) # 8c8e <mkdir>
    7372:	04054263          	bltz	a0,73b6 <openiputtest+0x60>
  pid = fork();
    7376:	00002097          	auipc	ra,0x2
    737a:	8a0080e7          	jalr	-1888(ra) # 8c16 <fork>
  if(pid < 0){
    737e:	04054a63          	bltz	a0,73d2 <openiputtest+0x7c>
  if(pid == 0){
    7382:	e93d                	bnez	a0,73f8 <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    7384:	4589                	li	a1,2
    7386:	00004517          	auipc	a0,0x4
    738a:	96250513          	addi	a0,a0,-1694 # ace8 <malloc+0x1c64>
    738e:	00002097          	auipc	ra,0x2
    7392:	8d8080e7          	jalr	-1832(ra) # 8c66 <open>
    if(fd >= 0){
    7396:	04054c63          	bltz	a0,73ee <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    739a:	85a6                	mv	a1,s1
    739c:	00004517          	auipc	a0,0x4
    73a0:	96c50513          	addi	a0,a0,-1684 # ad08 <malloc+0x1c84>
    73a4:	00002097          	auipc	ra,0x2
    73a8:	c22080e7          	jalr	-990(ra) # 8fc6 <printf>
      exit(1);
    73ac:	4505                	li	a0,1
    73ae:	00002097          	auipc	ra,0x2
    73b2:	870080e7          	jalr	-1936(ra) # 8c1e <exit>
    printf("%s: mkdir oidir failed\n", s);
    73b6:	85a6                	mv	a1,s1
    73b8:	00004517          	auipc	a0,0x4
    73bc:	93850513          	addi	a0,a0,-1736 # acf0 <malloc+0x1c6c>
    73c0:	00002097          	auipc	ra,0x2
    73c4:	c06080e7          	jalr	-1018(ra) # 8fc6 <printf>
    exit(1);
    73c8:	4505                	li	a0,1
    73ca:	00002097          	auipc	ra,0x2
    73ce:	854080e7          	jalr	-1964(ra) # 8c1e <exit>
    printf("%s: fork failed\n", s);
    73d2:	85a6                	mv	a1,s1
    73d4:	00002517          	auipc	a0,0x2
    73d8:	67c50513          	addi	a0,a0,1660 # 9a50 <malloc+0x9cc>
    73dc:	00002097          	auipc	ra,0x2
    73e0:	bea080e7          	jalr	-1046(ra) # 8fc6 <printf>
    exit(1);
    73e4:	4505                	li	a0,1
    73e6:	00002097          	auipc	ra,0x2
    73ea:	838080e7          	jalr	-1992(ra) # 8c1e <exit>
    exit(0);
    73ee:	4501                	li	a0,0
    73f0:	00002097          	auipc	ra,0x2
    73f4:	82e080e7          	jalr	-2002(ra) # 8c1e <exit>
  sleep(1);
    73f8:	4505                	li	a0,1
    73fa:	00002097          	auipc	ra,0x2
    73fe:	8bc080e7          	jalr	-1860(ra) # 8cb6 <sleep>
  if(unlink("oidir") != 0){
    7402:	00004517          	auipc	a0,0x4
    7406:	8e650513          	addi	a0,a0,-1818 # ace8 <malloc+0x1c64>
    740a:	00002097          	auipc	ra,0x2
    740e:	86c080e7          	jalr	-1940(ra) # 8c76 <unlink>
    7412:	cd19                	beqz	a0,7430 <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    7414:	85a6                	mv	a1,s1
    7416:	00003517          	auipc	a0,0x3
    741a:	82a50513          	addi	a0,a0,-2006 # 9c40 <malloc+0xbbc>
    741e:	00002097          	auipc	ra,0x2
    7422:	ba8080e7          	jalr	-1112(ra) # 8fc6 <printf>
    exit(1);
    7426:	4505                	li	a0,1
    7428:	00001097          	auipc	ra,0x1
    742c:	7f6080e7          	jalr	2038(ra) # 8c1e <exit>
  wait(&xstatus);
    7430:	fdc40513          	addi	a0,s0,-36
    7434:	00001097          	auipc	ra,0x1
    7438:	7f2080e7          	jalr	2034(ra) # 8c26 <wait>
  exit(xstatus);
    743c:	fdc42503          	lw	a0,-36(s0)
    7440:	00001097          	auipc	ra,0x1
    7444:	7de080e7          	jalr	2014(ra) # 8c1e <exit>

0000000000007448 <forkforkfork>:
{
    7448:	1101                	addi	sp,sp,-32
    744a:	ec06                	sd	ra,24(sp)
    744c:	e822                	sd	s0,16(sp)
    744e:	e426                	sd	s1,8(sp)
    7450:	1000                	addi	s0,sp,32
    7452:	84aa                	mv	s1,a0
  unlink("stopforking");
    7454:	00004517          	auipc	a0,0x4
    7458:	8dc50513          	addi	a0,a0,-1828 # ad30 <malloc+0x1cac>
    745c:	00002097          	auipc	ra,0x2
    7460:	81a080e7          	jalr	-2022(ra) # 8c76 <unlink>
  int pid = fork();
    7464:	00001097          	auipc	ra,0x1
    7468:	7b2080e7          	jalr	1970(ra) # 8c16 <fork>
  if(pid < 0){
    746c:	04054563          	bltz	a0,74b6 <forkforkfork+0x6e>
  if(pid == 0){
    7470:	c12d                	beqz	a0,74d2 <forkforkfork+0x8a>
  sleep(20); // two seconds
    7472:	4551                	li	a0,20
    7474:	00002097          	auipc	ra,0x2
    7478:	842080e7          	jalr	-1982(ra) # 8cb6 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    747c:	20200593          	li	a1,514
    7480:	00004517          	auipc	a0,0x4
    7484:	8b050513          	addi	a0,a0,-1872 # ad30 <malloc+0x1cac>
    7488:	00001097          	auipc	ra,0x1
    748c:	7de080e7          	jalr	2014(ra) # 8c66 <open>
    7490:	00001097          	auipc	ra,0x1
    7494:	7be080e7          	jalr	1982(ra) # 8c4e <close>
  wait(0);
    7498:	4501                	li	a0,0
    749a:	00001097          	auipc	ra,0x1
    749e:	78c080e7          	jalr	1932(ra) # 8c26 <wait>
  sleep(10); // one second
    74a2:	4529                	li	a0,10
    74a4:	00002097          	auipc	ra,0x2
    74a8:	812080e7          	jalr	-2030(ra) # 8cb6 <sleep>
}
    74ac:	60e2                	ld	ra,24(sp)
    74ae:	6442                	ld	s0,16(sp)
    74b0:	64a2                	ld	s1,8(sp)
    74b2:	6105                	addi	sp,sp,32
    74b4:	8082                	ret
    printf("%s: fork failed", s);
    74b6:	85a6                	mv	a1,s1
    74b8:	00002517          	auipc	a0,0x2
    74bc:	75850513          	addi	a0,a0,1880 # 9c10 <malloc+0xb8c>
    74c0:	00002097          	auipc	ra,0x2
    74c4:	b06080e7          	jalr	-1274(ra) # 8fc6 <printf>
    exit(1);
    74c8:	4505                	li	a0,1
    74ca:	00001097          	auipc	ra,0x1
    74ce:	754080e7          	jalr	1876(ra) # 8c1e <exit>
      int fd = open("stopforking", 0);
    74d2:	00004497          	auipc	s1,0x4
    74d6:	85e48493          	addi	s1,s1,-1954 # ad30 <malloc+0x1cac>
    74da:	4581                	li	a1,0
    74dc:	8526                	mv	a0,s1
    74de:	00001097          	auipc	ra,0x1
    74e2:	788080e7          	jalr	1928(ra) # 8c66 <open>
      if(fd >= 0){
    74e6:	02055463          	bgez	a0,750e <forkforkfork+0xc6>
      if(fork() < 0){
    74ea:	00001097          	auipc	ra,0x1
    74ee:	72c080e7          	jalr	1836(ra) # 8c16 <fork>
    74f2:	fe0554e3          	bgez	a0,74da <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
    74f6:	20200593          	li	a1,514
    74fa:	8526                	mv	a0,s1
    74fc:	00001097          	auipc	ra,0x1
    7500:	76a080e7          	jalr	1898(ra) # 8c66 <open>
    7504:	00001097          	auipc	ra,0x1
    7508:	74a080e7          	jalr	1866(ra) # 8c4e <close>
    750c:	b7f9                	j	74da <forkforkfork+0x92>
        exit(0);
    750e:	4501                	li	a0,0
    7510:	00001097          	auipc	ra,0x1
    7514:	70e080e7          	jalr	1806(ra) # 8c1e <exit>

0000000000007518 <killstatus>:
{
    7518:	7139                	addi	sp,sp,-64
    751a:	fc06                	sd	ra,56(sp)
    751c:	f822                	sd	s0,48(sp)
    751e:	f426                	sd	s1,40(sp)
    7520:	f04a                	sd	s2,32(sp)
    7522:	ec4e                	sd	s3,24(sp)
    7524:	e852                	sd	s4,16(sp)
    7526:	0080                	addi	s0,sp,64
    7528:	8a2a                	mv	s4,a0
    752a:	06400913          	li	s2,100
    if(xst != -1) {
    752e:	59fd                	li	s3,-1
    int pid1 = fork();
    7530:	00001097          	auipc	ra,0x1
    7534:	6e6080e7          	jalr	1766(ra) # 8c16 <fork>
    7538:	84aa                	mv	s1,a0
    if(pid1 < 0){
    753a:	02054f63          	bltz	a0,7578 <killstatus+0x60>
    if(pid1 == 0){
    753e:	c939                	beqz	a0,7594 <killstatus+0x7c>
    sleep(1);
    7540:	4505                	li	a0,1
    7542:	00001097          	auipc	ra,0x1
    7546:	774080e7          	jalr	1908(ra) # 8cb6 <sleep>
    kill(pid1);
    754a:	8526                	mv	a0,s1
    754c:	00001097          	auipc	ra,0x1
    7550:	70a080e7          	jalr	1802(ra) # 8c56 <kill>
    wait(&xst);
    7554:	fcc40513          	addi	a0,s0,-52
    7558:	00001097          	auipc	ra,0x1
    755c:	6ce080e7          	jalr	1742(ra) # 8c26 <wait>
    if(xst != -1) {
    7560:	fcc42783          	lw	a5,-52(s0)
    7564:	03379d63          	bne	a5,s3,759e <killstatus+0x86>
  for(int i = 0; i < 100; i++){
    7568:	397d                	addiw	s2,s2,-1
    756a:	fc0913e3          	bnez	s2,7530 <killstatus+0x18>
  exit(0);
    756e:	4501                	li	a0,0
    7570:	00001097          	auipc	ra,0x1
    7574:	6ae080e7          	jalr	1710(ra) # 8c1e <exit>
      printf("%s: fork failed\n", s);
    7578:	85d2                	mv	a1,s4
    757a:	00002517          	auipc	a0,0x2
    757e:	4d650513          	addi	a0,a0,1238 # 9a50 <malloc+0x9cc>
    7582:	00002097          	auipc	ra,0x2
    7586:	a44080e7          	jalr	-1468(ra) # 8fc6 <printf>
      exit(1);
    758a:	4505                	li	a0,1
    758c:	00001097          	auipc	ra,0x1
    7590:	692080e7          	jalr	1682(ra) # 8c1e <exit>
        getpid();
    7594:	00001097          	auipc	ra,0x1
    7598:	712080e7          	jalr	1810(ra) # 8ca6 <getpid>
      while(1) {
    759c:	bfe5                	j	7594 <killstatus+0x7c>
       printf("%s: status should be -1\n", s);
    759e:	85d2                	mv	a1,s4
    75a0:	00003517          	auipc	a0,0x3
    75a4:	7a050513          	addi	a0,a0,1952 # ad40 <malloc+0x1cbc>
    75a8:	00002097          	auipc	ra,0x2
    75ac:	a1e080e7          	jalr	-1506(ra) # 8fc6 <printf>
       exit(1);
    75b0:	4505                	li	a0,1
    75b2:	00001097          	auipc	ra,0x1
    75b6:	66c080e7          	jalr	1644(ra) # 8c1e <exit>

00000000000075ba <preempt>:
{
    75ba:	7139                	addi	sp,sp,-64
    75bc:	fc06                	sd	ra,56(sp)
    75be:	f822                	sd	s0,48(sp)
    75c0:	f426                	sd	s1,40(sp)
    75c2:	f04a                	sd	s2,32(sp)
    75c4:	ec4e                	sd	s3,24(sp)
    75c6:	e852                	sd	s4,16(sp)
    75c8:	0080                	addi	s0,sp,64
    75ca:	892a                	mv	s2,a0
  pid1 = fork();
    75cc:	00001097          	auipc	ra,0x1
    75d0:	64a080e7          	jalr	1610(ra) # 8c16 <fork>
  if(pid1 < 0) {
    75d4:	00054563          	bltz	a0,75de <preempt+0x24>
    75d8:	84aa                	mv	s1,a0
  if(pid1 == 0)
    75da:	e105                	bnez	a0,75fa <preempt+0x40>
    for(;;)
    75dc:	a001                	j	75dc <preempt+0x22>
    printf("%s: fork failed", s);
    75de:	85ca                	mv	a1,s2
    75e0:	00002517          	auipc	a0,0x2
    75e4:	63050513          	addi	a0,a0,1584 # 9c10 <malloc+0xb8c>
    75e8:	00002097          	auipc	ra,0x2
    75ec:	9de080e7          	jalr	-1570(ra) # 8fc6 <printf>
    exit(1);
    75f0:	4505                	li	a0,1
    75f2:	00001097          	auipc	ra,0x1
    75f6:	62c080e7          	jalr	1580(ra) # 8c1e <exit>
  pid2 = fork();
    75fa:	00001097          	auipc	ra,0x1
    75fe:	61c080e7          	jalr	1564(ra) # 8c16 <fork>
    7602:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    7604:	00054463          	bltz	a0,760c <preempt+0x52>
  if(pid2 == 0)
    7608:	e105                	bnez	a0,7628 <preempt+0x6e>
    for(;;)
    760a:	a001                	j	760a <preempt+0x50>
    printf("%s: fork failed\n", s);
    760c:	85ca                	mv	a1,s2
    760e:	00002517          	auipc	a0,0x2
    7612:	44250513          	addi	a0,a0,1090 # 9a50 <malloc+0x9cc>
    7616:	00002097          	auipc	ra,0x2
    761a:	9b0080e7          	jalr	-1616(ra) # 8fc6 <printf>
    exit(1);
    761e:	4505                	li	a0,1
    7620:	00001097          	auipc	ra,0x1
    7624:	5fe080e7          	jalr	1534(ra) # 8c1e <exit>
  pipe(pfds);
    7628:	fc840513          	addi	a0,s0,-56
    762c:	00001097          	auipc	ra,0x1
    7630:	60a080e7          	jalr	1546(ra) # 8c36 <pipe>
  pid3 = fork();
    7634:	00001097          	auipc	ra,0x1
    7638:	5e2080e7          	jalr	1506(ra) # 8c16 <fork>
    763c:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    763e:	02054e63          	bltz	a0,767a <preempt+0xc0>
  if(pid3 == 0){
    7642:	e525                	bnez	a0,76aa <preempt+0xf0>
    close(pfds[0]);
    7644:	fc842503          	lw	a0,-56(s0)
    7648:	00001097          	auipc	ra,0x1
    764c:	606080e7          	jalr	1542(ra) # 8c4e <close>
    if(write(pfds[1], "x", 1) != 1)
    7650:	4605                	li	a2,1
    7652:	00002597          	auipc	a1,0x2
    7656:	be658593          	addi	a1,a1,-1050 # 9238 <malloc+0x1b4>
    765a:	fcc42503          	lw	a0,-52(s0)
    765e:	00001097          	auipc	ra,0x1
    7662:	5e8080e7          	jalr	1512(ra) # 8c46 <write>
    7666:	4785                	li	a5,1
    7668:	02f51763          	bne	a0,a5,7696 <preempt+0xdc>
    close(pfds[1]);
    766c:	fcc42503          	lw	a0,-52(s0)
    7670:	00001097          	auipc	ra,0x1
    7674:	5de080e7          	jalr	1502(ra) # 8c4e <close>
    for(;;)
    7678:	a001                	j	7678 <preempt+0xbe>
     printf("%s: fork failed\n", s);
    767a:	85ca                	mv	a1,s2
    767c:	00002517          	auipc	a0,0x2
    7680:	3d450513          	addi	a0,a0,980 # 9a50 <malloc+0x9cc>
    7684:	00002097          	auipc	ra,0x2
    7688:	942080e7          	jalr	-1726(ra) # 8fc6 <printf>
     exit(1);
    768c:	4505                	li	a0,1
    768e:	00001097          	auipc	ra,0x1
    7692:	590080e7          	jalr	1424(ra) # 8c1e <exit>
      printf("%s: preempt write error", s);
    7696:	85ca                	mv	a1,s2
    7698:	00003517          	auipc	a0,0x3
    769c:	6c850513          	addi	a0,a0,1736 # ad60 <malloc+0x1cdc>
    76a0:	00002097          	auipc	ra,0x2
    76a4:	926080e7          	jalr	-1754(ra) # 8fc6 <printf>
    76a8:	b7d1                	j	766c <preempt+0xb2>
  close(pfds[1]);
    76aa:	fcc42503          	lw	a0,-52(s0)
    76ae:	00001097          	auipc	ra,0x1
    76b2:	5a0080e7          	jalr	1440(ra) # 8c4e <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    76b6:	660d                	lui	a2,0x3
    76b8:	00008597          	auipc	a1,0x8
    76bc:	5c058593          	addi	a1,a1,1472 # fc78 <buf>
    76c0:	fc842503          	lw	a0,-56(s0)
    76c4:	00001097          	auipc	ra,0x1
    76c8:	57a080e7          	jalr	1402(ra) # 8c3e <read>
    76cc:	4785                	li	a5,1
    76ce:	02f50363          	beq	a0,a5,76f4 <preempt+0x13a>
    printf("%s: preempt read error", s);
    76d2:	85ca                	mv	a1,s2
    76d4:	00003517          	auipc	a0,0x3
    76d8:	6a450513          	addi	a0,a0,1700 # ad78 <malloc+0x1cf4>
    76dc:	00002097          	auipc	ra,0x2
    76e0:	8ea080e7          	jalr	-1814(ra) # 8fc6 <printf>
}
    76e4:	70e2                	ld	ra,56(sp)
    76e6:	7442                	ld	s0,48(sp)
    76e8:	74a2                	ld	s1,40(sp)
    76ea:	7902                	ld	s2,32(sp)
    76ec:	69e2                	ld	s3,24(sp)
    76ee:	6a42                	ld	s4,16(sp)
    76f0:	6121                	addi	sp,sp,64
    76f2:	8082                	ret
  close(pfds[0]);
    76f4:	fc842503          	lw	a0,-56(s0)
    76f8:	00001097          	auipc	ra,0x1
    76fc:	556080e7          	jalr	1366(ra) # 8c4e <close>
  printf("kill... ");
    7700:	00003517          	auipc	a0,0x3
    7704:	69050513          	addi	a0,a0,1680 # ad90 <malloc+0x1d0c>
    7708:	00002097          	auipc	ra,0x2
    770c:	8be080e7          	jalr	-1858(ra) # 8fc6 <printf>
  kill(pid1);
    7710:	8526                	mv	a0,s1
    7712:	00001097          	auipc	ra,0x1
    7716:	544080e7          	jalr	1348(ra) # 8c56 <kill>
  kill(pid2);
    771a:	854e                	mv	a0,s3
    771c:	00001097          	auipc	ra,0x1
    7720:	53a080e7          	jalr	1338(ra) # 8c56 <kill>
  kill(pid3);
    7724:	8552                	mv	a0,s4
    7726:	00001097          	auipc	ra,0x1
    772a:	530080e7          	jalr	1328(ra) # 8c56 <kill>
  printf("wait... ");
    772e:	00003517          	auipc	a0,0x3
    7732:	67250513          	addi	a0,a0,1650 # ada0 <malloc+0x1d1c>
    7736:	00002097          	auipc	ra,0x2
    773a:	890080e7          	jalr	-1904(ra) # 8fc6 <printf>
  wait(0);
    773e:	4501                	li	a0,0
    7740:	00001097          	auipc	ra,0x1
    7744:	4e6080e7          	jalr	1254(ra) # 8c26 <wait>
  wait(0);
    7748:	4501                	li	a0,0
    774a:	00001097          	auipc	ra,0x1
    774e:	4dc080e7          	jalr	1244(ra) # 8c26 <wait>
  wait(0);
    7752:	4501                	li	a0,0
    7754:	00001097          	auipc	ra,0x1
    7758:	4d2080e7          	jalr	1234(ra) # 8c26 <wait>
    775c:	b761                	j	76e4 <preempt+0x12a>

000000000000775e <reparent>:
{
    775e:	7179                	addi	sp,sp,-48
    7760:	f406                	sd	ra,40(sp)
    7762:	f022                	sd	s0,32(sp)
    7764:	ec26                	sd	s1,24(sp)
    7766:	e84a                	sd	s2,16(sp)
    7768:	e44e                	sd	s3,8(sp)
    776a:	e052                	sd	s4,0(sp)
    776c:	1800                	addi	s0,sp,48
    776e:	89aa                	mv	s3,a0
  int master_pid = getpid();
    7770:	00001097          	auipc	ra,0x1
    7774:	536080e7          	jalr	1334(ra) # 8ca6 <getpid>
    7778:	8a2a                	mv	s4,a0
    777a:	0c800913          	li	s2,200
    int pid = fork();
    777e:	00001097          	auipc	ra,0x1
    7782:	498080e7          	jalr	1176(ra) # 8c16 <fork>
    7786:	84aa                	mv	s1,a0
    if(pid < 0){
    7788:	02054263          	bltz	a0,77ac <reparent+0x4e>
    if(pid){
    778c:	cd21                	beqz	a0,77e4 <reparent+0x86>
      if(wait(0) != pid){
    778e:	4501                	li	a0,0
    7790:	00001097          	auipc	ra,0x1
    7794:	496080e7          	jalr	1174(ra) # 8c26 <wait>
    7798:	02951863          	bne	a0,s1,77c8 <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    779c:	397d                	addiw	s2,s2,-1
    779e:	fe0910e3          	bnez	s2,777e <reparent+0x20>
  exit(0);
    77a2:	4501                	li	a0,0
    77a4:	00001097          	auipc	ra,0x1
    77a8:	47a080e7          	jalr	1146(ra) # 8c1e <exit>
      printf("%s: fork failed\n", s);
    77ac:	85ce                	mv	a1,s3
    77ae:	00002517          	auipc	a0,0x2
    77b2:	2a250513          	addi	a0,a0,674 # 9a50 <malloc+0x9cc>
    77b6:	00002097          	auipc	ra,0x2
    77ba:	810080e7          	jalr	-2032(ra) # 8fc6 <printf>
      exit(1);
    77be:	4505                	li	a0,1
    77c0:	00001097          	auipc	ra,0x1
    77c4:	45e080e7          	jalr	1118(ra) # 8c1e <exit>
        printf("%s: wait wrong pid\n", s);
    77c8:	85ce                	mv	a1,s3
    77ca:	00002517          	auipc	a0,0x2
    77ce:	40e50513          	addi	a0,a0,1038 # 9bd8 <malloc+0xb54>
    77d2:	00001097          	auipc	ra,0x1
    77d6:	7f4080e7          	jalr	2036(ra) # 8fc6 <printf>
        exit(1);
    77da:	4505                	li	a0,1
    77dc:	00001097          	auipc	ra,0x1
    77e0:	442080e7          	jalr	1090(ra) # 8c1e <exit>
      int pid2 = fork();
    77e4:	00001097          	auipc	ra,0x1
    77e8:	432080e7          	jalr	1074(ra) # 8c16 <fork>
      if(pid2 < 0){
    77ec:	00054763          	bltz	a0,77fa <reparent+0x9c>
      exit(0);
    77f0:	4501                	li	a0,0
    77f2:	00001097          	auipc	ra,0x1
    77f6:	42c080e7          	jalr	1068(ra) # 8c1e <exit>
        kill(master_pid);
    77fa:	8552                	mv	a0,s4
    77fc:	00001097          	auipc	ra,0x1
    7800:	45a080e7          	jalr	1114(ra) # 8c56 <kill>
        exit(1);
    7804:	4505                	li	a0,1
    7806:	00001097          	auipc	ra,0x1
    780a:	418080e7          	jalr	1048(ra) # 8c1e <exit>

000000000000780e <sbrkfail>:
{
    780e:	7119                	addi	sp,sp,-128
    7810:	fc86                	sd	ra,120(sp)
    7812:	f8a2                	sd	s0,112(sp)
    7814:	f4a6                	sd	s1,104(sp)
    7816:	f0ca                	sd	s2,96(sp)
    7818:	ecce                	sd	s3,88(sp)
    781a:	e8d2                	sd	s4,80(sp)
    781c:	e4d6                	sd	s5,72(sp)
    781e:	0100                	addi	s0,sp,128
    7820:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    7822:	fb040513          	addi	a0,s0,-80
    7826:	00001097          	auipc	ra,0x1
    782a:	410080e7          	jalr	1040(ra) # 8c36 <pipe>
    782e:	e901                	bnez	a0,783e <sbrkfail+0x30>
    7830:	f8040493          	addi	s1,s0,-128
    7834:	fa840993          	addi	s3,s0,-88
    7838:	8926                	mv	s2,s1
    if(pids[i] != -1)
    783a:	5a7d                	li	s4,-1
    783c:	a085                	j	789c <sbrkfail+0x8e>
    printf("%s: pipe() failed\n", s);
    783e:	85d6                	mv	a1,s5
    7840:	00002517          	auipc	a0,0x2
    7844:	31850513          	addi	a0,a0,792 # 9b58 <malloc+0xad4>
    7848:	00001097          	auipc	ra,0x1
    784c:	77e080e7          	jalr	1918(ra) # 8fc6 <printf>
    exit(1);
    7850:	4505                	li	a0,1
    7852:	00001097          	auipc	ra,0x1
    7856:	3cc080e7          	jalr	972(ra) # 8c1e <exit>
      sbrk(BIG - (uint64)sbrk(0));
    785a:	00001097          	auipc	ra,0x1
    785e:	454080e7          	jalr	1108(ra) # 8cae <sbrk>
    7862:	064007b7          	lui	a5,0x6400
    7866:	40a7853b          	subw	a0,a5,a0
    786a:	00001097          	auipc	ra,0x1
    786e:	444080e7          	jalr	1092(ra) # 8cae <sbrk>
      write(fds[1], "x", 1);
    7872:	4605                	li	a2,1
    7874:	00002597          	auipc	a1,0x2
    7878:	9c458593          	addi	a1,a1,-1596 # 9238 <malloc+0x1b4>
    787c:	fb442503          	lw	a0,-76(s0)
    7880:	00001097          	auipc	ra,0x1
    7884:	3c6080e7          	jalr	966(ra) # 8c46 <write>
      for(;;) sleep(1000);
    7888:	3e800513          	li	a0,1000
    788c:	00001097          	auipc	ra,0x1
    7890:	42a080e7          	jalr	1066(ra) # 8cb6 <sleep>
    7894:	bfd5                	j	7888 <sbrkfail+0x7a>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    7896:	0911                	addi	s2,s2,4
    7898:	03390563          	beq	s2,s3,78c2 <sbrkfail+0xb4>
    if((pids[i] = fork()) == 0){
    789c:	00001097          	auipc	ra,0x1
    78a0:	37a080e7          	jalr	890(ra) # 8c16 <fork>
    78a4:	00a92023          	sw	a0,0(s2)
    78a8:	d94d                	beqz	a0,785a <sbrkfail+0x4c>
    if(pids[i] != -1)
    78aa:	ff4506e3          	beq	a0,s4,7896 <sbrkfail+0x88>
      read(fds[0], &scratch, 1);
    78ae:	4605                	li	a2,1
    78b0:	faf40593          	addi	a1,s0,-81
    78b4:	fb042503          	lw	a0,-80(s0)
    78b8:	00001097          	auipc	ra,0x1
    78bc:	386080e7          	jalr	902(ra) # 8c3e <read>
    78c0:	bfd9                	j	7896 <sbrkfail+0x88>
  c = sbrk(PGSIZE);
    78c2:	6505                	lui	a0,0x1
    78c4:	00001097          	auipc	ra,0x1
    78c8:	3ea080e7          	jalr	1002(ra) # 8cae <sbrk>
    78cc:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    78ce:	597d                	li	s2,-1
    78d0:	a021                	j	78d8 <sbrkfail+0xca>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    78d2:	0491                	addi	s1,s1,4
    78d4:	01348f63          	beq	s1,s3,78f2 <sbrkfail+0xe4>
    if(pids[i] == -1)
    78d8:	4088                	lw	a0,0(s1)
    78da:	ff250ce3          	beq	a0,s2,78d2 <sbrkfail+0xc4>
    kill(pids[i]);
    78de:	00001097          	auipc	ra,0x1
    78e2:	378080e7          	jalr	888(ra) # 8c56 <kill>
    wait(0);
    78e6:	4501                	li	a0,0
    78e8:	00001097          	auipc	ra,0x1
    78ec:	33e080e7          	jalr	830(ra) # 8c26 <wait>
    78f0:	b7cd                	j	78d2 <sbrkfail+0xc4>
  if(c == (char*)0xffffffffffffffffL){
    78f2:	57fd                	li	a5,-1
    78f4:	04fa0163          	beq	s4,a5,7936 <sbrkfail+0x128>
  pid = fork();
    78f8:	00001097          	auipc	ra,0x1
    78fc:	31e080e7          	jalr	798(ra) # 8c16 <fork>
    7900:	84aa                	mv	s1,a0
  if(pid < 0){
    7902:	04054863          	bltz	a0,7952 <sbrkfail+0x144>
  if(pid == 0){
    7906:	c525                	beqz	a0,796e <sbrkfail+0x160>
  wait(&xstatus);
    7908:	fbc40513          	addi	a0,s0,-68
    790c:	00001097          	auipc	ra,0x1
    7910:	31a080e7          	jalr	794(ra) # 8c26 <wait>
  if(xstatus != -1 && xstatus != 2)
    7914:	fbc42783          	lw	a5,-68(s0)
    7918:	577d                	li	a4,-1
    791a:	00e78563          	beq	a5,a4,7924 <sbrkfail+0x116>
    791e:	4709                	li	a4,2
    7920:	08e79d63          	bne	a5,a4,79ba <sbrkfail+0x1ac>
}
    7924:	70e6                	ld	ra,120(sp)
    7926:	7446                	ld	s0,112(sp)
    7928:	74a6                	ld	s1,104(sp)
    792a:	7906                	ld	s2,96(sp)
    792c:	69e6                	ld	s3,88(sp)
    792e:	6a46                	ld	s4,80(sp)
    7930:	6aa6                	ld	s5,72(sp)
    7932:	6109                	addi	sp,sp,128
    7934:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    7936:	85d6                	mv	a1,s5
    7938:	00003517          	auipc	a0,0x3
    793c:	47850513          	addi	a0,a0,1144 # adb0 <malloc+0x1d2c>
    7940:	00001097          	auipc	ra,0x1
    7944:	686080e7          	jalr	1670(ra) # 8fc6 <printf>
    exit(1);
    7948:	4505                	li	a0,1
    794a:	00001097          	auipc	ra,0x1
    794e:	2d4080e7          	jalr	724(ra) # 8c1e <exit>
    printf("%s: fork failed\n", s);
    7952:	85d6                	mv	a1,s5
    7954:	00002517          	auipc	a0,0x2
    7958:	0fc50513          	addi	a0,a0,252 # 9a50 <malloc+0x9cc>
    795c:	00001097          	auipc	ra,0x1
    7960:	66a080e7          	jalr	1642(ra) # 8fc6 <printf>
    exit(1);
    7964:	4505                	li	a0,1
    7966:	00001097          	auipc	ra,0x1
    796a:	2b8080e7          	jalr	696(ra) # 8c1e <exit>
    a = sbrk(0);
    796e:	4501                	li	a0,0
    7970:	00001097          	auipc	ra,0x1
    7974:	33e080e7          	jalr	830(ra) # 8cae <sbrk>
    7978:	892a                	mv	s2,a0
    sbrk(10*BIG);
    797a:	3e800537          	lui	a0,0x3e800
    797e:	00001097          	auipc	ra,0x1
    7982:	330080e7          	jalr	816(ra) # 8cae <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    7986:	87ca                	mv	a5,s2
    7988:	3e800737          	lui	a4,0x3e800
    798c:	993a                	add	s2,s2,a4
    798e:	6705                	lui	a4,0x1
      n += *(a+i);
    7990:	0007c683          	lbu	a3,0(a5) # 6400000 <base+0x63ed388>
    7994:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    7996:	97ba                	add	a5,a5,a4
    7998:	ff279ce3          	bne	a5,s2,7990 <sbrkfail+0x182>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    799c:	8626                	mv	a2,s1
    799e:	85d6                	mv	a1,s5
    79a0:	00003517          	auipc	a0,0x3
    79a4:	43050513          	addi	a0,a0,1072 # add0 <malloc+0x1d4c>
    79a8:	00001097          	auipc	ra,0x1
    79ac:	61e080e7          	jalr	1566(ra) # 8fc6 <printf>
    exit(1);
    79b0:	4505                	li	a0,1
    79b2:	00001097          	auipc	ra,0x1
    79b6:	26c080e7          	jalr	620(ra) # 8c1e <exit>
    exit(1);
    79ba:	4505                	li	a0,1
    79bc:	00001097          	auipc	ra,0x1
    79c0:	262080e7          	jalr	610(ra) # 8c1e <exit>

00000000000079c4 <mem>:
{
    79c4:	7139                	addi	sp,sp,-64
    79c6:	fc06                	sd	ra,56(sp)
    79c8:	f822                	sd	s0,48(sp)
    79ca:	f426                	sd	s1,40(sp)
    79cc:	f04a                	sd	s2,32(sp)
    79ce:	ec4e                	sd	s3,24(sp)
    79d0:	0080                	addi	s0,sp,64
    79d2:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    79d4:	00001097          	auipc	ra,0x1
    79d8:	242080e7          	jalr	578(ra) # 8c16 <fork>
    m1 = 0;
    79dc:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    79de:	6909                	lui	s2,0x2
    79e0:	71190913          	addi	s2,s2,1809 # 2711 <copyinstr1-0x8ef>
  if((pid = fork()) == 0){
    79e4:	c115                	beqz	a0,7a08 <mem+0x44>
    wait(&xstatus);
    79e6:	fcc40513          	addi	a0,s0,-52
    79ea:	00001097          	auipc	ra,0x1
    79ee:	23c080e7          	jalr	572(ra) # 8c26 <wait>
    if(xstatus == -1){
    79f2:	fcc42503          	lw	a0,-52(s0)
    79f6:	57fd                	li	a5,-1
    79f8:	06f50363          	beq	a0,a5,7a5e <mem+0x9a>
    exit(xstatus);
    79fc:	00001097          	auipc	ra,0x1
    7a00:	222080e7          	jalr	546(ra) # 8c1e <exit>
      *(char**)m2 = m1;
    7a04:	e104                	sd	s1,0(a0)
      m1 = m2;
    7a06:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    7a08:	854a                	mv	a0,s2
    7a0a:	00001097          	auipc	ra,0x1
    7a0e:	67a080e7          	jalr	1658(ra) # 9084 <malloc>
    7a12:	f96d                	bnez	a0,7a04 <mem+0x40>
    while(m1){
    7a14:	c881                	beqz	s1,7a24 <mem+0x60>
      m2 = *(char**)m1;
    7a16:	8526                	mv	a0,s1
    7a18:	6084                	ld	s1,0(s1)
      free(m1);
    7a1a:	00001097          	auipc	ra,0x1
    7a1e:	5e2080e7          	jalr	1506(ra) # 8ffc <free>
    while(m1){
    7a22:	f8f5                	bnez	s1,7a16 <mem+0x52>
    m1 = malloc(1024*20);
    7a24:	6515                	lui	a0,0x5
    7a26:	00001097          	auipc	ra,0x1
    7a2a:	65e080e7          	jalr	1630(ra) # 9084 <malloc>
    if(m1 == 0){
    7a2e:	c911                	beqz	a0,7a42 <mem+0x7e>
    free(m1);
    7a30:	00001097          	auipc	ra,0x1
    7a34:	5cc080e7          	jalr	1484(ra) # 8ffc <free>
    exit(0);
    7a38:	4501                	li	a0,0
    7a3a:	00001097          	auipc	ra,0x1
    7a3e:	1e4080e7          	jalr	484(ra) # 8c1e <exit>
      printf("couldn't allocate mem?!!\n", s);
    7a42:	85ce                	mv	a1,s3
    7a44:	00003517          	auipc	a0,0x3
    7a48:	3bc50513          	addi	a0,a0,956 # ae00 <malloc+0x1d7c>
    7a4c:	00001097          	auipc	ra,0x1
    7a50:	57a080e7          	jalr	1402(ra) # 8fc6 <printf>
      exit(1);
    7a54:	4505                	li	a0,1
    7a56:	00001097          	auipc	ra,0x1
    7a5a:	1c8080e7          	jalr	456(ra) # 8c1e <exit>
      exit(0);
    7a5e:	4501                	li	a0,0
    7a60:	00001097          	auipc	ra,0x1
    7a64:	1be080e7          	jalr	446(ra) # 8c1e <exit>

0000000000007a68 <sharedfd>:
{
    7a68:	7159                	addi	sp,sp,-112
    7a6a:	f486                	sd	ra,104(sp)
    7a6c:	f0a2                	sd	s0,96(sp)
    7a6e:	eca6                	sd	s1,88(sp)
    7a70:	e8ca                	sd	s2,80(sp)
    7a72:	e4ce                	sd	s3,72(sp)
    7a74:	e0d2                	sd	s4,64(sp)
    7a76:	fc56                	sd	s5,56(sp)
    7a78:	f85a                	sd	s6,48(sp)
    7a7a:	f45e                	sd	s7,40(sp)
    7a7c:	1880                	addi	s0,sp,112
    7a7e:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    7a80:	00003517          	auipc	a0,0x3
    7a84:	3a050513          	addi	a0,a0,928 # ae20 <malloc+0x1d9c>
    7a88:	00001097          	auipc	ra,0x1
    7a8c:	1ee080e7          	jalr	494(ra) # 8c76 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    7a90:	20200593          	li	a1,514
    7a94:	00003517          	auipc	a0,0x3
    7a98:	38c50513          	addi	a0,a0,908 # ae20 <malloc+0x1d9c>
    7a9c:	00001097          	auipc	ra,0x1
    7aa0:	1ca080e7          	jalr	458(ra) # 8c66 <open>
  if(fd < 0){
    7aa4:	04054a63          	bltz	a0,7af8 <sharedfd+0x90>
    7aa8:	892a                	mv	s2,a0
  pid = fork();
    7aaa:	00001097          	auipc	ra,0x1
    7aae:	16c080e7          	jalr	364(ra) # 8c16 <fork>
    7ab2:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    7ab4:	06300593          	li	a1,99
    7ab8:	c119                	beqz	a0,7abe <sharedfd+0x56>
    7aba:	07000593          	li	a1,112
    7abe:	4629                	li	a2,10
    7ac0:	fa040513          	addi	a0,s0,-96
    7ac4:	00001097          	auipc	ra,0x1
    7ac8:	f06080e7          	jalr	-250(ra) # 89ca <memset>
    7acc:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    7ad0:	4629                	li	a2,10
    7ad2:	fa040593          	addi	a1,s0,-96
    7ad6:	854a                	mv	a0,s2
    7ad8:	00001097          	auipc	ra,0x1
    7adc:	16e080e7          	jalr	366(ra) # 8c46 <write>
    7ae0:	47a9                	li	a5,10
    7ae2:	02f51963          	bne	a0,a5,7b14 <sharedfd+0xac>
  for(i = 0; i < N; i++){
    7ae6:	34fd                	addiw	s1,s1,-1
    7ae8:	f4e5                	bnez	s1,7ad0 <sharedfd+0x68>
  if(pid == 0) {
    7aea:	04099363          	bnez	s3,7b30 <sharedfd+0xc8>
    exit(0);
    7aee:	4501                	li	a0,0
    7af0:	00001097          	auipc	ra,0x1
    7af4:	12e080e7          	jalr	302(ra) # 8c1e <exit>
    printf("%s: cannot open sharedfd for writing", s);
    7af8:	85d2                	mv	a1,s4
    7afa:	00003517          	auipc	a0,0x3
    7afe:	33650513          	addi	a0,a0,822 # ae30 <malloc+0x1dac>
    7b02:	00001097          	auipc	ra,0x1
    7b06:	4c4080e7          	jalr	1220(ra) # 8fc6 <printf>
    exit(1);
    7b0a:	4505                	li	a0,1
    7b0c:	00001097          	auipc	ra,0x1
    7b10:	112080e7          	jalr	274(ra) # 8c1e <exit>
      printf("%s: write sharedfd failed\n", s);
    7b14:	85d2                	mv	a1,s4
    7b16:	00003517          	auipc	a0,0x3
    7b1a:	34250513          	addi	a0,a0,834 # ae58 <malloc+0x1dd4>
    7b1e:	00001097          	auipc	ra,0x1
    7b22:	4a8080e7          	jalr	1192(ra) # 8fc6 <printf>
      exit(1);
    7b26:	4505                	li	a0,1
    7b28:	00001097          	auipc	ra,0x1
    7b2c:	0f6080e7          	jalr	246(ra) # 8c1e <exit>
    wait(&xstatus);
    7b30:	f9c40513          	addi	a0,s0,-100
    7b34:	00001097          	auipc	ra,0x1
    7b38:	0f2080e7          	jalr	242(ra) # 8c26 <wait>
    if(xstatus != 0)
    7b3c:	f9c42983          	lw	s3,-100(s0)
    7b40:	00098763          	beqz	s3,7b4e <sharedfd+0xe6>
      exit(xstatus);
    7b44:	854e                	mv	a0,s3
    7b46:	00001097          	auipc	ra,0x1
    7b4a:	0d8080e7          	jalr	216(ra) # 8c1e <exit>
  close(fd);
    7b4e:	854a                	mv	a0,s2
    7b50:	00001097          	auipc	ra,0x1
    7b54:	0fe080e7          	jalr	254(ra) # 8c4e <close>
  fd = open("sharedfd", 0);
    7b58:	4581                	li	a1,0
    7b5a:	00003517          	auipc	a0,0x3
    7b5e:	2c650513          	addi	a0,a0,710 # ae20 <malloc+0x1d9c>
    7b62:	00001097          	auipc	ra,0x1
    7b66:	104080e7          	jalr	260(ra) # 8c66 <open>
    7b6a:	8baa                	mv	s7,a0
  nc = np = 0;
    7b6c:	8ace                	mv	s5,s3
  if(fd < 0){
    7b6e:	02054563          	bltz	a0,7b98 <sharedfd+0x130>
    7b72:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    7b76:	06300493          	li	s1,99
      if(buf[i] == 'p')
    7b7a:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    7b7e:	4629                	li	a2,10
    7b80:	fa040593          	addi	a1,s0,-96
    7b84:	855e                	mv	a0,s7
    7b86:	00001097          	auipc	ra,0x1
    7b8a:	0b8080e7          	jalr	184(ra) # 8c3e <read>
    7b8e:	02a05f63          	blez	a0,7bcc <sharedfd+0x164>
    7b92:	fa040793          	addi	a5,s0,-96
    7b96:	a01d                	j	7bbc <sharedfd+0x154>
    printf("%s: cannot open sharedfd for reading\n", s);
    7b98:	85d2                	mv	a1,s4
    7b9a:	00003517          	auipc	a0,0x3
    7b9e:	2de50513          	addi	a0,a0,734 # ae78 <malloc+0x1df4>
    7ba2:	00001097          	auipc	ra,0x1
    7ba6:	424080e7          	jalr	1060(ra) # 8fc6 <printf>
    exit(1);
    7baa:	4505                	li	a0,1
    7bac:	00001097          	auipc	ra,0x1
    7bb0:	072080e7          	jalr	114(ra) # 8c1e <exit>
        nc++;
    7bb4:	2985                	addiw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    7bb6:	0785                	addi	a5,a5,1
    7bb8:	fd2783e3          	beq	a5,s2,7b7e <sharedfd+0x116>
      if(buf[i] == 'c')
    7bbc:	0007c703          	lbu	a4,0(a5)
    7bc0:	fe970ae3          	beq	a4,s1,7bb4 <sharedfd+0x14c>
      if(buf[i] == 'p')
    7bc4:	ff6719e3          	bne	a4,s6,7bb6 <sharedfd+0x14e>
        np++;
    7bc8:	2a85                	addiw	s5,s5,1
    7bca:	b7f5                	j	7bb6 <sharedfd+0x14e>
  close(fd);
    7bcc:	855e                	mv	a0,s7
    7bce:	00001097          	auipc	ra,0x1
    7bd2:	080080e7          	jalr	128(ra) # 8c4e <close>
  unlink("sharedfd");
    7bd6:	00003517          	auipc	a0,0x3
    7bda:	24a50513          	addi	a0,a0,586 # ae20 <malloc+0x1d9c>
    7bde:	00001097          	auipc	ra,0x1
    7be2:	098080e7          	jalr	152(ra) # 8c76 <unlink>
  if(nc == N*SZ && np == N*SZ){
    7be6:	6789                	lui	a5,0x2
    7be8:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr1-0x8f0>
    7bec:	00f99763          	bne	s3,a5,7bfa <sharedfd+0x192>
    7bf0:	6789                	lui	a5,0x2
    7bf2:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr1-0x8f0>
    7bf6:	02fa8063          	beq	s5,a5,7c16 <sharedfd+0x1ae>
    printf("%s: nc/np test fails\n", s);
    7bfa:	85d2                	mv	a1,s4
    7bfc:	00003517          	auipc	a0,0x3
    7c00:	2a450513          	addi	a0,a0,676 # aea0 <malloc+0x1e1c>
    7c04:	00001097          	auipc	ra,0x1
    7c08:	3c2080e7          	jalr	962(ra) # 8fc6 <printf>
    exit(1);
    7c0c:	4505                	li	a0,1
    7c0e:	00001097          	auipc	ra,0x1
    7c12:	010080e7          	jalr	16(ra) # 8c1e <exit>
    exit(0);
    7c16:	4501                	li	a0,0
    7c18:	00001097          	auipc	ra,0x1
    7c1c:	006080e7          	jalr	6(ra) # 8c1e <exit>

0000000000007c20 <fourfiles>:
{
    7c20:	7171                	addi	sp,sp,-176
    7c22:	f506                	sd	ra,168(sp)
    7c24:	f122                	sd	s0,160(sp)
    7c26:	ed26                	sd	s1,152(sp)
    7c28:	e94a                	sd	s2,144(sp)
    7c2a:	e54e                	sd	s3,136(sp)
    7c2c:	e152                	sd	s4,128(sp)
    7c2e:	fcd6                	sd	s5,120(sp)
    7c30:	f8da                	sd	s6,112(sp)
    7c32:	f4de                	sd	s7,104(sp)
    7c34:	f0e2                	sd	s8,96(sp)
    7c36:	ece6                	sd	s9,88(sp)
    7c38:	e8ea                	sd	s10,80(sp)
    7c3a:	e4ee                	sd	s11,72(sp)
    7c3c:	1900                	addi	s0,sp,176
    7c3e:	f4a43c23          	sd	a0,-168(s0)
  char *names[] = { "f0", "f1", "f2", "f3" };
    7c42:	00001797          	auipc	a5,0x1
    7c46:	52e78793          	addi	a5,a5,1326 # 9170 <malloc+0xec>
    7c4a:	f6f43823          	sd	a5,-144(s0)
    7c4e:	00001797          	auipc	a5,0x1
    7c52:	52a78793          	addi	a5,a5,1322 # 9178 <malloc+0xf4>
    7c56:	f6f43c23          	sd	a5,-136(s0)
    7c5a:	00001797          	auipc	a5,0x1
    7c5e:	52678793          	addi	a5,a5,1318 # 9180 <malloc+0xfc>
    7c62:	f8f43023          	sd	a5,-128(s0)
    7c66:	00001797          	auipc	a5,0x1
    7c6a:	52278793          	addi	a5,a5,1314 # 9188 <malloc+0x104>
    7c6e:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    7c72:	f7040c13          	addi	s8,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    7c76:	8962                	mv	s2,s8
  for(pi = 0; pi < NCHILD; pi++){
    7c78:	4481                	li	s1,0
    7c7a:	4a11                	li	s4,4
    fname = names[pi];
    7c7c:	00093983          	ld	s3,0(s2)
    unlink(fname);
    7c80:	854e                	mv	a0,s3
    7c82:	00001097          	auipc	ra,0x1
    7c86:	ff4080e7          	jalr	-12(ra) # 8c76 <unlink>
    pid = fork();
    7c8a:	00001097          	auipc	ra,0x1
    7c8e:	f8c080e7          	jalr	-116(ra) # 8c16 <fork>
    if(pid < 0){
    7c92:	04054463          	bltz	a0,7cda <fourfiles+0xba>
    if(pid == 0){
    7c96:	c12d                	beqz	a0,7cf8 <fourfiles+0xd8>
  for(pi = 0; pi < NCHILD; pi++){
    7c98:	2485                	addiw	s1,s1,1
    7c9a:	0921                	addi	s2,s2,8
    7c9c:	ff4490e3          	bne	s1,s4,7c7c <fourfiles+0x5c>
    7ca0:	4491                	li	s1,4
    wait(&xstatus);
    7ca2:	f6c40513          	addi	a0,s0,-148
    7ca6:	00001097          	auipc	ra,0x1
    7caa:	f80080e7          	jalr	-128(ra) # 8c26 <wait>
    if(xstatus != 0)
    7cae:	f6c42b03          	lw	s6,-148(s0)
    7cb2:	0c0b1e63          	bnez	s6,7d8e <fourfiles+0x16e>
  for(pi = 0; pi < NCHILD; pi++){
    7cb6:	34fd                	addiw	s1,s1,-1
    7cb8:	f4ed                	bnez	s1,7ca2 <fourfiles+0x82>
    7cba:	03000b93          	li	s7,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    7cbe:	00008a17          	auipc	s4,0x8
    7cc2:	fbaa0a13          	addi	s4,s4,-70 # fc78 <buf>
    7cc6:	00008a97          	auipc	s5,0x8
    7cca:	fb3a8a93          	addi	s5,s5,-77 # fc79 <buf+0x1>
    if(total != N*SZ){
    7cce:	6d85                	lui	s11,0x1
    7cd0:	770d8d93          	addi	s11,s11,1904 # 1770 <copyinstr1-0x1890>
  for(i = 0; i < NCHILD; i++){
    7cd4:	03400d13          	li	s10,52
    7cd8:	aa1d                	j	7e0e <fourfiles+0x1ee>
      printf("fork failed\n", s);
    7cda:	f5843583          	ld	a1,-168(s0)
    7cde:	00002517          	auipc	a0,0x2
    7ce2:	17a50513          	addi	a0,a0,378 # 9e58 <malloc+0xdd4>
    7ce6:	00001097          	auipc	ra,0x1
    7cea:	2e0080e7          	jalr	736(ra) # 8fc6 <printf>
      exit(1);
    7cee:	4505                	li	a0,1
    7cf0:	00001097          	auipc	ra,0x1
    7cf4:	f2e080e7          	jalr	-210(ra) # 8c1e <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    7cf8:	20200593          	li	a1,514
    7cfc:	854e                	mv	a0,s3
    7cfe:	00001097          	auipc	ra,0x1
    7d02:	f68080e7          	jalr	-152(ra) # 8c66 <open>
    7d06:	892a                	mv	s2,a0
      if(fd < 0){
    7d08:	04054763          	bltz	a0,7d56 <fourfiles+0x136>
      memset(buf, '0'+pi, SZ);
    7d0c:	1f400613          	li	a2,500
    7d10:	0304859b          	addiw	a1,s1,48
    7d14:	00008517          	auipc	a0,0x8
    7d18:	f6450513          	addi	a0,a0,-156 # fc78 <buf>
    7d1c:	00001097          	auipc	ra,0x1
    7d20:	cae080e7          	jalr	-850(ra) # 89ca <memset>
    7d24:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    7d26:	00008997          	auipc	s3,0x8
    7d2a:	f5298993          	addi	s3,s3,-174 # fc78 <buf>
    7d2e:	1f400613          	li	a2,500
    7d32:	85ce                	mv	a1,s3
    7d34:	854a                	mv	a0,s2
    7d36:	00001097          	auipc	ra,0x1
    7d3a:	f10080e7          	jalr	-240(ra) # 8c46 <write>
    7d3e:	85aa                	mv	a1,a0
    7d40:	1f400793          	li	a5,500
    7d44:	02f51863          	bne	a0,a5,7d74 <fourfiles+0x154>
      for(i = 0; i < N; i++){
    7d48:	34fd                	addiw	s1,s1,-1
    7d4a:	f0f5                	bnez	s1,7d2e <fourfiles+0x10e>
      exit(0);
    7d4c:	4501                	li	a0,0
    7d4e:	00001097          	auipc	ra,0x1
    7d52:	ed0080e7          	jalr	-304(ra) # 8c1e <exit>
        printf("create failed\n", s);
    7d56:	f5843583          	ld	a1,-168(s0)
    7d5a:	00003517          	auipc	a0,0x3
    7d5e:	15e50513          	addi	a0,a0,350 # aeb8 <malloc+0x1e34>
    7d62:	00001097          	auipc	ra,0x1
    7d66:	264080e7          	jalr	612(ra) # 8fc6 <printf>
        exit(1);
    7d6a:	4505                	li	a0,1
    7d6c:	00001097          	auipc	ra,0x1
    7d70:	eb2080e7          	jalr	-334(ra) # 8c1e <exit>
          printf("write failed %d\n", n);
    7d74:	00003517          	auipc	a0,0x3
    7d78:	15450513          	addi	a0,a0,340 # aec8 <malloc+0x1e44>
    7d7c:	00001097          	auipc	ra,0x1
    7d80:	24a080e7          	jalr	586(ra) # 8fc6 <printf>
          exit(1);
    7d84:	4505                	li	a0,1
    7d86:	00001097          	auipc	ra,0x1
    7d8a:	e98080e7          	jalr	-360(ra) # 8c1e <exit>
      exit(xstatus);
    7d8e:	855a                	mv	a0,s6
    7d90:	00001097          	auipc	ra,0x1
    7d94:	e8e080e7          	jalr	-370(ra) # 8c1e <exit>
          printf("wrong char\n", s);
    7d98:	f5843583          	ld	a1,-168(s0)
    7d9c:	00003517          	auipc	a0,0x3
    7da0:	14450513          	addi	a0,a0,324 # aee0 <malloc+0x1e5c>
    7da4:	00001097          	auipc	ra,0x1
    7da8:	222080e7          	jalr	546(ra) # 8fc6 <printf>
          exit(1);
    7dac:	4505                	li	a0,1
    7dae:	00001097          	auipc	ra,0x1
    7db2:	e70080e7          	jalr	-400(ra) # 8c1e <exit>
      total += n;
    7db6:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    7dba:	660d                	lui	a2,0x3
    7dbc:	85d2                	mv	a1,s4
    7dbe:	854e                	mv	a0,s3
    7dc0:	00001097          	auipc	ra,0x1
    7dc4:	e7e080e7          	jalr	-386(ra) # 8c3e <read>
    7dc8:	02a05363          	blez	a0,7dee <fourfiles+0x1ce>
    7dcc:	00008797          	auipc	a5,0x8
    7dd0:	eac78793          	addi	a5,a5,-340 # fc78 <buf>
    7dd4:	fff5069b          	addiw	a3,a0,-1
    7dd8:	1682                	slli	a3,a3,0x20
    7dda:	9281                	srli	a3,a3,0x20
    7ddc:	96d6                	add	a3,a3,s5
        if(buf[j] != '0'+i){
    7dde:	0007c703          	lbu	a4,0(a5)
    7de2:	fa971be3          	bne	a4,s1,7d98 <fourfiles+0x178>
      for(j = 0; j < n; j++){
    7de6:	0785                	addi	a5,a5,1
    7de8:	fed79be3          	bne	a5,a3,7dde <fourfiles+0x1be>
    7dec:	b7e9                	j	7db6 <fourfiles+0x196>
    close(fd);
    7dee:	854e                	mv	a0,s3
    7df0:	00001097          	auipc	ra,0x1
    7df4:	e5e080e7          	jalr	-418(ra) # 8c4e <close>
    if(total != N*SZ){
    7df8:	03b91863          	bne	s2,s11,7e28 <fourfiles+0x208>
    unlink(fname);
    7dfc:	8566                	mv	a0,s9
    7dfe:	00001097          	auipc	ra,0x1
    7e02:	e78080e7          	jalr	-392(ra) # 8c76 <unlink>
  for(i = 0; i < NCHILD; i++){
    7e06:	0c21                	addi	s8,s8,8
    7e08:	2b85                	addiw	s7,s7,1
    7e0a:	03ab8d63          	beq	s7,s10,7e44 <fourfiles+0x224>
    fname = names[i];
    7e0e:	000c3c83          	ld	s9,0(s8)
    fd = open(fname, 0);
    7e12:	4581                	li	a1,0
    7e14:	8566                	mv	a0,s9
    7e16:	00001097          	auipc	ra,0x1
    7e1a:	e50080e7          	jalr	-432(ra) # 8c66 <open>
    7e1e:	89aa                	mv	s3,a0
    total = 0;
    7e20:	895a                	mv	s2,s6
        if(buf[j] != '0'+i){
    7e22:	000b849b          	sext.w	s1,s7
    while((n = read(fd, buf, sizeof(buf))) > 0){
    7e26:	bf51                	j	7dba <fourfiles+0x19a>
      printf("wrong length %d\n", total);
    7e28:	85ca                	mv	a1,s2
    7e2a:	00003517          	auipc	a0,0x3
    7e2e:	0c650513          	addi	a0,a0,198 # aef0 <malloc+0x1e6c>
    7e32:	00001097          	auipc	ra,0x1
    7e36:	194080e7          	jalr	404(ra) # 8fc6 <printf>
      exit(1);
    7e3a:	4505                	li	a0,1
    7e3c:	00001097          	auipc	ra,0x1
    7e40:	de2080e7          	jalr	-542(ra) # 8c1e <exit>
}
    7e44:	70aa                	ld	ra,168(sp)
    7e46:	740a                	ld	s0,160(sp)
    7e48:	64ea                	ld	s1,152(sp)
    7e4a:	694a                	ld	s2,144(sp)
    7e4c:	69aa                	ld	s3,136(sp)
    7e4e:	6a0a                	ld	s4,128(sp)
    7e50:	7ae6                	ld	s5,120(sp)
    7e52:	7b46                	ld	s6,112(sp)
    7e54:	7ba6                	ld	s7,104(sp)
    7e56:	7c06                	ld	s8,96(sp)
    7e58:	6ce6                	ld	s9,88(sp)
    7e5a:	6d46                	ld	s10,80(sp)
    7e5c:	6da6                	ld	s11,72(sp)
    7e5e:	614d                	addi	sp,sp,176
    7e60:	8082                	ret

0000000000007e62 <concreate>:
{
    7e62:	7135                	addi	sp,sp,-160
    7e64:	ed06                	sd	ra,152(sp)
    7e66:	e922                	sd	s0,144(sp)
    7e68:	e526                	sd	s1,136(sp)
    7e6a:	e14a                	sd	s2,128(sp)
    7e6c:	fcce                	sd	s3,120(sp)
    7e6e:	f8d2                	sd	s4,112(sp)
    7e70:	f4d6                	sd	s5,104(sp)
    7e72:	f0da                	sd	s6,96(sp)
    7e74:	ecde                	sd	s7,88(sp)
    7e76:	1100                	addi	s0,sp,160
    7e78:	89aa                	mv	s3,a0
  file[0] = 'C';
    7e7a:	04300793          	li	a5,67
    7e7e:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    7e82:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    7e86:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    7e88:	4b0d                	li	s6,3
    7e8a:	4a85                	li	s5,1
      link("C0", file);
    7e8c:	00003b97          	auipc	s7,0x3
    7e90:	07cb8b93          	addi	s7,s7,124 # af08 <malloc+0x1e84>
  for(i = 0; i < N; i++){
    7e94:	02800a13          	li	s4,40
    7e98:	acc1                	j	8168 <concreate+0x306>
      link("C0", file);
    7e9a:	fa840593          	addi	a1,s0,-88
    7e9e:	855e                	mv	a0,s7
    7ea0:	00001097          	auipc	ra,0x1
    7ea4:	de6080e7          	jalr	-538(ra) # 8c86 <link>
    if(pid == 0) {
    7ea8:	a45d                	j	814e <concreate+0x2ec>
    } else if(pid == 0 && (i % 5) == 1){
    7eaa:	4795                	li	a5,5
    7eac:	02f9693b          	remw	s2,s2,a5
    7eb0:	4785                	li	a5,1
    7eb2:	02f90b63          	beq	s2,a5,7ee8 <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    7eb6:	20200593          	li	a1,514
    7eba:	fa840513          	addi	a0,s0,-88
    7ebe:	00001097          	auipc	ra,0x1
    7ec2:	da8080e7          	jalr	-600(ra) # 8c66 <open>
      if(fd < 0){
    7ec6:	26055b63          	bgez	a0,813c <concreate+0x2da>
        printf("concreate create %s failed\n", file);
    7eca:	fa840593          	addi	a1,s0,-88
    7ece:	00003517          	auipc	a0,0x3
    7ed2:	04250513          	addi	a0,a0,66 # af10 <malloc+0x1e8c>
    7ed6:	00001097          	auipc	ra,0x1
    7eda:	0f0080e7          	jalr	240(ra) # 8fc6 <printf>
        exit(1);
    7ede:	4505                	li	a0,1
    7ee0:	00001097          	auipc	ra,0x1
    7ee4:	d3e080e7          	jalr	-706(ra) # 8c1e <exit>
      link("C0", file);
    7ee8:	fa840593          	addi	a1,s0,-88
    7eec:	00003517          	auipc	a0,0x3
    7ef0:	01c50513          	addi	a0,a0,28 # af08 <malloc+0x1e84>
    7ef4:	00001097          	auipc	ra,0x1
    7ef8:	d92080e7          	jalr	-622(ra) # 8c86 <link>
      exit(0);
    7efc:	4501                	li	a0,0
    7efe:	00001097          	auipc	ra,0x1
    7f02:	d20080e7          	jalr	-736(ra) # 8c1e <exit>
        exit(1);
    7f06:	4505                	li	a0,1
    7f08:	00001097          	auipc	ra,0x1
    7f0c:	d16080e7          	jalr	-746(ra) # 8c1e <exit>
  memset(fa, 0, sizeof(fa));
    7f10:	02800613          	li	a2,40
    7f14:	4581                	li	a1,0
    7f16:	f8040513          	addi	a0,s0,-128
    7f1a:	00001097          	auipc	ra,0x1
    7f1e:	ab0080e7          	jalr	-1360(ra) # 89ca <memset>
  fd = open(".", 0);
    7f22:	4581                	li	a1,0
    7f24:	00002517          	auipc	a0,0x2
    7f28:	98c50513          	addi	a0,a0,-1652 # 98b0 <malloc+0x82c>
    7f2c:	00001097          	auipc	ra,0x1
    7f30:	d3a080e7          	jalr	-710(ra) # 8c66 <open>
    7f34:	892a                	mv	s2,a0
  n = 0;
    7f36:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    7f38:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    7f3c:	02700b13          	li	s6,39
      fa[i] = 1;
    7f40:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    7f42:	4641                	li	a2,16
    7f44:	f7040593          	addi	a1,s0,-144
    7f48:	854a                	mv	a0,s2
    7f4a:	00001097          	auipc	ra,0x1
    7f4e:	cf4080e7          	jalr	-780(ra) # 8c3e <read>
    7f52:	08a05163          	blez	a0,7fd4 <concreate+0x172>
    if(de.inum == 0)
    7f56:	f7045783          	lhu	a5,-144(s0)
    7f5a:	d7e5                	beqz	a5,7f42 <concreate+0xe0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    7f5c:	f7244783          	lbu	a5,-142(s0)
    7f60:	ff4791e3          	bne	a5,s4,7f42 <concreate+0xe0>
    7f64:	f7444783          	lbu	a5,-140(s0)
    7f68:	ffe9                	bnez	a5,7f42 <concreate+0xe0>
      i = de.name[1] - '0';
    7f6a:	f7344783          	lbu	a5,-141(s0)
    7f6e:	fd07879b          	addiw	a5,a5,-48
    7f72:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    7f76:	00eb6f63          	bltu	s6,a4,7f94 <concreate+0x132>
      if(fa[i]){
    7f7a:	fb040793          	addi	a5,s0,-80
    7f7e:	97ba                	add	a5,a5,a4
    7f80:	fd07c783          	lbu	a5,-48(a5)
    7f84:	eb85                	bnez	a5,7fb4 <concreate+0x152>
      fa[i] = 1;
    7f86:	fb040793          	addi	a5,s0,-80
    7f8a:	973e                	add	a4,a4,a5
    7f8c:	fd770823          	sb	s7,-48(a4) # fd0 <copyinstr1-0x2030>
      n++;
    7f90:	2a85                	addiw	s5,s5,1
    7f92:	bf45                	j	7f42 <concreate+0xe0>
        printf("%s: concreate weird file %s\n", s, de.name);
    7f94:	f7240613          	addi	a2,s0,-142
    7f98:	85ce                	mv	a1,s3
    7f9a:	00003517          	auipc	a0,0x3
    7f9e:	f9650513          	addi	a0,a0,-106 # af30 <malloc+0x1eac>
    7fa2:	00001097          	auipc	ra,0x1
    7fa6:	024080e7          	jalr	36(ra) # 8fc6 <printf>
        exit(1);
    7faa:	4505                	li	a0,1
    7fac:	00001097          	auipc	ra,0x1
    7fb0:	c72080e7          	jalr	-910(ra) # 8c1e <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    7fb4:	f7240613          	addi	a2,s0,-142
    7fb8:	85ce                	mv	a1,s3
    7fba:	00003517          	auipc	a0,0x3
    7fbe:	f9650513          	addi	a0,a0,-106 # af50 <malloc+0x1ecc>
    7fc2:	00001097          	auipc	ra,0x1
    7fc6:	004080e7          	jalr	4(ra) # 8fc6 <printf>
        exit(1);
    7fca:	4505                	li	a0,1
    7fcc:	00001097          	auipc	ra,0x1
    7fd0:	c52080e7          	jalr	-942(ra) # 8c1e <exit>
  close(fd);
    7fd4:	854a                	mv	a0,s2
    7fd6:	00001097          	auipc	ra,0x1
    7fda:	c78080e7          	jalr	-904(ra) # 8c4e <close>
  if(n != N){
    7fde:	02800793          	li	a5,40
    7fe2:	00fa9763          	bne	s5,a5,7ff0 <concreate+0x18e>
    if(((i % 3) == 0 && pid == 0) ||
    7fe6:	4a8d                	li	s5,3
    7fe8:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    7fea:	02800a13          	li	s4,40
    7fee:	a8c9                	j	80c0 <concreate+0x25e>
    printf("%s: concreate not enough files in directory listing\n", s);
    7ff0:	85ce                	mv	a1,s3
    7ff2:	00003517          	auipc	a0,0x3
    7ff6:	f8650513          	addi	a0,a0,-122 # af78 <malloc+0x1ef4>
    7ffa:	00001097          	auipc	ra,0x1
    7ffe:	fcc080e7          	jalr	-52(ra) # 8fc6 <printf>
    exit(1);
    8002:	4505                	li	a0,1
    8004:	00001097          	auipc	ra,0x1
    8008:	c1a080e7          	jalr	-998(ra) # 8c1e <exit>
      printf("%s: fork failed\n", s);
    800c:	85ce                	mv	a1,s3
    800e:	00002517          	auipc	a0,0x2
    8012:	a4250513          	addi	a0,a0,-1470 # 9a50 <malloc+0x9cc>
    8016:	00001097          	auipc	ra,0x1
    801a:	fb0080e7          	jalr	-80(ra) # 8fc6 <printf>
      exit(1);
    801e:	4505                	li	a0,1
    8020:	00001097          	auipc	ra,0x1
    8024:	bfe080e7          	jalr	-1026(ra) # 8c1e <exit>
      close(open(file, 0));
    8028:	4581                	li	a1,0
    802a:	fa840513          	addi	a0,s0,-88
    802e:	00001097          	auipc	ra,0x1
    8032:	c38080e7          	jalr	-968(ra) # 8c66 <open>
    8036:	00001097          	auipc	ra,0x1
    803a:	c18080e7          	jalr	-1000(ra) # 8c4e <close>
      close(open(file, 0));
    803e:	4581                	li	a1,0
    8040:	fa840513          	addi	a0,s0,-88
    8044:	00001097          	auipc	ra,0x1
    8048:	c22080e7          	jalr	-990(ra) # 8c66 <open>
    804c:	00001097          	auipc	ra,0x1
    8050:	c02080e7          	jalr	-1022(ra) # 8c4e <close>
      close(open(file, 0));
    8054:	4581                	li	a1,0
    8056:	fa840513          	addi	a0,s0,-88
    805a:	00001097          	auipc	ra,0x1
    805e:	c0c080e7          	jalr	-1012(ra) # 8c66 <open>
    8062:	00001097          	auipc	ra,0x1
    8066:	bec080e7          	jalr	-1044(ra) # 8c4e <close>
      close(open(file, 0));
    806a:	4581                	li	a1,0
    806c:	fa840513          	addi	a0,s0,-88
    8070:	00001097          	auipc	ra,0x1
    8074:	bf6080e7          	jalr	-1034(ra) # 8c66 <open>
    8078:	00001097          	auipc	ra,0x1
    807c:	bd6080e7          	jalr	-1066(ra) # 8c4e <close>
      close(open(file, 0));
    8080:	4581                	li	a1,0
    8082:	fa840513          	addi	a0,s0,-88
    8086:	00001097          	auipc	ra,0x1
    808a:	be0080e7          	jalr	-1056(ra) # 8c66 <open>
    808e:	00001097          	auipc	ra,0x1
    8092:	bc0080e7          	jalr	-1088(ra) # 8c4e <close>
      close(open(file, 0));
    8096:	4581                	li	a1,0
    8098:	fa840513          	addi	a0,s0,-88
    809c:	00001097          	auipc	ra,0x1
    80a0:	bca080e7          	jalr	-1078(ra) # 8c66 <open>
    80a4:	00001097          	auipc	ra,0x1
    80a8:	baa080e7          	jalr	-1110(ra) # 8c4e <close>
    if(pid == 0)
    80ac:	08090363          	beqz	s2,8132 <concreate+0x2d0>
      wait(0);
    80b0:	4501                	li	a0,0
    80b2:	00001097          	auipc	ra,0x1
    80b6:	b74080e7          	jalr	-1164(ra) # 8c26 <wait>
  for(i = 0; i < N; i++){
    80ba:	2485                	addiw	s1,s1,1
    80bc:	0f448563          	beq	s1,s4,81a6 <concreate+0x344>
    file[1] = '0' + i;
    80c0:	0304879b          	addiw	a5,s1,48
    80c4:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    80c8:	00001097          	auipc	ra,0x1
    80cc:	b4e080e7          	jalr	-1202(ra) # 8c16 <fork>
    80d0:	892a                	mv	s2,a0
    if(pid < 0){
    80d2:	f2054de3          	bltz	a0,800c <concreate+0x1aa>
    if(((i % 3) == 0 && pid == 0) ||
    80d6:	0354e73b          	remw	a4,s1,s5
    80da:	00a767b3          	or	a5,a4,a0
    80de:	2781                	sext.w	a5,a5
    80e0:	d7a1                	beqz	a5,8028 <concreate+0x1c6>
    80e2:	01671363          	bne	a4,s6,80e8 <concreate+0x286>
       ((i % 3) == 1 && pid != 0)){
    80e6:	f129                	bnez	a0,8028 <concreate+0x1c6>
      unlink(file);
    80e8:	fa840513          	addi	a0,s0,-88
    80ec:	00001097          	auipc	ra,0x1
    80f0:	b8a080e7          	jalr	-1142(ra) # 8c76 <unlink>
      unlink(file);
    80f4:	fa840513          	addi	a0,s0,-88
    80f8:	00001097          	auipc	ra,0x1
    80fc:	b7e080e7          	jalr	-1154(ra) # 8c76 <unlink>
      unlink(file);
    8100:	fa840513          	addi	a0,s0,-88
    8104:	00001097          	auipc	ra,0x1
    8108:	b72080e7          	jalr	-1166(ra) # 8c76 <unlink>
      unlink(file);
    810c:	fa840513          	addi	a0,s0,-88
    8110:	00001097          	auipc	ra,0x1
    8114:	b66080e7          	jalr	-1178(ra) # 8c76 <unlink>
      unlink(file);
    8118:	fa840513          	addi	a0,s0,-88
    811c:	00001097          	auipc	ra,0x1
    8120:	b5a080e7          	jalr	-1190(ra) # 8c76 <unlink>
      unlink(file);
    8124:	fa840513          	addi	a0,s0,-88
    8128:	00001097          	auipc	ra,0x1
    812c:	b4e080e7          	jalr	-1202(ra) # 8c76 <unlink>
    8130:	bfb5                	j	80ac <concreate+0x24a>
      exit(0);
    8132:	4501                	li	a0,0
    8134:	00001097          	auipc	ra,0x1
    8138:	aea080e7          	jalr	-1302(ra) # 8c1e <exit>
      close(fd);
    813c:	00001097          	auipc	ra,0x1
    8140:	b12080e7          	jalr	-1262(ra) # 8c4e <close>
    if(pid == 0) {
    8144:	bb65                	j	7efc <concreate+0x9a>
      close(fd);
    8146:	00001097          	auipc	ra,0x1
    814a:	b08080e7          	jalr	-1272(ra) # 8c4e <close>
      wait(&xstatus);
    814e:	f6c40513          	addi	a0,s0,-148
    8152:	00001097          	auipc	ra,0x1
    8156:	ad4080e7          	jalr	-1324(ra) # 8c26 <wait>
      if(xstatus != 0)
    815a:	f6c42483          	lw	s1,-148(s0)
    815e:	da0494e3          	bnez	s1,7f06 <concreate+0xa4>
  for(i = 0; i < N; i++){
    8162:	2905                	addiw	s2,s2,1
    8164:	db4906e3          	beq	s2,s4,7f10 <concreate+0xae>
    file[1] = '0' + i;
    8168:	0309079b          	addiw	a5,s2,48
    816c:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    8170:	fa840513          	addi	a0,s0,-88
    8174:	00001097          	auipc	ra,0x1
    8178:	b02080e7          	jalr	-1278(ra) # 8c76 <unlink>
    pid = fork();
    817c:	00001097          	auipc	ra,0x1
    8180:	a9a080e7          	jalr	-1382(ra) # 8c16 <fork>
    if(pid && (i % 3) == 1){
    8184:	d20503e3          	beqz	a0,7eaa <concreate+0x48>
    8188:	036967bb          	remw	a5,s2,s6
    818c:	d15787e3          	beq	a5,s5,7e9a <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    8190:	20200593          	li	a1,514
    8194:	fa840513          	addi	a0,s0,-88
    8198:	00001097          	auipc	ra,0x1
    819c:	ace080e7          	jalr	-1330(ra) # 8c66 <open>
      if(fd < 0){
    81a0:	fa0553e3          	bgez	a0,8146 <concreate+0x2e4>
    81a4:	b31d                	j	7eca <concreate+0x68>
}
    81a6:	60ea                	ld	ra,152(sp)
    81a8:	644a                	ld	s0,144(sp)
    81aa:	64aa                	ld	s1,136(sp)
    81ac:	690a                	ld	s2,128(sp)
    81ae:	79e6                	ld	s3,120(sp)
    81b0:	7a46                	ld	s4,112(sp)
    81b2:	7aa6                	ld	s5,104(sp)
    81b4:	7b06                	ld	s6,96(sp)
    81b6:	6be6                	ld	s7,88(sp)
    81b8:	610d                	addi	sp,sp,160
    81ba:	8082                	ret

00000000000081bc <bigfile>:
{
    81bc:	7139                	addi	sp,sp,-64
    81be:	fc06                	sd	ra,56(sp)
    81c0:	f822                	sd	s0,48(sp)
    81c2:	f426                	sd	s1,40(sp)
    81c4:	f04a                	sd	s2,32(sp)
    81c6:	ec4e                	sd	s3,24(sp)
    81c8:	e852                	sd	s4,16(sp)
    81ca:	e456                	sd	s5,8(sp)
    81cc:	0080                	addi	s0,sp,64
    81ce:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    81d0:	00003517          	auipc	a0,0x3
    81d4:	de050513          	addi	a0,a0,-544 # afb0 <malloc+0x1f2c>
    81d8:	00001097          	auipc	ra,0x1
    81dc:	a9e080e7          	jalr	-1378(ra) # 8c76 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    81e0:	20200593          	li	a1,514
    81e4:	00003517          	auipc	a0,0x3
    81e8:	dcc50513          	addi	a0,a0,-564 # afb0 <malloc+0x1f2c>
    81ec:	00001097          	auipc	ra,0x1
    81f0:	a7a080e7          	jalr	-1414(ra) # 8c66 <open>
    81f4:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    81f6:	4481                	li	s1,0
    memset(buf, i, SZ);
    81f8:	00008917          	auipc	s2,0x8
    81fc:	a8090913          	addi	s2,s2,-1408 # fc78 <buf>
  for(i = 0; i < N; i++){
    8200:	4a51                	li	s4,20
  if(fd < 0){
    8202:	0a054063          	bltz	a0,82a2 <bigfile+0xe6>
    memset(buf, i, SZ);
    8206:	25800613          	li	a2,600
    820a:	85a6                	mv	a1,s1
    820c:	854a                	mv	a0,s2
    820e:	00000097          	auipc	ra,0x0
    8212:	7bc080e7          	jalr	1980(ra) # 89ca <memset>
    if(write(fd, buf, SZ) != SZ){
    8216:	25800613          	li	a2,600
    821a:	85ca                	mv	a1,s2
    821c:	854e                	mv	a0,s3
    821e:	00001097          	auipc	ra,0x1
    8222:	a28080e7          	jalr	-1496(ra) # 8c46 <write>
    8226:	25800793          	li	a5,600
    822a:	08f51a63          	bne	a0,a5,82be <bigfile+0x102>
  for(i = 0; i < N; i++){
    822e:	2485                	addiw	s1,s1,1
    8230:	fd449be3          	bne	s1,s4,8206 <bigfile+0x4a>
  close(fd);
    8234:	854e                	mv	a0,s3
    8236:	00001097          	auipc	ra,0x1
    823a:	a18080e7          	jalr	-1512(ra) # 8c4e <close>
  fd = open("bigfile.dat", 0);
    823e:	4581                	li	a1,0
    8240:	00003517          	auipc	a0,0x3
    8244:	d7050513          	addi	a0,a0,-656 # afb0 <malloc+0x1f2c>
    8248:	00001097          	auipc	ra,0x1
    824c:	a1e080e7          	jalr	-1506(ra) # 8c66 <open>
    8250:	8a2a                	mv	s4,a0
  total = 0;
    8252:	4981                	li	s3,0
  for(i = 0; ; i++){
    8254:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    8256:	00008917          	auipc	s2,0x8
    825a:	a2290913          	addi	s2,s2,-1502 # fc78 <buf>
  if(fd < 0){
    825e:	06054e63          	bltz	a0,82da <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    8262:	12c00613          	li	a2,300
    8266:	85ca                	mv	a1,s2
    8268:	8552                	mv	a0,s4
    826a:	00001097          	auipc	ra,0x1
    826e:	9d4080e7          	jalr	-1580(ra) # 8c3e <read>
    if(cc < 0){
    8272:	08054263          	bltz	a0,82f6 <bigfile+0x13a>
    if(cc == 0)
    8276:	c971                	beqz	a0,834a <bigfile+0x18e>
    if(cc != SZ/2){
    8278:	12c00793          	li	a5,300
    827c:	08f51b63          	bne	a0,a5,8312 <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    8280:	01f4d79b          	srliw	a5,s1,0x1f
    8284:	9fa5                	addw	a5,a5,s1
    8286:	4017d79b          	sraiw	a5,a5,0x1
    828a:	00094703          	lbu	a4,0(s2)
    828e:	0af71063          	bne	a4,a5,832e <bigfile+0x172>
    8292:	12b94703          	lbu	a4,299(s2)
    8296:	08f71c63          	bne	a4,a5,832e <bigfile+0x172>
    total += cc;
    829a:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    829e:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    82a0:	b7c9                	j	8262 <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    82a2:	85d6                	mv	a1,s5
    82a4:	00003517          	auipc	a0,0x3
    82a8:	d1c50513          	addi	a0,a0,-740 # afc0 <malloc+0x1f3c>
    82ac:	00001097          	auipc	ra,0x1
    82b0:	d1a080e7          	jalr	-742(ra) # 8fc6 <printf>
    exit(1);
    82b4:	4505                	li	a0,1
    82b6:	00001097          	auipc	ra,0x1
    82ba:	968080e7          	jalr	-1688(ra) # 8c1e <exit>
      printf("%s: write bigfile failed\n", s);
    82be:	85d6                	mv	a1,s5
    82c0:	00003517          	auipc	a0,0x3
    82c4:	d2050513          	addi	a0,a0,-736 # afe0 <malloc+0x1f5c>
    82c8:	00001097          	auipc	ra,0x1
    82cc:	cfe080e7          	jalr	-770(ra) # 8fc6 <printf>
      exit(1);
    82d0:	4505                	li	a0,1
    82d2:	00001097          	auipc	ra,0x1
    82d6:	94c080e7          	jalr	-1716(ra) # 8c1e <exit>
    printf("%s: cannot open bigfile\n", s);
    82da:	85d6                	mv	a1,s5
    82dc:	00003517          	auipc	a0,0x3
    82e0:	d2450513          	addi	a0,a0,-732 # b000 <malloc+0x1f7c>
    82e4:	00001097          	auipc	ra,0x1
    82e8:	ce2080e7          	jalr	-798(ra) # 8fc6 <printf>
    exit(1);
    82ec:	4505                	li	a0,1
    82ee:	00001097          	auipc	ra,0x1
    82f2:	930080e7          	jalr	-1744(ra) # 8c1e <exit>
      printf("%s: read bigfile failed\n", s);
    82f6:	85d6                	mv	a1,s5
    82f8:	00003517          	auipc	a0,0x3
    82fc:	d2850513          	addi	a0,a0,-728 # b020 <malloc+0x1f9c>
    8300:	00001097          	auipc	ra,0x1
    8304:	cc6080e7          	jalr	-826(ra) # 8fc6 <printf>
      exit(1);
    8308:	4505                	li	a0,1
    830a:	00001097          	auipc	ra,0x1
    830e:	914080e7          	jalr	-1772(ra) # 8c1e <exit>
      printf("%s: short read bigfile\n", s);
    8312:	85d6                	mv	a1,s5
    8314:	00003517          	auipc	a0,0x3
    8318:	d2c50513          	addi	a0,a0,-724 # b040 <malloc+0x1fbc>
    831c:	00001097          	auipc	ra,0x1
    8320:	caa080e7          	jalr	-854(ra) # 8fc6 <printf>
      exit(1);
    8324:	4505                	li	a0,1
    8326:	00001097          	auipc	ra,0x1
    832a:	8f8080e7          	jalr	-1800(ra) # 8c1e <exit>
      printf("%s: read bigfile wrong data\n", s);
    832e:	85d6                	mv	a1,s5
    8330:	00003517          	auipc	a0,0x3
    8334:	d2850513          	addi	a0,a0,-728 # b058 <malloc+0x1fd4>
    8338:	00001097          	auipc	ra,0x1
    833c:	c8e080e7          	jalr	-882(ra) # 8fc6 <printf>
      exit(1);
    8340:	4505                	li	a0,1
    8342:	00001097          	auipc	ra,0x1
    8346:	8dc080e7          	jalr	-1828(ra) # 8c1e <exit>
  close(fd);
    834a:	8552                	mv	a0,s4
    834c:	00001097          	auipc	ra,0x1
    8350:	902080e7          	jalr	-1790(ra) # 8c4e <close>
  if(total != N*SZ){
    8354:	678d                	lui	a5,0x3
    8356:	ee078793          	addi	a5,a5,-288 # 2ee0 <copyinstr1-0x120>
    835a:	02f99363          	bne	s3,a5,8380 <bigfile+0x1c4>
  unlink("bigfile.dat");
    835e:	00003517          	auipc	a0,0x3
    8362:	c5250513          	addi	a0,a0,-942 # afb0 <malloc+0x1f2c>
    8366:	00001097          	auipc	ra,0x1
    836a:	910080e7          	jalr	-1776(ra) # 8c76 <unlink>
}
    836e:	70e2                	ld	ra,56(sp)
    8370:	7442                	ld	s0,48(sp)
    8372:	74a2                	ld	s1,40(sp)
    8374:	7902                	ld	s2,32(sp)
    8376:	69e2                	ld	s3,24(sp)
    8378:	6a42                	ld	s4,16(sp)
    837a:	6aa2                	ld	s5,8(sp)
    837c:	6121                	addi	sp,sp,64
    837e:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    8380:	85d6                	mv	a1,s5
    8382:	00003517          	auipc	a0,0x3
    8386:	cf650513          	addi	a0,a0,-778 # b078 <malloc+0x1ff4>
    838a:	00001097          	auipc	ra,0x1
    838e:	c3c080e7          	jalr	-964(ra) # 8fc6 <printf>
    exit(1);
    8392:	4505                	li	a0,1
    8394:	00001097          	auipc	ra,0x1
    8398:	88a080e7          	jalr	-1910(ra) # 8c1e <exit>

000000000000839c <fsfull>:
{
    839c:	7171                	addi	sp,sp,-176
    839e:	f506                	sd	ra,168(sp)
    83a0:	f122                	sd	s0,160(sp)
    83a2:	ed26                	sd	s1,152(sp)
    83a4:	e94a                	sd	s2,144(sp)
    83a6:	e54e                	sd	s3,136(sp)
    83a8:	e152                	sd	s4,128(sp)
    83aa:	fcd6                	sd	s5,120(sp)
    83ac:	f8da                	sd	s6,112(sp)
    83ae:	f4de                	sd	s7,104(sp)
    83b0:	f0e2                	sd	s8,96(sp)
    83b2:	ece6                	sd	s9,88(sp)
    83b4:	e8ea                	sd	s10,80(sp)
    83b6:	e4ee                	sd	s11,72(sp)
    83b8:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    83ba:	00003517          	auipc	a0,0x3
    83be:	cde50513          	addi	a0,a0,-802 # b098 <malloc+0x2014>
    83c2:	00001097          	auipc	ra,0x1
    83c6:	c04080e7          	jalr	-1020(ra) # 8fc6 <printf>
  for(nfiles = 0; ; nfiles++){
    83ca:	4481                	li	s1,0
    name[0] = 'f';
    83cc:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    83d0:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    83d4:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    83d8:	4b29                	li	s6,10
    printf("writing %s\n", name);
    83da:	00003c97          	auipc	s9,0x3
    83de:	ccec8c93          	addi	s9,s9,-818 # b0a8 <malloc+0x2024>
    int total = 0;
    83e2:	4d81                	li	s11,0
      int cc = write(fd, buf, BSIZE);
    83e4:	00008a17          	auipc	s4,0x8
    83e8:	894a0a13          	addi	s4,s4,-1900 # fc78 <buf>
    name[0] = 'f';
    83ec:	f5a40823          	sb	s10,-176(s0)
    name[1] = '0' + nfiles / 1000;
    83f0:	0384c7bb          	divw	a5,s1,s8
    83f4:	0307879b          	addiw	a5,a5,48
    83f8:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    83fc:	0384e7bb          	remw	a5,s1,s8
    8400:	0377c7bb          	divw	a5,a5,s7
    8404:	0307879b          	addiw	a5,a5,48
    8408:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    840c:	0374e7bb          	remw	a5,s1,s7
    8410:	0367c7bb          	divw	a5,a5,s6
    8414:	0307879b          	addiw	a5,a5,48
    8418:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    841c:	0364e7bb          	remw	a5,s1,s6
    8420:	0307879b          	addiw	a5,a5,48
    8424:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    8428:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    842c:	f5040593          	addi	a1,s0,-176
    8430:	8566                	mv	a0,s9
    8432:	00001097          	auipc	ra,0x1
    8436:	b94080e7          	jalr	-1132(ra) # 8fc6 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    843a:	20200593          	li	a1,514
    843e:	f5040513          	addi	a0,s0,-176
    8442:	00001097          	auipc	ra,0x1
    8446:	824080e7          	jalr	-2012(ra) # 8c66 <open>
    844a:	892a                	mv	s2,a0
    if(fd < 0){
    844c:	0a055663          	bgez	a0,84f8 <fsfull+0x15c>
      printf("open %s failed\n", name);
    8450:	f5040593          	addi	a1,s0,-176
    8454:	00003517          	auipc	a0,0x3
    8458:	c6450513          	addi	a0,a0,-924 # b0b8 <malloc+0x2034>
    845c:	00001097          	auipc	ra,0x1
    8460:	b6a080e7          	jalr	-1174(ra) # 8fc6 <printf>
  while(nfiles >= 0){
    8464:	0604c363          	bltz	s1,84ca <fsfull+0x12e>
    name[0] = 'f';
    8468:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    846c:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    8470:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    8474:	4929                	li	s2,10
  while(nfiles >= 0){
    8476:	5afd                	li	s5,-1
    name[0] = 'f';
    8478:	f5640823          	sb	s6,-176(s0)
    name[1] = '0' + nfiles / 1000;
    847c:	0344c7bb          	divw	a5,s1,s4
    8480:	0307879b          	addiw	a5,a5,48
    8484:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    8488:	0344e7bb          	remw	a5,s1,s4
    848c:	0337c7bb          	divw	a5,a5,s3
    8490:	0307879b          	addiw	a5,a5,48
    8494:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    8498:	0334e7bb          	remw	a5,s1,s3
    849c:	0327c7bb          	divw	a5,a5,s2
    84a0:	0307879b          	addiw	a5,a5,48
    84a4:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    84a8:	0324e7bb          	remw	a5,s1,s2
    84ac:	0307879b          	addiw	a5,a5,48
    84b0:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    84b4:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    84b8:	f5040513          	addi	a0,s0,-176
    84bc:	00000097          	auipc	ra,0x0
    84c0:	7ba080e7          	jalr	1978(ra) # 8c76 <unlink>
    nfiles--;
    84c4:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    84c6:	fb5499e3          	bne	s1,s5,8478 <fsfull+0xdc>
  printf("fsfull test finished\n");
    84ca:	00003517          	auipc	a0,0x3
    84ce:	c0e50513          	addi	a0,a0,-1010 # b0d8 <malloc+0x2054>
    84d2:	00001097          	auipc	ra,0x1
    84d6:	af4080e7          	jalr	-1292(ra) # 8fc6 <printf>
}
    84da:	70aa                	ld	ra,168(sp)
    84dc:	740a                	ld	s0,160(sp)
    84de:	64ea                	ld	s1,152(sp)
    84e0:	694a                	ld	s2,144(sp)
    84e2:	69aa                	ld	s3,136(sp)
    84e4:	6a0a                	ld	s4,128(sp)
    84e6:	7ae6                	ld	s5,120(sp)
    84e8:	7b46                	ld	s6,112(sp)
    84ea:	7ba6                	ld	s7,104(sp)
    84ec:	7c06                	ld	s8,96(sp)
    84ee:	6ce6                	ld	s9,88(sp)
    84f0:	6d46                	ld	s10,80(sp)
    84f2:	6da6                	ld	s11,72(sp)
    84f4:	614d                	addi	sp,sp,176
    84f6:	8082                	ret
    int total = 0;
    84f8:	89ee                	mv	s3,s11
      if(cc < BSIZE)
    84fa:	3ff00a93          	li	s5,1023
      int cc = write(fd, buf, BSIZE);
    84fe:	40000613          	li	a2,1024
    8502:	85d2                	mv	a1,s4
    8504:	854a                	mv	a0,s2
    8506:	00000097          	auipc	ra,0x0
    850a:	740080e7          	jalr	1856(ra) # 8c46 <write>
      if(cc < BSIZE)
    850e:	00aad563          	bge	s5,a0,8518 <fsfull+0x17c>
      total += cc;
    8512:	00a989bb          	addw	s3,s3,a0
    while(1){
    8516:	b7e5                	j	84fe <fsfull+0x162>
    printf("wrote %d bytes\n", total);
    8518:	85ce                	mv	a1,s3
    851a:	00003517          	auipc	a0,0x3
    851e:	bae50513          	addi	a0,a0,-1106 # b0c8 <malloc+0x2044>
    8522:	00001097          	auipc	ra,0x1
    8526:	aa4080e7          	jalr	-1372(ra) # 8fc6 <printf>
    close(fd);
    852a:	854a                	mv	a0,s2
    852c:	00000097          	auipc	ra,0x0
    8530:	722080e7          	jalr	1826(ra) # 8c4e <close>
    if(total == 0)
    8534:	f20988e3          	beqz	s3,8464 <fsfull+0xc8>
  for(nfiles = 0; ; nfiles++){
    8538:	2485                	addiw	s1,s1,1
    853a:	bd4d                	j	83ec <fsfull+0x50>

000000000000853c <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    853c:	7179                	addi	sp,sp,-48
    853e:	f406                	sd	ra,40(sp)
    8540:	f022                	sd	s0,32(sp)
    8542:	ec26                	sd	s1,24(sp)
    8544:	e84a                	sd	s2,16(sp)
    8546:	1800                	addi	s0,sp,48
    8548:	84aa                	mv	s1,a0
    854a:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    854c:	00003517          	auipc	a0,0x3
    8550:	ba450513          	addi	a0,a0,-1116 # b0f0 <malloc+0x206c>
    8554:	00001097          	auipc	ra,0x1
    8558:	a72080e7          	jalr	-1422(ra) # 8fc6 <printf>
  if((pid = fork()) < 0) {
    855c:	00000097          	auipc	ra,0x0
    8560:	6ba080e7          	jalr	1722(ra) # 8c16 <fork>
    8564:	02054e63          	bltz	a0,85a0 <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    8568:	c929                	beqz	a0,85ba <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    856a:	fdc40513          	addi	a0,s0,-36
    856e:	00000097          	auipc	ra,0x0
    8572:	6b8080e7          	jalr	1720(ra) # 8c26 <wait>
    if(xstatus != 0) 
    8576:	fdc42783          	lw	a5,-36(s0)
    857a:	c7b9                	beqz	a5,85c8 <run+0x8c>
      printf("FAILED\n");
    857c:	00003517          	auipc	a0,0x3
    8580:	b9c50513          	addi	a0,a0,-1124 # b118 <malloc+0x2094>
    8584:	00001097          	auipc	ra,0x1
    8588:	a42080e7          	jalr	-1470(ra) # 8fc6 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    858c:	fdc42503          	lw	a0,-36(s0)
  }
}
    8590:	00153513          	seqz	a0,a0
    8594:	70a2                	ld	ra,40(sp)
    8596:	7402                	ld	s0,32(sp)
    8598:	64e2                	ld	s1,24(sp)
    859a:	6942                	ld	s2,16(sp)
    859c:	6145                	addi	sp,sp,48
    859e:	8082                	ret
    printf("runtest: fork error\n");
    85a0:	00003517          	auipc	a0,0x3
    85a4:	b6050513          	addi	a0,a0,-1184 # b100 <malloc+0x207c>
    85a8:	00001097          	auipc	ra,0x1
    85ac:	a1e080e7          	jalr	-1506(ra) # 8fc6 <printf>
    exit(1);
    85b0:	4505                	li	a0,1
    85b2:	00000097          	auipc	ra,0x0
    85b6:	66c080e7          	jalr	1644(ra) # 8c1e <exit>
    f(s);
    85ba:	854a                	mv	a0,s2
    85bc:	9482                	jalr	s1
    exit(0);
    85be:	4501                	li	a0,0
    85c0:	00000097          	auipc	ra,0x0
    85c4:	65e080e7          	jalr	1630(ra) # 8c1e <exit>
      printf("OK\n");
    85c8:	00003517          	auipc	a0,0x3
    85cc:	b5850513          	addi	a0,a0,-1192 # b120 <malloc+0x209c>
    85d0:	00001097          	auipc	ra,0x1
    85d4:	9f6080e7          	jalr	-1546(ra) # 8fc6 <printf>
    85d8:	bf55                	j	858c <run+0x50>

00000000000085da <runtests>:

int
runtests(struct test *tests, char *justone) {
    85da:	1101                	addi	sp,sp,-32
    85dc:	ec06                	sd	ra,24(sp)
    85de:	e822                	sd	s0,16(sp)
    85e0:	e426                	sd	s1,8(sp)
    85e2:	e04a                	sd	s2,0(sp)
    85e4:	1000                	addi	s0,sp,32
    85e6:	84aa                	mv	s1,a0
    85e8:	892e                	mv	s2,a1
  for (struct test *t = tests; t->s != 0; t++) {
    85ea:	6508                	ld	a0,8(a0)
    85ec:	ed09                	bnez	a0,8606 <runtests+0x2c>
        printf("SOME TESTS FAILED\n");
        return 1;
      }
    }
  }
  return 0;
    85ee:	4501                	li	a0,0
    85f0:	a82d                	j	862a <runtests+0x50>
      if(!run(t->f, t->s)){
    85f2:	648c                	ld	a1,8(s1)
    85f4:	6088                	ld	a0,0(s1)
    85f6:	00000097          	auipc	ra,0x0
    85fa:	f46080e7          	jalr	-186(ra) # 853c <run>
    85fe:	cd09                	beqz	a0,8618 <runtests+0x3e>
  for (struct test *t = tests; t->s != 0; t++) {
    8600:	04c1                	addi	s1,s1,16
    8602:	6488                	ld	a0,8(s1)
    8604:	c11d                	beqz	a0,862a <runtests+0x50>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    8606:	fe0906e3          	beqz	s2,85f2 <runtests+0x18>
    860a:	85ca                	mv	a1,s2
    860c:	00000097          	auipc	ra,0x0
    8610:	368080e7          	jalr	872(ra) # 8974 <strcmp>
    8614:	f575                	bnez	a0,8600 <runtests+0x26>
    8616:	bff1                	j	85f2 <runtests+0x18>
        printf("SOME TESTS FAILED\n");
    8618:	00003517          	auipc	a0,0x3
    861c:	b1050513          	addi	a0,a0,-1264 # b128 <malloc+0x20a4>
    8620:	00001097          	auipc	ra,0x1
    8624:	9a6080e7          	jalr	-1626(ra) # 8fc6 <printf>
        return 1;
    8628:	4505                	li	a0,1
}
    862a:	60e2                	ld	ra,24(sp)
    862c:	6442                	ld	s0,16(sp)
    862e:	64a2                	ld	s1,8(sp)
    8630:	6902                	ld	s2,0(sp)
    8632:	6105                	addi	sp,sp,32
    8634:	8082                	ret

0000000000008636 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    8636:	7139                	addi	sp,sp,-64
    8638:	fc06                	sd	ra,56(sp)
    863a:	f822                	sd	s0,48(sp)
    863c:	f426                	sd	s1,40(sp)
    863e:	f04a                	sd	s2,32(sp)
    8640:	ec4e                	sd	s3,24(sp)
    8642:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    8644:	fc840513          	addi	a0,s0,-56
    8648:	00000097          	auipc	ra,0x0
    864c:	5ee080e7          	jalr	1518(ra) # 8c36 <pipe>
    8650:	06054763          	bltz	a0,86be <countfree+0x88>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    8654:	00000097          	auipc	ra,0x0
    8658:	5c2080e7          	jalr	1474(ra) # 8c16 <fork>

  if(pid < 0){
    865c:	06054e63          	bltz	a0,86d8 <countfree+0xa2>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    8660:	ed51                	bnez	a0,86fc <countfree+0xc6>
    close(fds[0]);
    8662:	fc842503          	lw	a0,-56(s0)
    8666:	00000097          	auipc	ra,0x0
    866a:	5e8080e7          	jalr	1512(ra) # 8c4e <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    866e:	597d                	li	s2,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    8670:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    8672:	00001997          	auipc	s3,0x1
    8676:	bc698993          	addi	s3,s3,-1082 # 9238 <malloc+0x1b4>
      uint64 a = (uint64) sbrk(4096);
    867a:	6505                	lui	a0,0x1
    867c:	00000097          	auipc	ra,0x0
    8680:	632080e7          	jalr	1586(ra) # 8cae <sbrk>
      if(a == 0xffffffffffffffff){
    8684:	07250763          	beq	a0,s2,86f2 <countfree+0xbc>
      *(char *)(a + 4096 - 1) = 1;
    8688:	6785                	lui	a5,0x1
    868a:	953e                	add	a0,a0,a5
    868c:	fe950fa3          	sb	s1,-1(a0) # fff <copyinstr1-0x2001>
      if(write(fds[1], "x", 1) != 1){
    8690:	8626                	mv	a2,s1
    8692:	85ce                	mv	a1,s3
    8694:	fcc42503          	lw	a0,-52(s0)
    8698:	00000097          	auipc	ra,0x0
    869c:	5ae080e7          	jalr	1454(ra) # 8c46 <write>
    86a0:	fc950de3          	beq	a0,s1,867a <countfree+0x44>
        printf("write() failed in countfree()\n");
    86a4:	00003517          	auipc	a0,0x3
    86a8:	adc50513          	addi	a0,a0,-1316 # b180 <malloc+0x20fc>
    86ac:	00001097          	auipc	ra,0x1
    86b0:	91a080e7          	jalr	-1766(ra) # 8fc6 <printf>
        exit(1);
    86b4:	4505                	li	a0,1
    86b6:	00000097          	auipc	ra,0x0
    86ba:	568080e7          	jalr	1384(ra) # 8c1e <exit>
    printf("pipe() failed in countfree()\n");
    86be:	00003517          	auipc	a0,0x3
    86c2:	a8250513          	addi	a0,a0,-1406 # b140 <malloc+0x20bc>
    86c6:	00001097          	auipc	ra,0x1
    86ca:	900080e7          	jalr	-1792(ra) # 8fc6 <printf>
    exit(1);
    86ce:	4505                	li	a0,1
    86d0:	00000097          	auipc	ra,0x0
    86d4:	54e080e7          	jalr	1358(ra) # 8c1e <exit>
    printf("fork failed in countfree()\n");
    86d8:	00003517          	auipc	a0,0x3
    86dc:	a8850513          	addi	a0,a0,-1400 # b160 <malloc+0x20dc>
    86e0:	00001097          	auipc	ra,0x1
    86e4:	8e6080e7          	jalr	-1818(ra) # 8fc6 <printf>
    exit(1);
    86e8:	4505                	li	a0,1
    86ea:	00000097          	auipc	ra,0x0
    86ee:	534080e7          	jalr	1332(ra) # 8c1e <exit>
      }
    }

    exit(0);
    86f2:	4501                	li	a0,0
    86f4:	00000097          	auipc	ra,0x0
    86f8:	52a080e7          	jalr	1322(ra) # 8c1e <exit>
  }

  close(fds[1]);
    86fc:	fcc42503          	lw	a0,-52(s0)
    8700:	00000097          	auipc	ra,0x0
    8704:	54e080e7          	jalr	1358(ra) # 8c4e <close>

  int n = 0;
    8708:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    870a:	4605                	li	a2,1
    870c:	fc740593          	addi	a1,s0,-57
    8710:	fc842503          	lw	a0,-56(s0)
    8714:	00000097          	auipc	ra,0x0
    8718:	52a080e7          	jalr	1322(ra) # 8c3e <read>
    if(cc < 0){
    871c:	00054563          	bltz	a0,8726 <countfree+0xf0>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    8720:	c105                	beqz	a0,8740 <countfree+0x10a>
      break;
    n += 1;
    8722:	2485                	addiw	s1,s1,1
  while(1){
    8724:	b7dd                	j	870a <countfree+0xd4>
      printf("read() failed in countfree()\n");
    8726:	00003517          	auipc	a0,0x3
    872a:	a7a50513          	addi	a0,a0,-1414 # b1a0 <malloc+0x211c>
    872e:	00001097          	auipc	ra,0x1
    8732:	898080e7          	jalr	-1896(ra) # 8fc6 <printf>
      exit(1);
    8736:	4505                	li	a0,1
    8738:	00000097          	auipc	ra,0x0
    873c:	4e6080e7          	jalr	1254(ra) # 8c1e <exit>
  }

  close(fds[0]);
    8740:	fc842503          	lw	a0,-56(s0)
    8744:	00000097          	auipc	ra,0x0
    8748:	50a080e7          	jalr	1290(ra) # 8c4e <close>
  wait((int*)0);
    874c:	4501                	li	a0,0
    874e:	00000097          	auipc	ra,0x0
    8752:	4d8080e7          	jalr	1240(ra) # 8c26 <wait>
  
  return n;
}
    8756:	8526                	mv	a0,s1
    8758:	70e2                	ld	ra,56(sp)
    875a:	7442                	ld	s0,48(sp)
    875c:	74a2                	ld	s1,40(sp)
    875e:	7902                	ld	s2,32(sp)
    8760:	69e2                	ld	s3,24(sp)
    8762:	6121                	addi	sp,sp,64
    8764:	8082                	ret

0000000000008766 <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    8766:	711d                	addi	sp,sp,-96
    8768:	ec86                	sd	ra,88(sp)
    876a:	e8a2                	sd	s0,80(sp)
    876c:	e4a6                	sd	s1,72(sp)
    876e:	e0ca                	sd	s2,64(sp)
    8770:	fc4e                	sd	s3,56(sp)
    8772:	f852                	sd	s4,48(sp)
    8774:	f456                	sd	s5,40(sp)
    8776:	f05a                	sd	s6,32(sp)
    8778:	ec5e                	sd	s7,24(sp)
    877a:	e862                	sd	s8,16(sp)
    877c:	e466                	sd	s9,8(sp)
    877e:	e06a                	sd	s10,0(sp)
    8780:	1080                	addi	s0,sp,96
    8782:	8a2a                	mv	s4,a0
    8784:	89ae                	mv	s3,a1
    8786:	8932                	mv	s2,a2
  do {
    printf("usertests starting\n");
    8788:	00003b97          	auipc	s7,0x3
    878c:	a38b8b93          	addi	s7,s7,-1480 # b1c0 <malloc+0x213c>
    int free0 = countfree();
    int free1 = 0;
    if (runtests(quicktests, justone)) {
    8790:	00004b17          	auipc	s6,0x4
    8794:	880b0b13          	addi	s6,s6,-1920 # c010 <quicktests>
      if(continuous != 2) {
    8798:	4a89                	li	s5,2
          return 1;
        }
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    879a:	00003c97          	auipc	s9,0x3
    879e:	a5ec8c93          	addi	s9,s9,-1442 # b1f8 <malloc+0x2174>
      if (runtests(slowtests, justone)) {
    87a2:	00004c17          	auipc	s8,0x4
    87a6:	c3ec0c13          	addi	s8,s8,-962 # c3e0 <slowtests>
        printf("usertests slow tests starting\n");
    87aa:	00003d17          	auipc	s10,0x3
    87ae:	a2ed0d13          	addi	s10,s10,-1490 # b1d8 <malloc+0x2154>
    87b2:	a839                	j	87d0 <drivetests+0x6a>
    87b4:	856a                	mv	a0,s10
    87b6:	00001097          	auipc	ra,0x1
    87ba:	810080e7          	jalr	-2032(ra) # 8fc6 <printf>
    87be:	a081                	j	87fe <drivetests+0x98>
    if((free1 = countfree()) < free0) {
    87c0:	00000097          	auipc	ra,0x0
    87c4:	e76080e7          	jalr	-394(ra) # 8636 <countfree>
    87c8:	06954263          	blt	a0,s1,882c <drivetests+0xc6>
      if(continuous != 2) {
        return 1;
      }
    }
  } while(continuous);
    87cc:	06098f63          	beqz	s3,884a <drivetests+0xe4>
    printf("usertests starting\n");
    87d0:	855e                	mv	a0,s7
    87d2:	00000097          	auipc	ra,0x0
    87d6:	7f4080e7          	jalr	2036(ra) # 8fc6 <printf>
    int free0 = countfree();
    87da:	00000097          	auipc	ra,0x0
    87de:	e5c080e7          	jalr	-420(ra) # 8636 <countfree>
    87e2:	84aa                	mv	s1,a0
    if (runtests(quicktests, justone)) {
    87e4:	85ca                	mv	a1,s2
    87e6:	855a                	mv	a0,s6
    87e8:	00000097          	auipc	ra,0x0
    87ec:	df2080e7          	jalr	-526(ra) # 85da <runtests>
    87f0:	c119                	beqz	a0,87f6 <drivetests+0x90>
      if(continuous != 2) {
    87f2:	05599863          	bne	s3,s5,8842 <drivetests+0xdc>
    if(!quick) {
    87f6:	fc0a15e3          	bnez	s4,87c0 <drivetests+0x5a>
      if (justone == 0)
    87fa:	fa090de3          	beqz	s2,87b4 <drivetests+0x4e>
      if (runtests(slowtests, justone)) {
    87fe:	85ca                	mv	a1,s2
    8800:	8562                	mv	a0,s8
    8802:	00000097          	auipc	ra,0x0
    8806:	dd8080e7          	jalr	-552(ra) # 85da <runtests>
    880a:	d95d                	beqz	a0,87c0 <drivetests+0x5a>
        if(continuous != 2) {
    880c:	03599d63          	bne	s3,s5,8846 <drivetests+0xe0>
    if((free1 = countfree()) < free0) {
    8810:	00000097          	auipc	ra,0x0
    8814:	e26080e7          	jalr	-474(ra) # 8636 <countfree>
    8818:	fa955ae3          	bge	a0,s1,87cc <drivetests+0x66>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    881c:	8626                	mv	a2,s1
    881e:	85aa                	mv	a1,a0
    8820:	8566                	mv	a0,s9
    8822:	00000097          	auipc	ra,0x0
    8826:	7a4080e7          	jalr	1956(ra) # 8fc6 <printf>
      if(continuous != 2) {
    882a:	b75d                	j	87d0 <drivetests+0x6a>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    882c:	8626                	mv	a2,s1
    882e:	85aa                	mv	a1,a0
    8830:	8566                	mv	a0,s9
    8832:	00000097          	auipc	ra,0x0
    8836:	794080e7          	jalr	1940(ra) # 8fc6 <printf>
      if(continuous != 2) {
    883a:	f9598be3          	beq	s3,s5,87d0 <drivetests+0x6a>
        return 1;
    883e:	4505                	li	a0,1
    8840:	a031                	j	884c <drivetests+0xe6>
        return 1;
    8842:	4505                	li	a0,1
    8844:	a021                	j	884c <drivetests+0xe6>
          return 1;
    8846:	4505                	li	a0,1
    8848:	a011                	j	884c <drivetests+0xe6>
  return 0;
    884a:	854e                	mv	a0,s3
}
    884c:	60e6                	ld	ra,88(sp)
    884e:	6446                	ld	s0,80(sp)
    8850:	64a6                	ld	s1,72(sp)
    8852:	6906                	ld	s2,64(sp)
    8854:	79e2                	ld	s3,56(sp)
    8856:	7a42                	ld	s4,48(sp)
    8858:	7aa2                	ld	s5,40(sp)
    885a:	7b02                	ld	s6,32(sp)
    885c:	6be2                	ld	s7,24(sp)
    885e:	6c42                	ld	s8,16(sp)
    8860:	6ca2                	ld	s9,8(sp)
    8862:	6d02                	ld	s10,0(sp)
    8864:	6125                	addi	sp,sp,96
    8866:	8082                	ret

0000000000008868 <main>:

int
main(int argc, char *argv[])
{
    8868:	1101                	addi	sp,sp,-32
    886a:	ec06                	sd	ra,24(sp)
    886c:	e822                	sd	s0,16(sp)
    886e:	e426                	sd	s1,8(sp)
    8870:	e04a                	sd	s2,0(sp)
    8872:	1000                	addi	s0,sp,32
    8874:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    8876:	4789                	li	a5,2
    8878:	02f50363          	beq	a0,a5,889e <main+0x36>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    887c:	4785                	li	a5,1
    887e:	06a7cd63          	blt	a5,a0,88f8 <main+0x90>
  char *justone = 0;
    8882:	4601                	li	a2,0
  int quick = 0;
    8884:	4501                	li	a0,0
  int continuous = 0;
    8886:	4481                	li	s1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    8888:	85a6                	mv	a1,s1
    888a:	00000097          	auipc	ra,0x0
    888e:	edc080e7          	jalr	-292(ra) # 8766 <drivetests>
    8892:	c949                	beqz	a0,8924 <main+0xbc>
    exit(1);
    8894:	4505                	li	a0,1
    8896:	00000097          	auipc	ra,0x0
    889a:	388080e7          	jalr	904(ra) # 8c1e <exit>
    889e:	892e                	mv	s2,a1
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    88a0:	00003597          	auipc	a1,0x3
    88a4:	98858593          	addi	a1,a1,-1656 # b228 <malloc+0x21a4>
    88a8:	00893503          	ld	a0,8(s2)
    88ac:	00000097          	auipc	ra,0x0
    88b0:	0c8080e7          	jalr	200(ra) # 8974 <strcmp>
    88b4:	cd39                	beqz	a0,8912 <main+0xaa>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    88b6:	00003597          	auipc	a1,0x3
    88ba:	9ca58593          	addi	a1,a1,-1590 # b280 <malloc+0x21fc>
    88be:	00893503          	ld	a0,8(s2)
    88c2:	00000097          	auipc	ra,0x0
    88c6:	0b2080e7          	jalr	178(ra) # 8974 <strcmp>
    88ca:	c931                	beqz	a0,891e <main+0xb6>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    88cc:	00003597          	auipc	a1,0x3
    88d0:	9ac58593          	addi	a1,a1,-1620 # b278 <malloc+0x21f4>
    88d4:	00893503          	ld	a0,8(s2)
    88d8:	00000097          	auipc	ra,0x0
    88dc:	09c080e7          	jalr	156(ra) # 8974 <strcmp>
    88e0:	cd0d                	beqz	a0,891a <main+0xb2>
  } else if(argc == 2 && argv[1][0] != '-'){
    88e2:	00893603          	ld	a2,8(s2)
    88e6:	00064703          	lbu	a4,0(a2) # 3000 <copyinstr1>
    88ea:	02d00793          	li	a5,45
    88ee:	00f70563          	beq	a4,a5,88f8 <main+0x90>
  int quick = 0;
    88f2:	4501                	li	a0,0
  int continuous = 0;
    88f4:	4481                	li	s1,0
    88f6:	bf49                	j	8888 <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    88f8:	00003517          	auipc	a0,0x3
    88fc:	93850513          	addi	a0,a0,-1736 # b230 <malloc+0x21ac>
    8900:	00000097          	auipc	ra,0x0
    8904:	6c6080e7          	jalr	1734(ra) # 8fc6 <printf>
    exit(1);
    8908:	4505                	li	a0,1
    890a:	00000097          	auipc	ra,0x0
    890e:	314080e7          	jalr	788(ra) # 8c1e <exit>
  int continuous = 0;
    8912:	84aa                	mv	s1,a0
  char *justone = 0;
    8914:	4601                	li	a2,0
    quick = 1;
    8916:	4505                	li	a0,1
    8918:	bf85                	j	8888 <main+0x20>
  char *justone = 0;
    891a:	4601                	li	a2,0
    891c:	b7b5                	j	8888 <main+0x20>
    891e:	4601                	li	a2,0
    continuous = 1;
    8920:	4485                	li	s1,1
    8922:	b79d                	j	8888 <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    8924:	00003517          	auipc	a0,0x3
    8928:	93c50513          	addi	a0,a0,-1732 # b260 <malloc+0x21dc>
    892c:	00000097          	auipc	ra,0x0
    8930:	69a080e7          	jalr	1690(ra) # 8fc6 <printf>
  exit(0);
    8934:	4501                	li	a0,0
    8936:	00000097          	auipc	ra,0x0
    893a:	2e8080e7          	jalr	744(ra) # 8c1e <exit>

000000000000893e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    893e:	1141                	addi	sp,sp,-16
    8940:	e406                	sd	ra,8(sp)
    8942:	e022                	sd	s0,0(sp)
    8944:	0800                	addi	s0,sp,16
  extern int main();
  main();
    8946:	00000097          	auipc	ra,0x0
    894a:	f22080e7          	jalr	-222(ra) # 8868 <main>
  exit(0);
    894e:	4501                	li	a0,0
    8950:	00000097          	auipc	ra,0x0
    8954:	2ce080e7          	jalr	718(ra) # 8c1e <exit>

0000000000008958 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    8958:	1141                	addi	sp,sp,-16
    895a:	e422                	sd	s0,8(sp)
    895c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    895e:	87aa                	mv	a5,a0
    8960:	0585                	addi	a1,a1,1
    8962:	0785                	addi	a5,a5,1
    8964:	fff5c703          	lbu	a4,-1(a1)
    8968:	fee78fa3          	sb	a4,-1(a5) # fff <copyinstr1-0x2001>
    896c:	fb75                	bnez	a4,8960 <strcpy+0x8>
    ;
  return os;
}
    896e:	6422                	ld	s0,8(sp)
    8970:	0141                	addi	sp,sp,16
    8972:	8082                	ret

0000000000008974 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    8974:	1141                	addi	sp,sp,-16
    8976:	e422                	sd	s0,8(sp)
    8978:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    897a:	00054783          	lbu	a5,0(a0)
    897e:	cb91                	beqz	a5,8992 <strcmp+0x1e>
    8980:	0005c703          	lbu	a4,0(a1)
    8984:	00f71763          	bne	a4,a5,8992 <strcmp+0x1e>
    p++, q++;
    8988:	0505                	addi	a0,a0,1
    898a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    898c:	00054783          	lbu	a5,0(a0)
    8990:	fbe5                	bnez	a5,8980 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    8992:	0005c503          	lbu	a0,0(a1)
}
    8996:	40a7853b          	subw	a0,a5,a0
    899a:	6422                	ld	s0,8(sp)
    899c:	0141                	addi	sp,sp,16
    899e:	8082                	ret

00000000000089a0 <strlen>:

uint
strlen(const char *s)
{
    89a0:	1141                	addi	sp,sp,-16
    89a2:	e422                	sd	s0,8(sp)
    89a4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    89a6:	00054783          	lbu	a5,0(a0)
    89aa:	cf91                	beqz	a5,89c6 <strlen+0x26>
    89ac:	0505                	addi	a0,a0,1
    89ae:	87aa                	mv	a5,a0
    89b0:	4685                	li	a3,1
    89b2:	9e89                	subw	a3,a3,a0
    89b4:	00f6853b          	addw	a0,a3,a5
    89b8:	0785                	addi	a5,a5,1
    89ba:	fff7c703          	lbu	a4,-1(a5)
    89be:	fb7d                	bnez	a4,89b4 <strlen+0x14>
    ;
  return n;
}
    89c0:	6422                	ld	s0,8(sp)
    89c2:	0141                	addi	sp,sp,16
    89c4:	8082                	ret
  for(n = 0; s[n]; n++)
    89c6:	4501                	li	a0,0
    89c8:	bfe5                	j	89c0 <strlen+0x20>

00000000000089ca <memset>:

void*
memset(void *dst, int c, uint n)
{
    89ca:	1141                	addi	sp,sp,-16
    89cc:	e422                	sd	s0,8(sp)
    89ce:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    89d0:	ca19                	beqz	a2,89e6 <memset+0x1c>
    89d2:	87aa                	mv	a5,a0
    89d4:	1602                	slli	a2,a2,0x20
    89d6:	9201                	srli	a2,a2,0x20
    89d8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    89dc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    89e0:	0785                	addi	a5,a5,1
    89e2:	fee79de3          	bne	a5,a4,89dc <memset+0x12>
  }
  return dst;
}
    89e6:	6422                	ld	s0,8(sp)
    89e8:	0141                	addi	sp,sp,16
    89ea:	8082                	ret

00000000000089ec <strchr>:

char*
strchr(const char *s, char c)
{
    89ec:	1141                	addi	sp,sp,-16
    89ee:	e422                	sd	s0,8(sp)
    89f0:	0800                	addi	s0,sp,16
  for(; *s; s++)
    89f2:	00054783          	lbu	a5,0(a0)
    89f6:	cb99                	beqz	a5,8a0c <strchr+0x20>
    if(*s == c)
    89f8:	00f58763          	beq	a1,a5,8a06 <strchr+0x1a>
  for(; *s; s++)
    89fc:	0505                	addi	a0,a0,1
    89fe:	00054783          	lbu	a5,0(a0)
    8a02:	fbfd                	bnez	a5,89f8 <strchr+0xc>
      return (char*)s;
  return 0;
    8a04:	4501                	li	a0,0
}
    8a06:	6422                	ld	s0,8(sp)
    8a08:	0141                	addi	sp,sp,16
    8a0a:	8082                	ret
  return 0;
    8a0c:	4501                	li	a0,0
    8a0e:	bfe5                	j	8a06 <strchr+0x1a>

0000000000008a10 <gets>:

char*
gets(char *buf, int max)
{
    8a10:	711d                	addi	sp,sp,-96
    8a12:	ec86                	sd	ra,88(sp)
    8a14:	e8a2                	sd	s0,80(sp)
    8a16:	e4a6                	sd	s1,72(sp)
    8a18:	e0ca                	sd	s2,64(sp)
    8a1a:	fc4e                	sd	s3,56(sp)
    8a1c:	f852                	sd	s4,48(sp)
    8a1e:	f456                	sd	s5,40(sp)
    8a20:	f05a                	sd	s6,32(sp)
    8a22:	ec5e                	sd	s7,24(sp)
    8a24:	1080                	addi	s0,sp,96
    8a26:	8baa                	mv	s7,a0
    8a28:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    8a2a:	892a                	mv	s2,a0
    8a2c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    8a2e:	4aa9                	li	s5,10
    8a30:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    8a32:	89a6                	mv	s3,s1
    8a34:	2485                	addiw	s1,s1,1
    8a36:	0344d863          	bge	s1,s4,8a66 <gets+0x56>
    cc = read(0, &c, 1);
    8a3a:	4605                	li	a2,1
    8a3c:	faf40593          	addi	a1,s0,-81
    8a40:	4501                	li	a0,0
    8a42:	00000097          	auipc	ra,0x0
    8a46:	1fc080e7          	jalr	508(ra) # 8c3e <read>
    if(cc < 1)
    8a4a:	00a05e63          	blez	a0,8a66 <gets+0x56>
    buf[i++] = c;
    8a4e:	faf44783          	lbu	a5,-81(s0)
    8a52:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    8a56:	01578763          	beq	a5,s5,8a64 <gets+0x54>
    8a5a:	0905                	addi	s2,s2,1
    8a5c:	fd679be3          	bne	a5,s6,8a32 <gets+0x22>
  for(i=0; i+1 < max; ){
    8a60:	89a6                	mv	s3,s1
    8a62:	a011                	j	8a66 <gets+0x56>
    8a64:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    8a66:	99de                	add	s3,s3,s7
    8a68:	00098023          	sb	zero,0(s3)
  return buf;
}
    8a6c:	855e                	mv	a0,s7
    8a6e:	60e6                	ld	ra,88(sp)
    8a70:	6446                	ld	s0,80(sp)
    8a72:	64a6                	ld	s1,72(sp)
    8a74:	6906                	ld	s2,64(sp)
    8a76:	79e2                	ld	s3,56(sp)
    8a78:	7a42                	ld	s4,48(sp)
    8a7a:	7aa2                	ld	s5,40(sp)
    8a7c:	7b02                	ld	s6,32(sp)
    8a7e:	6be2                	ld	s7,24(sp)
    8a80:	6125                	addi	sp,sp,96
    8a82:	8082                	ret

0000000000008a84 <stat>:

int
stat(const char *n, struct stat *st)
{
    8a84:	1101                	addi	sp,sp,-32
    8a86:	ec06                	sd	ra,24(sp)
    8a88:	e822                	sd	s0,16(sp)
    8a8a:	e426                	sd	s1,8(sp)
    8a8c:	e04a                	sd	s2,0(sp)
    8a8e:	1000                	addi	s0,sp,32
    8a90:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    8a92:	4581                	li	a1,0
    8a94:	00000097          	auipc	ra,0x0
    8a98:	1d2080e7          	jalr	466(ra) # 8c66 <open>
  if(fd < 0)
    8a9c:	02054563          	bltz	a0,8ac6 <stat+0x42>
    8aa0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    8aa2:	85ca                	mv	a1,s2
    8aa4:	00000097          	auipc	ra,0x0
    8aa8:	1da080e7          	jalr	474(ra) # 8c7e <fstat>
    8aac:	892a                	mv	s2,a0
  close(fd);
    8aae:	8526                	mv	a0,s1
    8ab0:	00000097          	auipc	ra,0x0
    8ab4:	19e080e7          	jalr	414(ra) # 8c4e <close>
  return r;
}
    8ab8:	854a                	mv	a0,s2
    8aba:	60e2                	ld	ra,24(sp)
    8abc:	6442                	ld	s0,16(sp)
    8abe:	64a2                	ld	s1,8(sp)
    8ac0:	6902                	ld	s2,0(sp)
    8ac2:	6105                	addi	sp,sp,32
    8ac4:	8082                	ret
    return -1;
    8ac6:	597d                	li	s2,-1
    8ac8:	bfc5                	j	8ab8 <stat+0x34>

0000000000008aca <atoi>:

int
atoi(const char *s)
{
    8aca:	1141                	addi	sp,sp,-16
    8acc:	e422                	sd	s0,8(sp)
    8ace:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    8ad0:	00054603          	lbu	a2,0(a0)
    8ad4:	fd06079b          	addiw	a5,a2,-48
    8ad8:	0ff7f793          	andi	a5,a5,255
    8adc:	4725                	li	a4,9
    8ade:	02f76963          	bltu	a4,a5,8b10 <atoi+0x46>
    8ae2:	86aa                	mv	a3,a0
  n = 0;
    8ae4:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    8ae6:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    8ae8:	0685                	addi	a3,a3,1
    8aea:	0025179b          	slliw	a5,a0,0x2
    8aee:	9fa9                	addw	a5,a5,a0
    8af0:	0017979b          	slliw	a5,a5,0x1
    8af4:	9fb1                	addw	a5,a5,a2
    8af6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    8afa:	0006c603          	lbu	a2,0(a3)
    8afe:	fd06071b          	addiw	a4,a2,-48
    8b02:	0ff77713          	andi	a4,a4,255
    8b06:	fee5f1e3          	bgeu	a1,a4,8ae8 <atoi+0x1e>
  return n;
}
    8b0a:	6422                	ld	s0,8(sp)
    8b0c:	0141                	addi	sp,sp,16
    8b0e:	8082                	ret
  n = 0;
    8b10:	4501                	li	a0,0
    8b12:	bfe5                	j	8b0a <atoi+0x40>

0000000000008b14 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    8b14:	1141                	addi	sp,sp,-16
    8b16:	e422                	sd	s0,8(sp)
    8b18:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    8b1a:	02b57463          	bgeu	a0,a1,8b42 <memmove+0x2e>
    while(n-- > 0)
    8b1e:	00c05f63          	blez	a2,8b3c <memmove+0x28>
    8b22:	1602                	slli	a2,a2,0x20
    8b24:	9201                	srli	a2,a2,0x20
    8b26:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    8b2a:	872a                	mv	a4,a0
      *dst++ = *src++;
    8b2c:	0585                	addi	a1,a1,1
    8b2e:	0705                	addi	a4,a4,1
    8b30:	fff5c683          	lbu	a3,-1(a1)
    8b34:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    8b38:	fee79ae3          	bne	a5,a4,8b2c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    8b3c:	6422                	ld	s0,8(sp)
    8b3e:	0141                	addi	sp,sp,16
    8b40:	8082                	ret
    dst += n;
    8b42:	00c50733          	add	a4,a0,a2
    src += n;
    8b46:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    8b48:	fec05ae3          	blez	a2,8b3c <memmove+0x28>
    8b4c:	fff6079b          	addiw	a5,a2,-1
    8b50:	1782                	slli	a5,a5,0x20
    8b52:	9381                	srli	a5,a5,0x20
    8b54:	fff7c793          	not	a5,a5
    8b58:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    8b5a:	15fd                	addi	a1,a1,-1
    8b5c:	177d                	addi	a4,a4,-1
    8b5e:	0005c683          	lbu	a3,0(a1)
    8b62:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    8b66:	fee79ae3          	bne	a5,a4,8b5a <memmove+0x46>
    8b6a:	bfc9                	j	8b3c <memmove+0x28>

0000000000008b6c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    8b6c:	1141                	addi	sp,sp,-16
    8b6e:	e422                	sd	s0,8(sp)
    8b70:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    8b72:	ca05                	beqz	a2,8ba2 <memcmp+0x36>
    8b74:	fff6069b          	addiw	a3,a2,-1
    8b78:	1682                	slli	a3,a3,0x20
    8b7a:	9281                	srli	a3,a3,0x20
    8b7c:	0685                	addi	a3,a3,1
    8b7e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    8b80:	00054783          	lbu	a5,0(a0)
    8b84:	0005c703          	lbu	a4,0(a1)
    8b88:	00e79863          	bne	a5,a4,8b98 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    8b8c:	0505                	addi	a0,a0,1
    p2++;
    8b8e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    8b90:	fed518e3          	bne	a0,a3,8b80 <memcmp+0x14>
  }
  return 0;
    8b94:	4501                	li	a0,0
    8b96:	a019                	j	8b9c <memcmp+0x30>
      return *p1 - *p2;
    8b98:	40e7853b          	subw	a0,a5,a4
}
    8b9c:	6422                	ld	s0,8(sp)
    8b9e:	0141                	addi	sp,sp,16
    8ba0:	8082                	ret
  return 0;
    8ba2:	4501                	li	a0,0
    8ba4:	bfe5                	j	8b9c <memcmp+0x30>

0000000000008ba6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    8ba6:	1141                	addi	sp,sp,-16
    8ba8:	e406                	sd	ra,8(sp)
    8baa:	e022                	sd	s0,0(sp)
    8bac:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    8bae:	00000097          	auipc	ra,0x0
    8bb2:	f66080e7          	jalr	-154(ra) # 8b14 <memmove>
}
    8bb6:	60a2                	ld	ra,8(sp)
    8bb8:	6402                	ld	s0,0(sp)
    8bba:	0141                	addi	sp,sp,16
    8bbc:	8082                	ret

0000000000008bbe <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    8bbe:	1141                	addi	sp,sp,-16
    8bc0:	e422                	sd	s0,8(sp)
    8bc2:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    8bc4:	00052023          	sw	zero,0(a0)
}  
    8bc8:	6422                	ld	s0,8(sp)
    8bca:	0141                	addi	sp,sp,16
    8bcc:	8082                	ret

0000000000008bce <lock>:

void lock(struct spinlock * lk) 
{    
    8bce:	1141                	addi	sp,sp,-16
    8bd0:	e422                	sd	s0,8(sp)
    8bd2:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    8bd4:	4705                	li	a4,1
    8bd6:	87ba                	mv	a5,a4
    8bd8:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    8bdc:	2781                	sext.w	a5,a5
    8bde:	ffe5                	bnez	a5,8bd6 <lock+0x8>
}  
    8be0:	6422                	ld	s0,8(sp)
    8be2:	0141                	addi	sp,sp,16
    8be4:	8082                	ret

0000000000008be6 <unlock>:

void unlock(struct spinlock * lk) 
{   
    8be6:	1141                	addi	sp,sp,-16
    8be8:	e422                	sd	s0,8(sp)
    8bea:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    8bec:	0f50000f          	fence	iorw,ow
    8bf0:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    8bf4:	6422                	ld	s0,8(sp)
    8bf6:	0141                	addi	sp,sp,16
    8bf8:	8082                	ret

0000000000008bfa <isDigit>:

unsigned int isDigit(char *c) {
    8bfa:	1141                	addi	sp,sp,-16
    8bfc:	e422                	sd	s0,8(sp)
    8bfe:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    8c00:	00054503          	lbu	a0,0(a0)
    8c04:	fd05051b          	addiw	a0,a0,-48
    8c08:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    8c0c:	00a53513          	sltiu	a0,a0,10
    8c10:	6422                	ld	s0,8(sp)
    8c12:	0141                	addi	sp,sp,16
    8c14:	8082                	ret

0000000000008c16 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    8c16:	4885                	li	a7,1
 ecall
    8c18:	00000073          	ecall
 ret
    8c1c:	8082                	ret

0000000000008c1e <exit>:
.global exit
exit:
 li a7, SYS_exit
    8c1e:	4889                	li	a7,2
 ecall
    8c20:	00000073          	ecall
 ret
    8c24:	8082                	ret

0000000000008c26 <wait>:
.global wait
wait:
 li a7, SYS_wait
    8c26:	488d                	li	a7,3
 ecall
    8c28:	00000073          	ecall
 ret
    8c2c:	8082                	ret

0000000000008c2e <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    8c2e:	48e1                	li	a7,24
 ecall
    8c30:	00000073          	ecall
 ret
    8c34:	8082                	ret

0000000000008c36 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    8c36:	4891                	li	a7,4
 ecall
    8c38:	00000073          	ecall
 ret
    8c3c:	8082                	ret

0000000000008c3e <read>:
.global read
read:
 li a7, SYS_read
    8c3e:	4895                	li	a7,5
 ecall
    8c40:	00000073          	ecall
 ret
    8c44:	8082                	ret

0000000000008c46 <write>:
.global write
write:
 li a7, SYS_write
    8c46:	48c1                	li	a7,16
 ecall
    8c48:	00000073          	ecall
 ret
    8c4c:	8082                	ret

0000000000008c4e <close>:
.global close
close:
 li a7, SYS_close
    8c4e:	48d5                	li	a7,21
 ecall
    8c50:	00000073          	ecall
 ret
    8c54:	8082                	ret

0000000000008c56 <kill>:
.global kill
kill:
 li a7, SYS_kill
    8c56:	4899                	li	a7,6
 ecall
    8c58:	00000073          	ecall
 ret
    8c5c:	8082                	ret

0000000000008c5e <exec>:
.global exec
exec:
 li a7, SYS_exec
    8c5e:	489d                	li	a7,7
 ecall
    8c60:	00000073          	ecall
 ret
    8c64:	8082                	ret

0000000000008c66 <open>:
.global open
open:
 li a7, SYS_open
    8c66:	48bd                	li	a7,15
 ecall
    8c68:	00000073          	ecall
 ret
    8c6c:	8082                	ret

0000000000008c6e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    8c6e:	48c5                	li	a7,17
 ecall
    8c70:	00000073          	ecall
 ret
    8c74:	8082                	ret

0000000000008c76 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    8c76:	48c9                	li	a7,18
 ecall
    8c78:	00000073          	ecall
 ret
    8c7c:	8082                	ret

0000000000008c7e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    8c7e:	48a1                	li	a7,8
 ecall
    8c80:	00000073          	ecall
 ret
    8c84:	8082                	ret

0000000000008c86 <link>:
.global link
link:
 li a7, SYS_link
    8c86:	48cd                	li	a7,19
 ecall
    8c88:	00000073          	ecall
 ret
    8c8c:	8082                	ret

0000000000008c8e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    8c8e:	48d1                	li	a7,20
 ecall
    8c90:	00000073          	ecall
 ret
    8c94:	8082                	ret

0000000000008c96 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    8c96:	48a5                	li	a7,9
 ecall
    8c98:	00000073          	ecall
 ret
    8c9c:	8082                	ret

0000000000008c9e <dup>:
.global dup
dup:
 li a7, SYS_dup
    8c9e:	48a9                	li	a7,10
 ecall
    8ca0:	00000073          	ecall
 ret
    8ca4:	8082                	ret

0000000000008ca6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    8ca6:	48ad                	li	a7,11
 ecall
    8ca8:	00000073          	ecall
 ret
    8cac:	8082                	ret

0000000000008cae <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    8cae:	48b1                	li	a7,12
 ecall
    8cb0:	00000073          	ecall
 ret
    8cb4:	8082                	ret

0000000000008cb6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    8cb6:	48b5                	li	a7,13
 ecall
    8cb8:	00000073          	ecall
 ret
    8cbc:	8082                	ret

0000000000008cbe <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    8cbe:	48b9                	li	a7,14
 ecall
    8cc0:	00000073          	ecall
 ret
    8cc4:	8082                	ret

0000000000008cc6 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    8cc6:	48d9                	li	a7,22
 ecall
    8cc8:	00000073          	ecall
 ret
    8ccc:	8082                	ret

0000000000008cce <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    8cce:	48dd                	li	a7,23
 ecall
    8cd0:	00000073          	ecall
 ret
    8cd4:	8082                	ret

0000000000008cd6 <ps>:
.global ps
ps:
 li a7, SYS_ps
    8cd6:	48e5                	li	a7,25
 ecall
    8cd8:	00000073          	ecall
 ret
    8cdc:	8082                	ret

0000000000008cde <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    8cde:	48e9                	li	a7,26
 ecall
    8ce0:	00000073          	ecall
 ret
    8ce4:	8082                	ret

0000000000008ce6 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    8ce6:	48ed                	li	a7,27
 ecall
    8ce8:	00000073          	ecall
 ret
    8cec:	8082                	ret

0000000000008cee <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    8cee:	1101                	addi	sp,sp,-32
    8cf0:	ec06                	sd	ra,24(sp)
    8cf2:	e822                	sd	s0,16(sp)
    8cf4:	1000                	addi	s0,sp,32
    8cf6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    8cfa:	4605                	li	a2,1
    8cfc:	fef40593          	addi	a1,s0,-17
    8d00:	00000097          	auipc	ra,0x0
    8d04:	f46080e7          	jalr	-186(ra) # 8c46 <write>
}
    8d08:	60e2                	ld	ra,24(sp)
    8d0a:	6442                	ld	s0,16(sp)
    8d0c:	6105                	addi	sp,sp,32
    8d0e:	8082                	ret

0000000000008d10 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    8d10:	7139                	addi	sp,sp,-64
    8d12:	fc06                	sd	ra,56(sp)
    8d14:	f822                	sd	s0,48(sp)
    8d16:	f426                	sd	s1,40(sp)
    8d18:	f04a                	sd	s2,32(sp)
    8d1a:	ec4e                	sd	s3,24(sp)
    8d1c:	0080                	addi	s0,sp,64
    8d1e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    8d20:	c299                	beqz	a3,8d26 <printint+0x16>
    8d22:	0805c863          	bltz	a1,8db2 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    8d26:	2581                	sext.w	a1,a1
  neg = 0;
    8d28:	4881                	li	a7,0
    8d2a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    8d2e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    8d30:	2601                	sext.w	a2,a2
    8d32:	00003517          	auipc	a0,0x3
    8d36:	8be50513          	addi	a0,a0,-1858 # b5f0 <digits>
    8d3a:	883a                	mv	a6,a4
    8d3c:	2705                	addiw	a4,a4,1
    8d3e:	02c5f7bb          	remuw	a5,a1,a2
    8d42:	1782                	slli	a5,a5,0x20
    8d44:	9381                	srli	a5,a5,0x20
    8d46:	97aa                	add	a5,a5,a0
    8d48:	0007c783          	lbu	a5,0(a5)
    8d4c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    8d50:	0005879b          	sext.w	a5,a1
    8d54:	02c5d5bb          	divuw	a1,a1,a2
    8d58:	0685                	addi	a3,a3,1
    8d5a:	fec7f0e3          	bgeu	a5,a2,8d3a <printint+0x2a>
  if(neg)
    8d5e:	00088b63          	beqz	a7,8d74 <printint+0x64>
    buf[i++] = '-';
    8d62:	fd040793          	addi	a5,s0,-48
    8d66:	973e                	add	a4,a4,a5
    8d68:	02d00793          	li	a5,45
    8d6c:	fef70823          	sb	a5,-16(a4)
    8d70:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    8d74:	02e05863          	blez	a4,8da4 <printint+0x94>
    8d78:	fc040793          	addi	a5,s0,-64
    8d7c:	00e78933          	add	s2,a5,a4
    8d80:	fff78993          	addi	s3,a5,-1
    8d84:	99ba                	add	s3,s3,a4
    8d86:	377d                	addiw	a4,a4,-1
    8d88:	1702                	slli	a4,a4,0x20
    8d8a:	9301                	srli	a4,a4,0x20
    8d8c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    8d90:	fff94583          	lbu	a1,-1(s2)
    8d94:	8526                	mv	a0,s1
    8d96:	00000097          	auipc	ra,0x0
    8d9a:	f58080e7          	jalr	-168(ra) # 8cee <putc>
  while(--i >= 0)
    8d9e:	197d                	addi	s2,s2,-1
    8da0:	ff3918e3          	bne	s2,s3,8d90 <printint+0x80>
}
    8da4:	70e2                	ld	ra,56(sp)
    8da6:	7442                	ld	s0,48(sp)
    8da8:	74a2                	ld	s1,40(sp)
    8daa:	7902                	ld	s2,32(sp)
    8dac:	69e2                	ld	s3,24(sp)
    8dae:	6121                	addi	sp,sp,64
    8db0:	8082                	ret
    x = -xx;
    8db2:	40b005bb          	negw	a1,a1
    neg = 1;
    8db6:	4885                	li	a7,1
    x = -xx;
    8db8:	bf8d                	j	8d2a <printint+0x1a>

0000000000008dba <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    8dba:	7119                	addi	sp,sp,-128
    8dbc:	fc86                	sd	ra,120(sp)
    8dbe:	f8a2                	sd	s0,112(sp)
    8dc0:	f4a6                	sd	s1,104(sp)
    8dc2:	f0ca                	sd	s2,96(sp)
    8dc4:	ecce                	sd	s3,88(sp)
    8dc6:	e8d2                	sd	s4,80(sp)
    8dc8:	e4d6                	sd	s5,72(sp)
    8dca:	e0da                	sd	s6,64(sp)
    8dcc:	fc5e                	sd	s7,56(sp)
    8dce:	f862                	sd	s8,48(sp)
    8dd0:	f466                	sd	s9,40(sp)
    8dd2:	f06a                	sd	s10,32(sp)
    8dd4:	ec6e                	sd	s11,24(sp)
    8dd6:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    8dd8:	0005c903          	lbu	s2,0(a1)
    8ddc:	18090f63          	beqz	s2,8f7a <vprintf+0x1c0>
    8de0:	8aaa                	mv	s5,a0
    8de2:	8b32                	mv	s6,a2
    8de4:	00158493          	addi	s1,a1,1
  state = 0;
    8de8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    8dea:	02500a13          	li	s4,37
      if(c == 'd'){
    8dee:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    8df2:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    8df6:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    8dfa:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    8dfe:	00002b97          	auipc	s7,0x2
    8e02:	7f2b8b93          	addi	s7,s7,2034 # b5f0 <digits>
    8e06:	a839                	j	8e24 <vprintf+0x6a>
        putc(fd, c);
    8e08:	85ca                	mv	a1,s2
    8e0a:	8556                	mv	a0,s5
    8e0c:	00000097          	auipc	ra,0x0
    8e10:	ee2080e7          	jalr	-286(ra) # 8cee <putc>
    8e14:	a019                	j	8e1a <vprintf+0x60>
    } else if(state == '%'){
    8e16:	01498f63          	beq	s3,s4,8e34 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    8e1a:	0485                	addi	s1,s1,1
    8e1c:	fff4c903          	lbu	s2,-1(s1)
    8e20:	14090d63          	beqz	s2,8f7a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    8e24:	0009079b          	sext.w	a5,s2
    if(state == 0){
    8e28:	fe0997e3          	bnez	s3,8e16 <vprintf+0x5c>
      if(c == '%'){
    8e2c:	fd479ee3          	bne	a5,s4,8e08 <vprintf+0x4e>
        state = '%';
    8e30:	89be                	mv	s3,a5
    8e32:	b7e5                	j	8e1a <vprintf+0x60>
      if(c == 'd'){
    8e34:	05878063          	beq	a5,s8,8e74 <vprintf+0xba>
      } else if(c == 'l') {
    8e38:	05978c63          	beq	a5,s9,8e90 <vprintf+0xd6>
      } else if(c == 'x') {
    8e3c:	07a78863          	beq	a5,s10,8eac <vprintf+0xf2>
      } else if(c == 'p') {
    8e40:	09b78463          	beq	a5,s11,8ec8 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    8e44:	07300713          	li	a4,115
    8e48:	0ce78663          	beq	a5,a4,8f14 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    8e4c:	06300713          	li	a4,99
    8e50:	0ee78e63          	beq	a5,a4,8f4c <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    8e54:	11478863          	beq	a5,s4,8f64 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    8e58:	85d2                	mv	a1,s4
    8e5a:	8556                	mv	a0,s5
    8e5c:	00000097          	auipc	ra,0x0
    8e60:	e92080e7          	jalr	-366(ra) # 8cee <putc>
        putc(fd, c);
    8e64:	85ca                	mv	a1,s2
    8e66:	8556                	mv	a0,s5
    8e68:	00000097          	auipc	ra,0x0
    8e6c:	e86080e7          	jalr	-378(ra) # 8cee <putc>
      }
      state = 0;
    8e70:	4981                	li	s3,0
    8e72:	b765                	j	8e1a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    8e74:	008b0913          	addi	s2,s6,8
    8e78:	4685                	li	a3,1
    8e7a:	4629                	li	a2,10
    8e7c:	000b2583          	lw	a1,0(s6)
    8e80:	8556                	mv	a0,s5
    8e82:	00000097          	auipc	ra,0x0
    8e86:	e8e080e7          	jalr	-370(ra) # 8d10 <printint>
    8e8a:	8b4a                	mv	s6,s2
      state = 0;
    8e8c:	4981                	li	s3,0
    8e8e:	b771                	j	8e1a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    8e90:	008b0913          	addi	s2,s6,8
    8e94:	4681                	li	a3,0
    8e96:	4629                	li	a2,10
    8e98:	000b2583          	lw	a1,0(s6)
    8e9c:	8556                	mv	a0,s5
    8e9e:	00000097          	auipc	ra,0x0
    8ea2:	e72080e7          	jalr	-398(ra) # 8d10 <printint>
    8ea6:	8b4a                	mv	s6,s2
      state = 0;
    8ea8:	4981                	li	s3,0
    8eaa:	bf85                	j	8e1a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    8eac:	008b0913          	addi	s2,s6,8
    8eb0:	4681                	li	a3,0
    8eb2:	4641                	li	a2,16
    8eb4:	000b2583          	lw	a1,0(s6)
    8eb8:	8556                	mv	a0,s5
    8eba:	00000097          	auipc	ra,0x0
    8ebe:	e56080e7          	jalr	-426(ra) # 8d10 <printint>
    8ec2:	8b4a                	mv	s6,s2
      state = 0;
    8ec4:	4981                	li	s3,0
    8ec6:	bf91                	j	8e1a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    8ec8:	008b0793          	addi	a5,s6,8
    8ecc:	f8f43423          	sd	a5,-120(s0)
    8ed0:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    8ed4:	03000593          	li	a1,48
    8ed8:	8556                	mv	a0,s5
    8eda:	00000097          	auipc	ra,0x0
    8ede:	e14080e7          	jalr	-492(ra) # 8cee <putc>
  putc(fd, 'x');
    8ee2:	85ea                	mv	a1,s10
    8ee4:	8556                	mv	a0,s5
    8ee6:	00000097          	auipc	ra,0x0
    8eea:	e08080e7          	jalr	-504(ra) # 8cee <putc>
    8eee:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    8ef0:	03c9d793          	srli	a5,s3,0x3c
    8ef4:	97de                	add	a5,a5,s7
    8ef6:	0007c583          	lbu	a1,0(a5)
    8efa:	8556                	mv	a0,s5
    8efc:	00000097          	auipc	ra,0x0
    8f00:	df2080e7          	jalr	-526(ra) # 8cee <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    8f04:	0992                	slli	s3,s3,0x4
    8f06:	397d                	addiw	s2,s2,-1
    8f08:	fe0914e3          	bnez	s2,8ef0 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    8f0c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    8f10:	4981                	li	s3,0
    8f12:	b721                	j	8e1a <vprintf+0x60>
        s = va_arg(ap, char*);
    8f14:	008b0993          	addi	s3,s6,8
    8f18:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    8f1c:	02090163          	beqz	s2,8f3e <vprintf+0x184>
        while(*s != 0){
    8f20:	00094583          	lbu	a1,0(s2)
    8f24:	c9a1                	beqz	a1,8f74 <vprintf+0x1ba>
          putc(fd, *s);
    8f26:	8556                	mv	a0,s5
    8f28:	00000097          	auipc	ra,0x0
    8f2c:	dc6080e7          	jalr	-570(ra) # 8cee <putc>
          s++;
    8f30:	0905                	addi	s2,s2,1
        while(*s != 0){
    8f32:	00094583          	lbu	a1,0(s2)
    8f36:	f9e5                	bnez	a1,8f26 <vprintf+0x16c>
        s = va_arg(ap, char*);
    8f38:	8b4e                	mv	s6,s3
      state = 0;
    8f3a:	4981                	li	s3,0
    8f3c:	bdf9                	j	8e1a <vprintf+0x60>
          s = "(null)";
    8f3e:	00002917          	auipc	s2,0x2
    8f42:	6aa90913          	addi	s2,s2,1706 # b5e8 <malloc+0x2564>
        while(*s != 0){
    8f46:	02800593          	li	a1,40
    8f4a:	bff1                	j	8f26 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    8f4c:	008b0913          	addi	s2,s6,8
    8f50:	000b4583          	lbu	a1,0(s6)
    8f54:	8556                	mv	a0,s5
    8f56:	00000097          	auipc	ra,0x0
    8f5a:	d98080e7          	jalr	-616(ra) # 8cee <putc>
    8f5e:	8b4a                	mv	s6,s2
      state = 0;
    8f60:	4981                	li	s3,0
    8f62:	bd65                	j	8e1a <vprintf+0x60>
        putc(fd, c);
    8f64:	85d2                	mv	a1,s4
    8f66:	8556                	mv	a0,s5
    8f68:	00000097          	auipc	ra,0x0
    8f6c:	d86080e7          	jalr	-634(ra) # 8cee <putc>
      state = 0;
    8f70:	4981                	li	s3,0
    8f72:	b565                	j	8e1a <vprintf+0x60>
        s = va_arg(ap, char*);
    8f74:	8b4e                	mv	s6,s3
      state = 0;
    8f76:	4981                	li	s3,0
    8f78:	b54d                	j	8e1a <vprintf+0x60>
    }
  }
}
    8f7a:	70e6                	ld	ra,120(sp)
    8f7c:	7446                	ld	s0,112(sp)
    8f7e:	74a6                	ld	s1,104(sp)
    8f80:	7906                	ld	s2,96(sp)
    8f82:	69e6                	ld	s3,88(sp)
    8f84:	6a46                	ld	s4,80(sp)
    8f86:	6aa6                	ld	s5,72(sp)
    8f88:	6b06                	ld	s6,64(sp)
    8f8a:	7be2                	ld	s7,56(sp)
    8f8c:	7c42                	ld	s8,48(sp)
    8f8e:	7ca2                	ld	s9,40(sp)
    8f90:	7d02                	ld	s10,32(sp)
    8f92:	6de2                	ld	s11,24(sp)
    8f94:	6109                	addi	sp,sp,128
    8f96:	8082                	ret

0000000000008f98 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    8f98:	715d                	addi	sp,sp,-80
    8f9a:	ec06                	sd	ra,24(sp)
    8f9c:	e822                	sd	s0,16(sp)
    8f9e:	1000                	addi	s0,sp,32
    8fa0:	e010                	sd	a2,0(s0)
    8fa2:	e414                	sd	a3,8(s0)
    8fa4:	e818                	sd	a4,16(s0)
    8fa6:	ec1c                	sd	a5,24(s0)
    8fa8:	03043023          	sd	a6,32(s0)
    8fac:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    8fb0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    8fb4:	8622                	mv	a2,s0
    8fb6:	00000097          	auipc	ra,0x0
    8fba:	e04080e7          	jalr	-508(ra) # 8dba <vprintf>
}
    8fbe:	60e2                	ld	ra,24(sp)
    8fc0:	6442                	ld	s0,16(sp)
    8fc2:	6161                	addi	sp,sp,80
    8fc4:	8082                	ret

0000000000008fc6 <printf>:

void
printf(const char *fmt, ...)
{
    8fc6:	711d                	addi	sp,sp,-96
    8fc8:	ec06                	sd	ra,24(sp)
    8fca:	e822                	sd	s0,16(sp)
    8fcc:	1000                	addi	s0,sp,32
    8fce:	e40c                	sd	a1,8(s0)
    8fd0:	e810                	sd	a2,16(s0)
    8fd2:	ec14                	sd	a3,24(s0)
    8fd4:	f018                	sd	a4,32(s0)
    8fd6:	f41c                	sd	a5,40(s0)
    8fd8:	03043823          	sd	a6,48(s0)
    8fdc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    8fe0:	00840613          	addi	a2,s0,8
    8fe4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    8fe8:	85aa                	mv	a1,a0
    8fea:	4505                	li	a0,1
    8fec:	00000097          	auipc	ra,0x0
    8ff0:	dce080e7          	jalr	-562(ra) # 8dba <vprintf>
}
    8ff4:	60e2                	ld	ra,24(sp)
    8ff6:	6442                	ld	s0,16(sp)
    8ff8:	6125                	addi	sp,sp,96
    8ffa:	8082                	ret

0000000000008ffc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    8ffc:	1141                	addi	sp,sp,-16
    8ffe:	e422                	sd	s0,8(sp)
    9000:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    9002:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    9006:	00003797          	auipc	a5,0x3
    900a:	44a7b783          	ld	a5,1098(a5) # c450 <freep>
    900e:	a805                	j	903e <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    9010:	4618                	lw	a4,8(a2)
    9012:	9db9                	addw	a1,a1,a4
    9014:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    9018:	6398                	ld	a4,0(a5)
    901a:	6318                	ld	a4,0(a4)
    901c:	fee53823          	sd	a4,-16(a0)
    9020:	a091                	j	9064 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    9022:	ff852703          	lw	a4,-8(a0)
    9026:	9e39                	addw	a2,a2,a4
    9028:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    902a:	ff053703          	ld	a4,-16(a0)
    902e:	e398                	sd	a4,0(a5)
    9030:	a099                	j	9076 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    9032:	6398                	ld	a4,0(a5)
    9034:	00e7e463          	bltu	a5,a4,903c <free+0x40>
    9038:	00e6ea63          	bltu	a3,a4,904c <free+0x50>
{
    903c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    903e:	fed7fae3          	bgeu	a5,a3,9032 <free+0x36>
    9042:	6398                	ld	a4,0(a5)
    9044:	00e6e463          	bltu	a3,a4,904c <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    9048:	fee7eae3          	bltu	a5,a4,903c <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    904c:	ff852583          	lw	a1,-8(a0)
    9050:	6390                	ld	a2,0(a5)
    9052:	02059713          	slli	a4,a1,0x20
    9056:	9301                	srli	a4,a4,0x20
    9058:	0712                	slli	a4,a4,0x4
    905a:	9736                	add	a4,a4,a3
    905c:	fae60ae3          	beq	a2,a4,9010 <free+0x14>
    bp->s.ptr = p->s.ptr;
    9060:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    9064:	4790                	lw	a2,8(a5)
    9066:	02061713          	slli	a4,a2,0x20
    906a:	9301                	srli	a4,a4,0x20
    906c:	0712                	slli	a4,a4,0x4
    906e:	973e                	add	a4,a4,a5
    9070:	fae689e3          	beq	a3,a4,9022 <free+0x26>
  } else
    p->s.ptr = bp;
    9074:	e394                	sd	a3,0(a5)
  freep = p;
    9076:	00003717          	auipc	a4,0x3
    907a:	3cf73d23          	sd	a5,986(a4) # c450 <freep>
}
    907e:	6422                	ld	s0,8(sp)
    9080:	0141                	addi	sp,sp,16
    9082:	8082                	ret

0000000000009084 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    9084:	7139                	addi	sp,sp,-64
    9086:	fc06                	sd	ra,56(sp)
    9088:	f822                	sd	s0,48(sp)
    908a:	f426                	sd	s1,40(sp)
    908c:	f04a                	sd	s2,32(sp)
    908e:	ec4e                	sd	s3,24(sp)
    9090:	e852                	sd	s4,16(sp)
    9092:	e456                	sd	s5,8(sp)
    9094:	e05a                	sd	s6,0(sp)
    9096:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    9098:	02051493          	slli	s1,a0,0x20
    909c:	9081                	srli	s1,s1,0x20
    909e:	04bd                	addi	s1,s1,15
    90a0:	8091                	srli	s1,s1,0x4
    90a2:	0014899b          	addiw	s3,s1,1
    90a6:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    90a8:	00003517          	auipc	a0,0x3
    90ac:	3a853503          	ld	a0,936(a0) # c450 <freep>
    90b0:	c515                	beqz	a0,90dc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    90b2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    90b4:	4798                	lw	a4,8(a5)
    90b6:	02977f63          	bgeu	a4,s1,90f4 <malloc+0x70>
    90ba:	8a4e                	mv	s4,s3
    90bc:	0009871b          	sext.w	a4,s3
    90c0:	6685                	lui	a3,0x1
    90c2:	00d77363          	bgeu	a4,a3,90c8 <malloc+0x44>
    90c6:	6a05                	lui	s4,0x1
    90c8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    90cc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    90d0:	00003917          	auipc	s2,0x3
    90d4:	38090913          	addi	s2,s2,896 # c450 <freep>
  if(p == (char*)-1)
    90d8:	5afd                	li	s5,-1
    90da:	a88d                	j	914c <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    90dc:	0000a797          	auipc	a5,0xa
    90e0:	b9c78793          	addi	a5,a5,-1124 # 12c78 <base>
    90e4:	00003717          	auipc	a4,0x3
    90e8:	36f73623          	sd	a5,876(a4) # c450 <freep>
    90ec:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    90ee:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    90f2:	b7e1                	j	90ba <malloc+0x36>
      if(p->s.size == nunits)
    90f4:	02e48b63          	beq	s1,a4,912a <malloc+0xa6>
        p->s.size -= nunits;
    90f8:	4137073b          	subw	a4,a4,s3
    90fc:	c798                	sw	a4,8(a5)
        p += p->s.size;
    90fe:	1702                	slli	a4,a4,0x20
    9100:	9301                	srli	a4,a4,0x20
    9102:	0712                	slli	a4,a4,0x4
    9104:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    9106:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    910a:	00003717          	auipc	a4,0x3
    910e:	34a73323          	sd	a0,838(a4) # c450 <freep>
      return (void*)(p + 1);
    9112:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    9116:	70e2                	ld	ra,56(sp)
    9118:	7442                	ld	s0,48(sp)
    911a:	74a2                	ld	s1,40(sp)
    911c:	7902                	ld	s2,32(sp)
    911e:	69e2                	ld	s3,24(sp)
    9120:	6a42                	ld	s4,16(sp)
    9122:	6aa2                	ld	s5,8(sp)
    9124:	6b02                	ld	s6,0(sp)
    9126:	6121                	addi	sp,sp,64
    9128:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    912a:	6398                	ld	a4,0(a5)
    912c:	e118                	sd	a4,0(a0)
    912e:	bff1                	j	910a <malloc+0x86>
  hp->s.size = nu;
    9130:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    9134:	0541                	addi	a0,a0,16
    9136:	00000097          	auipc	ra,0x0
    913a:	ec6080e7          	jalr	-314(ra) # 8ffc <free>
  return freep;
    913e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    9142:	d971                	beqz	a0,9116 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    9144:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    9146:	4798                	lw	a4,8(a5)
    9148:	fa9776e3          	bgeu	a4,s1,90f4 <malloc+0x70>
    if(p == freep)
    914c:	00093703          	ld	a4,0(s2)
    9150:	853e                	mv	a0,a5
    9152:	fef719e3          	bne	a4,a5,9144 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    9156:	8552                	mv	a0,s4
    9158:	00000097          	auipc	ra,0x0
    915c:	b56080e7          	jalr	-1194(ra) # 8cae <sbrk>
  if(p == (char*)-1)
    9160:	fd5518e3          	bne	a0,s5,9130 <malloc+0xac>
        return 0;
    9164:	4501                	li	a0,0
    9166:	bf45                	j	9116 <malloc+0x92>
