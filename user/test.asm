
user/_test:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <findArgs>:
  "echo"
};

const int functions_length = sizeof(functions) / sizeof(functions[0]);

int findArgs(int argc, char *argv[], char *args[], int i) {
    3000:	7159                	addi	sp,sp,-112
    3002:	f486                	sd	ra,104(sp)
    3004:	f0a2                	sd	s0,96(sp)
    3006:	eca6                	sd	s1,88(sp)
    3008:	e8ca                	sd	s2,80(sp)
    300a:	e4ce                	sd	s3,72(sp)
    300c:	e0d2                	sd	s4,64(sp)
    300e:	fc56                	sd	s5,56(sp)
    3010:	f85a                	sd	s6,48(sp)
    3012:	f45e                	sd	s7,40(sp)
    3014:	f062                	sd	s8,32(sp)
    3016:	ec66                	sd	s9,24(sp)
    3018:	e86a                	sd	s10,16(sp)
    301a:	e46e                	sd	s11,8(sp)
    301c:	1880                	addi	s0,sp,112
    301e:	8cb2                	mv	s9,a2
    3020:	8bb6                	mv	s7,a3
  int n, j; 
  for (j = i; j < argc; j++) {
    3022:	06a6d363          	bge	a3,a0,3088 <findArgs+0x88>
    3026:	8d2a                	mv	s10,a0
    3028:	00369993          	slli	s3,a3,0x3
    302c:	99ae                	add	s3,s3,a1
    302e:	8a36                	mv	s4,a3
    3030:	4b01                	li	s6,0
    // Process args for current function call (up until the next function call)
    if (j == i) 
      args[j-i] = argv[j]; 
    else {
      for (n = 0; n < functions_length; n++) {
    3032:	4d81                	li	s11,0
    3034:	4a99                	li	s5,6
    3036:	a01d                	j	305c <findArgs+0x5c>
      args[j-i] = argv[j]; 
    3038:	0009b783          	ld	a5,0(s3)
    303c:	00fcb023          	sd	a5,0(s9)
    3040:	a809                	j	3052 <findArgs+0x52>
        if (!strcmp(argv[j], functions[n]))
          break; 
      }
      if (n == functions_length)
    3042:	05549463          	bne	s1,s5,308a <findArgs+0x8a>
        args[j-i] = argv[j]; 
    3046:	000c3703          	ld	a4,0(s8)
    304a:	003b1793          	slli	a5,s6,0x3
    304e:	97e6                	add	a5,a5,s9
    3050:	e398                	sd	a4,0(a5)
  for (j = i; j < argc; j++) {
    3052:	2a05                	addiw	s4,s4,1
    3054:	2b05                	addiw	s6,s6,1
    3056:	09a1                	addi	s3,s3,8
    3058:	034d0963          	beq	s10,s4,308a <findArgs+0x8a>
    if (j == i) 
    305c:	00002917          	auipc	s2,0x2
    3060:	fa490913          	addi	s2,s2,-92 # 5000 <functions>
      for (n = 0; n < functions_length; n++) {
    3064:	84ee                	mv	s1,s11
    3066:	8c4e                	mv	s8,s3
    if (j == i) 
    3068:	fd4b88e3          	beq	s7,s4,3038 <findArgs+0x38>
        if (!strcmp(argv[j], functions[n]))
    306c:	00093583          	ld	a1,0(s2)
    3070:	0009b503          	ld	a0,0(s3)
    3074:	00000097          	auipc	ra,0x0
    3078:	6cc080e7          	jalr	1740(ra) # 3740 <strcmp>
    307c:	d179                	beqz	a0,3042 <findArgs+0x42>
      for (n = 0; n < functions_length; n++) {
    307e:	2485                	addiw	s1,s1,1
    3080:	0921                	addi	s2,s2,8
    3082:	ff5495e3          	bne	s1,s5,306c <findArgs+0x6c>
    3086:	b7c1                	j	3046 <findArgs+0x46>
  for (j = i; j < argc; j++) {
    3088:	8a36                	mv	s4,a3
      else break; 
    }
  }
  args[j-i] = 0;		// null terminated args array
    308a:	417a0bbb          	subw	s7,s4,s7
    308e:	0b8e                	slli	s7,s7,0x3
    3090:	9be6                	add	s7,s7,s9
    3092:	000bb023          	sd	zero,0(s7)
  return j; 
}
    3096:	8552                	mv	a0,s4
    3098:	70a6                	ld	ra,104(sp)
    309a:	7406                	ld	s0,96(sp)
    309c:	64e6                	ld	s1,88(sp)
    309e:	6946                	ld	s2,80(sp)
    30a0:	69a6                	ld	s3,72(sp)
    30a2:	6a06                	ld	s4,64(sp)
    30a4:	7ae2                	ld	s5,56(sp)
    30a6:	7b42                	ld	s6,48(sp)
    30a8:	7ba2                	ld	s7,40(sp)
    30aa:	7c02                	ld	s8,32(sp)
    30ac:	6ce2                	ld	s9,24(sp)
    30ae:	6d42                	ld	s10,16(sp)
    30b0:	6da2                	ld	s11,8(sp)
    30b2:	6165                	addi	sp,sp,112
    30b4:	8082                	ret

00000000000030b6 <isFunction>:

int isFunction(char *arg) {
    30b6:	7179                	addi	sp,sp,-48
    30b8:	f406                	sd	ra,40(sp)
    30ba:	f022                	sd	s0,32(sp)
    30bc:	ec26                	sd	s1,24(sp)
    30be:	e84a                	sd	s2,16(sp)
    30c0:	e44e                	sd	s3,8(sp)
    30c2:	e052                	sd	s4,0(sp)
    30c4:	1800                	addi	s0,sp,48
    30c6:	89aa                	mv	s3,a0
  int n; 
  for (n = 0; n < functions_length; n++) {
    30c8:	00002917          	auipc	s2,0x2
    30cc:	f3890913          	addi	s2,s2,-200 # 5000 <functions>
    30d0:	4481                	li	s1,0
    30d2:	4a19                	li	s4,6
    if (!strcmp(arg, functions[n]))  
    30d4:	00093583          	ld	a1,0(s2)
    30d8:	854e                	mv	a0,s3
    30da:	00000097          	auipc	ra,0x0
    30de:	666080e7          	jalr	1638(ra) # 3740 <strcmp>
    30e2:	c509                	beqz	a0,30ec <isFunction+0x36>
  for (n = 0; n < functions_length; n++) {
    30e4:	2485                	addiw	s1,s1,1
    30e6:	0921                	addi	s2,s2,8
    30e8:	ff4496e3          	bne	s1,s4,30d4 <isFunction+0x1e>
      break; 
  }
  return (n != functions_length); 
    30ec:	ffa48513          	addi	a0,s1,-6
}
    30f0:	00a03533          	snez	a0,a0
    30f4:	70a2                	ld	ra,40(sp)
    30f6:	7402                	ld	s0,32(sp)
    30f8:	64e2                	ld	s1,24(sp)
    30fa:	6942                	ld	s2,16(sp)
    30fc:	69a2                	ld	s3,8(sp)
    30fe:	6a02                	ld	s4,0(sp)
    3100:	6145                	addi	sp,sp,48
    3102:	8082                	ret

0000000000003104 <int_to_ascii>:

void int_to_ascii(int num, char str[]) {
    3104:	1141                	addi	sp,sp,-16
    3106:	e422                	sd	s0,8(sp)
    3108:	0800                	addi	s0,sp,16
    int i = 0;

    // Extract digits in reverse order
    while (num > 0) {
    310a:	06a05263          	blez	a0,316e <int_to_ascii+0x6a>
    310e:	86ae                	mv	a3,a1
    3110:	872e                	mv	a4,a1
    int i = 0;
    3112:	4601                	li	a2,0
        int digit = num % 10;
    3114:	48a9                	li	a7,10
    while (num > 0) {
    3116:	4325                	li	t1,9
        str[i++] = '0' + digit;
    3118:	8832                	mv	a6,a2
    311a:	2605                	addiw	a2,a2,1
        int digit = num % 10;
    311c:	031567bb          	remw	a5,a0,a7
        str[i++] = '0' + digit;
    3120:	0307879b          	addiw	a5,a5,48
    3124:	00f70023          	sb	a5,0(a4)
        num /= 10;
    3128:	87aa                	mv	a5,a0
    312a:	0315453b          	divw	a0,a0,a7
    while (num > 0) {
    312e:	0705                	addi	a4,a4,1
    3130:	fef344e3          	blt	t1,a5,3118 <int_to_ascii+0x14>
    }

    // Reverse the string
    int start = 0;
    int end = i - 1;
    while (start < end) {
    3134:	03005763          	blez	a6,3162 <int_to_ascii+0x5e>
    3138:	01058733          	add	a4,a1,a6
    int start = 0;
    313c:	4501                	li	a0,0
        char temp = str[start];
    313e:	0006c783          	lbu	a5,0(a3)
        str[start] = str[end];
    3142:	00074883          	lbu	a7,0(a4)
    3146:	01168023          	sb	a7,0(a3)
        str[end] = temp;
    314a:	00f70023          	sb	a5,0(a4)
        start++;
    314e:	0015079b          	addiw	a5,a0,1
    3152:	0007851b          	sext.w	a0,a5
    while (start < end) {
    3156:	0685                	addi	a3,a3,1
    3158:	177d                	addi	a4,a4,-1
    315a:	40f807bb          	subw	a5,a6,a5
    315e:	fef540e3          	blt	a0,a5,313e <int_to_ascii+0x3a>
        end--;
    }

    // Null-terminate the string
    str[i] = '\0';
    3162:	95b2                	add	a1,a1,a2
    3164:	00058023          	sb	zero,0(a1)
}
    3168:	6422                	ld	s0,8(sp)
    316a:	0141                	addi	sp,sp,16
    316c:	8082                	ret
    int i = 0;
    316e:	4601                	li	a2,0
    3170:	bfcd                	j	3162 <int_to_ascii+0x5e>

0000000000003172 <separator>:

void separator() {
    3172:	715d                	addi	sp,sp,-80
    3174:	e486                	sd	ra,72(sp)
    3176:	e0a2                	sd	s0,64(sp)
    3178:	0880                	addi	s0,sp,80
  char dashes[51]; 
  memset(dashes, '-', 50); 
    317a:	03200613          	li	a2,50
    317e:	02d00593          	li	a1,45
    3182:	fb840513          	addi	a0,s0,-72
    3186:	00000097          	auipc	ra,0x0
    318a:	610080e7          	jalr	1552(ra) # 3796 <memset>
  dashes[50] = '\0';
    318e:	fe040523          	sb	zero,-22(s0)
  printf("\n%s\n\n", dashes); 
    3192:	fb840593          	addi	a1,s0,-72
    3196:	00001517          	auipc	a0,0x1
    319a:	dba50513          	addi	a0,a0,-582 # 3f50 <functions_length+0x10>
    319e:	00001097          	auipc	ra,0x1
    31a2:	bf4080e7          	jalr	-1036(ra) # 3d92 <printf>
}
    31a6:	60a6                	ld	ra,72(sp)
    31a8:	6406                	ld	s0,64(sp)
    31aa:	6161                	addi	sp,sp,80
    31ac:	8082                	ret

00000000000031ae <convertTicks>:

// Function to convert ticks to seconds (for more readability)
void convertTicks(int ticks) {
    31ae:	1141                	addi	sp,sp,-16
    31b0:	e406                	sd	ra,8(sp)
    31b2:	e022                	sd	s0,0(sp)
    31b4:	0800                	addi	s0,sp,16
  uint minutes = ticks / 60000; // 1 min = 60 * 1000 ticks
  ticks = ticks % 60000;
    31b6:	67bd                	lui	a5,0xf
    31b8:	a607879b          	addiw	a5,a5,-1440
    31bc:	02f5663b          	remw	a2,a0,a5
  uint seconds = ticks / 1000; // 1 sec = 1000 ticks
  ticks = ticks % 1000;
    31c0:	3e800713          	li	a4,1000

  printf("%d:%d.%d", minutes, seconds, ticks);
    31c4:	02e666bb          	remw	a3,a2,a4
    31c8:	02e6463b          	divw	a2,a2,a4
    31cc:	02f545bb          	divw	a1,a0,a5
    31d0:	00001517          	auipc	a0,0x1
    31d4:	d8850513          	addi	a0,a0,-632 # 3f58 <functions_length+0x18>
    31d8:	00001097          	auipc	ra,0x1
    31dc:	bba080e7          	jalr	-1094(ra) # 3d92 <printf>
}
    31e0:	60a2                	ld	ra,8(sp)
    31e2:	6402                	ld	s0,0(sp)
    31e4:	0141                	addi	sp,sp,16
    31e6:	8082                	ret

00000000000031e8 <printStats>:

void printStats(const char *str, const char *str1, const char *str2, const int val1, const int val2) {
    31e8:	7179                	addi	sp,sp,-48
    31ea:	f406                	sd	ra,40(sp)
    31ec:	f022                	sd	s0,32(sp)
    31ee:	ec26                	sd	s1,24(sp)
    31f0:	e84a                	sd	s2,16(sp)
    31f2:	e44e                	sd	s3,8(sp)
    31f4:	e052                	sd	s4,0(sp)
    31f6:	1800                	addi	s0,sp,48
    31f8:	8a2e                	mv	s4,a1
    31fa:	89b2                	mv	s3,a2
    31fc:	8936                	mv	s2,a3
    31fe:	84ba                	mv	s1,a4
  printf("%s\t\t| Ticks\t\t| min:sec", str);  
    3200:	85aa                	mv	a1,a0
    3202:	00001517          	auipc	a0,0x1
    3206:	d6650513          	addi	a0,a0,-666 # 3f68 <functions_length+0x28>
    320a:	00001097          	auipc	ra,0x1
    320e:	b88080e7          	jalr	-1144(ra) # 3d92 <printf>
  printf("\n%s\t\t| %d\t\t| ", str1, val1);  convertTicks(val1); 
    3212:	864a                	mv	a2,s2
    3214:	85d2                	mv	a1,s4
    3216:	00001517          	auipc	a0,0x1
    321a:	d6a50513          	addi	a0,a0,-662 # 3f80 <functions_length+0x40>
    321e:	00001097          	auipc	ra,0x1
    3222:	b74080e7          	jalr	-1164(ra) # 3d92 <printf>
    3226:	854a                	mv	a0,s2
    3228:	00000097          	auipc	ra,0x0
    322c:	f86080e7          	jalr	-122(ra) # 31ae <convertTicks>
  printf("\n%s \t| %d\t\t| ", str2, val2);   convertTicks(val2);  
    3230:	8626                	mv	a2,s1
    3232:	85ce                	mv	a1,s3
    3234:	00001517          	auipc	a0,0x1
    3238:	d5c50513          	addi	a0,a0,-676 # 3f90 <functions_length+0x50>
    323c:	00001097          	auipc	ra,0x1
    3240:	b56080e7          	jalr	-1194(ra) # 3d92 <printf>
    3244:	8526                	mv	a0,s1
    3246:	00000097          	auipc	ra,0x0
    324a:	f68080e7          	jalr	-152(ra) # 31ae <convertTicks>
  printf("\n");
    324e:	00001517          	auipc	a0,0x1
    3252:	d5250513          	addi	a0,a0,-686 # 3fa0 <functions_length+0x60>
    3256:	00001097          	auipc	ra,0x1
    325a:	b3c080e7          	jalr	-1220(ra) # 3d92 <printf>
}
    325e:	70a2                	ld	ra,40(sp)
    3260:	7402                	ld	s0,32(sp)
    3262:	64e2                	ld	s1,24(sp)
    3264:	6942                	ld	s2,16(sp)
    3266:	69a2                	ld	s3,8(sp)
    3268:	6a02                	ld	s4,0(sp)
    326a:	6145                	addi	sp,sp,48
    326c:	8082                	ret

000000000000326e <main>:

int main (int argc, char *argv[]) {
    326e:	7165                	addi	sp,sp,-400
    3270:	e706                	sd	ra,392(sp)
    3272:	e322                	sd	s0,384(sp)
    3274:	fea6                	sd	s1,376(sp)
    3276:	faca                	sd	s2,368(sp)
    3278:	f6ce                	sd	s3,360(sp)
    327a:	f2d2                	sd	s4,352(sp)
    327c:	eed6                	sd	s5,344(sp)
    327e:	eada                	sd	s6,336(sp)
    3280:	e6de                	sd	s7,328(sp)
    3282:	e2e2                	sd	s8,320(sp)
    3284:	fe66                	sd	s9,312(sp)
    3286:	fa6a                	sd	s10,304(sp)
    3288:	f66e                	sd	s11,296(sp)
    328a:	0b00                	addi	s0,sp,400
    328c:	89aa                	mv	s3,a0
    328e:	8c2e                	mv	s8,a1
  int pid, i = 1, j, n, proc_count = 0, total_wait = 0, total_turnaround = 0; 
  
  // PRIORITY BASED SCHEDULING
  if (!strcmp(argv[i], "PRIORITY")) {
    3290:	00001597          	auipc	a1,0x1
    3294:	d1858593          	addi	a1,a1,-744 # 3fa8 <functions_length+0x68>
    3298:	008c3503          	ld	a0,8(s8)
    329c:	00000097          	auipc	ra,0x0
    32a0:	4a4080e7          	jalr	1188(ra) # 3740 <strcmp>
    32a4:	32051c63          	bnez	a0,35dc <main+0x36e>
    32a8:	84aa                	mv	s1,a0
    separator(); 
    32aa:	00000097          	auipc	ra,0x0
    32ae:	ec8080e7          	jalr	-312(ra) # 3172 <separator>
    set_scheduler(2);
    32b2:	4509                	li	a0,2
    32b4:	00000097          	auipc	ra,0x0
    32b8:	7f6080e7          	jalr	2038(ra) # 3aaa <set_scheduler>
    i++; 
    char *new_argv[32]; 
    int k = 0, x, size = 0; 

    for (; i < argc; i++) {
    32bc:	4789                	li	a5,2
    32be:	2d37dd63          	bge	a5,s3,3598 <main+0x32a>
    32c2:	010c0913          	addi	s2,s8,16
    int k = 0, x, size = 0; 
    32c6:	8aa6                	mv	s5,s1
    32c8:	8ca6                	mv	s9,s1
    i++; 
    32ca:	4a09                	li	s4,2
      // Check if arg is in functions, if not continue
      if (!isFunction(argv[i])) continue; 
    
      char *args[argc-i+1]; 
    32cc:	0019879b          	addiw	a5,s3,1
    32d0:	e6f42e23          	sw	a5,-388(s0)
    32d4:	a841                	j	3364 <main+0xf6>
    32d6:	e7c42783          	lw	a5,-388(s0)
    32da:	414787bb          	subw	a5,a5,s4
    32de:	078e                	slli	a5,a5,0x3
    32e0:	07bd                	addi	a5,a5,15
    32e2:	9bc1                	andi	a5,a5,-16
    32e4:	40f10133          	sub	sp,sp,a5
    32e8:	8b0a                	mv	s6,sp
      j = findArgs(argc, argv, args, i); 
    32ea:	86d2                	mv	a3,s4
    32ec:	865a                	mv	a2,s6
    32ee:	85e2                	mv	a1,s8
    32f0:	854e                	mv	a0,s3
    32f2:	00000097          	auipc	ra,0x0
    32f6:	d0e080e7          	jalr	-754(ra) # 3000 <findArgs>
      // append to new_argv
      n = k; 
      for (x = 0; x < j-i; x++, n++) {
    32fa:	41450abb          	subw	s5,a0,s4
    32fe:	000a879b          	sext.w	a5,s5
    3302:	06f05c63          	blez	a5,337a <main+0x10c>
    3306:	87da                	mv	a5,s6
    3308:	003c9713          	slli	a4,s9,0x3
    330c:	e9040693          	addi	a3,s0,-368
    3310:	9736                	add	a4,a4,a3
    3312:	fffa869b          	addiw	a3,s5,-1
    3316:	1682                	slli	a3,a3,0x20
    3318:	9281                	srli	a3,a3,0x20
    331a:	068e                	slli	a3,a3,0x3
    331c:	0b21                	addi	s6,s6,8
    331e:	9b36                	add	s6,s6,a3
        new_argv[n] = args[x]; 
    3320:	6394                	ld	a3,0(a5)
    3322:	e314                	sd	a3,0(a4)
      for (x = 0; x < j-i; x++, n++) {
    3324:	07a1                	addi	a5,a5,8
    3326:	0721                	addi	a4,a4,8
    3328:	ff679ce3          	bne	a5,s6,3320 <main+0xb2>
    332c:	019a8abb          	addw	s5,s5,s9
      }
      // if no custom priorities, use a priority counter 
      if (!isDigit(new_argv[n-1])) {
    3330:	fffa8b1b          	addiw	s6,s5,-1
    3334:	003b1793          	slli	a5,s6,0x3
    3338:	f9040713          	addi	a4,s0,-112
    333c:	97ba                	add	a5,a5,a4
    333e:	f007b503          	ld	a0,-256(a5) # ef00 <base+0x9ec0>
    3342:	00000097          	auipc	ra,0x0
    3346:	684080e7          	jalr	1668(ra) # 39c6 <isDigit>
    334a:	2501                	sext.w	a0,a0
    334c:	c90d                	beqz	a0,337e <main+0x110>
        }
        else {
          new_argv[n] = "2"; 
        }
      } else n--; 
      size = n+1; 
    334e:	001b0a9b          	addiw	s5,s6,1
      // switch place 
      if (k > 0 && atoi(new_argv[n]) < atoi(new_argv[k-1])) {
    3352:	09904863          	bgtz	s9,33e2 <main+0x174>
          new_argv[x] = new_argv[n]; 
          new_argv[n] = temp; 
          if (isFunction(new_argv[x])) break; 
        }
      }
      k = n+1; 
    3356:	001b0c9b          	addiw	s9,s6,1
    335a:	815e                	mv	sp,s7
    for (; i < argc; i++) {
    335c:	2a05                	addiw	s4,s4,1
    335e:	0921                	addi	s2,s2,8
    3360:	0f498c63          	beq	s3,s4,3458 <main+0x1ea>
    3364:	8b8a                	mv	s7,sp
      if (!isFunction(argv[i])) continue; 
    3366:	8d4a                	mv	s10,s2
    3368:	00093503          	ld	a0,0(s2)
    336c:	00000097          	auipc	ra,0x0
    3370:	d4a080e7          	jalr	-694(ra) # 30b6 <isFunction>
    3374:	f12d                	bnez	a0,32d6 <main+0x68>
    3376:	815e                	mv	sp,s7
    3378:	b7d5                	j	335c <main+0xee>
      for (x = 0; x < j-i; x++, n++) {
    337a:	8ae6                	mv	s5,s9
    337c:	bf55                	j	3330 <main+0xc2>
        x = strlen(argv[i]); 
    337e:	000d3503          	ld	a0,0(s10)
    3382:	00000097          	auipc	ra,0x0
    3386:	3ea080e7          	jalr	1002(ra) # 376c <strlen>
        if ((argv[i][x-1] == 'k') && (argv[i][x-2] == '_')) {
    338a:	000d3783          	ld	a5,0(s10)
    338e:	2501                	sext.w	a0,a0
    3390:	00a78733          	add	a4,a5,a0
    3394:	fff74703          	lbu	a4,-1(a4)
    3398:	06b00693          	li	a3,107
    339c:	00d70f63          	beq	a4,a3,33ba <main+0x14c>
          new_argv[n] = "2"; 
    33a0:	003a9793          	slli	a5,s5,0x3
    33a4:	f9040713          	addi	a4,s0,-112
    33a8:	97ba                	add	a5,a5,a4
    33aa:	00001717          	auipc	a4,0x1
    33ae:	c1670713          	addi	a4,a4,-1002 # 3fc0 <functions_length+0x80>
    33b2:	f0e7b023          	sd	a4,-256(a5)
    33b6:	8b56                	mv	s6,s5
    33b8:	bf59                	j	334e <main+0xe0>
        if ((argv[i][x-1] == 'k') && (argv[i][x-2] == '_')) {
    33ba:	97aa                	add	a5,a5,a0
    33bc:	ffe7c783          	lbu	a5,-2(a5)
    33c0:	05f00713          	li	a4,95
    33c4:	fce79ee3          	bne	a5,a4,33a0 <main+0x132>
          new_argv[n] = "1"; 
    33c8:	003a9793          	slli	a5,s5,0x3
    33cc:	f9040713          	addi	a4,s0,-112
    33d0:	97ba                	add	a5,a5,a4
    33d2:	00001717          	auipc	a4,0x1
    33d6:	be670713          	addi	a4,a4,-1050 # 3fb8 <functions_length+0x78>
    33da:	f0e7b023          	sd	a4,-256(a5)
    33de:	8b56                	mv	s6,s5
    33e0:	b7bd                	j	334e <main+0xe0>
      if (k > 0 && atoi(new_argv[n]) < atoi(new_argv[k-1])) {
    33e2:	003b1793          	slli	a5,s6,0x3
    33e6:	f9040713          	addi	a4,s0,-112
    33ea:	97ba                	add	a5,a5,a4
    33ec:	f007b503          	ld	a0,-256(a5)
    33f0:	00000097          	auipc	ra,0x0
    33f4:	4a6080e7          	jalr	1190(ra) # 3896 <atoi>
    33f8:	8d2a                	mv	s10,a0
    33fa:	fffc879b          	addiw	a5,s9,-1
    33fe:	078e                	slli	a5,a5,0x3
    3400:	f9040713          	addi	a4,s0,-112
    3404:	97ba                	add	a5,a5,a4
    3406:	f007b503          	ld	a0,-256(a5)
    340a:	00000097          	auipc	ra,0x0
    340e:	48c080e7          	jalr	1164(ra) # 3896 <atoi>
    3412:	f4ad52e3          	bge	s10,a0,3356 <main+0xe8>
    3416:	003c9d13          	slli	s10,s9,0x3
    341a:	1d61                	addi	s10,s10,-8
    341c:	e9040793          	addi	a5,s0,-368
    3420:	9d3e                	add	s10,s10,a5
    3422:	003b1d93          	slli	s11,s6,0x3
    3426:	9dbe                	add	s11,s11,a5
    3428:	419b0cbb          	subw	s9,s6,s9
          char *temp = new_argv[x]; 
    342c:	000d3783          	ld	a5,0(s10)
          new_argv[x] = new_argv[n]; 
    3430:	000db703          	ld	a4,0(s11)
    3434:	00ed3023          	sd	a4,0(s10)
          new_argv[n] = temp; 
    3438:	00fdb023          	sd	a5,0(s11)
          if (isFunction(new_argv[x])) break; 
    343c:	000d3503          	ld	a0,0(s10)
    3440:	00000097          	auipc	ra,0x0
    3444:	c76080e7          	jalr	-906(ra) # 30b6 <isFunction>
    3448:	f519                	bnez	a0,3356 <main+0xe8>
        for (x = k-1; x >= 0; x--, n--) {
    344a:	3b7d                	addiw	s6,s6,-1
    344c:	1d61                	addi	s10,s10,-8
    344e:	1de1                	addi	s11,s11,-8
    3450:	fd9b1ee3          	bne	s6,s9,342c <main+0x1be>
    3454:	8b66                	mv	s6,s9
    3456:	b701                	j	3356 <main+0xe8>
    }
    new_argv[size] = 0; 
    3458:	003a9793          	slli	a5,s5,0x3
    345c:	f9040713          	addi	a4,s0,-112
    3460:	97ba                	add	a5,a5,a4
    3462:	f007b023          	sd	zero,-256(a5)
    for (i = 0; i < size; i++) {
    3466:	17505863          	blez	s5,35d6 <main+0x368>
    346a:	e9040993          	addi	s3,s0,-368
  int pid, i = 1, j, n, proc_count = 0, total_wait = 0, total_turnaround = 0; 
    346e:	8ba6                	mv	s7,s1
    3470:	8b26                	mv	s6,s1
    for (i = 0; i < size; i++) {
    3472:	8926                	mv	s2,s1
        int wait_time, turnaround_time;    
        if (waitx(0, &wait_time, &turnaround_time) >= 0) {
          total_wait += wait_time;
          total_turnaround += turnaround_time;
          proc_count++;
          printStats("\nTime\t", "Wait time", "Turnaround time", wait_time, turnaround_time);
    3474:	00001c97          	auipc	s9,0x1
    3478:	b84c8c93          	addi	s9,s9,-1148 # 3ff8 <functions_length+0xb8>
    347c:	00001c17          	auipc	s8,0x1
    3480:	b8cc0c13          	addi	s8,s8,-1140 # 4008 <functions_length+0xc8>
    3484:	00001a17          	auipc	s4,0x1
    3488:	b94a0a13          	addi	s4,s4,-1132 # 4018 <functions_length+0xd8>
    348c:	a8d9                	j	3562 <main+0x2f4>
        printf("test: fork failed\n");
    348e:	00001517          	auipc	a0,0x1
    3492:	b3a50513          	addi	a0,a0,-1222 # 3fc8 <functions_length+0x88>
    3496:	00001097          	auipc	ra,0x1
    349a:	8fc080e7          	jalr	-1796(ra) # 3d92 <printf>
        exit(1);
    349e:	4505                	li	a0,1
    34a0:	00000097          	auipc	ra,0x0
    34a4:	54a080e7          	jalr	1354(ra) # 39ea <exit>
        char *args[size - i + 1]; 
    34a8:	412a87bb          	subw	a5,s5,s2
    34ac:	2785                	addiw	a5,a5,1
    34ae:	078e                	slli	a5,a5,0x3
    34b0:	07bd                	addi	a5,a5,15
    34b2:	9bc1                	andi	a5,a5,-16
    34b4:	40f10133          	sub	sp,sp,a5
    34b8:	898a                	mv	s3,sp
        j = findArgs(size, new_argv, args, i); 
    34ba:	86ca                	mv	a3,s2
    34bc:	864e                	mv	a2,s3
    34be:	e9040593          	addi	a1,s0,-368
    34c2:	8556                	mv	a0,s5
    34c4:	00000097          	auipc	ra,0x0
    34c8:	b3c080e7          	jalr	-1220(ra) # 3000 <findArgs>
    34cc:	84aa                	mv	s1,a0
        set_priority(getpid(), atoi(args[j-i-1])); 
    34ce:	00000097          	auipc	ra,0x0
    34d2:	5a4080e7          	jalr	1444(ra) # 3a72 <getpid>
    34d6:	8a2a                	mv	s4,a0
    34d8:	412484bb          	subw	s1,s1,s2
    34dc:	048e                	slli	s1,s1,0x3
    34de:	94ce                	add	s1,s1,s3
    34e0:	ff84b503          	ld	a0,-8(s1)
    34e4:	00000097          	auipc	ra,0x0
    34e8:	3b2080e7          	jalr	946(ra) # 3896 <atoi>
    34ec:	85aa                	mv	a1,a0
    34ee:	8552                	mv	a0,s4
    34f0:	00000097          	auipc	ra,0x0
    34f4:	5c2080e7          	jalr	1474(ra) # 3ab2 <set_priority>
        args[j-i-1] = 0; // don't need priority for exec
    34f8:	fe04bc23          	sd	zero,-8(s1)
        exec(new_argv[i], args); 
    34fc:	00391493          	slli	s1,s2,0x3
    3500:	f9040793          	addi	a5,s0,-112
    3504:	94be                	add	s1,s1,a5
    3506:	85ce                	mv	a1,s3
    3508:	f004b503          	ld	a0,-256(s1)
    350c:	00000097          	auipc	ra,0x0
    3510:	51e080e7          	jalr	1310(ra) # 3a2a <exec>
        printf("test: %s failed\n", new_argv[i]); 
    3514:	f004b583          	ld	a1,-256(s1)
    3518:	00001517          	auipc	a0,0x1
    351c:	ac850513          	addi	a0,a0,-1336 # 3fe0 <functions_length+0xa0>
    3520:	00001097          	auipc	ra,0x1
    3524:	872080e7          	jalr	-1934(ra) # 3d92 <printf>
        exit(0);
    3528:	4501                	li	a0,0
    352a:	00000097          	auipc	ra,0x0
    352e:	4c0080e7          	jalr	1216(ra) # 39ea <exit>
          total_wait += wait_time;
    3532:	e8842683          	lw	a3,-376(s0)
    3536:	01668b3b          	addw	s6,a3,s6
          total_turnaround += turnaround_time;
    353a:	e8c42703          	lw	a4,-372(s0)
    353e:	01770bbb          	addw	s7,a4,s7
          proc_count++;
    3542:	2489                	addiw	s1,s1,2
          printStats("\nTime\t", "Wait time", "Turnaround time", wait_time, turnaround_time);
    3544:	8666                	mv	a2,s9
    3546:	85e2                	mv	a1,s8
    3548:	8552                	mv	a0,s4
    354a:	00000097          	auipc	ra,0x0
    354e:	c9e080e7          	jalr	-866(ra) # 31e8 <printStats>
          separator(); 
    3552:	00000097          	auipc	ra,0x0
    3556:	c20080e7          	jalr	-992(ra) # 3172 <separator>
    for (i = 0; i < size; i++) {
    355a:	2905                	addiw	s2,s2,1
    355c:	09a1                	addi	s3,s3,8
    355e:	032a8f63          	beq	s5,s2,359c <main+0x32e>
      if (!isFunction(new_argv[i])) continue; 
    3562:	0009b503          	ld	a0,0(s3)
    3566:	00000097          	auipc	ra,0x0
    356a:	b50080e7          	jalr	-1200(ra) # 30b6 <isFunction>
    356e:	d575                	beqz	a0,355a <main+0x2ec>
      pid = fork();  
    3570:	00000097          	auipc	ra,0x0
    3574:	472080e7          	jalr	1138(ra) # 39e2 <fork>
      if (pid < 0) {
    3578:	f0054be3          	bltz	a0,348e <main+0x220>
      if (pid == 0) {
    357c:	d515                	beqz	a0,34a8 <main+0x23a>
        if (waitx(0, &wait_time, &turnaround_time) >= 0) {
    357e:	e8c40613          	addi	a2,s0,-372
    3582:	e8840593          	addi	a1,s0,-376
    3586:	4501                	li	a0,0
    3588:	00000097          	auipc	ra,0x0
    358c:	472080e7          	jalr	1138(ra) # 39fa <waitx>
    3590:	fa0551e3          	bgez	a0,3532 <main+0x2c4>
        proc_count++; 
    3594:	2485                	addiw	s1,s1,1
    3596:	b7d1                	j	355a <main+0x2ec>
  int pid, i = 1, j, n, proc_count = 0, total_wait = 0, total_turnaround = 0; 
    3598:	8ba6                	mv	s7,s1
    359a:	8b26                	mv	s6,s1
        }
      }
    }
  }

  printStats("Avg Time", "Avg Wait time", "Avg Turnaround time", total_wait/proc_count, total_turnaround/proc_count);
    359c:	029bc73b          	divw	a4,s7,s1
    35a0:	029b46bb          	divw	a3,s6,s1
    35a4:	00001617          	auipc	a2,0x1
    35a8:	a8460613          	addi	a2,a2,-1404 # 4028 <functions_length+0xe8>
    35ac:	00001597          	auipc	a1,0x1
    35b0:	a9458593          	addi	a1,a1,-1388 # 4040 <functions_length+0x100>
    35b4:	00001517          	auipc	a0,0x1
    35b8:	a9c50513          	addi	a0,a0,-1380 # 4050 <functions_length+0x110>
    35bc:	00000097          	auipc	ra,0x0
    35c0:	c2c080e7          	jalr	-980(ra) # 31e8 <printStats>
  separator();
    35c4:	00000097          	auipc	ra,0x0
    35c8:	bae080e7          	jalr	-1106(ra) # 3172 <separator>

  exit(0); 
    35cc:	4501                	li	a0,0
    35ce:	00000097          	auipc	ra,0x0
    35d2:	41c080e7          	jalr	1052(ra) # 39ea <exit>
  int pid, i = 1, j, n, proc_count = 0, total_wait = 0, total_turnaround = 0; 
    35d6:	8ba6                	mv	s7,s1
    35d8:	8b26                	mv	s6,s1
    35da:	b7c9                	j	359c <main+0x32e>
    separator(); 
    35dc:	00000097          	auipc	ra,0x0
    35e0:	b96080e7          	jalr	-1130(ra) # 3172 <separator>
    if (!strcmp(argv[i], "FCFS")) {
    35e4:	00001597          	auipc	a1,0x1
    35e8:	a3c58593          	addi	a1,a1,-1476 # 4020 <functions_length+0xe0>
    35ec:	008c3503          	ld	a0,8(s8)
    35f0:	00000097          	auipc	ra,0x0
    35f4:	150080e7          	jalr	336(ra) # 3740 <strcmp>
  int pid, i = 1, j, n, proc_count = 0, total_wait = 0, total_turnaround = 0; 
    35f8:	4a05                	li	s4,1
    if (!strcmp(argv[i], "FCFS")) {
    35fa:	c515                	beqz	a0,3626 <main+0x3b8>
    for (; i < argc; i++) {
    35fc:	113a5363          	bge	s4,s3,3702 <main+0x494>
    3600:	003a1913          	slli	s2,s4,0x3
    3604:	9962                	add	s2,s2,s8
    3606:	4b81                	li	s7,0
    3608:	4b01                	li	s6,0
    360a:	4481                	li	s1,0
          printStats("\nTime\t", "Wait time", "Turnaround time", wait_time, turnaround_time);
    360c:	00001d97          	auipc	s11,0x1
    3610:	9ecd8d93          	addi	s11,s11,-1556 # 3ff8 <functions_length+0xb8>
    3614:	00001d17          	auipc	s10,0x1
    3618:	9f4d0d13          	addi	s10,s10,-1548 # 4008 <functions_length+0xc8>
    361c:	00001c97          	auipc	s9,0x1
    3620:	9fcc8c93          	addi	s9,s9,-1540 # 4018 <functions_length+0xd8>
    3624:	a065                	j	36cc <main+0x45e>
      set_scheduler(1); 
    3626:	4505                	li	a0,1
    3628:	00000097          	auipc	ra,0x0
    362c:	482080e7          	jalr	1154(ra) # 3aaa <set_scheduler>
      i++;
    3630:	4a09                	li	s4,2
    3632:	b7e9                	j	35fc <main+0x38e>
        printf("test: fork failed\n");
    3634:	00001517          	auipc	a0,0x1
    3638:	99450513          	addi	a0,a0,-1644 # 3fc8 <functions_length+0x88>
    363c:	00000097          	auipc	ra,0x0
    3640:	756080e7          	jalr	1878(ra) # 3d92 <printf>
        exit(1);
    3644:	4505                	li	a0,1
    3646:	00000097          	auipc	ra,0x0
    364a:	3a4080e7          	jalr	932(ra) # 39ea <exit>
        char *args[argc - i + 1]; 
    364e:	414987bb          	subw	a5,s3,s4
    3652:	2785                	addiw	a5,a5,1
    3654:	078e                	slli	a5,a5,0x3
    3656:	07bd                	addi	a5,a5,15
    3658:	9bc1                	andi	a5,a5,-16
    365a:	40f10133          	sub	sp,sp,a5
    365e:	848a                	mv	s1,sp
        j = findArgs(argc, argv, args, i); 
    3660:	86d2                	mv	a3,s4
    3662:	8626                	mv	a2,s1
    3664:	85e2                	mv	a1,s8
    3666:	854e                	mv	a0,s3
    3668:	00000097          	auipc	ra,0x0
    366c:	998080e7          	jalr	-1640(ra) # 3000 <findArgs>
        exec(argv[i], args); 
    3670:	85a6                	mv	a1,s1
    3672:	00093503          	ld	a0,0(s2)
    3676:	00000097          	auipc	ra,0x0
    367a:	3b4080e7          	jalr	948(ra) # 3a2a <exec>
        printf("test: %s failed\n", argv[i]); 
    367e:	00093583          	ld	a1,0(s2)
    3682:	00001517          	auipc	a0,0x1
    3686:	95e50513          	addi	a0,a0,-1698 # 3fe0 <functions_length+0xa0>
    368a:	00000097          	auipc	ra,0x0
    368e:	708080e7          	jalr	1800(ra) # 3d92 <printf>
        exit(0);
    3692:	4501                	li	a0,0
    3694:	00000097          	auipc	ra,0x0
    3698:	356080e7          	jalr	854(ra) # 39ea <exit>
          total_wait += wait_time;
    369c:	e8c42683          	lw	a3,-372(s0)
    36a0:	01668b3b          	addw	s6,a3,s6
          total_turnaround += turnaround_time;
    36a4:	e9042703          	lw	a4,-368(s0)
    36a8:	01770bbb          	addw	s7,a4,s7
          proc_count++;
    36ac:	2489                	addiw	s1,s1,2
          printStats("\nTime\t", "Wait time", "Turnaround time", wait_time, turnaround_time);
    36ae:	866e                	mv	a2,s11
    36b0:	85ea                	mv	a1,s10
    36b2:	8566                	mv	a0,s9
    36b4:	00000097          	auipc	ra,0x0
    36b8:	b34080e7          	jalr	-1228(ra) # 31e8 <printStats>
          separator();    
    36bc:	00000097          	auipc	ra,0x0
    36c0:	ab6080e7          	jalr	-1354(ra) # 3172 <separator>
    for (; i < argc; i++) {
    36c4:	2a05                	addiw	s4,s4,1
    36c6:	0921                	addi	s2,s2,8
    36c8:	ed498ae3          	beq	s3,s4,359c <main+0x32e>
      if (!isFunction(argv[i])) continue; 
    36cc:	00093503          	ld	a0,0(s2)
    36d0:	00000097          	auipc	ra,0x0
    36d4:	9e6080e7          	jalr	-1562(ra) # 30b6 <isFunction>
    36d8:	d575                	beqz	a0,36c4 <main+0x456>
      pid = fork();  
    36da:	00000097          	auipc	ra,0x0
    36de:	308080e7          	jalr	776(ra) # 39e2 <fork>
      if (pid < 0) {
    36e2:	f40549e3          	bltz	a0,3634 <main+0x3c6>
      if (pid == 0) {
    36e6:	d525                	beqz	a0,364e <main+0x3e0>
        if (waitx(0, &wait_time, &turnaround_time) >= 0) {
    36e8:	e9040613          	addi	a2,s0,-368
    36ec:	e8c40593          	addi	a1,s0,-372
    36f0:	4501                	li	a0,0
    36f2:	00000097          	auipc	ra,0x0
    36f6:	308080e7          	jalr	776(ra) # 39fa <waitx>
    36fa:	fa0551e3          	bgez	a0,369c <main+0x42e>
        proc_count++; 
    36fe:	2485                	addiw	s1,s1,1
    3700:	b7d1                	j	36c4 <main+0x456>
    for (; i < argc; i++) {
    3702:	4b81                	li	s7,0
    3704:	4b01                	li	s6,0
    3706:	4481                	li	s1,0
    3708:	bd51                	j	359c <main+0x32e>

000000000000370a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    370a:	1141                	addi	sp,sp,-16
    370c:	e406                	sd	ra,8(sp)
    370e:	e022                	sd	s0,0(sp)
    3710:	0800                	addi	s0,sp,16
  extern int main();
  main();
    3712:	00000097          	auipc	ra,0x0
    3716:	b5c080e7          	jalr	-1188(ra) # 326e <main>
  exit(0);
    371a:	4501                	li	a0,0
    371c:	00000097          	auipc	ra,0x0
    3720:	2ce080e7          	jalr	718(ra) # 39ea <exit>

0000000000003724 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3724:	1141                	addi	sp,sp,-16
    3726:	e422                	sd	s0,8(sp)
    3728:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    372a:	87aa                	mv	a5,a0
    372c:	0585                	addi	a1,a1,1
    372e:	0785                	addi	a5,a5,1
    3730:	fff5c703          	lbu	a4,-1(a1)
    3734:	fee78fa3          	sb	a4,-1(a5)
    3738:	fb75                	bnez	a4,372c <strcpy+0x8>
    ;
  return os;
}
    373a:	6422                	ld	s0,8(sp)
    373c:	0141                	addi	sp,sp,16
    373e:	8082                	ret

0000000000003740 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3740:	1141                	addi	sp,sp,-16
    3742:	e422                	sd	s0,8(sp)
    3744:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    3746:	00054783          	lbu	a5,0(a0)
    374a:	cb91                	beqz	a5,375e <strcmp+0x1e>
    374c:	0005c703          	lbu	a4,0(a1)
    3750:	00f71763          	bne	a4,a5,375e <strcmp+0x1e>
    p++, q++;
    3754:	0505                	addi	a0,a0,1
    3756:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    3758:	00054783          	lbu	a5,0(a0)
    375c:	fbe5                	bnez	a5,374c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    375e:	0005c503          	lbu	a0,0(a1)
}
    3762:	40a7853b          	subw	a0,a5,a0
    3766:	6422                	ld	s0,8(sp)
    3768:	0141                	addi	sp,sp,16
    376a:	8082                	ret

000000000000376c <strlen>:

uint
strlen(const char *s)
{
    376c:	1141                	addi	sp,sp,-16
    376e:	e422                	sd	s0,8(sp)
    3770:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    3772:	00054783          	lbu	a5,0(a0)
    3776:	cf91                	beqz	a5,3792 <strlen+0x26>
    3778:	0505                	addi	a0,a0,1
    377a:	87aa                	mv	a5,a0
    377c:	4685                	li	a3,1
    377e:	9e89                	subw	a3,a3,a0
    3780:	00f6853b          	addw	a0,a3,a5
    3784:	0785                	addi	a5,a5,1
    3786:	fff7c703          	lbu	a4,-1(a5)
    378a:	fb7d                	bnez	a4,3780 <strlen+0x14>
    ;
  return n;
}
    378c:	6422                	ld	s0,8(sp)
    378e:	0141                	addi	sp,sp,16
    3790:	8082                	ret
  for(n = 0; s[n]; n++)
    3792:	4501                	li	a0,0
    3794:	bfe5                	j	378c <strlen+0x20>

0000000000003796 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3796:	1141                	addi	sp,sp,-16
    3798:	e422                	sd	s0,8(sp)
    379a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    379c:	ca19                	beqz	a2,37b2 <memset+0x1c>
    379e:	87aa                	mv	a5,a0
    37a0:	1602                	slli	a2,a2,0x20
    37a2:	9201                	srli	a2,a2,0x20
    37a4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    37a8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    37ac:	0785                	addi	a5,a5,1
    37ae:	fee79de3          	bne	a5,a4,37a8 <memset+0x12>
  }
  return dst;
}
    37b2:	6422                	ld	s0,8(sp)
    37b4:	0141                	addi	sp,sp,16
    37b6:	8082                	ret

00000000000037b8 <strchr>:

char*
strchr(const char *s, char c)
{
    37b8:	1141                	addi	sp,sp,-16
    37ba:	e422                	sd	s0,8(sp)
    37bc:	0800                	addi	s0,sp,16
  for(; *s; s++)
    37be:	00054783          	lbu	a5,0(a0)
    37c2:	cb99                	beqz	a5,37d8 <strchr+0x20>
    if(*s == c)
    37c4:	00f58763          	beq	a1,a5,37d2 <strchr+0x1a>
  for(; *s; s++)
    37c8:	0505                	addi	a0,a0,1
    37ca:	00054783          	lbu	a5,0(a0)
    37ce:	fbfd                	bnez	a5,37c4 <strchr+0xc>
      return (char*)s;
  return 0;
    37d0:	4501                	li	a0,0
}
    37d2:	6422                	ld	s0,8(sp)
    37d4:	0141                	addi	sp,sp,16
    37d6:	8082                	ret
  return 0;
    37d8:	4501                	li	a0,0
    37da:	bfe5                	j	37d2 <strchr+0x1a>

00000000000037dc <gets>:

char*
gets(char *buf, int max)
{
    37dc:	711d                	addi	sp,sp,-96
    37de:	ec86                	sd	ra,88(sp)
    37e0:	e8a2                	sd	s0,80(sp)
    37e2:	e4a6                	sd	s1,72(sp)
    37e4:	e0ca                	sd	s2,64(sp)
    37e6:	fc4e                	sd	s3,56(sp)
    37e8:	f852                	sd	s4,48(sp)
    37ea:	f456                	sd	s5,40(sp)
    37ec:	f05a                	sd	s6,32(sp)
    37ee:	ec5e                	sd	s7,24(sp)
    37f0:	1080                	addi	s0,sp,96
    37f2:	8baa                	mv	s7,a0
    37f4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    37f6:	892a                	mv	s2,a0
    37f8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    37fa:	4aa9                	li	s5,10
    37fc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    37fe:	89a6                	mv	s3,s1
    3800:	2485                	addiw	s1,s1,1
    3802:	0344d863          	bge	s1,s4,3832 <gets+0x56>
    cc = read(0, &c, 1);
    3806:	4605                	li	a2,1
    3808:	faf40593          	addi	a1,s0,-81
    380c:	4501                	li	a0,0
    380e:	00000097          	auipc	ra,0x0
    3812:	1fc080e7          	jalr	508(ra) # 3a0a <read>
    if(cc < 1)
    3816:	00a05e63          	blez	a0,3832 <gets+0x56>
    buf[i++] = c;
    381a:	faf44783          	lbu	a5,-81(s0)
    381e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3822:	01578763          	beq	a5,s5,3830 <gets+0x54>
    3826:	0905                	addi	s2,s2,1
    3828:	fd679be3          	bne	a5,s6,37fe <gets+0x22>
  for(i=0; i+1 < max; ){
    382c:	89a6                	mv	s3,s1
    382e:	a011                	j	3832 <gets+0x56>
    3830:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3832:	99de                	add	s3,s3,s7
    3834:	00098023          	sb	zero,0(s3)
  return buf;
}
    3838:	855e                	mv	a0,s7
    383a:	60e6                	ld	ra,88(sp)
    383c:	6446                	ld	s0,80(sp)
    383e:	64a6                	ld	s1,72(sp)
    3840:	6906                	ld	s2,64(sp)
    3842:	79e2                	ld	s3,56(sp)
    3844:	7a42                	ld	s4,48(sp)
    3846:	7aa2                	ld	s5,40(sp)
    3848:	7b02                	ld	s6,32(sp)
    384a:	6be2                	ld	s7,24(sp)
    384c:	6125                	addi	sp,sp,96
    384e:	8082                	ret

0000000000003850 <stat>:

int
stat(const char *n, struct stat *st)
{
    3850:	1101                	addi	sp,sp,-32
    3852:	ec06                	sd	ra,24(sp)
    3854:	e822                	sd	s0,16(sp)
    3856:	e426                	sd	s1,8(sp)
    3858:	e04a                	sd	s2,0(sp)
    385a:	1000                	addi	s0,sp,32
    385c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    385e:	4581                	li	a1,0
    3860:	00000097          	auipc	ra,0x0
    3864:	1d2080e7          	jalr	466(ra) # 3a32 <open>
  if(fd < 0)
    3868:	02054563          	bltz	a0,3892 <stat+0x42>
    386c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    386e:	85ca                	mv	a1,s2
    3870:	00000097          	auipc	ra,0x0
    3874:	1da080e7          	jalr	474(ra) # 3a4a <fstat>
    3878:	892a                	mv	s2,a0
  close(fd);
    387a:	8526                	mv	a0,s1
    387c:	00000097          	auipc	ra,0x0
    3880:	19e080e7          	jalr	414(ra) # 3a1a <close>
  return r;
}
    3884:	854a                	mv	a0,s2
    3886:	60e2                	ld	ra,24(sp)
    3888:	6442                	ld	s0,16(sp)
    388a:	64a2                	ld	s1,8(sp)
    388c:	6902                	ld	s2,0(sp)
    388e:	6105                	addi	sp,sp,32
    3890:	8082                	ret
    return -1;
    3892:	597d                	li	s2,-1
    3894:	bfc5                	j	3884 <stat+0x34>

0000000000003896 <atoi>:

int
atoi(const char *s)
{
    3896:	1141                	addi	sp,sp,-16
    3898:	e422                	sd	s0,8(sp)
    389a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    389c:	00054603          	lbu	a2,0(a0)
    38a0:	fd06079b          	addiw	a5,a2,-48
    38a4:	0ff7f793          	andi	a5,a5,255
    38a8:	4725                	li	a4,9
    38aa:	02f76963          	bltu	a4,a5,38dc <atoi+0x46>
    38ae:	86aa                	mv	a3,a0
  n = 0;
    38b0:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    38b2:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    38b4:	0685                	addi	a3,a3,1
    38b6:	0025179b          	slliw	a5,a0,0x2
    38ba:	9fa9                	addw	a5,a5,a0
    38bc:	0017979b          	slliw	a5,a5,0x1
    38c0:	9fb1                	addw	a5,a5,a2
    38c2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    38c6:	0006c603          	lbu	a2,0(a3)
    38ca:	fd06071b          	addiw	a4,a2,-48
    38ce:	0ff77713          	andi	a4,a4,255
    38d2:	fee5f1e3          	bgeu	a1,a4,38b4 <atoi+0x1e>
  return n;
}
    38d6:	6422                	ld	s0,8(sp)
    38d8:	0141                	addi	sp,sp,16
    38da:	8082                	ret
  n = 0;
    38dc:	4501                	li	a0,0
    38de:	bfe5                	j	38d6 <atoi+0x40>

00000000000038e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    38e0:	1141                	addi	sp,sp,-16
    38e2:	e422                	sd	s0,8(sp)
    38e4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    38e6:	02b57463          	bgeu	a0,a1,390e <memmove+0x2e>
    while(n-- > 0)
    38ea:	00c05f63          	blez	a2,3908 <memmove+0x28>
    38ee:	1602                	slli	a2,a2,0x20
    38f0:	9201                	srli	a2,a2,0x20
    38f2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    38f6:	872a                	mv	a4,a0
      *dst++ = *src++;
    38f8:	0585                	addi	a1,a1,1
    38fa:	0705                	addi	a4,a4,1
    38fc:	fff5c683          	lbu	a3,-1(a1)
    3900:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3904:	fee79ae3          	bne	a5,a4,38f8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    3908:	6422                	ld	s0,8(sp)
    390a:	0141                	addi	sp,sp,16
    390c:	8082                	ret
    dst += n;
    390e:	00c50733          	add	a4,a0,a2
    src += n;
    3912:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    3914:	fec05ae3          	blez	a2,3908 <memmove+0x28>
    3918:	fff6079b          	addiw	a5,a2,-1
    391c:	1782                	slli	a5,a5,0x20
    391e:	9381                	srli	a5,a5,0x20
    3920:	fff7c793          	not	a5,a5
    3924:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3926:	15fd                	addi	a1,a1,-1
    3928:	177d                	addi	a4,a4,-1
    392a:	0005c683          	lbu	a3,0(a1)
    392e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3932:	fee79ae3          	bne	a5,a4,3926 <memmove+0x46>
    3936:	bfc9                	j	3908 <memmove+0x28>

0000000000003938 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    3938:	1141                	addi	sp,sp,-16
    393a:	e422                	sd	s0,8(sp)
    393c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    393e:	ca05                	beqz	a2,396e <memcmp+0x36>
    3940:	fff6069b          	addiw	a3,a2,-1
    3944:	1682                	slli	a3,a3,0x20
    3946:	9281                	srli	a3,a3,0x20
    3948:	0685                	addi	a3,a3,1
    394a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    394c:	00054783          	lbu	a5,0(a0)
    3950:	0005c703          	lbu	a4,0(a1)
    3954:	00e79863          	bne	a5,a4,3964 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    3958:	0505                	addi	a0,a0,1
    p2++;
    395a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    395c:	fed518e3          	bne	a0,a3,394c <memcmp+0x14>
  }
  return 0;
    3960:	4501                	li	a0,0
    3962:	a019                	j	3968 <memcmp+0x30>
      return *p1 - *p2;
    3964:	40e7853b          	subw	a0,a5,a4
}
    3968:	6422                	ld	s0,8(sp)
    396a:	0141                	addi	sp,sp,16
    396c:	8082                	ret
  return 0;
    396e:	4501                	li	a0,0
    3970:	bfe5                	j	3968 <memcmp+0x30>

0000000000003972 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    3972:	1141                	addi	sp,sp,-16
    3974:	e406                	sd	ra,8(sp)
    3976:	e022                	sd	s0,0(sp)
    3978:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    397a:	00000097          	auipc	ra,0x0
    397e:	f66080e7          	jalr	-154(ra) # 38e0 <memmove>
}
    3982:	60a2                	ld	ra,8(sp)
    3984:	6402                	ld	s0,0(sp)
    3986:	0141                	addi	sp,sp,16
    3988:	8082                	ret

000000000000398a <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    398a:	1141                	addi	sp,sp,-16
    398c:	e422                	sd	s0,8(sp)
    398e:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    3990:	00052023          	sw	zero,0(a0)
}  
    3994:	6422                	ld	s0,8(sp)
    3996:	0141                	addi	sp,sp,16
    3998:	8082                	ret

000000000000399a <lock>:

void lock(struct spinlock * lk) 
{    
    399a:	1141                	addi	sp,sp,-16
    399c:	e422                	sd	s0,8(sp)
    399e:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    39a0:	4705                	li	a4,1
    39a2:	87ba                	mv	a5,a4
    39a4:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    39a8:	2781                	sext.w	a5,a5
    39aa:	ffe5                	bnez	a5,39a2 <lock+0x8>
}  
    39ac:	6422                	ld	s0,8(sp)
    39ae:	0141                	addi	sp,sp,16
    39b0:	8082                	ret

00000000000039b2 <unlock>:

void unlock(struct spinlock * lk) 
{   
    39b2:	1141                	addi	sp,sp,-16
    39b4:	e422                	sd	s0,8(sp)
    39b6:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    39b8:	0f50000f          	fence	iorw,ow
    39bc:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    39c0:	6422                	ld	s0,8(sp)
    39c2:	0141                	addi	sp,sp,16
    39c4:	8082                	ret

00000000000039c6 <isDigit>:

unsigned int isDigit(char *c) {
    39c6:	1141                	addi	sp,sp,-16
    39c8:	e422                	sd	s0,8(sp)
    39ca:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    39cc:	00054503          	lbu	a0,0(a0)
    39d0:	fd05051b          	addiw	a0,a0,-48
    39d4:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    39d8:	00a53513          	sltiu	a0,a0,10
    39dc:	6422                	ld	s0,8(sp)
    39de:	0141                	addi	sp,sp,16
    39e0:	8082                	ret

00000000000039e2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    39e2:	4885                	li	a7,1
 ecall
    39e4:	00000073          	ecall
 ret
    39e8:	8082                	ret

00000000000039ea <exit>:
.global exit
exit:
 li a7, SYS_exit
    39ea:	4889                	li	a7,2
 ecall
    39ec:	00000073          	ecall
 ret
    39f0:	8082                	ret

00000000000039f2 <wait>:
.global wait
wait:
 li a7, SYS_wait
    39f2:	488d                	li	a7,3
 ecall
    39f4:	00000073          	ecall
 ret
    39f8:	8082                	ret

00000000000039fa <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    39fa:	48e1                	li	a7,24
 ecall
    39fc:	00000073          	ecall
 ret
    3a00:	8082                	ret

0000000000003a02 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    3a02:	4891                	li	a7,4
 ecall
    3a04:	00000073          	ecall
 ret
    3a08:	8082                	ret

0000000000003a0a <read>:
.global read
read:
 li a7, SYS_read
    3a0a:	4895                	li	a7,5
 ecall
    3a0c:	00000073          	ecall
 ret
    3a10:	8082                	ret

0000000000003a12 <write>:
.global write
write:
 li a7, SYS_write
    3a12:	48c1                	li	a7,16
 ecall
    3a14:	00000073          	ecall
 ret
    3a18:	8082                	ret

0000000000003a1a <close>:
.global close
close:
 li a7, SYS_close
    3a1a:	48d5                	li	a7,21
 ecall
    3a1c:	00000073          	ecall
 ret
    3a20:	8082                	ret

0000000000003a22 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3a22:	4899                	li	a7,6
 ecall
    3a24:	00000073          	ecall
 ret
    3a28:	8082                	ret

0000000000003a2a <exec>:
.global exec
exec:
 li a7, SYS_exec
    3a2a:	489d                	li	a7,7
 ecall
    3a2c:	00000073          	ecall
 ret
    3a30:	8082                	ret

0000000000003a32 <open>:
.global open
open:
 li a7, SYS_open
    3a32:	48bd                	li	a7,15
 ecall
    3a34:	00000073          	ecall
 ret
    3a38:	8082                	ret

0000000000003a3a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    3a3a:	48c5                	li	a7,17
 ecall
    3a3c:	00000073          	ecall
 ret
    3a40:	8082                	ret

0000000000003a42 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3a42:	48c9                	li	a7,18
 ecall
    3a44:	00000073          	ecall
 ret
    3a48:	8082                	ret

0000000000003a4a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    3a4a:	48a1                	li	a7,8
 ecall
    3a4c:	00000073          	ecall
 ret
    3a50:	8082                	ret

0000000000003a52 <link>:
.global link
link:
 li a7, SYS_link
    3a52:	48cd                	li	a7,19
 ecall
    3a54:	00000073          	ecall
 ret
    3a58:	8082                	ret

0000000000003a5a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    3a5a:	48d1                	li	a7,20
 ecall
    3a5c:	00000073          	ecall
 ret
    3a60:	8082                	ret

0000000000003a62 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3a62:	48a5                	li	a7,9
 ecall
    3a64:	00000073          	ecall
 ret
    3a68:	8082                	ret

0000000000003a6a <dup>:
.global dup
dup:
 li a7, SYS_dup
    3a6a:	48a9                	li	a7,10
 ecall
    3a6c:	00000073          	ecall
 ret
    3a70:	8082                	ret

0000000000003a72 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    3a72:	48ad                	li	a7,11
 ecall
    3a74:	00000073          	ecall
 ret
    3a78:	8082                	ret

0000000000003a7a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    3a7a:	48b1                	li	a7,12
 ecall
    3a7c:	00000073          	ecall
 ret
    3a80:	8082                	ret

0000000000003a82 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    3a82:	48b5                	li	a7,13
 ecall
    3a84:	00000073          	ecall
 ret
    3a88:	8082                	ret

0000000000003a8a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    3a8a:	48b9                	li	a7,14
 ecall
    3a8c:	00000073          	ecall
 ret
    3a90:	8082                	ret

0000000000003a92 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    3a92:	48d9                	li	a7,22
 ecall
    3a94:	00000073          	ecall
 ret
    3a98:	8082                	ret

0000000000003a9a <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    3a9a:	48dd                	li	a7,23
 ecall
    3a9c:	00000073          	ecall
 ret
    3aa0:	8082                	ret

0000000000003aa2 <ps>:
.global ps
ps:
 li a7, SYS_ps
    3aa2:	48e5                	li	a7,25
 ecall
    3aa4:	00000073          	ecall
 ret
    3aa8:	8082                	ret

0000000000003aaa <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    3aaa:	48e9                	li	a7,26
 ecall
    3aac:	00000073          	ecall
 ret
    3ab0:	8082                	ret

0000000000003ab2 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    3ab2:	48ed                	li	a7,27
 ecall
    3ab4:	00000073          	ecall
 ret
    3ab8:	8082                	ret

0000000000003aba <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    3aba:	1101                	addi	sp,sp,-32
    3abc:	ec06                	sd	ra,24(sp)
    3abe:	e822                	sd	s0,16(sp)
    3ac0:	1000                	addi	s0,sp,32
    3ac2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    3ac6:	4605                	li	a2,1
    3ac8:	fef40593          	addi	a1,s0,-17
    3acc:	00000097          	auipc	ra,0x0
    3ad0:	f46080e7          	jalr	-186(ra) # 3a12 <write>
}
    3ad4:	60e2                	ld	ra,24(sp)
    3ad6:	6442                	ld	s0,16(sp)
    3ad8:	6105                	addi	sp,sp,32
    3ada:	8082                	ret

0000000000003adc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3adc:	7139                	addi	sp,sp,-64
    3ade:	fc06                	sd	ra,56(sp)
    3ae0:	f822                	sd	s0,48(sp)
    3ae2:	f426                	sd	s1,40(sp)
    3ae4:	f04a                	sd	s2,32(sp)
    3ae6:	ec4e                	sd	s3,24(sp)
    3ae8:	0080                	addi	s0,sp,64
    3aea:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3aec:	c299                	beqz	a3,3af2 <printint+0x16>
    3aee:	0805c863          	bltz	a1,3b7e <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3af2:	2581                	sext.w	a1,a1
  neg = 0;
    3af4:	4881                	li	a7,0
    3af6:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    3afa:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    3afc:	2601                	sext.w	a2,a2
    3afe:	00000517          	auipc	a0,0x0
    3b02:	59a50513          	addi	a0,a0,1434 # 4098 <digits>
    3b06:	883a                	mv	a6,a4
    3b08:	2705                	addiw	a4,a4,1
    3b0a:	02c5f7bb          	remuw	a5,a1,a2
    3b0e:	1782                	slli	a5,a5,0x20
    3b10:	9381                	srli	a5,a5,0x20
    3b12:	97aa                	add	a5,a5,a0
    3b14:	0007c783          	lbu	a5,0(a5)
    3b18:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    3b1c:	0005879b          	sext.w	a5,a1
    3b20:	02c5d5bb          	divuw	a1,a1,a2
    3b24:	0685                	addi	a3,a3,1
    3b26:	fec7f0e3          	bgeu	a5,a2,3b06 <printint+0x2a>
  if(neg)
    3b2a:	00088b63          	beqz	a7,3b40 <printint+0x64>
    buf[i++] = '-';
    3b2e:	fd040793          	addi	a5,s0,-48
    3b32:	973e                	add	a4,a4,a5
    3b34:	02d00793          	li	a5,45
    3b38:	fef70823          	sb	a5,-16(a4)
    3b3c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    3b40:	02e05863          	blez	a4,3b70 <printint+0x94>
    3b44:	fc040793          	addi	a5,s0,-64
    3b48:	00e78933          	add	s2,a5,a4
    3b4c:	fff78993          	addi	s3,a5,-1
    3b50:	99ba                	add	s3,s3,a4
    3b52:	377d                	addiw	a4,a4,-1
    3b54:	1702                	slli	a4,a4,0x20
    3b56:	9301                	srli	a4,a4,0x20
    3b58:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    3b5c:	fff94583          	lbu	a1,-1(s2)
    3b60:	8526                	mv	a0,s1
    3b62:	00000097          	auipc	ra,0x0
    3b66:	f58080e7          	jalr	-168(ra) # 3aba <putc>
  while(--i >= 0)
    3b6a:	197d                	addi	s2,s2,-1
    3b6c:	ff3918e3          	bne	s2,s3,3b5c <printint+0x80>
}
    3b70:	70e2                	ld	ra,56(sp)
    3b72:	7442                	ld	s0,48(sp)
    3b74:	74a2                	ld	s1,40(sp)
    3b76:	7902                	ld	s2,32(sp)
    3b78:	69e2                	ld	s3,24(sp)
    3b7a:	6121                	addi	sp,sp,64
    3b7c:	8082                	ret
    x = -xx;
    3b7e:	40b005bb          	negw	a1,a1
    neg = 1;
    3b82:	4885                	li	a7,1
    x = -xx;
    3b84:	bf8d                	j	3af6 <printint+0x1a>

0000000000003b86 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    3b86:	7119                	addi	sp,sp,-128
    3b88:	fc86                	sd	ra,120(sp)
    3b8a:	f8a2                	sd	s0,112(sp)
    3b8c:	f4a6                	sd	s1,104(sp)
    3b8e:	f0ca                	sd	s2,96(sp)
    3b90:	ecce                	sd	s3,88(sp)
    3b92:	e8d2                	sd	s4,80(sp)
    3b94:	e4d6                	sd	s5,72(sp)
    3b96:	e0da                	sd	s6,64(sp)
    3b98:	fc5e                	sd	s7,56(sp)
    3b9a:	f862                	sd	s8,48(sp)
    3b9c:	f466                	sd	s9,40(sp)
    3b9e:	f06a                	sd	s10,32(sp)
    3ba0:	ec6e                	sd	s11,24(sp)
    3ba2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    3ba4:	0005c903          	lbu	s2,0(a1)
    3ba8:	18090f63          	beqz	s2,3d46 <vprintf+0x1c0>
    3bac:	8aaa                	mv	s5,a0
    3bae:	8b32                	mv	s6,a2
    3bb0:	00158493          	addi	s1,a1,1
  state = 0;
    3bb4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3bb6:	02500a13          	li	s4,37
      if(c == 'd'){
    3bba:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    3bbe:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    3bc2:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    3bc6:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3bca:	00000b97          	auipc	s7,0x0
    3bce:	4ceb8b93          	addi	s7,s7,1230 # 4098 <digits>
    3bd2:	a839                	j	3bf0 <vprintf+0x6a>
        putc(fd, c);
    3bd4:	85ca                	mv	a1,s2
    3bd6:	8556                	mv	a0,s5
    3bd8:	00000097          	auipc	ra,0x0
    3bdc:	ee2080e7          	jalr	-286(ra) # 3aba <putc>
    3be0:	a019                	j	3be6 <vprintf+0x60>
    } else if(state == '%'){
    3be2:	01498f63          	beq	s3,s4,3c00 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    3be6:	0485                	addi	s1,s1,1
    3be8:	fff4c903          	lbu	s2,-1(s1)
    3bec:	14090d63          	beqz	s2,3d46 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    3bf0:	0009079b          	sext.w	a5,s2
    if(state == 0){
    3bf4:	fe0997e3          	bnez	s3,3be2 <vprintf+0x5c>
      if(c == '%'){
    3bf8:	fd479ee3          	bne	a5,s4,3bd4 <vprintf+0x4e>
        state = '%';
    3bfc:	89be                	mv	s3,a5
    3bfe:	b7e5                	j	3be6 <vprintf+0x60>
      if(c == 'd'){
    3c00:	05878063          	beq	a5,s8,3c40 <vprintf+0xba>
      } else if(c == 'l') {
    3c04:	05978c63          	beq	a5,s9,3c5c <vprintf+0xd6>
      } else if(c == 'x') {
    3c08:	07a78863          	beq	a5,s10,3c78 <vprintf+0xf2>
      } else if(c == 'p') {
    3c0c:	09b78463          	beq	a5,s11,3c94 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    3c10:	07300713          	li	a4,115
    3c14:	0ce78663          	beq	a5,a4,3ce0 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3c18:	06300713          	li	a4,99
    3c1c:	0ee78e63          	beq	a5,a4,3d18 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    3c20:	11478863          	beq	a5,s4,3d30 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3c24:	85d2                	mv	a1,s4
    3c26:	8556                	mv	a0,s5
    3c28:	00000097          	auipc	ra,0x0
    3c2c:	e92080e7          	jalr	-366(ra) # 3aba <putc>
        putc(fd, c);
    3c30:	85ca                	mv	a1,s2
    3c32:	8556                	mv	a0,s5
    3c34:	00000097          	auipc	ra,0x0
    3c38:	e86080e7          	jalr	-378(ra) # 3aba <putc>
      }
      state = 0;
    3c3c:	4981                	li	s3,0
    3c3e:	b765                	j	3be6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    3c40:	008b0913          	addi	s2,s6,8
    3c44:	4685                	li	a3,1
    3c46:	4629                	li	a2,10
    3c48:	000b2583          	lw	a1,0(s6)
    3c4c:	8556                	mv	a0,s5
    3c4e:	00000097          	auipc	ra,0x0
    3c52:	e8e080e7          	jalr	-370(ra) # 3adc <printint>
    3c56:	8b4a                	mv	s6,s2
      state = 0;
    3c58:	4981                	li	s3,0
    3c5a:	b771                	j	3be6 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    3c5c:	008b0913          	addi	s2,s6,8
    3c60:	4681                	li	a3,0
    3c62:	4629                	li	a2,10
    3c64:	000b2583          	lw	a1,0(s6)
    3c68:	8556                	mv	a0,s5
    3c6a:	00000097          	auipc	ra,0x0
    3c6e:	e72080e7          	jalr	-398(ra) # 3adc <printint>
    3c72:	8b4a                	mv	s6,s2
      state = 0;
    3c74:	4981                	li	s3,0
    3c76:	bf85                	j	3be6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    3c78:	008b0913          	addi	s2,s6,8
    3c7c:	4681                	li	a3,0
    3c7e:	4641                	li	a2,16
    3c80:	000b2583          	lw	a1,0(s6)
    3c84:	8556                	mv	a0,s5
    3c86:	00000097          	auipc	ra,0x0
    3c8a:	e56080e7          	jalr	-426(ra) # 3adc <printint>
    3c8e:	8b4a                	mv	s6,s2
      state = 0;
    3c90:	4981                	li	s3,0
    3c92:	bf91                	j	3be6 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    3c94:	008b0793          	addi	a5,s6,8
    3c98:	f8f43423          	sd	a5,-120(s0)
    3c9c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    3ca0:	03000593          	li	a1,48
    3ca4:	8556                	mv	a0,s5
    3ca6:	00000097          	auipc	ra,0x0
    3caa:	e14080e7          	jalr	-492(ra) # 3aba <putc>
  putc(fd, 'x');
    3cae:	85ea                	mv	a1,s10
    3cb0:	8556                	mv	a0,s5
    3cb2:	00000097          	auipc	ra,0x0
    3cb6:	e08080e7          	jalr	-504(ra) # 3aba <putc>
    3cba:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3cbc:	03c9d793          	srli	a5,s3,0x3c
    3cc0:	97de                	add	a5,a5,s7
    3cc2:	0007c583          	lbu	a1,0(a5)
    3cc6:	8556                	mv	a0,s5
    3cc8:	00000097          	auipc	ra,0x0
    3ccc:	df2080e7          	jalr	-526(ra) # 3aba <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    3cd0:	0992                	slli	s3,s3,0x4
    3cd2:	397d                	addiw	s2,s2,-1
    3cd4:	fe0914e3          	bnez	s2,3cbc <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    3cd8:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    3cdc:	4981                	li	s3,0
    3cde:	b721                	j	3be6 <vprintf+0x60>
        s = va_arg(ap, char*);
    3ce0:	008b0993          	addi	s3,s6,8
    3ce4:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    3ce8:	02090163          	beqz	s2,3d0a <vprintf+0x184>
        while(*s != 0){
    3cec:	00094583          	lbu	a1,0(s2)
    3cf0:	c9a1                	beqz	a1,3d40 <vprintf+0x1ba>
          putc(fd, *s);
    3cf2:	8556                	mv	a0,s5
    3cf4:	00000097          	auipc	ra,0x0
    3cf8:	dc6080e7          	jalr	-570(ra) # 3aba <putc>
          s++;
    3cfc:	0905                	addi	s2,s2,1
        while(*s != 0){
    3cfe:	00094583          	lbu	a1,0(s2)
    3d02:	f9e5                	bnez	a1,3cf2 <vprintf+0x16c>
        s = va_arg(ap, char*);
    3d04:	8b4e                	mv	s6,s3
      state = 0;
    3d06:	4981                	li	s3,0
    3d08:	bdf9                	j	3be6 <vprintf+0x60>
          s = "(null)";
    3d0a:	00000917          	auipc	s2,0x0
    3d0e:	38690913          	addi	s2,s2,902 # 4090 <functions_length+0x150>
        while(*s != 0){
    3d12:	02800593          	li	a1,40
    3d16:	bff1                	j	3cf2 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    3d18:	008b0913          	addi	s2,s6,8
    3d1c:	000b4583          	lbu	a1,0(s6)
    3d20:	8556                	mv	a0,s5
    3d22:	00000097          	auipc	ra,0x0
    3d26:	d98080e7          	jalr	-616(ra) # 3aba <putc>
    3d2a:	8b4a                	mv	s6,s2
      state = 0;
    3d2c:	4981                	li	s3,0
    3d2e:	bd65                	j	3be6 <vprintf+0x60>
        putc(fd, c);
    3d30:	85d2                	mv	a1,s4
    3d32:	8556                	mv	a0,s5
    3d34:	00000097          	auipc	ra,0x0
    3d38:	d86080e7          	jalr	-634(ra) # 3aba <putc>
      state = 0;
    3d3c:	4981                	li	s3,0
    3d3e:	b565                	j	3be6 <vprintf+0x60>
        s = va_arg(ap, char*);
    3d40:	8b4e                	mv	s6,s3
      state = 0;
    3d42:	4981                	li	s3,0
    3d44:	b54d                	j	3be6 <vprintf+0x60>
    }
  }
}
    3d46:	70e6                	ld	ra,120(sp)
    3d48:	7446                	ld	s0,112(sp)
    3d4a:	74a6                	ld	s1,104(sp)
    3d4c:	7906                	ld	s2,96(sp)
    3d4e:	69e6                	ld	s3,88(sp)
    3d50:	6a46                	ld	s4,80(sp)
    3d52:	6aa6                	ld	s5,72(sp)
    3d54:	6b06                	ld	s6,64(sp)
    3d56:	7be2                	ld	s7,56(sp)
    3d58:	7c42                	ld	s8,48(sp)
    3d5a:	7ca2                	ld	s9,40(sp)
    3d5c:	7d02                	ld	s10,32(sp)
    3d5e:	6de2                	ld	s11,24(sp)
    3d60:	6109                	addi	sp,sp,128
    3d62:	8082                	ret

0000000000003d64 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    3d64:	715d                	addi	sp,sp,-80
    3d66:	ec06                	sd	ra,24(sp)
    3d68:	e822                	sd	s0,16(sp)
    3d6a:	1000                	addi	s0,sp,32
    3d6c:	e010                	sd	a2,0(s0)
    3d6e:	e414                	sd	a3,8(s0)
    3d70:	e818                	sd	a4,16(s0)
    3d72:	ec1c                	sd	a5,24(s0)
    3d74:	03043023          	sd	a6,32(s0)
    3d78:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    3d7c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    3d80:	8622                	mv	a2,s0
    3d82:	00000097          	auipc	ra,0x0
    3d86:	e04080e7          	jalr	-508(ra) # 3b86 <vprintf>
}
    3d8a:	60e2                	ld	ra,24(sp)
    3d8c:	6442                	ld	s0,16(sp)
    3d8e:	6161                	addi	sp,sp,80
    3d90:	8082                	ret

0000000000003d92 <printf>:

void
printf(const char *fmt, ...)
{
    3d92:	711d                	addi	sp,sp,-96
    3d94:	ec06                	sd	ra,24(sp)
    3d96:	e822                	sd	s0,16(sp)
    3d98:	1000                	addi	s0,sp,32
    3d9a:	e40c                	sd	a1,8(s0)
    3d9c:	e810                	sd	a2,16(s0)
    3d9e:	ec14                	sd	a3,24(s0)
    3da0:	f018                	sd	a4,32(s0)
    3da2:	f41c                	sd	a5,40(s0)
    3da4:	03043823          	sd	a6,48(s0)
    3da8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    3dac:	00840613          	addi	a2,s0,8
    3db0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    3db4:	85aa                	mv	a1,a0
    3db6:	4505                	li	a0,1
    3db8:	00000097          	auipc	ra,0x0
    3dbc:	dce080e7          	jalr	-562(ra) # 3b86 <vprintf>
}
    3dc0:	60e2                	ld	ra,24(sp)
    3dc2:	6442                	ld	s0,16(sp)
    3dc4:	6125                	addi	sp,sp,96
    3dc6:	8082                	ret

0000000000003dc8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3dc8:	1141                	addi	sp,sp,-16
    3dca:	e422                	sd	s0,8(sp)
    3dcc:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3dce:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3dd2:	00001797          	auipc	a5,0x1
    3dd6:	25e7b783          	ld	a5,606(a5) # 5030 <freep>
    3dda:	a805                	j	3e0a <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3ddc:	4618                	lw	a4,8(a2)
    3dde:	9db9                	addw	a1,a1,a4
    3de0:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    3de4:	6398                	ld	a4,0(a5)
    3de6:	6318                	ld	a4,0(a4)
    3de8:	fee53823          	sd	a4,-16(a0)
    3dec:	a091                	j	3e30 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3dee:	ff852703          	lw	a4,-8(a0)
    3df2:	9e39                	addw	a2,a2,a4
    3df4:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    3df6:	ff053703          	ld	a4,-16(a0)
    3dfa:	e398                	sd	a4,0(a5)
    3dfc:	a099                	j	3e42 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3dfe:	6398                	ld	a4,0(a5)
    3e00:	00e7e463          	bltu	a5,a4,3e08 <free+0x40>
    3e04:	00e6ea63          	bltu	a3,a4,3e18 <free+0x50>
{
    3e08:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3e0a:	fed7fae3          	bgeu	a5,a3,3dfe <free+0x36>
    3e0e:	6398                	ld	a4,0(a5)
    3e10:	00e6e463          	bltu	a3,a4,3e18 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3e14:	fee7eae3          	bltu	a5,a4,3e08 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    3e18:	ff852583          	lw	a1,-8(a0)
    3e1c:	6390                	ld	a2,0(a5)
    3e1e:	02059713          	slli	a4,a1,0x20
    3e22:	9301                	srli	a4,a4,0x20
    3e24:	0712                	slli	a4,a4,0x4
    3e26:	9736                	add	a4,a4,a3
    3e28:	fae60ae3          	beq	a2,a4,3ddc <free+0x14>
    bp->s.ptr = p->s.ptr;
    3e2c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    3e30:	4790                	lw	a2,8(a5)
    3e32:	02061713          	slli	a4,a2,0x20
    3e36:	9301                	srli	a4,a4,0x20
    3e38:	0712                	slli	a4,a4,0x4
    3e3a:	973e                	add	a4,a4,a5
    3e3c:	fae689e3          	beq	a3,a4,3dee <free+0x26>
  } else
    p->s.ptr = bp;
    3e40:	e394                	sd	a3,0(a5)
  freep = p;
    3e42:	00001717          	auipc	a4,0x1
    3e46:	1ef73723          	sd	a5,494(a4) # 5030 <freep>
}
    3e4a:	6422                	ld	s0,8(sp)
    3e4c:	0141                	addi	sp,sp,16
    3e4e:	8082                	ret

0000000000003e50 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3e50:	7139                	addi	sp,sp,-64
    3e52:	fc06                	sd	ra,56(sp)
    3e54:	f822                	sd	s0,48(sp)
    3e56:	f426                	sd	s1,40(sp)
    3e58:	f04a                	sd	s2,32(sp)
    3e5a:	ec4e                	sd	s3,24(sp)
    3e5c:	e852                	sd	s4,16(sp)
    3e5e:	e456                	sd	s5,8(sp)
    3e60:	e05a                	sd	s6,0(sp)
    3e62:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3e64:	02051493          	slli	s1,a0,0x20
    3e68:	9081                	srli	s1,s1,0x20
    3e6a:	04bd                	addi	s1,s1,15
    3e6c:	8091                	srli	s1,s1,0x4
    3e6e:	0014899b          	addiw	s3,s1,1
    3e72:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    3e74:	00001517          	auipc	a0,0x1
    3e78:	1bc53503          	ld	a0,444(a0) # 5030 <freep>
    3e7c:	c515                	beqz	a0,3ea8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3e7e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3e80:	4798                	lw	a4,8(a5)
    3e82:	02977f63          	bgeu	a4,s1,3ec0 <malloc+0x70>
    3e86:	8a4e                	mv	s4,s3
    3e88:	0009871b          	sext.w	a4,s3
    3e8c:	6685                	lui	a3,0x1
    3e8e:	00d77363          	bgeu	a4,a3,3e94 <malloc+0x44>
    3e92:	6a05                	lui	s4,0x1
    3e94:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    3e98:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3e9c:	00001917          	auipc	s2,0x1
    3ea0:	19490913          	addi	s2,s2,404 # 5030 <freep>
  if(p == (char*)-1)
    3ea4:	5afd                	li	s5,-1
    3ea6:	a88d                	j	3f18 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    3ea8:	00001797          	auipc	a5,0x1
    3eac:	19878793          	addi	a5,a5,408 # 5040 <base>
    3eb0:	00001717          	auipc	a4,0x1
    3eb4:	18f73023          	sd	a5,384(a4) # 5030 <freep>
    3eb8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    3eba:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    3ebe:	b7e1                	j	3e86 <malloc+0x36>
      if(p->s.size == nunits)
    3ec0:	02e48b63          	beq	s1,a4,3ef6 <malloc+0xa6>
        p->s.size -= nunits;
    3ec4:	4137073b          	subw	a4,a4,s3
    3ec8:	c798                	sw	a4,8(a5)
        p += p->s.size;
    3eca:	1702                	slli	a4,a4,0x20
    3ecc:	9301                	srli	a4,a4,0x20
    3ece:	0712                	slli	a4,a4,0x4
    3ed0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    3ed2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    3ed6:	00001717          	auipc	a4,0x1
    3eda:	14a73d23          	sd	a0,346(a4) # 5030 <freep>
      return (void*)(p + 1);
    3ede:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3ee2:	70e2                	ld	ra,56(sp)
    3ee4:	7442                	ld	s0,48(sp)
    3ee6:	74a2                	ld	s1,40(sp)
    3ee8:	7902                	ld	s2,32(sp)
    3eea:	69e2                	ld	s3,24(sp)
    3eec:	6a42                	ld	s4,16(sp)
    3eee:	6aa2                	ld	s5,8(sp)
    3ef0:	6b02                	ld	s6,0(sp)
    3ef2:	6121                	addi	sp,sp,64
    3ef4:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3ef6:	6398                	ld	a4,0(a5)
    3ef8:	e118                	sd	a4,0(a0)
    3efa:	bff1                	j	3ed6 <malloc+0x86>
  hp->s.size = nu;
    3efc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    3f00:	0541                	addi	a0,a0,16
    3f02:	00000097          	auipc	ra,0x0
    3f06:	ec6080e7          	jalr	-314(ra) # 3dc8 <free>
  return freep;
    3f0a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    3f0e:	d971                	beqz	a0,3ee2 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3f10:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3f12:	4798                	lw	a4,8(a5)
    3f14:	fa9776e3          	bgeu	a4,s1,3ec0 <malloc+0x70>
    if(p == freep)
    3f18:	00093703          	ld	a4,0(s2)
    3f1c:	853e                	mv	a0,a5
    3f1e:	fef719e3          	bne	a4,a5,3f10 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3f22:	8552                	mv	a0,s4
    3f24:	00000097          	auipc	ra,0x0
    3f28:	b56080e7          	jalr	-1194(ra) # 3a7a <sbrk>
  if(p == (char*)-1)
    3f2c:	fd5518e3          	bne	a0,s5,3efc <malloc+0xac>
        return 0;
    3f30:	4501                	li	a0,0
    3f32:	bf45                	j	3ee2 <malloc+0x92>
