
user/_uniq:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <to_lower>:
#include "user/user.h"

#define BUF_SIZE  512

// Helper function to convert char to lowercase
int to_lower(int c) {
    3000:	1141                	addi	sp,sp,-16
    3002:	e422                	sd	s0,8(sp)
    3004:	0800                	addi	s0,sp,16
  if (c >= 'A' && c <= 'Z')
    3006:	fbf5071b          	addiw	a4,a0,-65
    300a:	47e5                	li	a5,25
    300c:	00e7f563          	bgeu	a5,a4,3016 <to_lower+0x16>
    return c + ('a' - 'A');
  return c;
}
    3010:	6422                	ld	s0,8(sp)
    3012:	0141                	addi	sp,sp,16
    3014:	8082                	ret
    return c + ('a' - 'A');
    3016:	0205051b          	addiw	a0,a0,32
    301a:	bfdd                	j	3010 <to_lower+0x10>

000000000000301c <my_strcasecmp>:

// Helper function to compare chars with insensitive case
int my_strcasecmp(const char *str1, const char *str2) {
    301c:	7179                	addi	sp,sp,-48
    301e:	f406                	sd	ra,40(sp)
    3020:	f022                	sd	s0,32(sp)
    3022:	ec26                	sd	s1,24(sp)
    3024:	e84a                	sd	s2,16(sp)
    3026:	e44e                	sd	s3,8(sp)
    3028:	e052                	sd	s4,0(sp)
    302a:	1800                	addi	s0,sp,48
    302c:	89aa                	mv	s3,a0
    302e:	892e                	mv	s2,a1
  while (*str1 && to_lower(*str1) == to_lower(*str2))
    3030:	00054a03          	lbu	s4,0(a0)
    3034:	020a0663          	beqz	s4,3060 <my_strcasecmp+0x44>
    3038:	8552                	mv	a0,s4
    303a:	00000097          	auipc	ra,0x0
    303e:	fc6080e7          	jalr	-58(ra) # 3000 <to_lower>
    3042:	84aa                	mv	s1,a0
    3044:	00094503          	lbu	a0,0(s2)
    3048:	00000097          	auipc	ra,0x0
    304c:	fb8080e7          	jalr	-72(ra) # 3000 <to_lower>
    3050:	00a49863          	bne	s1,a0,3060 <my_strcasecmp+0x44>
    str1++, str2++;
    3054:	0985                	addi	s3,s3,1
    3056:	0905                	addi	s2,s2,1
  while (*str1 && to_lower(*str1) == to_lower(*str2))
    3058:	0009ca03          	lbu	s4,0(s3)
    305c:	fc0a1ee3          	bnez	s4,3038 <my_strcasecmp+0x1c>
  return (unsigned char)to_lower(*str1) - (unsigned char)to_lower(*str2);
    3060:	8552                	mv	a0,s4
    3062:	00000097          	auipc	ra,0x0
    3066:	f9e080e7          	jalr	-98(ra) # 3000 <to_lower>
    306a:	84aa                	mv	s1,a0
    306c:	00094503          	lbu	a0,0(s2)
    3070:	00000097          	auipc	ra,0x0
    3074:	f90080e7          	jalr	-112(ra) # 3000 <to_lower>
    3078:	0ff4f493          	andi	s1,s1,255
    307c:	0ff57513          	andi	a0,a0,255
}
    3080:	40a4853b          	subw	a0,s1,a0
    3084:	70a2                	ld	ra,40(sp)
    3086:	7402                	ld	s0,32(sp)
    3088:	64e2                	ld	s1,24(sp)
    308a:	6942                	ld	s2,16(sp)
    308c:	69a2                	ld	s3,8(sp)
    308e:	6a02                	ld	s4,0(sp)
    3090:	6145                	addi	sp,sp,48
    3092:	8082                	ret

0000000000003094 <print_str>:

// Helper function to print line depending on flags for uniq command
void print_str(const char *str, const int repeated, const int printed, const int c_flag, const int d_flag) {
  if (!printed) {
    3094:	ea39                	bnez	a2,30ea <print_str+0x56>
void print_str(const char *str, const int repeated, const int printed, const int c_flag, const int d_flag) {
    3096:	7179                	addi	sp,sp,-48
    3098:	f406                	sd	ra,40(sp)
    309a:	f022                	sd	s0,32(sp)
    309c:	ec26                	sd	s1,24(sp)
    309e:	e84a                	sd	s2,16(sp)
    30a0:	e44e                	sd	s3,8(sp)
    30a2:	1800                	addi	s0,sp,48
    30a4:	89aa                	mv	s3,a0
    30a6:	84ae                	mv	s1,a1
    30a8:	893a                	mv	s2,a4
    if (c_flag) { 
    30aa:	ce89                	beqz	a3,30c4 <print_str+0x30>
      // if d_flag and line is not repeated, don't print non-duplicate lines
      if (repeated || !d_flag)
    30ac:	e191                	bnez	a1,30b0 <print_str+0x1c>
    30ae:	e71d                	bnez	a4,30dc <print_str+0x48>
        printf("%d ", repeated + 1);
    30b0:	0014859b          	addiw	a1,s1,1
    30b4:	00001517          	auipc	a0,0x1
    30b8:	adc50513          	addi	a0,a0,-1316 # 3b90 <malloc+0xe8>
    30bc:	00001097          	auipc	ra,0x1
    30c0:	92e080e7          	jalr	-1746(ra) # 39ea <printf>
    }
    if (repeated || !d_flag) 
    30c4:	e099                	bnez	s1,30ca <print_str+0x36>
    30c6:	00091b63          	bnez	s2,30dc <print_str+0x48>
      printf("%s", str);
    30ca:	85ce                	mv	a1,s3
    30cc:	00001517          	auipc	a0,0x1
    30d0:	acc50513          	addi	a0,a0,-1332 # 3b98 <malloc+0xf0>
    30d4:	00001097          	auipc	ra,0x1
    30d8:	916080e7          	jalr	-1770(ra) # 39ea <printf>
  } 
}
    30dc:	70a2                	ld	ra,40(sp)
    30de:	7402                	ld	s0,32(sp)
    30e0:	64e2                	ld	s1,24(sp)
    30e2:	6942                	ld	s2,16(sp)
    30e4:	69a2                	ld	s3,8(sp)
    30e6:	6145                	addi	sp,sp,48
    30e8:	8082                	ret
    30ea:	8082                	ret

00000000000030ec <uniq>:

void uniq(int fd, int c_flag, int d_flag, int i_flag) {
    30ec:	9a010113          	addi	sp,sp,-1632
    30f0:	64113c23          	sd	ra,1624(sp)
    30f4:	64813823          	sd	s0,1616(sp)
    30f8:	64913423          	sd	s1,1608(sp)
    30fc:	65213023          	sd	s2,1600(sp)
    3100:	63313c23          	sd	s3,1592(sp)
    3104:	63413823          	sd	s4,1584(sp)
    3108:	63513423          	sd	s5,1576(sp)
    310c:	63613023          	sd	s6,1568(sp)
    3110:	61713c23          	sd	s7,1560(sp)
    3114:	61813823          	sd	s8,1552(sp)
    3118:	61913423          	sd	s9,1544(sp)
    311c:	61a13023          	sd	s10,1536(sp)
    3120:	66010413          	addi	s0,sp,1632
    3124:	8d2a                	mv	s10,a0
    3126:	8cae                	mv	s9,a1
    3128:	8c32                	mv	s8,a2
    312a:	8b36                	mv	s6,a3
  char buf[BUF_SIZE]; 
  char line[BUF_SIZE];
  char prev_line[BUF_SIZE] = ""; 
    312c:	9a043023          	sd	zero,-1632(s0)
    3130:	1f800613          	li	a2,504
    3134:	4581                	li	a1,0
    3136:	9a840513          	addi	a0,s0,-1624
    313a:	00000097          	auipc	ra,0x0
    313e:	2b4080e7          	jalr	692(ra) # 33ee <memset>
  int repeated = 0, n, i, j, printed = 1;  
    3142:	4b85                	li	s7,1
    3144:	4a01                	li	s4,0
  
  while ((n = read(fd, buf, BUF_SIZE)) > 0) {
    for (i = 0, j = 0; i < n; i++) {
    3146:	4a81                	li	s5,0
  while ((n = read(fd, buf, BUF_SIZE)) > 0) {
    3148:	a841                	j	31d8 <uniq+0xec>
      line[j++] = buf[i]; 
      if (buf[i] == '\n') {
        line[j] = '\0';  
        int res = i_flag ? my_strcasecmp(line, prev_line) : strcmp(line, prev_line); 
    314a:	9a040593          	addi	a1,s0,-1632
    314e:	ba040513          	addi	a0,s0,-1120
    3152:	00000097          	auipc	ra,0x0
    3156:	246080e7          	jalr	582(ra) # 3398 <strcmp>
        if (!res) {
    315a:	ed1d                	bnez	a0,3198 <uniq+0xac>
          repeated++; 
    315c:	2a05                	addiw	s4,s4,1
    for (i = 0, j = 0; i < n; i++) {
    315e:	0485                	addi	s1,s1,1
    3160:	06990263          	beq	s2,s1,31c4 <uniq+0xd8>
      line[j++] = buf[i]; 
    3164:	0015079b          	addiw	a5,a0,1
    3168:	0004c703          	lbu	a4,0(s1)
    316c:	fa040693          	addi	a3,s0,-96
    3170:	9536                	add	a0,a0,a3
    3172:	c0e50023          	sb	a4,-1024(a0)
    3176:	853e                	mv	a0,a5
      if (buf[i] == '\n') {
    3178:	ff3713e3          	bne	a4,s3,315e <uniq+0x72>
        line[j] = '\0';  
    317c:	97b6                	add	a5,a5,a3
    317e:	c0078023          	sb	zero,-1024(a5)
        int res = i_flag ? my_strcasecmp(line, prev_line) : strcmp(line, prev_line); 
    3182:	fc0b04e3          	beqz	s6,314a <uniq+0x5e>
    3186:	9a040593          	addi	a1,s0,-1632
    318a:	ba040513          	addi	a0,s0,-1120
    318e:	00000097          	auipc	ra,0x0
    3192:	e8e080e7          	jalr	-370(ra) # 301c <my_strcasecmp>
    3196:	b7d1                	j	315a <uniq+0x6e>
        } else {
          print_str(prev_line, repeated, printed, c_flag, d_flag); 
    3198:	8762                	mv	a4,s8
    319a:	86e6                	mv	a3,s9
    319c:	865e                	mv	a2,s7
    319e:	85d2                	mv	a1,s4
    31a0:	9a040513          	addi	a0,s0,-1632
    31a4:	00000097          	auipc	ra,0x0
    31a8:	ef0080e7          	jalr	-272(ra) # 3094 <print_str>
          strcpy(prev_line, line);
    31ac:	ba040593          	addi	a1,s0,-1120
    31b0:	9a040513          	addi	a0,s0,-1632
    31b4:	00000097          	auipc	ra,0x0
    31b8:	1c8080e7          	jalr	456(ra) # 337c <strcpy>
          repeated = 0;
          printed = 0; 	  
    31bc:	8bd6                	mv	s7,s5
        } 
        j = 0; 
    31be:	8556                	mv	a0,s5
          repeated = 0;
    31c0:	8a56                	mv	s4,s5
    31c2:	bf71                	j	315e <uniq+0x72>
      }
    }
    // for last line
    print_str(prev_line, repeated, printed, c_flag, d_flag); 
    31c4:	8762                	mv	a4,s8
    31c6:	86e6                	mv	a3,s9
    31c8:	865e                	mv	a2,s7
    31ca:	85d2                	mv	a1,s4
    31cc:	9a040513          	addi	a0,s0,-1632
    31d0:	00000097          	auipc	ra,0x0
    31d4:	ec4080e7          	jalr	-316(ra) # 3094 <print_str>
  while ((n = read(fd, buf, BUF_SIZE)) > 0) {
    31d8:	20000613          	li	a2,512
    31dc:	da040593          	addi	a1,s0,-608
    31e0:	856a                	mv	a0,s10
    31e2:	00000097          	auipc	ra,0x0
    31e6:	480080e7          	jalr	1152(ra) # 3662 <read>
    31ea:	00a05f63          	blez	a0,3208 <uniq+0x11c>
    for (i = 0, j = 0; i < n; i++) {
    31ee:	da040493          	addi	s1,s0,-608
    31f2:	fff5091b          	addiw	s2,a0,-1
    31f6:	1902                	slli	s2,s2,0x20
    31f8:	02095913          	srli	s2,s2,0x20
    31fc:	da140793          	addi	a5,s0,-607
    3200:	993e                	add	s2,s2,a5
    3202:	8556                	mv	a0,s5
      if (buf[i] == '\n') {
    3204:	49a9                	li	s3,10
    3206:	bfb9                	j	3164 <uniq+0x78>
  } 
}
    3208:	65813083          	ld	ra,1624(sp)
    320c:	65013403          	ld	s0,1616(sp)
    3210:	64813483          	ld	s1,1608(sp)
    3214:	64013903          	ld	s2,1600(sp)
    3218:	63813983          	ld	s3,1592(sp)
    321c:	63013a03          	ld	s4,1584(sp)
    3220:	62813a83          	ld	s5,1576(sp)
    3224:	62013b03          	ld	s6,1568(sp)
    3228:	61813b83          	ld	s7,1560(sp)
    322c:	61013c03          	ld	s8,1552(sp)
    3230:	60813c83          	ld	s9,1544(sp)
    3234:	60013d03          	ld	s10,1536(sp)
    3238:	66010113          	addi	sp,sp,1632
    323c:	8082                	ret

000000000000323e <main>:

int main(int argc, char *argv[]) {
    323e:	7139                	addi	sp,sp,-64
    3240:	fc06                	sd	ra,56(sp)
    3242:	f822                	sd	s0,48(sp)
    3244:	f426                	sd	s1,40(sp)
    3246:	f04a                	sd	s2,32(sp)
    3248:	ec4e                	sd	s3,24(sp)
    324a:	e852                	sd	s4,16(sp)
    324c:	e456                	sd	s5,8(sp)
    324e:	0080                	addi	s0,sp,64
    3250:	84aa                	mv	s1,a0
    3252:	892e                	mv	s2,a1
  int fd, c_flag = 0, d_flag = 0, i_flag = 0; 

  printf("Uniq command is getting executed in user mode.\n");
    3254:	00001517          	auipc	a0,0x1
    3258:	94c50513          	addi	a0,a0,-1716 # 3ba0 <malloc+0xf8>
    325c:	00000097          	auipc	ra,0x0
    3260:	78e080e7          	jalr	1934(ra) # 39ea <printf>

  // Read from standard input
  if (argc <= 1) {
    3264:	4785                	li	a5,1
    3266:	0297d963          	bge	a5,s1,3298 <main+0x5a>
    326a:	00890893          	addi	a7,s2,8
    326e:	ffe4881b          	addiw	a6,s1,-2
    3272:	1802                	slli	a6,a6,0x20
    3274:	02085813          	srli	a6,a6,0x20
    3278:	080e                	slli	a6,a6,0x3
    327a:	0941                	addi	s2,s2,16
    327c:	984a                	add	a6,a6,s2
  int fd, c_flag = 0, d_flag = 0, i_flag = 0; 
    327e:	4481                	li	s1,0
    3280:	4981                	li	s3,0
    3282:	4901                	li	s2,0

  int i, j;
  // Process flags and text file in format (allow only 1 file with multi flags)
  // uniq [-c | -d | -i] filename.extension
  for (i = 1; i < argc; i++) {
    if (argv[i][0] == '-') {
    3284:	02d00313          	li	t1,45
      for (j = 1; argv[i][j] != '\0'; j++) {
        if (argv[i][j] == 'c') 
    3288:	06300793          	li	a5,99
          c_flag = 1;
    328c:	4705                	li	a4,1
        else if (argv[i][j] == 'd')
    328e:	06400693          	li	a3,100
          d_flag = 1;
        else if (argv[i][j] == 'i')
    3292:	06900613          	li	a2,105
    3296:	a06d                	j	3340 <main+0x102>
    uniq(0, c_flag, d_flag, i_flag); 
    3298:	4681                	li	a3,0
    329a:	4601                	li	a2,0
    329c:	4581                	li	a1,0
    329e:	4501                	li	a0,0
    32a0:	00000097          	auipc	ra,0x0
    32a4:	e4c080e7          	jalr	-436(ra) # 30ec <uniq>
    exit(0); 
    32a8:	4501                	li	a0,0
    32aa:	00000097          	auipc	ra,0x0
    32ae:	398080e7          	jalr	920(ra) # 3642 <exit>
          i_flag = 1; 
        else {
          printf("uniq: invalid option -%c\n", argv[i][j]); 
    32b2:	00001517          	auipc	a0,0x1
    32b6:	91e50513          	addi	a0,a0,-1762 # 3bd0 <malloc+0x128>
    32ba:	00000097          	auipc	ra,0x0
    32be:	730080e7          	jalr	1840(ra) # 39ea <printf>
          exit(1);
    32c2:	4505                	li	a0,1
    32c4:	00000097          	auipc	ra,0x0
    32c8:	37e080e7          	jalr	894(ra) # 3642 <exit>
          c_flag = 1;
    32cc:	893a                	mv	s2,a4
      for (j = 1; argv[i][j] != '\0'; j++) {
    32ce:	0505                	addi	a0,a0,1
    32d0:	fff54583          	lbu	a1,-1(a0)
    32d4:	c1bd                	beqz	a1,333a <main+0xfc>
        if (argv[i][j] == 'c') 
    32d6:	fef58be3          	beq	a1,a5,32cc <main+0x8e>
        else if (argv[i][j] == 'd')
    32da:	00d58663          	beq	a1,a3,32e6 <main+0xa8>
        else if (argv[i][j] == 'i')
    32de:	fcc59ae3          	bne	a1,a2,32b2 <main+0x74>
          i_flag = 1; 
    32e2:	84ba                	mv	s1,a4
    32e4:	b7ed                	j	32ce <main+0x90>
          d_flag = 1;
    32e6:	89ba                	mv	s3,a4
    32e8:	b7dd                	j	32ce <main+0x90>
        }
      }
    } else {
      if ((fd = open(argv[i], 0)) < 0) {
    32ea:	4581                	li	a1,0
    32ec:	00000097          	auipc	ra,0x0
    32f0:	39e080e7          	jalr	926(ra) # 368a <open>
    32f4:	8aaa                	mv	s5,a0
    32f6:	02054363          	bltz	a0,331c <main+0xde>
        printf("uniq: cannot open %s\n", argv[i]); 
	      exit(1);
      }
      uniq(fd, c_flag, d_flag, i_flag); 
    32fa:	86a6                	mv	a3,s1
    32fc:	864e                	mv	a2,s3
    32fe:	85ca                	mv	a1,s2
    3300:	00000097          	auipc	ra,0x0
    3304:	dec080e7          	jalr	-532(ra) # 30ec <uniq>
      close(fd);
    3308:	8556                	mv	a0,s5
    330a:	00000097          	auipc	ra,0x0
    330e:	368080e7          	jalr	872(ra) # 3672 <close>
      exit(0);  
    3312:	4501                	li	a0,0
    3314:	00000097          	auipc	ra,0x0
    3318:	32e080e7          	jalr	814(ra) # 3642 <exit>
        printf("uniq: cannot open %s\n", argv[i]); 
    331c:	000a3583          	ld	a1,0(s4)
    3320:	00001517          	auipc	a0,0x1
    3324:	8d050513          	addi	a0,a0,-1840 # 3bf0 <malloc+0x148>
    3328:	00000097          	auipc	ra,0x0
    332c:	6c2080e7          	jalr	1730(ra) # 39ea <printf>
	      exit(1);
    3330:	4505                	li	a0,1
    3332:	00000097          	auipc	ra,0x0
    3336:	310080e7          	jalr	784(ra) # 3642 <exit>
  for (i = 1; i < argc; i++) {
    333a:	08a1                	addi	a7,a7,8
    333c:	01088e63          	beq	a7,a6,3358 <main+0x11a>
    if (argv[i][0] == '-') {
    3340:	8a46                	mv	s4,a7
    3342:	0008b503          	ld	a0,0(a7)
    3346:	00054583          	lbu	a1,0(a0)
    334a:	fa6590e3          	bne	a1,t1,32ea <main+0xac>
      for (j = 1; argv[i][j] != '\0'; j++) {
    334e:	00154583          	lbu	a1,1(a0)
    3352:	d5e5                	beqz	a1,333a <main+0xfc>
    3354:	0509                	addi	a0,a0,2
    3356:	b741                	j	32d6 <main+0x98>
    }
  }
  exit(0); 
    3358:	4501                	li	a0,0
    335a:	00000097          	auipc	ra,0x0
    335e:	2e8080e7          	jalr	744(ra) # 3642 <exit>

0000000000003362 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    3362:	1141                	addi	sp,sp,-16
    3364:	e406                	sd	ra,8(sp)
    3366:	e022                	sd	s0,0(sp)
    3368:	0800                	addi	s0,sp,16
  extern int main();
  main();
    336a:	00000097          	auipc	ra,0x0
    336e:	ed4080e7          	jalr	-300(ra) # 323e <main>
  exit(0);
    3372:	4501                	li	a0,0
    3374:	00000097          	auipc	ra,0x0
    3378:	2ce080e7          	jalr	718(ra) # 3642 <exit>

000000000000337c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    337c:	1141                	addi	sp,sp,-16
    337e:	e422                	sd	s0,8(sp)
    3380:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3382:	87aa                	mv	a5,a0
    3384:	0585                	addi	a1,a1,1
    3386:	0785                	addi	a5,a5,1
    3388:	fff5c703          	lbu	a4,-1(a1)
    338c:	fee78fa3          	sb	a4,-1(a5)
    3390:	fb75                	bnez	a4,3384 <strcpy+0x8>
    ;
  return os;
}
    3392:	6422                	ld	s0,8(sp)
    3394:	0141                	addi	sp,sp,16
    3396:	8082                	ret

0000000000003398 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3398:	1141                	addi	sp,sp,-16
    339a:	e422                	sd	s0,8(sp)
    339c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    339e:	00054783          	lbu	a5,0(a0)
    33a2:	cb91                	beqz	a5,33b6 <strcmp+0x1e>
    33a4:	0005c703          	lbu	a4,0(a1)
    33a8:	00f71763          	bne	a4,a5,33b6 <strcmp+0x1e>
    p++, q++;
    33ac:	0505                	addi	a0,a0,1
    33ae:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    33b0:	00054783          	lbu	a5,0(a0)
    33b4:	fbe5                	bnez	a5,33a4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    33b6:	0005c503          	lbu	a0,0(a1)
}
    33ba:	40a7853b          	subw	a0,a5,a0
    33be:	6422                	ld	s0,8(sp)
    33c0:	0141                	addi	sp,sp,16
    33c2:	8082                	ret

00000000000033c4 <strlen>:

uint
strlen(const char *s)
{
    33c4:	1141                	addi	sp,sp,-16
    33c6:	e422                	sd	s0,8(sp)
    33c8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    33ca:	00054783          	lbu	a5,0(a0)
    33ce:	cf91                	beqz	a5,33ea <strlen+0x26>
    33d0:	0505                	addi	a0,a0,1
    33d2:	87aa                	mv	a5,a0
    33d4:	4685                	li	a3,1
    33d6:	9e89                	subw	a3,a3,a0
    33d8:	00f6853b          	addw	a0,a3,a5
    33dc:	0785                	addi	a5,a5,1
    33de:	fff7c703          	lbu	a4,-1(a5)
    33e2:	fb7d                	bnez	a4,33d8 <strlen+0x14>
    ;
  return n;
}
    33e4:	6422                	ld	s0,8(sp)
    33e6:	0141                	addi	sp,sp,16
    33e8:	8082                	ret
  for(n = 0; s[n]; n++)
    33ea:	4501                	li	a0,0
    33ec:	bfe5                	j	33e4 <strlen+0x20>

00000000000033ee <memset>:

void*
memset(void *dst, int c, uint n)
{
    33ee:	1141                	addi	sp,sp,-16
    33f0:	e422                	sd	s0,8(sp)
    33f2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    33f4:	ca19                	beqz	a2,340a <memset+0x1c>
    33f6:	87aa                	mv	a5,a0
    33f8:	1602                	slli	a2,a2,0x20
    33fa:	9201                	srli	a2,a2,0x20
    33fc:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    3400:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    3404:	0785                	addi	a5,a5,1
    3406:	fee79de3          	bne	a5,a4,3400 <memset+0x12>
  }
  return dst;
}
    340a:	6422                	ld	s0,8(sp)
    340c:	0141                	addi	sp,sp,16
    340e:	8082                	ret

0000000000003410 <strchr>:

char*
strchr(const char *s, char c)
{
    3410:	1141                	addi	sp,sp,-16
    3412:	e422                	sd	s0,8(sp)
    3414:	0800                	addi	s0,sp,16
  for(; *s; s++)
    3416:	00054783          	lbu	a5,0(a0)
    341a:	cb99                	beqz	a5,3430 <strchr+0x20>
    if(*s == c)
    341c:	00f58763          	beq	a1,a5,342a <strchr+0x1a>
  for(; *s; s++)
    3420:	0505                	addi	a0,a0,1
    3422:	00054783          	lbu	a5,0(a0)
    3426:	fbfd                	bnez	a5,341c <strchr+0xc>
      return (char*)s;
  return 0;
    3428:	4501                	li	a0,0
}
    342a:	6422                	ld	s0,8(sp)
    342c:	0141                	addi	sp,sp,16
    342e:	8082                	ret
  return 0;
    3430:	4501                	li	a0,0
    3432:	bfe5                	j	342a <strchr+0x1a>

0000000000003434 <gets>:

char*
gets(char *buf, int max)
{
    3434:	711d                	addi	sp,sp,-96
    3436:	ec86                	sd	ra,88(sp)
    3438:	e8a2                	sd	s0,80(sp)
    343a:	e4a6                	sd	s1,72(sp)
    343c:	e0ca                	sd	s2,64(sp)
    343e:	fc4e                	sd	s3,56(sp)
    3440:	f852                	sd	s4,48(sp)
    3442:	f456                	sd	s5,40(sp)
    3444:	f05a                	sd	s6,32(sp)
    3446:	ec5e                	sd	s7,24(sp)
    3448:	1080                	addi	s0,sp,96
    344a:	8baa                	mv	s7,a0
    344c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    344e:	892a                	mv	s2,a0
    3450:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3452:	4aa9                	li	s5,10
    3454:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    3456:	89a6                	mv	s3,s1
    3458:	2485                	addiw	s1,s1,1
    345a:	0344d863          	bge	s1,s4,348a <gets+0x56>
    cc = read(0, &c, 1);
    345e:	4605                	li	a2,1
    3460:	faf40593          	addi	a1,s0,-81
    3464:	4501                	li	a0,0
    3466:	00000097          	auipc	ra,0x0
    346a:	1fc080e7          	jalr	508(ra) # 3662 <read>
    if(cc < 1)
    346e:	00a05e63          	blez	a0,348a <gets+0x56>
    buf[i++] = c;
    3472:	faf44783          	lbu	a5,-81(s0)
    3476:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    347a:	01578763          	beq	a5,s5,3488 <gets+0x54>
    347e:	0905                	addi	s2,s2,1
    3480:	fd679be3          	bne	a5,s6,3456 <gets+0x22>
  for(i=0; i+1 < max; ){
    3484:	89a6                	mv	s3,s1
    3486:	a011                	j	348a <gets+0x56>
    3488:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    348a:	99de                	add	s3,s3,s7
    348c:	00098023          	sb	zero,0(s3)
  return buf;
}
    3490:	855e                	mv	a0,s7
    3492:	60e6                	ld	ra,88(sp)
    3494:	6446                	ld	s0,80(sp)
    3496:	64a6                	ld	s1,72(sp)
    3498:	6906                	ld	s2,64(sp)
    349a:	79e2                	ld	s3,56(sp)
    349c:	7a42                	ld	s4,48(sp)
    349e:	7aa2                	ld	s5,40(sp)
    34a0:	7b02                	ld	s6,32(sp)
    34a2:	6be2                	ld	s7,24(sp)
    34a4:	6125                	addi	sp,sp,96
    34a6:	8082                	ret

00000000000034a8 <stat>:

int
stat(const char *n, struct stat *st)
{
    34a8:	1101                	addi	sp,sp,-32
    34aa:	ec06                	sd	ra,24(sp)
    34ac:	e822                	sd	s0,16(sp)
    34ae:	e426                	sd	s1,8(sp)
    34b0:	e04a                	sd	s2,0(sp)
    34b2:	1000                	addi	s0,sp,32
    34b4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    34b6:	4581                	li	a1,0
    34b8:	00000097          	auipc	ra,0x0
    34bc:	1d2080e7          	jalr	466(ra) # 368a <open>
  if(fd < 0)
    34c0:	02054563          	bltz	a0,34ea <stat+0x42>
    34c4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    34c6:	85ca                	mv	a1,s2
    34c8:	00000097          	auipc	ra,0x0
    34cc:	1da080e7          	jalr	474(ra) # 36a2 <fstat>
    34d0:	892a                	mv	s2,a0
  close(fd);
    34d2:	8526                	mv	a0,s1
    34d4:	00000097          	auipc	ra,0x0
    34d8:	19e080e7          	jalr	414(ra) # 3672 <close>
  return r;
}
    34dc:	854a                	mv	a0,s2
    34de:	60e2                	ld	ra,24(sp)
    34e0:	6442                	ld	s0,16(sp)
    34e2:	64a2                	ld	s1,8(sp)
    34e4:	6902                	ld	s2,0(sp)
    34e6:	6105                	addi	sp,sp,32
    34e8:	8082                	ret
    return -1;
    34ea:	597d                	li	s2,-1
    34ec:	bfc5                	j	34dc <stat+0x34>

00000000000034ee <atoi>:

int
atoi(const char *s)
{
    34ee:	1141                	addi	sp,sp,-16
    34f0:	e422                	sd	s0,8(sp)
    34f2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    34f4:	00054603          	lbu	a2,0(a0)
    34f8:	fd06079b          	addiw	a5,a2,-48
    34fc:	0ff7f793          	andi	a5,a5,255
    3500:	4725                	li	a4,9
    3502:	02f76963          	bltu	a4,a5,3534 <atoi+0x46>
    3506:	86aa                	mv	a3,a0
  n = 0;
    3508:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    350a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    350c:	0685                	addi	a3,a3,1
    350e:	0025179b          	slliw	a5,a0,0x2
    3512:	9fa9                	addw	a5,a5,a0
    3514:	0017979b          	slliw	a5,a5,0x1
    3518:	9fb1                	addw	a5,a5,a2
    351a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    351e:	0006c603          	lbu	a2,0(a3)
    3522:	fd06071b          	addiw	a4,a2,-48
    3526:	0ff77713          	andi	a4,a4,255
    352a:	fee5f1e3          	bgeu	a1,a4,350c <atoi+0x1e>
  return n;
}
    352e:	6422                	ld	s0,8(sp)
    3530:	0141                	addi	sp,sp,16
    3532:	8082                	ret
  n = 0;
    3534:	4501                	li	a0,0
    3536:	bfe5                	j	352e <atoi+0x40>

0000000000003538 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3538:	1141                	addi	sp,sp,-16
    353a:	e422                	sd	s0,8(sp)
    353c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    353e:	02b57463          	bgeu	a0,a1,3566 <memmove+0x2e>
    while(n-- > 0)
    3542:	00c05f63          	blez	a2,3560 <memmove+0x28>
    3546:	1602                	slli	a2,a2,0x20
    3548:	9201                	srli	a2,a2,0x20
    354a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    354e:	872a                	mv	a4,a0
      *dst++ = *src++;
    3550:	0585                	addi	a1,a1,1
    3552:	0705                	addi	a4,a4,1
    3554:	fff5c683          	lbu	a3,-1(a1)
    3558:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    355c:	fee79ae3          	bne	a5,a4,3550 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    3560:	6422                	ld	s0,8(sp)
    3562:	0141                	addi	sp,sp,16
    3564:	8082                	ret
    dst += n;
    3566:	00c50733          	add	a4,a0,a2
    src += n;
    356a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    356c:	fec05ae3          	blez	a2,3560 <memmove+0x28>
    3570:	fff6079b          	addiw	a5,a2,-1
    3574:	1782                	slli	a5,a5,0x20
    3576:	9381                	srli	a5,a5,0x20
    3578:	fff7c793          	not	a5,a5
    357c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    357e:	15fd                	addi	a1,a1,-1
    3580:	177d                	addi	a4,a4,-1
    3582:	0005c683          	lbu	a3,0(a1)
    3586:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    358a:	fee79ae3          	bne	a5,a4,357e <memmove+0x46>
    358e:	bfc9                	j	3560 <memmove+0x28>

0000000000003590 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    3590:	1141                	addi	sp,sp,-16
    3592:	e422                	sd	s0,8(sp)
    3594:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    3596:	ca05                	beqz	a2,35c6 <memcmp+0x36>
    3598:	fff6069b          	addiw	a3,a2,-1
    359c:	1682                	slli	a3,a3,0x20
    359e:	9281                	srli	a3,a3,0x20
    35a0:	0685                	addi	a3,a3,1
    35a2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    35a4:	00054783          	lbu	a5,0(a0)
    35a8:	0005c703          	lbu	a4,0(a1)
    35ac:	00e79863          	bne	a5,a4,35bc <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    35b0:	0505                	addi	a0,a0,1
    p2++;
    35b2:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    35b4:	fed518e3          	bne	a0,a3,35a4 <memcmp+0x14>
  }
  return 0;
    35b8:	4501                	li	a0,0
    35ba:	a019                	j	35c0 <memcmp+0x30>
      return *p1 - *p2;
    35bc:	40e7853b          	subw	a0,a5,a4
}
    35c0:	6422                	ld	s0,8(sp)
    35c2:	0141                	addi	sp,sp,16
    35c4:	8082                	ret
  return 0;
    35c6:	4501                	li	a0,0
    35c8:	bfe5                	j	35c0 <memcmp+0x30>

00000000000035ca <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    35ca:	1141                	addi	sp,sp,-16
    35cc:	e406                	sd	ra,8(sp)
    35ce:	e022                	sd	s0,0(sp)
    35d0:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    35d2:	00000097          	auipc	ra,0x0
    35d6:	f66080e7          	jalr	-154(ra) # 3538 <memmove>
}
    35da:	60a2                	ld	ra,8(sp)
    35dc:	6402                	ld	s0,0(sp)
    35de:	0141                	addi	sp,sp,16
    35e0:	8082                	ret

00000000000035e2 <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    35e2:	1141                	addi	sp,sp,-16
    35e4:	e422                	sd	s0,8(sp)
    35e6:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    35e8:	00052023          	sw	zero,0(a0)
}  
    35ec:	6422                	ld	s0,8(sp)
    35ee:	0141                	addi	sp,sp,16
    35f0:	8082                	ret

00000000000035f2 <lock>:

void lock(struct spinlock * lk) 
{    
    35f2:	1141                	addi	sp,sp,-16
    35f4:	e422                	sd	s0,8(sp)
    35f6:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    35f8:	4705                	li	a4,1
    35fa:	87ba                	mv	a5,a4
    35fc:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    3600:	2781                	sext.w	a5,a5
    3602:	ffe5                	bnez	a5,35fa <lock+0x8>
}  
    3604:	6422                	ld	s0,8(sp)
    3606:	0141                	addi	sp,sp,16
    3608:	8082                	ret

000000000000360a <unlock>:

void unlock(struct spinlock * lk) 
{   
    360a:	1141                	addi	sp,sp,-16
    360c:	e422                	sd	s0,8(sp)
    360e:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    3610:	0f50000f          	fence	iorw,ow
    3614:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    3618:	6422                	ld	s0,8(sp)
    361a:	0141                	addi	sp,sp,16
    361c:	8082                	ret

000000000000361e <isDigit>:

unsigned int isDigit(char *c) {
    361e:	1141                	addi	sp,sp,-16
    3620:	e422                	sd	s0,8(sp)
    3622:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    3624:	00054503          	lbu	a0,0(a0)
    3628:	fd05051b          	addiw	a0,a0,-48
    362c:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    3630:	00a53513          	sltiu	a0,a0,10
    3634:	6422                	ld	s0,8(sp)
    3636:	0141                	addi	sp,sp,16
    3638:	8082                	ret

000000000000363a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    363a:	4885                	li	a7,1
 ecall
    363c:	00000073          	ecall
 ret
    3640:	8082                	ret

0000000000003642 <exit>:
.global exit
exit:
 li a7, SYS_exit
    3642:	4889                	li	a7,2
 ecall
    3644:	00000073          	ecall
 ret
    3648:	8082                	ret

000000000000364a <wait>:
.global wait
wait:
 li a7, SYS_wait
    364a:	488d                	li	a7,3
 ecall
    364c:	00000073          	ecall
 ret
    3650:	8082                	ret

0000000000003652 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    3652:	48e1                	li	a7,24
 ecall
    3654:	00000073          	ecall
 ret
    3658:	8082                	ret

000000000000365a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    365a:	4891                	li	a7,4
 ecall
    365c:	00000073          	ecall
 ret
    3660:	8082                	ret

0000000000003662 <read>:
.global read
read:
 li a7, SYS_read
    3662:	4895                	li	a7,5
 ecall
    3664:	00000073          	ecall
 ret
    3668:	8082                	ret

000000000000366a <write>:
.global write
write:
 li a7, SYS_write
    366a:	48c1                	li	a7,16
 ecall
    366c:	00000073          	ecall
 ret
    3670:	8082                	ret

0000000000003672 <close>:
.global close
close:
 li a7, SYS_close
    3672:	48d5                	li	a7,21
 ecall
    3674:	00000073          	ecall
 ret
    3678:	8082                	ret

000000000000367a <kill>:
.global kill
kill:
 li a7, SYS_kill
    367a:	4899                	li	a7,6
 ecall
    367c:	00000073          	ecall
 ret
    3680:	8082                	ret

0000000000003682 <exec>:
.global exec
exec:
 li a7, SYS_exec
    3682:	489d                	li	a7,7
 ecall
    3684:	00000073          	ecall
 ret
    3688:	8082                	ret

000000000000368a <open>:
.global open
open:
 li a7, SYS_open
    368a:	48bd                	li	a7,15
 ecall
    368c:	00000073          	ecall
 ret
    3690:	8082                	ret

0000000000003692 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    3692:	48c5                	li	a7,17
 ecall
    3694:	00000073          	ecall
 ret
    3698:	8082                	ret

000000000000369a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    369a:	48c9                	li	a7,18
 ecall
    369c:	00000073          	ecall
 ret
    36a0:	8082                	ret

00000000000036a2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    36a2:	48a1                	li	a7,8
 ecall
    36a4:	00000073          	ecall
 ret
    36a8:	8082                	ret

00000000000036aa <link>:
.global link
link:
 li a7, SYS_link
    36aa:	48cd                	li	a7,19
 ecall
    36ac:	00000073          	ecall
 ret
    36b0:	8082                	ret

00000000000036b2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    36b2:	48d1                	li	a7,20
 ecall
    36b4:	00000073          	ecall
 ret
    36b8:	8082                	ret

00000000000036ba <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    36ba:	48a5                	li	a7,9
 ecall
    36bc:	00000073          	ecall
 ret
    36c0:	8082                	ret

00000000000036c2 <dup>:
.global dup
dup:
 li a7, SYS_dup
    36c2:	48a9                	li	a7,10
 ecall
    36c4:	00000073          	ecall
 ret
    36c8:	8082                	ret

00000000000036ca <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    36ca:	48ad                	li	a7,11
 ecall
    36cc:	00000073          	ecall
 ret
    36d0:	8082                	ret

00000000000036d2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    36d2:	48b1                	li	a7,12
 ecall
    36d4:	00000073          	ecall
 ret
    36d8:	8082                	ret

00000000000036da <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    36da:	48b5                	li	a7,13
 ecall
    36dc:	00000073          	ecall
 ret
    36e0:	8082                	ret

00000000000036e2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    36e2:	48b9                	li	a7,14
 ecall
    36e4:	00000073          	ecall
 ret
    36e8:	8082                	ret

00000000000036ea <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    36ea:	48d9                	li	a7,22
 ecall
    36ec:	00000073          	ecall
 ret
    36f0:	8082                	ret

00000000000036f2 <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    36f2:	48dd                	li	a7,23
 ecall
    36f4:	00000073          	ecall
 ret
    36f8:	8082                	ret

00000000000036fa <ps>:
.global ps
ps:
 li a7, SYS_ps
    36fa:	48e5                	li	a7,25
 ecall
    36fc:	00000073          	ecall
 ret
    3700:	8082                	ret

0000000000003702 <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    3702:	48e9                	li	a7,26
 ecall
    3704:	00000073          	ecall
 ret
    3708:	8082                	ret

000000000000370a <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    370a:	48ed                	li	a7,27
 ecall
    370c:	00000073          	ecall
 ret
    3710:	8082                	ret

0000000000003712 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    3712:	1101                	addi	sp,sp,-32
    3714:	ec06                	sd	ra,24(sp)
    3716:	e822                	sd	s0,16(sp)
    3718:	1000                	addi	s0,sp,32
    371a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    371e:	4605                	li	a2,1
    3720:	fef40593          	addi	a1,s0,-17
    3724:	00000097          	auipc	ra,0x0
    3728:	f46080e7          	jalr	-186(ra) # 366a <write>
}
    372c:	60e2                	ld	ra,24(sp)
    372e:	6442                	ld	s0,16(sp)
    3730:	6105                	addi	sp,sp,32
    3732:	8082                	ret

0000000000003734 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3734:	7139                	addi	sp,sp,-64
    3736:	fc06                	sd	ra,56(sp)
    3738:	f822                	sd	s0,48(sp)
    373a:	f426                	sd	s1,40(sp)
    373c:	f04a                	sd	s2,32(sp)
    373e:	ec4e                	sd	s3,24(sp)
    3740:	0080                	addi	s0,sp,64
    3742:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3744:	c299                	beqz	a3,374a <printint+0x16>
    3746:	0805c863          	bltz	a1,37d6 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    374a:	2581                	sext.w	a1,a1
  neg = 0;
    374c:	4881                	li	a7,0
    374e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    3752:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    3754:	2601                	sext.w	a2,a2
    3756:	00000517          	auipc	a0,0x0
    375a:	4ba50513          	addi	a0,a0,1210 # 3c10 <digits>
    375e:	883a                	mv	a6,a4
    3760:	2705                	addiw	a4,a4,1
    3762:	02c5f7bb          	remuw	a5,a1,a2
    3766:	1782                	slli	a5,a5,0x20
    3768:	9381                	srli	a5,a5,0x20
    376a:	97aa                	add	a5,a5,a0
    376c:	0007c783          	lbu	a5,0(a5)
    3770:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    3774:	0005879b          	sext.w	a5,a1
    3778:	02c5d5bb          	divuw	a1,a1,a2
    377c:	0685                	addi	a3,a3,1
    377e:	fec7f0e3          	bgeu	a5,a2,375e <printint+0x2a>
  if(neg)
    3782:	00088b63          	beqz	a7,3798 <printint+0x64>
    buf[i++] = '-';
    3786:	fd040793          	addi	a5,s0,-48
    378a:	973e                	add	a4,a4,a5
    378c:	02d00793          	li	a5,45
    3790:	fef70823          	sb	a5,-16(a4)
    3794:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    3798:	02e05863          	blez	a4,37c8 <printint+0x94>
    379c:	fc040793          	addi	a5,s0,-64
    37a0:	00e78933          	add	s2,a5,a4
    37a4:	fff78993          	addi	s3,a5,-1
    37a8:	99ba                	add	s3,s3,a4
    37aa:	377d                	addiw	a4,a4,-1
    37ac:	1702                	slli	a4,a4,0x20
    37ae:	9301                	srli	a4,a4,0x20
    37b0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    37b4:	fff94583          	lbu	a1,-1(s2)
    37b8:	8526                	mv	a0,s1
    37ba:	00000097          	auipc	ra,0x0
    37be:	f58080e7          	jalr	-168(ra) # 3712 <putc>
  while(--i >= 0)
    37c2:	197d                	addi	s2,s2,-1
    37c4:	ff3918e3          	bne	s2,s3,37b4 <printint+0x80>
}
    37c8:	70e2                	ld	ra,56(sp)
    37ca:	7442                	ld	s0,48(sp)
    37cc:	74a2                	ld	s1,40(sp)
    37ce:	7902                	ld	s2,32(sp)
    37d0:	69e2                	ld	s3,24(sp)
    37d2:	6121                	addi	sp,sp,64
    37d4:	8082                	ret
    x = -xx;
    37d6:	40b005bb          	negw	a1,a1
    neg = 1;
    37da:	4885                	li	a7,1
    x = -xx;
    37dc:	bf8d                	j	374e <printint+0x1a>

00000000000037de <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    37de:	7119                	addi	sp,sp,-128
    37e0:	fc86                	sd	ra,120(sp)
    37e2:	f8a2                	sd	s0,112(sp)
    37e4:	f4a6                	sd	s1,104(sp)
    37e6:	f0ca                	sd	s2,96(sp)
    37e8:	ecce                	sd	s3,88(sp)
    37ea:	e8d2                	sd	s4,80(sp)
    37ec:	e4d6                	sd	s5,72(sp)
    37ee:	e0da                	sd	s6,64(sp)
    37f0:	fc5e                	sd	s7,56(sp)
    37f2:	f862                	sd	s8,48(sp)
    37f4:	f466                	sd	s9,40(sp)
    37f6:	f06a                	sd	s10,32(sp)
    37f8:	ec6e                	sd	s11,24(sp)
    37fa:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    37fc:	0005c903          	lbu	s2,0(a1)
    3800:	18090f63          	beqz	s2,399e <vprintf+0x1c0>
    3804:	8aaa                	mv	s5,a0
    3806:	8b32                	mv	s6,a2
    3808:	00158493          	addi	s1,a1,1
  state = 0;
    380c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    380e:	02500a13          	li	s4,37
      if(c == 'd'){
    3812:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    3816:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    381a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    381e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3822:	00000b97          	auipc	s7,0x0
    3826:	3eeb8b93          	addi	s7,s7,1006 # 3c10 <digits>
    382a:	a839                	j	3848 <vprintf+0x6a>
        putc(fd, c);
    382c:	85ca                	mv	a1,s2
    382e:	8556                	mv	a0,s5
    3830:	00000097          	auipc	ra,0x0
    3834:	ee2080e7          	jalr	-286(ra) # 3712 <putc>
    3838:	a019                	j	383e <vprintf+0x60>
    } else if(state == '%'){
    383a:	01498f63          	beq	s3,s4,3858 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    383e:	0485                	addi	s1,s1,1
    3840:	fff4c903          	lbu	s2,-1(s1)
    3844:	14090d63          	beqz	s2,399e <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    3848:	0009079b          	sext.w	a5,s2
    if(state == 0){
    384c:	fe0997e3          	bnez	s3,383a <vprintf+0x5c>
      if(c == '%'){
    3850:	fd479ee3          	bne	a5,s4,382c <vprintf+0x4e>
        state = '%';
    3854:	89be                	mv	s3,a5
    3856:	b7e5                	j	383e <vprintf+0x60>
      if(c == 'd'){
    3858:	05878063          	beq	a5,s8,3898 <vprintf+0xba>
      } else if(c == 'l') {
    385c:	05978c63          	beq	a5,s9,38b4 <vprintf+0xd6>
      } else if(c == 'x') {
    3860:	07a78863          	beq	a5,s10,38d0 <vprintf+0xf2>
      } else if(c == 'p') {
    3864:	09b78463          	beq	a5,s11,38ec <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    3868:	07300713          	li	a4,115
    386c:	0ce78663          	beq	a5,a4,3938 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3870:	06300713          	li	a4,99
    3874:	0ee78e63          	beq	a5,a4,3970 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    3878:	11478863          	beq	a5,s4,3988 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    387c:	85d2                	mv	a1,s4
    387e:	8556                	mv	a0,s5
    3880:	00000097          	auipc	ra,0x0
    3884:	e92080e7          	jalr	-366(ra) # 3712 <putc>
        putc(fd, c);
    3888:	85ca                	mv	a1,s2
    388a:	8556                	mv	a0,s5
    388c:	00000097          	auipc	ra,0x0
    3890:	e86080e7          	jalr	-378(ra) # 3712 <putc>
      }
      state = 0;
    3894:	4981                	li	s3,0
    3896:	b765                	j	383e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    3898:	008b0913          	addi	s2,s6,8
    389c:	4685                	li	a3,1
    389e:	4629                	li	a2,10
    38a0:	000b2583          	lw	a1,0(s6)
    38a4:	8556                	mv	a0,s5
    38a6:	00000097          	auipc	ra,0x0
    38aa:	e8e080e7          	jalr	-370(ra) # 3734 <printint>
    38ae:	8b4a                	mv	s6,s2
      state = 0;
    38b0:	4981                	li	s3,0
    38b2:	b771                	j	383e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    38b4:	008b0913          	addi	s2,s6,8
    38b8:	4681                	li	a3,0
    38ba:	4629                	li	a2,10
    38bc:	000b2583          	lw	a1,0(s6)
    38c0:	8556                	mv	a0,s5
    38c2:	00000097          	auipc	ra,0x0
    38c6:	e72080e7          	jalr	-398(ra) # 3734 <printint>
    38ca:	8b4a                	mv	s6,s2
      state = 0;
    38cc:	4981                	li	s3,0
    38ce:	bf85                	j	383e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    38d0:	008b0913          	addi	s2,s6,8
    38d4:	4681                	li	a3,0
    38d6:	4641                	li	a2,16
    38d8:	000b2583          	lw	a1,0(s6)
    38dc:	8556                	mv	a0,s5
    38de:	00000097          	auipc	ra,0x0
    38e2:	e56080e7          	jalr	-426(ra) # 3734 <printint>
    38e6:	8b4a                	mv	s6,s2
      state = 0;
    38e8:	4981                	li	s3,0
    38ea:	bf91                	j	383e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    38ec:	008b0793          	addi	a5,s6,8
    38f0:	f8f43423          	sd	a5,-120(s0)
    38f4:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    38f8:	03000593          	li	a1,48
    38fc:	8556                	mv	a0,s5
    38fe:	00000097          	auipc	ra,0x0
    3902:	e14080e7          	jalr	-492(ra) # 3712 <putc>
  putc(fd, 'x');
    3906:	85ea                	mv	a1,s10
    3908:	8556                	mv	a0,s5
    390a:	00000097          	auipc	ra,0x0
    390e:	e08080e7          	jalr	-504(ra) # 3712 <putc>
    3912:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3914:	03c9d793          	srli	a5,s3,0x3c
    3918:	97de                	add	a5,a5,s7
    391a:	0007c583          	lbu	a1,0(a5)
    391e:	8556                	mv	a0,s5
    3920:	00000097          	auipc	ra,0x0
    3924:	df2080e7          	jalr	-526(ra) # 3712 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    3928:	0992                	slli	s3,s3,0x4
    392a:	397d                	addiw	s2,s2,-1
    392c:	fe0914e3          	bnez	s2,3914 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    3930:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    3934:	4981                	li	s3,0
    3936:	b721                	j	383e <vprintf+0x60>
        s = va_arg(ap, char*);
    3938:	008b0993          	addi	s3,s6,8
    393c:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    3940:	02090163          	beqz	s2,3962 <vprintf+0x184>
        while(*s != 0){
    3944:	00094583          	lbu	a1,0(s2)
    3948:	c9a1                	beqz	a1,3998 <vprintf+0x1ba>
          putc(fd, *s);
    394a:	8556                	mv	a0,s5
    394c:	00000097          	auipc	ra,0x0
    3950:	dc6080e7          	jalr	-570(ra) # 3712 <putc>
          s++;
    3954:	0905                	addi	s2,s2,1
        while(*s != 0){
    3956:	00094583          	lbu	a1,0(s2)
    395a:	f9e5                	bnez	a1,394a <vprintf+0x16c>
        s = va_arg(ap, char*);
    395c:	8b4e                	mv	s6,s3
      state = 0;
    395e:	4981                	li	s3,0
    3960:	bdf9                	j	383e <vprintf+0x60>
          s = "(null)";
    3962:	00000917          	auipc	s2,0x0
    3966:	2a690913          	addi	s2,s2,678 # 3c08 <malloc+0x160>
        while(*s != 0){
    396a:	02800593          	li	a1,40
    396e:	bff1                	j	394a <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    3970:	008b0913          	addi	s2,s6,8
    3974:	000b4583          	lbu	a1,0(s6)
    3978:	8556                	mv	a0,s5
    397a:	00000097          	auipc	ra,0x0
    397e:	d98080e7          	jalr	-616(ra) # 3712 <putc>
    3982:	8b4a                	mv	s6,s2
      state = 0;
    3984:	4981                	li	s3,0
    3986:	bd65                	j	383e <vprintf+0x60>
        putc(fd, c);
    3988:	85d2                	mv	a1,s4
    398a:	8556                	mv	a0,s5
    398c:	00000097          	auipc	ra,0x0
    3990:	d86080e7          	jalr	-634(ra) # 3712 <putc>
      state = 0;
    3994:	4981                	li	s3,0
    3996:	b565                	j	383e <vprintf+0x60>
        s = va_arg(ap, char*);
    3998:	8b4e                	mv	s6,s3
      state = 0;
    399a:	4981                	li	s3,0
    399c:	b54d                	j	383e <vprintf+0x60>
    }
  }
}
    399e:	70e6                	ld	ra,120(sp)
    39a0:	7446                	ld	s0,112(sp)
    39a2:	74a6                	ld	s1,104(sp)
    39a4:	7906                	ld	s2,96(sp)
    39a6:	69e6                	ld	s3,88(sp)
    39a8:	6a46                	ld	s4,80(sp)
    39aa:	6aa6                	ld	s5,72(sp)
    39ac:	6b06                	ld	s6,64(sp)
    39ae:	7be2                	ld	s7,56(sp)
    39b0:	7c42                	ld	s8,48(sp)
    39b2:	7ca2                	ld	s9,40(sp)
    39b4:	7d02                	ld	s10,32(sp)
    39b6:	6de2                	ld	s11,24(sp)
    39b8:	6109                	addi	sp,sp,128
    39ba:	8082                	ret

00000000000039bc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    39bc:	715d                	addi	sp,sp,-80
    39be:	ec06                	sd	ra,24(sp)
    39c0:	e822                	sd	s0,16(sp)
    39c2:	1000                	addi	s0,sp,32
    39c4:	e010                	sd	a2,0(s0)
    39c6:	e414                	sd	a3,8(s0)
    39c8:	e818                	sd	a4,16(s0)
    39ca:	ec1c                	sd	a5,24(s0)
    39cc:	03043023          	sd	a6,32(s0)
    39d0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    39d4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    39d8:	8622                	mv	a2,s0
    39da:	00000097          	auipc	ra,0x0
    39de:	e04080e7          	jalr	-508(ra) # 37de <vprintf>
}
    39e2:	60e2                	ld	ra,24(sp)
    39e4:	6442                	ld	s0,16(sp)
    39e6:	6161                	addi	sp,sp,80
    39e8:	8082                	ret

00000000000039ea <printf>:

void
printf(const char *fmt, ...)
{
    39ea:	711d                	addi	sp,sp,-96
    39ec:	ec06                	sd	ra,24(sp)
    39ee:	e822                	sd	s0,16(sp)
    39f0:	1000                	addi	s0,sp,32
    39f2:	e40c                	sd	a1,8(s0)
    39f4:	e810                	sd	a2,16(s0)
    39f6:	ec14                	sd	a3,24(s0)
    39f8:	f018                	sd	a4,32(s0)
    39fa:	f41c                	sd	a5,40(s0)
    39fc:	03043823          	sd	a6,48(s0)
    3a00:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    3a04:	00840613          	addi	a2,s0,8
    3a08:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    3a0c:	85aa                	mv	a1,a0
    3a0e:	4505                	li	a0,1
    3a10:	00000097          	auipc	ra,0x0
    3a14:	dce080e7          	jalr	-562(ra) # 37de <vprintf>
}
    3a18:	60e2                	ld	ra,24(sp)
    3a1a:	6442                	ld	s0,16(sp)
    3a1c:	6125                	addi	sp,sp,96
    3a1e:	8082                	ret

0000000000003a20 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3a20:	1141                	addi	sp,sp,-16
    3a22:	e422                	sd	s0,8(sp)
    3a24:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3a26:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3a2a:	00000797          	auipc	a5,0x0
    3a2e:	5d67b783          	ld	a5,1494(a5) # 4000 <freep>
    3a32:	a805                	j	3a62 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3a34:	4618                	lw	a4,8(a2)
    3a36:	9db9                	addw	a1,a1,a4
    3a38:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    3a3c:	6398                	ld	a4,0(a5)
    3a3e:	6318                	ld	a4,0(a4)
    3a40:	fee53823          	sd	a4,-16(a0)
    3a44:	a091                	j	3a88 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3a46:	ff852703          	lw	a4,-8(a0)
    3a4a:	9e39                	addw	a2,a2,a4
    3a4c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    3a4e:	ff053703          	ld	a4,-16(a0)
    3a52:	e398                	sd	a4,0(a5)
    3a54:	a099                	j	3a9a <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3a56:	6398                	ld	a4,0(a5)
    3a58:	00e7e463          	bltu	a5,a4,3a60 <free+0x40>
    3a5c:	00e6ea63          	bltu	a3,a4,3a70 <free+0x50>
{
    3a60:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3a62:	fed7fae3          	bgeu	a5,a3,3a56 <free+0x36>
    3a66:	6398                	ld	a4,0(a5)
    3a68:	00e6e463          	bltu	a3,a4,3a70 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3a6c:	fee7eae3          	bltu	a5,a4,3a60 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    3a70:	ff852583          	lw	a1,-8(a0)
    3a74:	6390                	ld	a2,0(a5)
    3a76:	02059713          	slli	a4,a1,0x20
    3a7a:	9301                	srli	a4,a4,0x20
    3a7c:	0712                	slli	a4,a4,0x4
    3a7e:	9736                	add	a4,a4,a3
    3a80:	fae60ae3          	beq	a2,a4,3a34 <free+0x14>
    bp->s.ptr = p->s.ptr;
    3a84:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    3a88:	4790                	lw	a2,8(a5)
    3a8a:	02061713          	slli	a4,a2,0x20
    3a8e:	9301                	srli	a4,a4,0x20
    3a90:	0712                	slli	a4,a4,0x4
    3a92:	973e                	add	a4,a4,a5
    3a94:	fae689e3          	beq	a3,a4,3a46 <free+0x26>
  } else
    p->s.ptr = bp;
    3a98:	e394                	sd	a3,0(a5)
  freep = p;
    3a9a:	00000717          	auipc	a4,0x0
    3a9e:	56f73323          	sd	a5,1382(a4) # 4000 <freep>
}
    3aa2:	6422                	ld	s0,8(sp)
    3aa4:	0141                	addi	sp,sp,16
    3aa6:	8082                	ret

0000000000003aa8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3aa8:	7139                	addi	sp,sp,-64
    3aaa:	fc06                	sd	ra,56(sp)
    3aac:	f822                	sd	s0,48(sp)
    3aae:	f426                	sd	s1,40(sp)
    3ab0:	f04a                	sd	s2,32(sp)
    3ab2:	ec4e                	sd	s3,24(sp)
    3ab4:	e852                	sd	s4,16(sp)
    3ab6:	e456                	sd	s5,8(sp)
    3ab8:	e05a                	sd	s6,0(sp)
    3aba:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3abc:	02051493          	slli	s1,a0,0x20
    3ac0:	9081                	srli	s1,s1,0x20
    3ac2:	04bd                	addi	s1,s1,15
    3ac4:	8091                	srli	s1,s1,0x4
    3ac6:	0014899b          	addiw	s3,s1,1
    3aca:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    3acc:	00000517          	auipc	a0,0x0
    3ad0:	53453503          	ld	a0,1332(a0) # 4000 <freep>
    3ad4:	c515                	beqz	a0,3b00 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3ad6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3ad8:	4798                	lw	a4,8(a5)
    3ada:	02977f63          	bgeu	a4,s1,3b18 <malloc+0x70>
    3ade:	8a4e                	mv	s4,s3
    3ae0:	0009871b          	sext.w	a4,s3
    3ae4:	6685                	lui	a3,0x1
    3ae6:	00d77363          	bgeu	a4,a3,3aec <malloc+0x44>
    3aea:	6a05                	lui	s4,0x1
    3aec:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    3af0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3af4:	00000917          	auipc	s2,0x0
    3af8:	50c90913          	addi	s2,s2,1292 # 4000 <freep>
  if(p == (char*)-1)
    3afc:	5afd                	li	s5,-1
    3afe:	a88d                	j	3b70 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    3b00:	00000797          	auipc	a5,0x0
    3b04:	51078793          	addi	a5,a5,1296 # 4010 <base>
    3b08:	00000717          	auipc	a4,0x0
    3b0c:	4ef73c23          	sd	a5,1272(a4) # 4000 <freep>
    3b10:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    3b12:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    3b16:	b7e1                	j	3ade <malloc+0x36>
      if(p->s.size == nunits)
    3b18:	02e48b63          	beq	s1,a4,3b4e <malloc+0xa6>
        p->s.size -= nunits;
    3b1c:	4137073b          	subw	a4,a4,s3
    3b20:	c798                	sw	a4,8(a5)
        p += p->s.size;
    3b22:	1702                	slli	a4,a4,0x20
    3b24:	9301                	srli	a4,a4,0x20
    3b26:	0712                	slli	a4,a4,0x4
    3b28:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    3b2a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    3b2e:	00000717          	auipc	a4,0x0
    3b32:	4ca73923          	sd	a0,1234(a4) # 4000 <freep>
      return (void*)(p + 1);
    3b36:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3b3a:	70e2                	ld	ra,56(sp)
    3b3c:	7442                	ld	s0,48(sp)
    3b3e:	74a2                	ld	s1,40(sp)
    3b40:	7902                	ld	s2,32(sp)
    3b42:	69e2                	ld	s3,24(sp)
    3b44:	6a42                	ld	s4,16(sp)
    3b46:	6aa2                	ld	s5,8(sp)
    3b48:	6b02                	ld	s6,0(sp)
    3b4a:	6121                	addi	sp,sp,64
    3b4c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3b4e:	6398                	ld	a4,0(a5)
    3b50:	e118                	sd	a4,0(a0)
    3b52:	bff1                	j	3b2e <malloc+0x86>
  hp->s.size = nu;
    3b54:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    3b58:	0541                	addi	a0,a0,16
    3b5a:	00000097          	auipc	ra,0x0
    3b5e:	ec6080e7          	jalr	-314(ra) # 3a20 <free>
  return freep;
    3b62:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    3b66:	d971                	beqz	a0,3b3a <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3b68:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3b6a:	4798                	lw	a4,8(a5)
    3b6c:	fa9776e3          	bgeu	a4,s1,3b18 <malloc+0x70>
    if(p == freep)
    3b70:	00093703          	ld	a4,0(s2)
    3b74:	853e                	mv	a0,a5
    3b76:	fef719e3          	bne	a4,a5,3b68 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3b7a:	8552                	mv	a0,s4
    3b7c:	00000097          	auipc	ra,0x0
    3b80:	b56080e7          	jalr	-1194(ra) # 36d2 <sbrk>
  if(p == (char*)-1)
    3b84:	fd5518e3          	bne	a0,s5,3b54 <malloc+0xac>
        return 0;
    3b88:	4501                	li	a0,0
    3b8a:	bf45                	j	3b3a <malloc+0x92>
