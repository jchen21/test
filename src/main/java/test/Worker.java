package test;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.LongStream;

import org.apache.geode.cache.Region;

public class Worker implements Runnable {

  private static final int bufferSize = 1_000;

  private int workerId;

  private Region clientRegion;

  private long lowerBound;

  private long upperBound;

  public Worker(int id, Region region, long lower, long upper) {
    workerId = id;
    clientRegion = region;
    lowerBound = lower;
    upperBound = upper;
  }

  @Override
  public void run() {

    Map buffer = new HashMap(bufferSize);

    LongStream.range(lowerBound, upperBound).forEach(i -> {
      if (i % bufferSize == 0) {
        clientRegion.putAll(buffer);
        buffer.clear();
      }
      buffer.put(workerId + "key12345678901234567890" + i, workerId + "value" + i);
    });

    if (!buffer.isEmpty()) {
      clientRegion.putAll(buffer);
    }

    System.out.println("Worker " + workerId + " is done putting entries (" + lowerBound + ", " + upperBound + ").");
  }
}
