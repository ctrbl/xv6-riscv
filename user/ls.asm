
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
    3000:	7179                	addi	sp,sp,-48
    3002:	f406                	sd	ra,40(sp)
    3004:	f022                	sd	s0,32(sp)
    3006:	ec26                	sd	s1,24(sp)
    3008:	e84a                	sd	s2,16(sp)
    300a:	e44e                	sd	s3,8(sp)
    300c:	1800                	addi	s0,sp,48
    300e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    3010:	00000097          	auipc	ra,0x0
    3014:	32a080e7          	jalr	810(ra) # 333a <strlen>
    3018:	02051793          	slli	a5,a0,0x20
    301c:	9381                	srli	a5,a5,0x20
    301e:	97a6                	add	a5,a5,s1
    3020:	02f00693          	li	a3,47
    3024:	0097e963          	bltu	a5,s1,3036 <fmtname+0x36>
    3028:	0007c703          	lbu	a4,0(a5)
    302c:	00d70563          	beq	a4,a3,3036 <fmtname+0x36>
    3030:	17fd                	addi	a5,a5,-1
    3032:	fe97fbe3          	bgeu	a5,s1,3028 <fmtname+0x28>
    ;
  p++;
    3036:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    303a:	8526                	mv	a0,s1
    303c:	00000097          	auipc	ra,0x0
    3040:	2fe080e7          	jalr	766(ra) # 333a <strlen>
    3044:	2501                	sext.w	a0,a0
    3046:	47b5                	li	a5,13
    3048:	00a7fa63          	bgeu	a5,a0,305c <fmtname+0x5c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
    304c:	8526                	mv	a0,s1
    304e:	70a2                	ld	ra,40(sp)
    3050:	7402                	ld	s0,32(sp)
    3052:	64e2                	ld	s1,24(sp)
    3054:	6942                	ld	s2,16(sp)
    3056:	69a2                	ld	s3,8(sp)
    3058:	6145                	addi	sp,sp,48
    305a:	8082                	ret
  memmove(buf, p, strlen(p));
    305c:	8526                	mv	a0,s1
    305e:	00000097          	auipc	ra,0x0
    3062:	2dc080e7          	jalr	732(ra) # 333a <strlen>
    3066:	00001997          	auipc	s3,0x1
    306a:	faa98993          	addi	s3,s3,-86 # 4010 <buf.0>
    306e:	0005061b          	sext.w	a2,a0
    3072:	85a6                	mv	a1,s1
    3074:	854e                	mv	a0,s3
    3076:	00000097          	auipc	ra,0x0
    307a:	438080e7          	jalr	1080(ra) # 34ae <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    307e:	8526                	mv	a0,s1
    3080:	00000097          	auipc	ra,0x0
    3084:	2ba080e7          	jalr	698(ra) # 333a <strlen>
    3088:	0005091b          	sext.w	s2,a0
    308c:	8526                	mv	a0,s1
    308e:	00000097          	auipc	ra,0x0
    3092:	2ac080e7          	jalr	684(ra) # 333a <strlen>
    3096:	1902                	slli	s2,s2,0x20
    3098:	02095913          	srli	s2,s2,0x20
    309c:	4639                	li	a2,14
    309e:	9e09                	subw	a2,a2,a0
    30a0:	02000593          	li	a1,32
    30a4:	01298533          	add	a0,s3,s2
    30a8:	00000097          	auipc	ra,0x0
    30ac:	2bc080e7          	jalr	700(ra) # 3364 <memset>
  return buf;
    30b0:	84ce                	mv	s1,s3
    30b2:	bf69                	j	304c <fmtname+0x4c>

00000000000030b4 <ls>:

void
ls(char *path)
{
    30b4:	d9010113          	addi	sp,sp,-624
    30b8:	26113423          	sd	ra,616(sp)
    30bc:	26813023          	sd	s0,608(sp)
    30c0:	24913c23          	sd	s1,600(sp)
    30c4:	25213823          	sd	s2,592(sp)
    30c8:	25313423          	sd	s3,584(sp)
    30cc:	25413023          	sd	s4,576(sp)
    30d0:	23513c23          	sd	s5,568(sp)
    30d4:	1c80                	addi	s0,sp,624
    30d6:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    30d8:	4581                	li	a1,0
    30da:	00000097          	auipc	ra,0x0
    30de:	526080e7          	jalr	1318(ra) # 3600 <open>
    30e2:	08054163          	bltz	a0,3164 <ls+0xb0>
    30e6:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    30e8:	d9840593          	addi	a1,s0,-616
    30ec:	00000097          	auipc	ra,0x0
    30f0:	52c080e7          	jalr	1324(ra) # 3618 <fstat>
    30f4:	08054363          	bltz	a0,317a <ls+0xc6>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
    30f8:	da041783          	lh	a5,-608(s0)
    30fc:	0007869b          	sext.w	a3,a5
    3100:	4705                	li	a4,1
    3102:	08e68c63          	beq	a3,a4,319a <ls+0xe6>
    3106:	37f9                	addiw	a5,a5,-2
    3108:	17c2                	slli	a5,a5,0x30
    310a:	93c1                	srli	a5,a5,0x30
    310c:	02f76663          	bltu	a4,a5,3138 <ls+0x84>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
    3110:	854a                	mv	a0,s2
    3112:	00000097          	auipc	ra,0x0
    3116:	eee080e7          	jalr	-274(ra) # 3000 <fmtname>
    311a:	85aa                	mv	a1,a0
    311c:	da843703          	ld	a4,-600(s0)
    3120:	d9c42683          	lw	a3,-612(s0)
    3124:	da041603          	lh	a2,-608(s0)
    3128:	00001517          	auipc	a0,0x1
    312c:	a1850513          	addi	a0,a0,-1512 # 3b40 <malloc+0x122>
    3130:	00001097          	auipc	ra,0x1
    3134:	830080e7          	jalr	-2000(ra) # 3960 <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
    3138:	8526                	mv	a0,s1
    313a:	00000097          	auipc	ra,0x0
    313e:	4ae080e7          	jalr	1198(ra) # 35e8 <close>
}
    3142:	26813083          	ld	ra,616(sp)
    3146:	26013403          	ld	s0,608(sp)
    314a:	25813483          	ld	s1,600(sp)
    314e:	25013903          	ld	s2,592(sp)
    3152:	24813983          	ld	s3,584(sp)
    3156:	24013a03          	ld	s4,576(sp)
    315a:	23813a83          	ld	s5,568(sp)
    315e:	27010113          	addi	sp,sp,624
    3162:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
    3164:	864a                	mv	a2,s2
    3166:	00001597          	auipc	a1,0x1
    316a:	9aa58593          	addi	a1,a1,-1622 # 3b10 <malloc+0xf2>
    316e:	4509                	li	a0,2
    3170:	00000097          	auipc	ra,0x0
    3174:	7c2080e7          	jalr	1986(ra) # 3932 <fprintf>
    return;
    3178:	b7e9                	j	3142 <ls+0x8e>
    fprintf(2, "ls: cannot stat %s\n", path);
    317a:	864a                	mv	a2,s2
    317c:	00001597          	auipc	a1,0x1
    3180:	9ac58593          	addi	a1,a1,-1620 # 3b28 <malloc+0x10a>
    3184:	4509                	li	a0,2
    3186:	00000097          	auipc	ra,0x0
    318a:	7ac080e7          	jalr	1964(ra) # 3932 <fprintf>
    close(fd);
    318e:	8526                	mv	a0,s1
    3190:	00000097          	auipc	ra,0x0
    3194:	458080e7          	jalr	1112(ra) # 35e8 <close>
    return;
    3198:	b76d                	j	3142 <ls+0x8e>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
    319a:	854a                	mv	a0,s2
    319c:	00000097          	auipc	ra,0x0
    31a0:	19e080e7          	jalr	414(ra) # 333a <strlen>
    31a4:	2541                	addiw	a0,a0,16
    31a6:	20000793          	li	a5,512
    31aa:	00a7fb63          	bgeu	a5,a0,31c0 <ls+0x10c>
      printf("ls: path too long\n");
    31ae:	00001517          	auipc	a0,0x1
    31b2:	9a250513          	addi	a0,a0,-1630 # 3b50 <malloc+0x132>
    31b6:	00000097          	auipc	ra,0x0
    31ba:	7aa080e7          	jalr	1962(ra) # 3960 <printf>
      break;
    31be:	bfad                	j	3138 <ls+0x84>
    strcpy(buf, path);
    31c0:	85ca                	mv	a1,s2
    31c2:	dc040513          	addi	a0,s0,-576
    31c6:	00000097          	auipc	ra,0x0
    31ca:	12c080e7          	jalr	300(ra) # 32f2 <strcpy>
    p = buf+strlen(buf);
    31ce:	dc040513          	addi	a0,s0,-576
    31d2:	00000097          	auipc	ra,0x0
    31d6:	168080e7          	jalr	360(ra) # 333a <strlen>
    31da:	02051913          	slli	s2,a0,0x20
    31de:	02095913          	srli	s2,s2,0x20
    31e2:	dc040793          	addi	a5,s0,-576
    31e6:	993e                	add	s2,s2,a5
    *p++ = '/';
    31e8:	00190993          	addi	s3,s2,1
    31ec:	02f00793          	li	a5,47
    31f0:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    31f4:	00001a17          	auipc	s4,0x1
    31f8:	974a0a13          	addi	s4,s4,-1676 # 3b68 <malloc+0x14a>
        printf("ls: cannot stat %s\n", buf);
    31fc:	00001a97          	auipc	s5,0x1
    3200:	92ca8a93          	addi	s5,s5,-1748 # 3b28 <malloc+0x10a>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    3204:	a801                	j	3214 <ls+0x160>
        printf("ls: cannot stat %s\n", buf);
    3206:	dc040593          	addi	a1,s0,-576
    320a:	8556                	mv	a0,s5
    320c:	00000097          	auipc	ra,0x0
    3210:	754080e7          	jalr	1876(ra) # 3960 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    3214:	4641                	li	a2,16
    3216:	db040593          	addi	a1,s0,-592
    321a:	8526                	mv	a0,s1
    321c:	00000097          	auipc	ra,0x0
    3220:	3bc080e7          	jalr	956(ra) # 35d8 <read>
    3224:	47c1                	li	a5,16
    3226:	f0f519e3          	bne	a0,a5,3138 <ls+0x84>
      if(de.inum == 0)
    322a:	db045783          	lhu	a5,-592(s0)
    322e:	d3fd                	beqz	a5,3214 <ls+0x160>
      memmove(p, de.name, DIRSIZ);
    3230:	4639                	li	a2,14
    3232:	db240593          	addi	a1,s0,-590
    3236:	854e                	mv	a0,s3
    3238:	00000097          	auipc	ra,0x0
    323c:	276080e7          	jalr	630(ra) # 34ae <memmove>
      p[DIRSIZ] = 0;
    3240:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
    3244:	d9840593          	addi	a1,s0,-616
    3248:	dc040513          	addi	a0,s0,-576
    324c:	00000097          	auipc	ra,0x0
    3250:	1d2080e7          	jalr	466(ra) # 341e <stat>
    3254:	fa0549e3          	bltz	a0,3206 <ls+0x152>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    3258:	dc040513          	addi	a0,s0,-576
    325c:	00000097          	auipc	ra,0x0
    3260:	da4080e7          	jalr	-604(ra) # 3000 <fmtname>
    3264:	85aa                	mv	a1,a0
    3266:	da843703          	ld	a4,-600(s0)
    326a:	d9c42683          	lw	a3,-612(s0)
    326e:	da041603          	lh	a2,-608(s0)
    3272:	8552                	mv	a0,s4
    3274:	00000097          	auipc	ra,0x0
    3278:	6ec080e7          	jalr	1772(ra) # 3960 <printf>
    327c:	bf61                	j	3214 <ls+0x160>

000000000000327e <main>:

int
main(int argc, char *argv[])
{
    327e:	1101                	addi	sp,sp,-32
    3280:	ec06                	sd	ra,24(sp)
    3282:	e822                	sd	s0,16(sp)
    3284:	e426                	sd	s1,8(sp)
    3286:	e04a                	sd	s2,0(sp)
    3288:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
    328a:	4785                	li	a5,1
    328c:	02a7d963          	bge	a5,a0,32be <main+0x40>
    3290:	00858493          	addi	s1,a1,8
    3294:	ffe5091b          	addiw	s2,a0,-2
    3298:	1902                	slli	s2,s2,0x20
    329a:	02095913          	srli	s2,s2,0x20
    329e:	090e                	slli	s2,s2,0x3
    32a0:	05c1                	addi	a1,a1,16
    32a2:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
    32a4:	6088                	ld	a0,0(s1)
    32a6:	00000097          	auipc	ra,0x0
    32aa:	e0e080e7          	jalr	-498(ra) # 30b4 <ls>
  for(i=1; i<argc; i++)
    32ae:	04a1                	addi	s1,s1,8
    32b0:	ff249ae3          	bne	s1,s2,32a4 <main+0x26>
  exit(0);
    32b4:	4501                	li	a0,0
    32b6:	00000097          	auipc	ra,0x0
    32ba:	302080e7          	jalr	770(ra) # 35b8 <exit>
    ls(".");
    32be:	00001517          	auipc	a0,0x1
    32c2:	8ba50513          	addi	a0,a0,-1862 # 3b78 <malloc+0x15a>
    32c6:	00000097          	auipc	ra,0x0
    32ca:	dee080e7          	jalr	-530(ra) # 30b4 <ls>
    exit(0);
    32ce:	4501                	li	a0,0
    32d0:	00000097          	auipc	ra,0x0
    32d4:	2e8080e7          	jalr	744(ra) # 35b8 <exit>

00000000000032d8 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    32d8:	1141                	addi	sp,sp,-16
    32da:	e406                	sd	ra,8(sp)
    32dc:	e022                	sd	s0,0(sp)
    32de:	0800                	addi	s0,sp,16
  extern int main();
  main();
    32e0:	00000097          	auipc	ra,0x0
    32e4:	f9e080e7          	jalr	-98(ra) # 327e <main>
  exit(0);
    32e8:	4501                	li	a0,0
    32ea:	00000097          	auipc	ra,0x0
    32ee:	2ce080e7          	jalr	718(ra) # 35b8 <exit>

00000000000032f2 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    32f2:	1141                	addi	sp,sp,-16
    32f4:	e422                	sd	s0,8(sp)
    32f6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    32f8:	87aa                	mv	a5,a0
    32fa:	0585                	addi	a1,a1,1
    32fc:	0785                	addi	a5,a5,1
    32fe:	fff5c703          	lbu	a4,-1(a1)
    3302:	fee78fa3          	sb	a4,-1(a5)
    3306:	fb75                	bnez	a4,32fa <strcpy+0x8>
    ;
  return os;
}
    3308:	6422                	ld	s0,8(sp)
    330a:	0141                	addi	sp,sp,16
    330c:	8082                	ret

000000000000330e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    330e:	1141                	addi	sp,sp,-16
    3310:	e422                	sd	s0,8(sp)
    3312:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    3314:	00054783          	lbu	a5,0(a0)
    3318:	cb91                	beqz	a5,332c <strcmp+0x1e>
    331a:	0005c703          	lbu	a4,0(a1)
    331e:	00f71763          	bne	a4,a5,332c <strcmp+0x1e>
    p++, q++;
    3322:	0505                	addi	a0,a0,1
    3324:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    3326:	00054783          	lbu	a5,0(a0)
    332a:	fbe5                	bnez	a5,331a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    332c:	0005c503          	lbu	a0,0(a1)
}
    3330:	40a7853b          	subw	a0,a5,a0
    3334:	6422                	ld	s0,8(sp)
    3336:	0141                	addi	sp,sp,16
    3338:	8082                	ret

000000000000333a <strlen>:

uint
strlen(const char *s)
{
    333a:	1141                	addi	sp,sp,-16
    333c:	e422                	sd	s0,8(sp)
    333e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    3340:	00054783          	lbu	a5,0(a0)
    3344:	cf91                	beqz	a5,3360 <strlen+0x26>
    3346:	0505                	addi	a0,a0,1
    3348:	87aa                	mv	a5,a0
    334a:	4685                	li	a3,1
    334c:	9e89                	subw	a3,a3,a0
    334e:	00f6853b          	addw	a0,a3,a5
    3352:	0785                	addi	a5,a5,1
    3354:	fff7c703          	lbu	a4,-1(a5)
    3358:	fb7d                	bnez	a4,334e <strlen+0x14>
    ;
  return n;
}
    335a:	6422                	ld	s0,8(sp)
    335c:	0141                	addi	sp,sp,16
    335e:	8082                	ret
  for(n = 0; s[n]; n++)
    3360:	4501                	li	a0,0
    3362:	bfe5                	j	335a <strlen+0x20>

0000000000003364 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3364:	1141                	addi	sp,sp,-16
    3366:	e422                	sd	s0,8(sp)
    3368:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    336a:	ca19                	beqz	a2,3380 <memset+0x1c>
    336c:	87aa                	mv	a5,a0
    336e:	1602                	slli	a2,a2,0x20
    3370:	9201                	srli	a2,a2,0x20
    3372:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    3376:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    337a:	0785                	addi	a5,a5,1
    337c:	fee79de3          	bne	a5,a4,3376 <memset+0x12>
  }
  return dst;
}
    3380:	6422                	ld	s0,8(sp)
    3382:	0141                	addi	sp,sp,16
    3384:	8082                	ret

0000000000003386 <strchr>:

char*
strchr(const char *s, char c)
{
    3386:	1141                	addi	sp,sp,-16
    3388:	e422                	sd	s0,8(sp)
    338a:	0800                	addi	s0,sp,16
  for(; *s; s++)
    338c:	00054783          	lbu	a5,0(a0)
    3390:	cb99                	beqz	a5,33a6 <strchr+0x20>
    if(*s == c)
    3392:	00f58763          	beq	a1,a5,33a0 <strchr+0x1a>
  for(; *s; s++)
    3396:	0505                	addi	a0,a0,1
    3398:	00054783          	lbu	a5,0(a0)
    339c:	fbfd                	bnez	a5,3392 <strchr+0xc>
      return (char*)s;
  return 0;
    339e:	4501                	li	a0,0
}
    33a0:	6422                	ld	s0,8(sp)
    33a2:	0141                	addi	sp,sp,16
    33a4:	8082                	ret
  return 0;
    33a6:	4501                	li	a0,0
    33a8:	bfe5                	j	33a0 <strchr+0x1a>

00000000000033aa <gets>:

char*
gets(char *buf, int max)
{
    33aa:	711d                	addi	sp,sp,-96
    33ac:	ec86                	sd	ra,88(sp)
    33ae:	e8a2                	sd	s0,80(sp)
    33b0:	e4a6                	sd	s1,72(sp)
    33b2:	e0ca                	sd	s2,64(sp)
    33b4:	fc4e                	sd	s3,56(sp)
    33b6:	f852                	sd	s4,48(sp)
    33b8:	f456                	sd	s5,40(sp)
    33ba:	f05a                	sd	s6,32(sp)
    33bc:	ec5e                	sd	s7,24(sp)
    33be:	1080                	addi	s0,sp,96
    33c0:	8baa                	mv	s7,a0
    33c2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    33c4:	892a                	mv	s2,a0
    33c6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    33c8:	4aa9                	li	s5,10
    33ca:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    33cc:	89a6                	mv	s3,s1
    33ce:	2485                	addiw	s1,s1,1
    33d0:	0344d863          	bge	s1,s4,3400 <gets+0x56>
    cc = read(0, &c, 1);
    33d4:	4605                	li	a2,1
    33d6:	faf40593          	addi	a1,s0,-81
    33da:	4501                	li	a0,0
    33dc:	00000097          	auipc	ra,0x0
    33e0:	1fc080e7          	jalr	508(ra) # 35d8 <read>
    if(cc < 1)
    33e4:	00a05e63          	blez	a0,3400 <gets+0x56>
    buf[i++] = c;
    33e8:	faf44783          	lbu	a5,-81(s0)
    33ec:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    33f0:	01578763          	beq	a5,s5,33fe <gets+0x54>
    33f4:	0905                	addi	s2,s2,1
    33f6:	fd679be3          	bne	a5,s6,33cc <gets+0x22>
  for(i=0; i+1 < max; ){
    33fa:	89a6                	mv	s3,s1
    33fc:	a011                	j	3400 <gets+0x56>
    33fe:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3400:	99de                	add	s3,s3,s7
    3402:	00098023          	sb	zero,0(s3)
  return buf;
}
    3406:	855e                	mv	a0,s7
    3408:	60e6                	ld	ra,88(sp)
    340a:	6446                	ld	s0,80(sp)
    340c:	64a6                	ld	s1,72(sp)
    340e:	6906                	ld	s2,64(sp)
    3410:	79e2                	ld	s3,56(sp)
    3412:	7a42                	ld	s4,48(sp)
    3414:	7aa2                	ld	s5,40(sp)
    3416:	7b02                	ld	s6,32(sp)
    3418:	6be2                	ld	s7,24(sp)
    341a:	6125                	addi	sp,sp,96
    341c:	8082                	ret

000000000000341e <stat>:

int
stat(const char *n, struct stat *st)
{
    341e:	1101                	addi	sp,sp,-32
    3420:	ec06                	sd	ra,24(sp)
    3422:	e822                	sd	s0,16(sp)
    3424:	e426                	sd	s1,8(sp)
    3426:	e04a                	sd	s2,0(sp)
    3428:	1000                	addi	s0,sp,32
    342a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    342c:	4581                	li	a1,0
    342e:	00000097          	auipc	ra,0x0
    3432:	1d2080e7          	jalr	466(ra) # 3600 <open>
  if(fd < 0)
    3436:	02054563          	bltz	a0,3460 <stat+0x42>
    343a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    343c:	85ca                	mv	a1,s2
    343e:	00000097          	auipc	ra,0x0
    3442:	1da080e7          	jalr	474(ra) # 3618 <fstat>
    3446:	892a                	mv	s2,a0
  close(fd);
    3448:	8526                	mv	a0,s1
    344a:	00000097          	auipc	ra,0x0
    344e:	19e080e7          	jalr	414(ra) # 35e8 <close>
  return r;
}
    3452:	854a                	mv	a0,s2
    3454:	60e2                	ld	ra,24(sp)
    3456:	6442                	ld	s0,16(sp)
    3458:	64a2                	ld	s1,8(sp)
    345a:	6902                	ld	s2,0(sp)
    345c:	6105                	addi	sp,sp,32
    345e:	8082                	ret
    return -1;
    3460:	597d                	li	s2,-1
    3462:	bfc5                	j	3452 <stat+0x34>

0000000000003464 <atoi>:

int
atoi(const char *s)
{
    3464:	1141                	addi	sp,sp,-16
    3466:	e422                	sd	s0,8(sp)
    3468:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    346a:	00054603          	lbu	a2,0(a0)
    346e:	fd06079b          	addiw	a5,a2,-48
    3472:	0ff7f793          	andi	a5,a5,255
    3476:	4725                	li	a4,9
    3478:	02f76963          	bltu	a4,a5,34aa <atoi+0x46>
    347c:	86aa                	mv	a3,a0
  n = 0;
    347e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    3480:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    3482:	0685                	addi	a3,a3,1
    3484:	0025179b          	slliw	a5,a0,0x2
    3488:	9fa9                	addw	a5,a5,a0
    348a:	0017979b          	slliw	a5,a5,0x1
    348e:	9fb1                	addw	a5,a5,a2
    3490:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    3494:	0006c603          	lbu	a2,0(a3)
    3498:	fd06071b          	addiw	a4,a2,-48
    349c:	0ff77713          	andi	a4,a4,255
    34a0:	fee5f1e3          	bgeu	a1,a4,3482 <atoi+0x1e>
  return n;
}
    34a4:	6422                	ld	s0,8(sp)
    34a6:	0141                	addi	sp,sp,16
    34a8:	8082                	ret
  n = 0;
    34aa:	4501                	li	a0,0
    34ac:	bfe5                	j	34a4 <atoi+0x40>

00000000000034ae <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    34ae:	1141                	addi	sp,sp,-16
    34b0:	e422                	sd	s0,8(sp)
    34b2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    34b4:	02b57463          	bgeu	a0,a1,34dc <memmove+0x2e>
    while(n-- > 0)
    34b8:	00c05f63          	blez	a2,34d6 <memmove+0x28>
    34bc:	1602                	slli	a2,a2,0x20
    34be:	9201                	srli	a2,a2,0x20
    34c0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    34c4:	872a                	mv	a4,a0
      *dst++ = *src++;
    34c6:	0585                	addi	a1,a1,1
    34c8:	0705                	addi	a4,a4,1
    34ca:	fff5c683          	lbu	a3,-1(a1)
    34ce:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    34d2:	fee79ae3          	bne	a5,a4,34c6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    34d6:	6422                	ld	s0,8(sp)
    34d8:	0141                	addi	sp,sp,16
    34da:	8082                	ret
    dst += n;
    34dc:	00c50733          	add	a4,a0,a2
    src += n;
    34e0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    34e2:	fec05ae3          	blez	a2,34d6 <memmove+0x28>
    34e6:	fff6079b          	addiw	a5,a2,-1
    34ea:	1782                	slli	a5,a5,0x20
    34ec:	9381                	srli	a5,a5,0x20
    34ee:	fff7c793          	not	a5,a5
    34f2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    34f4:	15fd                	addi	a1,a1,-1
    34f6:	177d                	addi	a4,a4,-1
    34f8:	0005c683          	lbu	a3,0(a1)
    34fc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3500:	fee79ae3          	bne	a5,a4,34f4 <memmove+0x46>
    3504:	bfc9                	j	34d6 <memmove+0x28>

0000000000003506 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    3506:	1141                	addi	sp,sp,-16
    3508:	e422                	sd	s0,8(sp)
    350a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    350c:	ca05                	beqz	a2,353c <memcmp+0x36>
    350e:	fff6069b          	addiw	a3,a2,-1
    3512:	1682                	slli	a3,a3,0x20
    3514:	9281                	srli	a3,a3,0x20
    3516:	0685                	addi	a3,a3,1
    3518:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    351a:	00054783          	lbu	a5,0(a0)
    351e:	0005c703          	lbu	a4,0(a1)
    3522:	00e79863          	bne	a5,a4,3532 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    3526:	0505                	addi	a0,a0,1
    p2++;
    3528:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    352a:	fed518e3          	bne	a0,a3,351a <memcmp+0x14>
  }
  return 0;
    352e:	4501                	li	a0,0
    3530:	a019                	j	3536 <memcmp+0x30>
      return *p1 - *p2;
    3532:	40e7853b          	subw	a0,a5,a4
}
    3536:	6422                	ld	s0,8(sp)
    3538:	0141                	addi	sp,sp,16
    353a:	8082                	ret
  return 0;
    353c:	4501                	li	a0,0
    353e:	bfe5                	j	3536 <memcmp+0x30>

0000000000003540 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    3540:	1141                	addi	sp,sp,-16
    3542:	e406                	sd	ra,8(sp)
    3544:	e022                	sd	s0,0(sp)
    3546:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    3548:	00000097          	auipc	ra,0x0
    354c:	f66080e7          	jalr	-154(ra) # 34ae <memmove>
}
    3550:	60a2                	ld	ra,8(sp)
    3552:	6402                	ld	s0,0(sp)
    3554:	0141                	addi	sp,sp,16
    3556:	8082                	ret

0000000000003558 <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    3558:	1141                	addi	sp,sp,-16
    355a:	e422                	sd	s0,8(sp)
    355c:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    355e:	00052023          	sw	zero,0(a0)
}  
    3562:	6422                	ld	s0,8(sp)
    3564:	0141                	addi	sp,sp,16
    3566:	8082                	ret

0000000000003568 <lock>:

void lock(struct spinlock * lk) 
{    
    3568:	1141                	addi	sp,sp,-16
    356a:	e422                	sd	s0,8(sp)
    356c:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    356e:	4705                	li	a4,1
    3570:	87ba                	mv	a5,a4
    3572:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    3576:	2781                	sext.w	a5,a5
    3578:	ffe5                	bnez	a5,3570 <lock+0x8>
}  
    357a:	6422                	ld	s0,8(sp)
    357c:	0141                	addi	sp,sp,16
    357e:	8082                	ret

0000000000003580 <unlock>:

void unlock(struct spinlock * lk) 
{   
    3580:	1141                	addi	sp,sp,-16
    3582:	e422                	sd	s0,8(sp)
    3584:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    3586:	0f50000f          	fence	iorw,ow
    358a:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    358e:	6422                	ld	s0,8(sp)
    3590:	0141                	addi	sp,sp,16
    3592:	8082                	ret

0000000000003594 <isDigit>:

unsigned int isDigit(char *c) {
    3594:	1141                	addi	sp,sp,-16
    3596:	e422                	sd	s0,8(sp)
    3598:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    359a:	00054503          	lbu	a0,0(a0)
    359e:	fd05051b          	addiw	a0,a0,-48
    35a2:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    35a6:	00a53513          	sltiu	a0,a0,10
    35aa:	6422                	ld	s0,8(sp)
    35ac:	0141                	addi	sp,sp,16
    35ae:	8082                	ret

00000000000035b0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    35b0:	4885                	li	a7,1
 ecall
    35b2:	00000073          	ecall
 ret
    35b6:	8082                	ret

00000000000035b8 <exit>:
.global exit
exit:
 li a7, SYS_exit
    35b8:	4889                	li	a7,2
 ecall
    35ba:	00000073          	ecall
 ret
    35be:	8082                	ret

00000000000035c0 <wait>:
.global wait
wait:
 li a7, SYS_wait
    35c0:	488d                	li	a7,3
 ecall
    35c2:	00000073          	ecall
 ret
    35c6:	8082                	ret

00000000000035c8 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    35c8:	48e1                	li	a7,24
 ecall
    35ca:	00000073          	ecall
 ret
    35ce:	8082                	ret

00000000000035d0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    35d0:	4891                	li	a7,4
 ecall
    35d2:	00000073          	ecall
 ret
    35d6:	8082                	ret

00000000000035d8 <read>:
.global read
read:
 li a7, SYS_read
    35d8:	4895                	li	a7,5
 ecall
    35da:	00000073          	ecall
 ret
    35de:	8082                	ret

00000000000035e0 <write>:
.global write
write:
 li a7, SYS_write
    35e0:	48c1                	li	a7,16
 ecall
    35e2:	00000073          	ecall
 ret
    35e6:	8082                	ret

00000000000035e8 <close>:
.global close
close:
 li a7, SYS_close
    35e8:	48d5                	li	a7,21
 ecall
    35ea:	00000073          	ecall
 ret
    35ee:	8082                	ret

00000000000035f0 <kill>:
.global kill
kill:
 li a7, SYS_kill
    35f0:	4899                	li	a7,6
 ecall
    35f2:	00000073          	ecall
 ret
    35f6:	8082                	ret

00000000000035f8 <exec>:
.global exec
exec:
 li a7, SYS_exec
    35f8:	489d                	li	a7,7
 ecall
    35fa:	00000073          	ecall
 ret
    35fe:	8082                	ret

0000000000003600 <open>:
.global open
open:
 li a7, SYS_open
    3600:	48bd                	li	a7,15
 ecall
    3602:	00000073          	ecall
 ret
    3606:	8082                	ret

0000000000003608 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    3608:	48c5                	li	a7,17
 ecall
    360a:	00000073          	ecall
 ret
    360e:	8082                	ret

0000000000003610 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3610:	48c9                	li	a7,18
 ecall
    3612:	00000073          	ecall
 ret
    3616:	8082                	ret

0000000000003618 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    3618:	48a1                	li	a7,8
 ecall
    361a:	00000073          	ecall
 ret
    361e:	8082                	ret

0000000000003620 <link>:
.global link
link:
 li a7, SYS_link
    3620:	48cd                	li	a7,19
 ecall
    3622:	00000073          	ecall
 ret
    3626:	8082                	ret

0000000000003628 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    3628:	48d1                	li	a7,20
 ecall
    362a:	00000073          	ecall
 ret
    362e:	8082                	ret

0000000000003630 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3630:	48a5                	li	a7,9
 ecall
    3632:	00000073          	ecall
 ret
    3636:	8082                	ret

0000000000003638 <dup>:
.global dup
dup:
 li a7, SYS_dup
    3638:	48a9                	li	a7,10
 ecall
    363a:	00000073          	ecall
 ret
    363e:	8082                	ret

0000000000003640 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    3640:	48ad                	li	a7,11
 ecall
    3642:	00000073          	ecall
 ret
    3646:	8082                	ret

0000000000003648 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    3648:	48b1                	li	a7,12
 ecall
    364a:	00000073          	ecall
 ret
    364e:	8082                	ret

0000000000003650 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    3650:	48b5                	li	a7,13
 ecall
    3652:	00000073          	ecall
 ret
    3656:	8082                	ret

0000000000003658 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    3658:	48b9                	li	a7,14
 ecall
    365a:	00000073          	ecall
 ret
    365e:	8082                	ret

0000000000003660 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    3660:	48d9                	li	a7,22
 ecall
    3662:	00000073          	ecall
 ret
    3666:	8082                	ret

0000000000003668 <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    3668:	48dd                	li	a7,23
 ecall
    366a:	00000073          	ecall
 ret
    366e:	8082                	ret

0000000000003670 <ps>:
.global ps
ps:
 li a7, SYS_ps
    3670:	48e5                	li	a7,25
 ecall
    3672:	00000073          	ecall
 ret
    3676:	8082                	ret

0000000000003678 <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    3678:	48e9                	li	a7,26
 ecall
    367a:	00000073          	ecall
 ret
    367e:	8082                	ret

0000000000003680 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    3680:	48ed                	li	a7,27
 ecall
    3682:	00000073          	ecall
 ret
    3686:	8082                	ret

0000000000003688 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    3688:	1101                	addi	sp,sp,-32
    368a:	ec06                	sd	ra,24(sp)
    368c:	e822                	sd	s0,16(sp)
    368e:	1000                	addi	s0,sp,32
    3690:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    3694:	4605                	li	a2,1
    3696:	fef40593          	addi	a1,s0,-17
    369a:	00000097          	auipc	ra,0x0
    369e:	f46080e7          	jalr	-186(ra) # 35e0 <write>
}
    36a2:	60e2                	ld	ra,24(sp)
    36a4:	6442                	ld	s0,16(sp)
    36a6:	6105                	addi	sp,sp,32
    36a8:	8082                	ret

00000000000036aa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    36aa:	7139                	addi	sp,sp,-64
    36ac:	fc06                	sd	ra,56(sp)
    36ae:	f822                	sd	s0,48(sp)
    36b0:	f426                	sd	s1,40(sp)
    36b2:	f04a                	sd	s2,32(sp)
    36b4:	ec4e                	sd	s3,24(sp)
    36b6:	0080                	addi	s0,sp,64
    36b8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    36ba:	c299                	beqz	a3,36c0 <printint+0x16>
    36bc:	0805c863          	bltz	a1,374c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    36c0:	2581                	sext.w	a1,a1
  neg = 0;
    36c2:	4881                	li	a7,0
    36c4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    36c8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    36ca:	2601                	sext.w	a2,a2
    36cc:	00000517          	auipc	a0,0x0
    36d0:	4bc50513          	addi	a0,a0,1212 # 3b88 <digits>
    36d4:	883a                	mv	a6,a4
    36d6:	2705                	addiw	a4,a4,1
    36d8:	02c5f7bb          	remuw	a5,a1,a2
    36dc:	1782                	slli	a5,a5,0x20
    36de:	9381                	srli	a5,a5,0x20
    36e0:	97aa                	add	a5,a5,a0
    36e2:	0007c783          	lbu	a5,0(a5)
    36e6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    36ea:	0005879b          	sext.w	a5,a1
    36ee:	02c5d5bb          	divuw	a1,a1,a2
    36f2:	0685                	addi	a3,a3,1
    36f4:	fec7f0e3          	bgeu	a5,a2,36d4 <printint+0x2a>
  if(neg)
    36f8:	00088b63          	beqz	a7,370e <printint+0x64>
    buf[i++] = '-';
    36fc:	fd040793          	addi	a5,s0,-48
    3700:	973e                	add	a4,a4,a5
    3702:	02d00793          	li	a5,45
    3706:	fef70823          	sb	a5,-16(a4)
    370a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    370e:	02e05863          	blez	a4,373e <printint+0x94>
    3712:	fc040793          	addi	a5,s0,-64
    3716:	00e78933          	add	s2,a5,a4
    371a:	fff78993          	addi	s3,a5,-1
    371e:	99ba                	add	s3,s3,a4
    3720:	377d                	addiw	a4,a4,-1
    3722:	1702                	slli	a4,a4,0x20
    3724:	9301                	srli	a4,a4,0x20
    3726:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    372a:	fff94583          	lbu	a1,-1(s2)
    372e:	8526                	mv	a0,s1
    3730:	00000097          	auipc	ra,0x0
    3734:	f58080e7          	jalr	-168(ra) # 3688 <putc>
  while(--i >= 0)
    3738:	197d                	addi	s2,s2,-1
    373a:	ff3918e3          	bne	s2,s3,372a <printint+0x80>
}
    373e:	70e2                	ld	ra,56(sp)
    3740:	7442                	ld	s0,48(sp)
    3742:	74a2                	ld	s1,40(sp)
    3744:	7902                	ld	s2,32(sp)
    3746:	69e2                	ld	s3,24(sp)
    3748:	6121                	addi	sp,sp,64
    374a:	8082                	ret
    x = -xx;
    374c:	40b005bb          	negw	a1,a1
    neg = 1;
    3750:	4885                	li	a7,1
    x = -xx;
    3752:	bf8d                	j	36c4 <printint+0x1a>

0000000000003754 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    3754:	7119                	addi	sp,sp,-128
    3756:	fc86                	sd	ra,120(sp)
    3758:	f8a2                	sd	s0,112(sp)
    375a:	f4a6                	sd	s1,104(sp)
    375c:	f0ca                	sd	s2,96(sp)
    375e:	ecce                	sd	s3,88(sp)
    3760:	e8d2                	sd	s4,80(sp)
    3762:	e4d6                	sd	s5,72(sp)
    3764:	e0da                	sd	s6,64(sp)
    3766:	fc5e                	sd	s7,56(sp)
    3768:	f862                	sd	s8,48(sp)
    376a:	f466                	sd	s9,40(sp)
    376c:	f06a                	sd	s10,32(sp)
    376e:	ec6e                	sd	s11,24(sp)
    3770:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    3772:	0005c903          	lbu	s2,0(a1)
    3776:	18090f63          	beqz	s2,3914 <vprintf+0x1c0>
    377a:	8aaa                	mv	s5,a0
    377c:	8b32                	mv	s6,a2
    377e:	00158493          	addi	s1,a1,1
  state = 0;
    3782:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3784:	02500a13          	li	s4,37
      if(c == 'd'){
    3788:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    378c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    3790:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    3794:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3798:	00000b97          	auipc	s7,0x0
    379c:	3f0b8b93          	addi	s7,s7,1008 # 3b88 <digits>
    37a0:	a839                	j	37be <vprintf+0x6a>
        putc(fd, c);
    37a2:	85ca                	mv	a1,s2
    37a4:	8556                	mv	a0,s5
    37a6:	00000097          	auipc	ra,0x0
    37aa:	ee2080e7          	jalr	-286(ra) # 3688 <putc>
    37ae:	a019                	j	37b4 <vprintf+0x60>
    } else if(state == '%'){
    37b0:	01498f63          	beq	s3,s4,37ce <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    37b4:	0485                	addi	s1,s1,1
    37b6:	fff4c903          	lbu	s2,-1(s1)
    37ba:	14090d63          	beqz	s2,3914 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    37be:	0009079b          	sext.w	a5,s2
    if(state == 0){
    37c2:	fe0997e3          	bnez	s3,37b0 <vprintf+0x5c>
      if(c == '%'){
    37c6:	fd479ee3          	bne	a5,s4,37a2 <vprintf+0x4e>
        state = '%';
    37ca:	89be                	mv	s3,a5
    37cc:	b7e5                	j	37b4 <vprintf+0x60>
      if(c == 'd'){
    37ce:	05878063          	beq	a5,s8,380e <vprintf+0xba>
      } else if(c == 'l') {
    37d2:	05978c63          	beq	a5,s9,382a <vprintf+0xd6>
      } else if(c == 'x') {
    37d6:	07a78863          	beq	a5,s10,3846 <vprintf+0xf2>
      } else if(c == 'p') {
    37da:	09b78463          	beq	a5,s11,3862 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    37de:	07300713          	li	a4,115
    37e2:	0ce78663          	beq	a5,a4,38ae <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    37e6:	06300713          	li	a4,99
    37ea:	0ee78e63          	beq	a5,a4,38e6 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    37ee:	11478863          	beq	a5,s4,38fe <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    37f2:	85d2                	mv	a1,s4
    37f4:	8556                	mv	a0,s5
    37f6:	00000097          	auipc	ra,0x0
    37fa:	e92080e7          	jalr	-366(ra) # 3688 <putc>
        putc(fd, c);
    37fe:	85ca                	mv	a1,s2
    3800:	8556                	mv	a0,s5
    3802:	00000097          	auipc	ra,0x0
    3806:	e86080e7          	jalr	-378(ra) # 3688 <putc>
      }
      state = 0;
    380a:	4981                	li	s3,0
    380c:	b765                	j	37b4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    380e:	008b0913          	addi	s2,s6,8
    3812:	4685                	li	a3,1
    3814:	4629                	li	a2,10
    3816:	000b2583          	lw	a1,0(s6)
    381a:	8556                	mv	a0,s5
    381c:	00000097          	auipc	ra,0x0
    3820:	e8e080e7          	jalr	-370(ra) # 36aa <printint>
    3824:	8b4a                	mv	s6,s2
      state = 0;
    3826:	4981                	li	s3,0
    3828:	b771                	j	37b4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    382a:	008b0913          	addi	s2,s6,8
    382e:	4681                	li	a3,0
    3830:	4629                	li	a2,10
    3832:	000b2583          	lw	a1,0(s6)
    3836:	8556                	mv	a0,s5
    3838:	00000097          	auipc	ra,0x0
    383c:	e72080e7          	jalr	-398(ra) # 36aa <printint>
    3840:	8b4a                	mv	s6,s2
      state = 0;
    3842:	4981                	li	s3,0
    3844:	bf85                	j	37b4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    3846:	008b0913          	addi	s2,s6,8
    384a:	4681                	li	a3,0
    384c:	4641                	li	a2,16
    384e:	000b2583          	lw	a1,0(s6)
    3852:	8556                	mv	a0,s5
    3854:	00000097          	auipc	ra,0x0
    3858:	e56080e7          	jalr	-426(ra) # 36aa <printint>
    385c:	8b4a                	mv	s6,s2
      state = 0;
    385e:	4981                	li	s3,0
    3860:	bf91                	j	37b4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    3862:	008b0793          	addi	a5,s6,8
    3866:	f8f43423          	sd	a5,-120(s0)
    386a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    386e:	03000593          	li	a1,48
    3872:	8556                	mv	a0,s5
    3874:	00000097          	auipc	ra,0x0
    3878:	e14080e7          	jalr	-492(ra) # 3688 <putc>
  putc(fd, 'x');
    387c:	85ea                	mv	a1,s10
    387e:	8556                	mv	a0,s5
    3880:	00000097          	auipc	ra,0x0
    3884:	e08080e7          	jalr	-504(ra) # 3688 <putc>
    3888:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    388a:	03c9d793          	srli	a5,s3,0x3c
    388e:	97de                	add	a5,a5,s7
    3890:	0007c583          	lbu	a1,0(a5)
    3894:	8556                	mv	a0,s5
    3896:	00000097          	auipc	ra,0x0
    389a:	df2080e7          	jalr	-526(ra) # 3688 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    389e:	0992                	slli	s3,s3,0x4
    38a0:	397d                	addiw	s2,s2,-1
    38a2:	fe0914e3          	bnez	s2,388a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    38a6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    38aa:	4981                	li	s3,0
    38ac:	b721                	j	37b4 <vprintf+0x60>
        s = va_arg(ap, char*);
    38ae:	008b0993          	addi	s3,s6,8
    38b2:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    38b6:	02090163          	beqz	s2,38d8 <vprintf+0x184>
        while(*s != 0){
    38ba:	00094583          	lbu	a1,0(s2)
    38be:	c9a1                	beqz	a1,390e <vprintf+0x1ba>
          putc(fd, *s);
    38c0:	8556                	mv	a0,s5
    38c2:	00000097          	auipc	ra,0x0
    38c6:	dc6080e7          	jalr	-570(ra) # 3688 <putc>
          s++;
    38ca:	0905                	addi	s2,s2,1
        while(*s != 0){
    38cc:	00094583          	lbu	a1,0(s2)
    38d0:	f9e5                	bnez	a1,38c0 <vprintf+0x16c>
        s = va_arg(ap, char*);
    38d2:	8b4e                	mv	s6,s3
      state = 0;
    38d4:	4981                	li	s3,0
    38d6:	bdf9                	j	37b4 <vprintf+0x60>
          s = "(null)";
    38d8:	00000917          	auipc	s2,0x0
    38dc:	2a890913          	addi	s2,s2,680 # 3b80 <malloc+0x162>
        while(*s != 0){
    38e0:	02800593          	li	a1,40
    38e4:	bff1                	j	38c0 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    38e6:	008b0913          	addi	s2,s6,8
    38ea:	000b4583          	lbu	a1,0(s6)
    38ee:	8556                	mv	a0,s5
    38f0:	00000097          	auipc	ra,0x0
    38f4:	d98080e7          	jalr	-616(ra) # 3688 <putc>
    38f8:	8b4a                	mv	s6,s2
      state = 0;
    38fa:	4981                	li	s3,0
    38fc:	bd65                	j	37b4 <vprintf+0x60>
        putc(fd, c);
    38fe:	85d2                	mv	a1,s4
    3900:	8556                	mv	a0,s5
    3902:	00000097          	auipc	ra,0x0
    3906:	d86080e7          	jalr	-634(ra) # 3688 <putc>
      state = 0;
    390a:	4981                	li	s3,0
    390c:	b565                	j	37b4 <vprintf+0x60>
        s = va_arg(ap, char*);
    390e:	8b4e                	mv	s6,s3
      state = 0;
    3910:	4981                	li	s3,0
    3912:	b54d                	j	37b4 <vprintf+0x60>
    }
  }
}
    3914:	70e6                	ld	ra,120(sp)
    3916:	7446                	ld	s0,112(sp)
    3918:	74a6                	ld	s1,104(sp)
    391a:	7906                	ld	s2,96(sp)
    391c:	69e6                	ld	s3,88(sp)
    391e:	6a46                	ld	s4,80(sp)
    3920:	6aa6                	ld	s5,72(sp)
    3922:	6b06                	ld	s6,64(sp)
    3924:	7be2                	ld	s7,56(sp)
    3926:	7c42                	ld	s8,48(sp)
    3928:	7ca2                	ld	s9,40(sp)
    392a:	7d02                	ld	s10,32(sp)
    392c:	6de2                	ld	s11,24(sp)
    392e:	6109                	addi	sp,sp,128
    3930:	8082                	ret

0000000000003932 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    3932:	715d                	addi	sp,sp,-80
    3934:	ec06                	sd	ra,24(sp)
    3936:	e822                	sd	s0,16(sp)
    3938:	1000                	addi	s0,sp,32
    393a:	e010                	sd	a2,0(s0)
    393c:	e414                	sd	a3,8(s0)
    393e:	e818                	sd	a4,16(s0)
    3940:	ec1c                	sd	a5,24(s0)
    3942:	03043023          	sd	a6,32(s0)
    3946:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    394a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    394e:	8622                	mv	a2,s0
    3950:	00000097          	auipc	ra,0x0
    3954:	e04080e7          	jalr	-508(ra) # 3754 <vprintf>
}
    3958:	60e2                	ld	ra,24(sp)
    395a:	6442                	ld	s0,16(sp)
    395c:	6161                	addi	sp,sp,80
    395e:	8082                	ret

0000000000003960 <printf>:

void
printf(const char *fmt, ...)
{
    3960:	711d                	addi	sp,sp,-96
    3962:	ec06                	sd	ra,24(sp)
    3964:	e822                	sd	s0,16(sp)
    3966:	1000                	addi	s0,sp,32
    3968:	e40c                	sd	a1,8(s0)
    396a:	e810                	sd	a2,16(s0)
    396c:	ec14                	sd	a3,24(s0)
    396e:	f018                	sd	a4,32(s0)
    3970:	f41c                	sd	a5,40(s0)
    3972:	03043823          	sd	a6,48(s0)
    3976:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    397a:	00840613          	addi	a2,s0,8
    397e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    3982:	85aa                	mv	a1,a0
    3984:	4505                	li	a0,1
    3986:	00000097          	auipc	ra,0x0
    398a:	dce080e7          	jalr	-562(ra) # 3754 <vprintf>
}
    398e:	60e2                	ld	ra,24(sp)
    3990:	6442                	ld	s0,16(sp)
    3992:	6125                	addi	sp,sp,96
    3994:	8082                	ret

0000000000003996 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3996:	1141                	addi	sp,sp,-16
    3998:	e422                	sd	s0,8(sp)
    399a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    399c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    39a0:	00000797          	auipc	a5,0x0
    39a4:	6607b783          	ld	a5,1632(a5) # 4000 <freep>
    39a8:	a805                	j	39d8 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    39aa:	4618                	lw	a4,8(a2)
    39ac:	9db9                	addw	a1,a1,a4
    39ae:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    39b2:	6398                	ld	a4,0(a5)
    39b4:	6318                	ld	a4,0(a4)
    39b6:	fee53823          	sd	a4,-16(a0)
    39ba:	a091                	j	39fe <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    39bc:	ff852703          	lw	a4,-8(a0)
    39c0:	9e39                	addw	a2,a2,a4
    39c2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    39c4:	ff053703          	ld	a4,-16(a0)
    39c8:	e398                	sd	a4,0(a5)
    39ca:	a099                	j	3a10 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    39cc:	6398                	ld	a4,0(a5)
    39ce:	00e7e463          	bltu	a5,a4,39d6 <free+0x40>
    39d2:	00e6ea63          	bltu	a3,a4,39e6 <free+0x50>
{
    39d6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    39d8:	fed7fae3          	bgeu	a5,a3,39cc <free+0x36>
    39dc:	6398                	ld	a4,0(a5)
    39de:	00e6e463          	bltu	a3,a4,39e6 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    39e2:	fee7eae3          	bltu	a5,a4,39d6 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    39e6:	ff852583          	lw	a1,-8(a0)
    39ea:	6390                	ld	a2,0(a5)
    39ec:	02059713          	slli	a4,a1,0x20
    39f0:	9301                	srli	a4,a4,0x20
    39f2:	0712                	slli	a4,a4,0x4
    39f4:	9736                	add	a4,a4,a3
    39f6:	fae60ae3          	beq	a2,a4,39aa <free+0x14>
    bp->s.ptr = p->s.ptr;
    39fa:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    39fe:	4790                	lw	a2,8(a5)
    3a00:	02061713          	slli	a4,a2,0x20
    3a04:	9301                	srli	a4,a4,0x20
    3a06:	0712                	slli	a4,a4,0x4
    3a08:	973e                	add	a4,a4,a5
    3a0a:	fae689e3          	beq	a3,a4,39bc <free+0x26>
  } else
    p->s.ptr = bp;
    3a0e:	e394                	sd	a3,0(a5)
  freep = p;
    3a10:	00000717          	auipc	a4,0x0
    3a14:	5ef73823          	sd	a5,1520(a4) # 4000 <freep>
}
    3a18:	6422                	ld	s0,8(sp)
    3a1a:	0141                	addi	sp,sp,16
    3a1c:	8082                	ret

0000000000003a1e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3a1e:	7139                	addi	sp,sp,-64
    3a20:	fc06                	sd	ra,56(sp)
    3a22:	f822                	sd	s0,48(sp)
    3a24:	f426                	sd	s1,40(sp)
    3a26:	f04a                	sd	s2,32(sp)
    3a28:	ec4e                	sd	s3,24(sp)
    3a2a:	e852                	sd	s4,16(sp)
    3a2c:	e456                	sd	s5,8(sp)
    3a2e:	e05a                	sd	s6,0(sp)
    3a30:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3a32:	02051493          	slli	s1,a0,0x20
    3a36:	9081                	srli	s1,s1,0x20
    3a38:	04bd                	addi	s1,s1,15
    3a3a:	8091                	srli	s1,s1,0x4
    3a3c:	0014899b          	addiw	s3,s1,1
    3a40:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    3a42:	00000517          	auipc	a0,0x0
    3a46:	5be53503          	ld	a0,1470(a0) # 4000 <freep>
    3a4a:	c515                	beqz	a0,3a76 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3a4c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3a4e:	4798                	lw	a4,8(a5)
    3a50:	02977f63          	bgeu	a4,s1,3a8e <malloc+0x70>
    3a54:	8a4e                	mv	s4,s3
    3a56:	0009871b          	sext.w	a4,s3
    3a5a:	6685                	lui	a3,0x1
    3a5c:	00d77363          	bgeu	a4,a3,3a62 <malloc+0x44>
    3a60:	6a05                	lui	s4,0x1
    3a62:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    3a66:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3a6a:	00000917          	auipc	s2,0x0
    3a6e:	59690913          	addi	s2,s2,1430 # 4000 <freep>
  if(p == (char*)-1)
    3a72:	5afd                	li	s5,-1
    3a74:	a88d                	j	3ae6 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    3a76:	00000797          	auipc	a5,0x0
    3a7a:	5aa78793          	addi	a5,a5,1450 # 4020 <base>
    3a7e:	00000717          	auipc	a4,0x0
    3a82:	58f73123          	sd	a5,1410(a4) # 4000 <freep>
    3a86:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    3a88:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    3a8c:	b7e1                	j	3a54 <malloc+0x36>
      if(p->s.size == nunits)
    3a8e:	02e48b63          	beq	s1,a4,3ac4 <malloc+0xa6>
        p->s.size -= nunits;
    3a92:	4137073b          	subw	a4,a4,s3
    3a96:	c798                	sw	a4,8(a5)
        p += p->s.size;
    3a98:	1702                	slli	a4,a4,0x20
    3a9a:	9301                	srli	a4,a4,0x20
    3a9c:	0712                	slli	a4,a4,0x4
    3a9e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    3aa0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    3aa4:	00000717          	auipc	a4,0x0
    3aa8:	54a73e23          	sd	a0,1372(a4) # 4000 <freep>
      return (void*)(p + 1);
    3aac:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3ab0:	70e2                	ld	ra,56(sp)
    3ab2:	7442                	ld	s0,48(sp)
    3ab4:	74a2                	ld	s1,40(sp)
    3ab6:	7902                	ld	s2,32(sp)
    3ab8:	69e2                	ld	s3,24(sp)
    3aba:	6a42                	ld	s4,16(sp)
    3abc:	6aa2                	ld	s5,8(sp)
    3abe:	6b02                	ld	s6,0(sp)
    3ac0:	6121                	addi	sp,sp,64
    3ac2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3ac4:	6398                	ld	a4,0(a5)
    3ac6:	e118                	sd	a4,0(a0)
    3ac8:	bff1                	j	3aa4 <malloc+0x86>
  hp->s.size = nu;
    3aca:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    3ace:	0541                	addi	a0,a0,16
    3ad0:	00000097          	auipc	ra,0x0
    3ad4:	ec6080e7          	jalr	-314(ra) # 3996 <free>
  return freep;
    3ad8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    3adc:	d971                	beqz	a0,3ab0 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3ade:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3ae0:	4798                	lw	a4,8(a5)
    3ae2:	fa9776e3          	bgeu	a4,s1,3a8e <malloc+0x70>
    if(p == freep)
    3ae6:	00093703          	ld	a4,0(s2)
    3aea:	853e                	mv	a0,a5
    3aec:	fef719e3          	bne	a4,a5,3ade <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3af0:	8552                	mv	a0,s4
    3af2:	00000097          	auipc	ra,0x0
    3af6:	b56080e7          	jalr	-1194(ra) # 3648 <sbrk>
  if(p == (char*)-1)
    3afa:	fd5518e3          	bne	a0,s5,3aca <malloc+0xac>
        return 0;
    3afe:	4501                	li	a0,0
    3b00:	bf45                	j	3ab0 <malloc+0x92>
